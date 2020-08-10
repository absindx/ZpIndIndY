;--------------------------------------------------
; ジャンボ尾崎のホールインワンプロフェッシュナル マップ表示倍率決定部
;--------------------------------------------------

HoleIndex		= $3B
GroundAttribute		= $5B
;				  $00 フェアウェイ
;				  $01 ティーイングエリア
;				  $02 ラフ
;				  $03 バンカー
;				  $04 ウォーターハザード
;				  $05 OB
;				  $06 グリーン
DisplayingMapZoom	= $7C
BallXPosition		= $62
BallXPosition_Low	= BallXPosition + 0	; $62
BallXPosition_High	= BallXPosition + 1	; $63
;BallXPosition_Page	= BallXPosition + 2	; $64 未使用？
BallYPosition		= $65
BallYPosition_Low	= BallYPosition + 0	; $65
BallYPosition_High	= BallYPosition + 1	; $66
BallYPosition_Page	= BallYPosition + 2	; $67 縦に長いコースだと使うことがある（East 4など）

BallXPosition_Mirror		= $56
BallXPosition_Mirror_Low	= BallXPosition_Mirror + 0	; $56
BallXPosition_Mirror_High	= BallXPosition_Mirror + 1	; $57
BallYPosition_Mirror		= $68
BallYPosition_Mirror_Low	= BallYPosition_Mirror + 0	; $58
BallYPosition_Mirror_High	= BallYPosition_Mirror + 1	; $59
BallYPosition_Mirror_Page	= BallYPosition_Mirror + 2	; $5A

	.org	$CCA4
		JSR	UpdateGroundAttribute
		LDA	GroundAttribute
		CMP	#$06				;   グリーンに乗っていたらx4
		BEQ	.Return_x4
		JSR	CopyBallPosition
		JSR	JudgeZoom_x2			;   ボール座標でx1かx2を判定
		BNE	.Return_x2
.Return_x1	LDA	#$00
		RTS
.Return_x2	LDA	#$01
		RTS
.Return_x4	LDA	#$02
		RTS

CopyBallPosition:
		LDA	BallXPosition_Low
		STA	BallXPosition_Mirror_Low
		LDA	BallXPosition_High
		STA	BallXPosition_Mirror_High
		LDA	BallYPosition_Low
		STA	BallYPosition_Mirror_Low
		LDA	BallYPosition_High
		STA	BallYPosition_Mirror_High
		LDA	BallYPosition_Page
		STA	BallYPosition_Mirror_Page
		RTS

;--------------------------------------------------
; 多分ボール位置の属性を取得・更新
; 処理が多くて深みに嵌っていくので追ってない
	.org	$D5D5
UpdateGroundAttribute:
		LDA	#$02				;   ラフ
		STA	GroundAttribute
		LDA	#$00
		STA	$5C
		LDA	#$00
		STA	$5D
		LDA	#$00
		STA	$5F
		LDA	#$00
		STA	$05A2
		LDA	BallXPosition_Low
		STA	BallXPosition_Mirror_Low
		LDA	BallXPosition_High
		STA	BallXPosition_Mirror_High
		LDA	BallYPosition_Low
		STA	BallYPosition_Mirror_Low
		LDA	BallYPosition_High
		STA	BallYPosition_Mirror_High
		LDA	BallYPosition_Page
		STA	BallYPosition_Mirror_Page
		JSR	$D6C9
		LDA	$05A2
		BNE	.D607
		RTS

.D607		JSR	$D695
		LDA	GroundAttribute
		STA	$05A9
		LDA	$5D
		STA	$05AA
		LDA	$05A2
		STA	$05A3
		LDA	#$00
		STA	$05A2
		JSR	$EA7F
		LDA	$62
		STA	BallXPosition_Mirror_Low
		TXA
		STA	$2B
		LDA	$63
		SEC
		SBC	$2B
		STA	BallXPosition_Mirror_High
		LDA	$65
		STA	BallYPosition_Mirror_Low
		TYA
		STA	$2B
		LDA	$66
		SEC
		SBC	$2B
		STA	BallYPosition_Mirror_High
		LDA	$67
		SBC	#$00
		STA	BallYPosition_Mirror_Page
		LDA	$7C
		CMP	#$00
		BEQ	.D66F
		LDX	$3B
		LDA	BallXPosition_Mirror_High
		SEC
		SBC	$E278,X
		STA	BallXPosition_Mirror_High
		LDA	$E29C,X
		SEC
		SBC	#$0C
		STA	$2B
		LDA	BallYPosition_Mirror_High
		SEC
		SBC	$2B
		STA	BallYPosition_Mirror_High
		LDA	BallYPosition_Mirror_Page
		SBC	#$00
		STA	BallYPosition_Mirror_Page
		JSR	$D842
		JMP	.D672
.D66F		JSR	$E2E9
.D672		LDA	$05A2
		AND	#$01
		BEQ	.D687
		LDA	$05A3
		LSR	A
		BCC	.D683
		LDA	#$01
		BPL	.D685
.D683		LDA	#$02
.D685		STA	$5C
.D687		JSR	$D6AF
		LDA	$05A9
		STA	GroundAttribute
		LDA	$05AA
		STA	$5D
		RTS

	.org	$D6C9
		LDA	BallXPosition_Mirror_High
		CMP	#$B0
		BCS	.D6E0
		LDA	BallYPosition_Mirror_Page
		BMI	.D6E0
		LSR	A
		LDA	BallYPosition_Mirror_High
		ROR	A
		LSR	A
		LSR	A
		LDX	$3B
		CMP	$EA8C,X
		BCC	.D6E5
.D6E0		LDA	#$05				;   OB
		STA	GroundAttribute
		RTS
.D6E5		JSR	$D7CE
		BEQ	.D6ED
		JMP	.D6F8
.D6ED		JSR	$E249
		BEQ	.D6F5
		JMP	$D842
.D6F5		JMP	$E2E9
.D6F8		LDA	$0533
		PHA
		LDA	#$04
		JSR	$D32D
		JSR	$D709
		PLA
		JSR	$D32D
		RTS

;--------------------------------------------------
; x2表示するか
; 呼び元で同じ値が再代入されるが、こちらはbooleanで返したかったと思われる
; Return : A = $00 しない（x1）, $01 する（x2）
	.org	$E249
JudgeZoom_x2:
.Temporary	= $1A
		LDX	HoleIndex
		LDA	BallXPosition_Mirror_High
		SEC
		SBC	Zoom_x2_OffsetX,X
		BCC	.Return_x1			;   マイナスになった
		CMP	#$50				;\  or 表示範囲（$50.00pxの外）
		BCS	.Return_x1			;/  → x1
		STA	.Temporary			;   Y座標の判定が残っているので上書きせずに一時領域に退避
		LDA	BallYPosition_Mirror_Page	;\  256以上残っている（=遠すぎ）
		BNE	.Return_x1			;/  x1
		LDA	BallYPosition_Mirror_High
		SEC
		SBC	Zoom_x2_OffsetY,X
		BCC	.Return_x1			;   マイナスになった
		CMP	#$60				;\  表示範囲（$60.00pxの外）
		BCS	.Return_x1			;/  → x1
		CLC
		ADC	#$0C				;   描画用オフセット？
		STA	BallYPosition_Mirror_High	;\
		LDA	.Temporary			; | x2を返すことが決まったので座標を反映
		STA	BallXPosition_Mirror_High	;/
.Return_x2	LDA	#$01
		RTS
.Return_x1	LDA	#$00
		RTS

	.org	$E278
Zoom_x2_OffsetX:
		.db	$20,$18,$30,$10,$30,$50,$14,$08,$50,	; East 01-09
		.db	$20,$28,$20,$08,$30,$38,$20,$28,$18,	; East 10-18
		.db	$08,$48,$50,$20,$30,$20,$20,$18,$38,	; West 01-09
		.db	$20,$28,$18,$18,$08,$30,$10,$28,$50,	; West 10-18
Zoom_x2_OffsetY:
	.org	$E29C
		.db	$14,$34,$5C,$14,$3C,$14,$14,$0C,$14,	; East 01-09
		.db	$24,$0C,$1C,$04,$54,$04,$0C,$04,$2C,	; East 10-18
		.db	$04,$14,$14,$0C,$3C,$1C,$14,$34,$04,	; West 01-09
		.db	$24,$0C,$2C,$24,$0C,$34,$14,$04,$14,	; West 10-18
