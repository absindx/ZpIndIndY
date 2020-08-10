;--------------------------------------------------
; ジャンボ尾崎のホールインワンプロフェッシュナル ホール開始時処理
;--------------------------------------------------

PpuControlSetting	= $00
PlayerCount		= $37			; $00 = 1P, $01 = 2P
Difficulty		= $38			; $00 = Amateur, $01 = Single, $02 = Professional
CourseType		= $39			; $00 = East, $01 = West
HoleNumber		= $3A
HoleIndex		= $3B
NowWindDirection	= $3C
NowWindVolume		= $3D
BaseWindDirection	= $3E
BaseWindVolume		= $3F
CupXPosition		= $52
CupXPosition_Low	= CupXPosition + 0	; $52
CupXPosition_High	= CupXPosition + 1	; $53
CupYPosition		= $54
CupYPosition_Low	= CupYPosition + 0	; $54
CupYPosition_High	= CupYPosition + 1	; $55
BallXPosition		= $62
BallXPosition_Low	= BallXPosition + 0	; $62
BallXPosition_High	= BallXPosition + 1	; $63
;BallXPosition_Page	= BallXPosition + 2	; $64 未使用？
BallYPosition		= $65
BallYPosition_Low	= BallYPosition + 0	; $65
BallYPosition_High	= BallYPosition + 1	; $66
BallYPosition_Page	= BallYPosition + 2	; $67 縦に長いコースだと使うことがある（East 4など）
PrgLowBankIndex		= $0533
CourseRand		= $6061

;--------------------------------------------------

C3C1:
		JSR	Rand			;\
		AND	#$E0			; | 基準風向
		STA	BaseWindDirection	;/
		JSR	Rand			;\
		AND	#$0F			; |
		CMP	#$0B			; | 基準風量
		BCC	.C3D3			; | [0, 1, ... , 9, 10, 3, 4, 5, 6, 7 ]
		SBC	#$08			; |
.C3D3		STA	BaseWindVolume		;/

;--------------------------------------------------

	.org	$C3DA
C3DA:
		LDA	HoleNumber
		LDY	CourseType
		BEQ	.CourseEast
		CLC				;\  18ホール分加算して内部インデックスへ変換
		ADC	#18			;/
.CourseEast	STA	HoleIndex
		LDA	#$01
		STA	$0504
		LDX	HoleNumber
		LDY	HoleIndex
		TYA
		ASL	A
		ASL	A
		CLC
		ADC	CourseRand,X		;   CourseIndex * 4 + Rand & 3 → 各コース4パターンのうちの一つを選択
		TAX
		LDA	CupRandomX,X
		STA	CupXPosition_High
		LDA	#$80			;\
		LSR	CupXPosition_High	; | $53 下位3bit取り出し
		ROR	A			; | $53 %.... .xxx
		LSR	CupXPosition_High	; |            |||	座標下位バイトの整数領域に移動
		ROR	A			; |      +++---+++	乱数パターンが1バイトで、カップ座標系に変換しているイメージ
		LSR	CupXPosition_High	; |      vvv
		ROR	A			; | $52 %xxx1 0000	下位2ビットは常に0のため %x0010000 の形になる （→ #$10 or #$90）
		STA	CupXPosition		;/
		LDA	CupRandomY,X
		STA	CupYPosition_High
		LDA	#$80			;\
		LSR	CupYPosition_High	; | $55 下位3bit取り出し （$53, $52と一緒の処理）
		ROR	A			; | $55 %.... .xxx
		LSR	CupYPosition_High	; |            |||
		ROR	A			; |      +++---+++
		LSR	CupYPosition_High	; |      vvv
		ROR	A			; | $54 %xxx1 0000
		STA	CupYPosition		;/
		LDA	CupBaseX,Y		;\
		CLC				; | カップの位置を乱数でずらす
		ADC	CupXPosition_High	; | X座標
		STA	CupXPosition_High	;/
		LDA	CupBaseY,Y		;\
		CLC				; |
		ADC	CupYPosition_High	; | Y座標
		STA	CupYPosition_High	;/
		LDA	#$FF
		STA	$6087
		JSR	$EAB0			;   コースのヘッダ情報？のコピーっぽい
		LDA	$0504			;\
		BEQ	.C43E			; | $0504 = 0 : 実行 / !0 : 次回実行
		LDA	#$00			; |
		STA	$0504			;/
		BEQ	.C466			;   JMP
.C43E		LDA	BaseWindDirection	;\  風向のコピー
		STA	NowWindDirection	;/

		JSR	Rand			;\  0 → 0	加算する風量
		AND	#$07			; | 1 → 0
		LSR	A			; | 2 → -1
		BEQ	.SkipSub		; | 3 → 0
		SBC	#$01			; | 4 → 0
.SkipSub					; | 5 → 1
						; | 6 → 1
						;/  7 → 2
		CLC
		ADC	BaseWindVolume		;   基準風量に加算
		BPL	.SkipInvertWind		;   プラスなら風向はそのまま
		LDA	NowWindDirection	;\  マイナスなら風向を反転、風速1m
		EOR	#$80			; | 基準風量が0、加算風量が-1（Rand() => 2）でしか発生しない
		STA	NowWindDirection	;/  1/16 * 1/8 = 1/128
		LDA	#$01
.SkipInvertWind
.LoopAirSub	LDX	Difficulty
		CMP	MaxWindVolume,X		;   難易度別最大風速と比較
		BCC	.SetWindVolume
		SBC	#$05
		BPL	.LoopAirSub		;   X不変だからCMPの位置でよかったのでは…
.SetWindVolume	STA	NowWindVolume		;   風速が最大風速以下になるように5を引き続ける

.C466		LDA	#$00
		STA	$36
		STA	$6079
		LDX	PlayerCount
		BEQ	.C4B9
		LDA	$40
		CMP	$41
		BEQ	.C47B
		BCC	.C4B9
		BCS	.C4B7
.C47B		LDA	$40
		BNE	.C496
		LDX	HoleNumber
		LDA	$6083
		BEQ	.C487
		INX				; 次のDEXをキャンセル
.C487		DEX
		BMI	$C4B9
		LDA	$6019,X
		CMP	$602B,X
		BEQ	.C487
		BCC	.C4B9
		BCS	.C4B7
.C496		LDX	#$00
		JSR	$CF49
		LDA	$A1
		STA	$1F
		LDA	$A2
		STA	$20
		LDX	#$01
		JSR	$CF49
		LDA	$A1
		SEC
		SBC	$1F
		STA	$A1
		LDA	$A2
		SBC	$20
		STA	$A2
		BCC	$C4B9
.C4B7		INC	$36
.C4B9		LDA	$35
		CMP	#$01
		BNE	$C4E2
		; snip



	.org	$CCD3
MaxWindVolume:
		.db	$06,$0A,$0D

	.org	$CE29
CupRandomX:	; 0XXX Xx00
		.db	$28,$68,$50,$50, $28,$70,$20,$28, $68,$20,$38,$68, $58,$20,$28,$50, $48,$78,$28,$60, $30,$20,$70,$38	;  0- 5
		.db	$40,$20,$60,$28, $60,$78,$20,$60, $58,$70,$40,$58, $28,$70,$40,$58, $58,$48,$20,$70, $78,$30,$78,$30	;  6-11
		.db	$30,$70,$30,$68, $48,$60,$78,$38, $28,$50,$70,$30, $48,$20,$78,$48, $28,$48,$28,$70, $78,$78,$48,$28	; 12-17
		.db	$38,$60,$78,$38, $30,$60,$28,$60, $70,$70,$28,$48, $4C,$4C,$20,$78, $60,$28,$4C,$70, $68,$50,$20,$68	;  0- 5
		.db	$28,$48,$60,$70, $28,$48,$70,$28, $68,$28,$48,$70, $28,$48,$70,$48, $30,$48,$58,$28, $50,$78,$48,$28	;  6-11
		.db	$44,$28,$70,$44, $68,$28,$20,$70, $28,$70,$58,$38, $28,$70,$68,$30, $28,$48,$28,$70, $28,$58,$78,$28	; 12-17
	;.org	$CEB9
CupRandomY:
		.db	$28,$28,$40,$70, $28,$48,$50,$78, $20,$60,$70,$70, $28,$48,$70,$70, $18,$28,$30,$78, $20,$50,$50,$78	;  0- 5
		.db	$28,$38,$38,$68, $18,$60,$70,$78, $28,$40,$48,$68, $28,$38,$70,$70, $20,$48,$50,$70, $30,$40,$68,$70	;  6-11
		.db	$28,$30,$68,$68, $20,$30,$50,$60, $38,$48,$68,$70, $20,$68,$68,$70, $28,$48,$70,$70, $20,$40,$50,$70	; 12-17
		.db	$20,$28,$48,$68, $30,$38,$60,$60, $20,$48,$78,$78, $20,$50,$70,$70, $28,$40,$4C,$60, $28,$50,$68,$78	;  0- 5
		.db	$28,$48,$68,$78, $28,$50,$50,$78, $20,$28,$48,$70, $30,$40,$40,$78, $30,$50,$68,$70, $28,$40,$50,$70	;  6-11
		.db	$18,$48,$48,$70, $20,$38,$70,$70, $28,$28,$58,$78, $28,$30,$68,$70, $28,$48,$78,$78, $30,$38,$50,$70	; 12-17

	.org	$D7FA
CupBaseX:	; 0xxx xx00
		.db	$40,$34,$54,$34,$54,$7C,$34,$20,$74	;  0- 8
		.db	$40,$48,$40,$24,$50,$5C,$3C,$48,$34	;  9-17
		.db	$24,$70,$74,$40,$50,$40,$3C,$34,$60	;  0- 8
		.db	$40,$54,$34,$38,$20,$50,$30,$44,$74	;  9-17
	;.org	$D81E
CupBaseY:
		.db	$24,$40,$64,$24,$54,$20,$2C,$24,$24	;  0- 8
		.db	$3C,$20,$30,$14,$58,$14,$24,$18,$44	;  9-17
		.db	$14,$24,$28,$24,$54,$2C,$1C,$40,$1C	;  0- 8
		.db	$3C,$20,$44,$3C,$24,$48,$24,$18,$20	;  9-17

;--------------------------------------------------

; コースのヘッダ情報？をコピー
; 何かは知らん

; ADDR | 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
; -----+------------------------------------------------
; 05A0 |                                        XX XX XX
; 05B0 | XX BB YY YY YY YY YY YY BB ZZ ZZ ZZ ZZ         

EAB0:
		LDA	HoleNumber		;\
		ASL	A			; | 2bytes ptr
		TAX				;/
		LDY	CourseType

		; Bank 0 : East 1-18, East 1-18, Data ...
		; Bank 1 : West 1-18, West 1-18, Data ...
		LDA	CourseBankList,Y
		STA	$05B1
		LDA	$05B1			;   無駄では？？？
		JSR	SetPrgLowBank
		LDA	$8000,X			;   $8000 -> $05AD : 2bytes
		STA	$05AD
		LDA	$8001,X
		STA	$05AE
		LDA	$8024,X			;   $8024 -> $05AF : 2bytes	; #$24 = 18 * 2
		STA	$05AF
		LDA	$8025,X
		STA	$05B0

		; Bank 2 : East 1-18, East 1-18, East 1-18, Data ...
		; Bank 3 : West 1-18, West 1-18, West 1-18, Data ...
		LDA	CourseBankList+2,Y
		STA	$05B8
		LDA	$05B8			;   無駄では？？？
		JSR	SetPrgLowBank
		LDA	$8000,X			;   $8000 -> $05B2 : 2bytes
		STA	$05B2
		LDA	$8001,X
		STA	$05B3
		LDA	$8024,X			;   $8024 -> $05B4 : 2bytes
		STA	$05B4
		LDA	$8025,X
		STA	$05B5
		LDA	$8048,X			;   $8048 -> $05B6 : 2bytes
		STA	$05B6
		LDA	$8049,X
		STA	$05B7

		; Bank 4 : East 1-18, West 1-18, East 1-18, West 1-18, Data ...
		LDA	#$04
		JSR	SetPrgLowBank
		LDA	HoleIndex
		ASL	A
		TAX
		LDA	$8000,X			;   $8000 -> $05B9 : 2bytes
		STA	$05B9
		LDA	$8001,X
		STA	$05BA
		LDA	$8048,X			;   $8048 -> $05BB : 2bytes
		STA	$05BB
		LDA	$8049,X
		STA	$05BC

		LDA	#$06			;   プログラム用バンクに復帰
		JSR	SetPrgLowBank
		RTS

CourseBankList:
		.db	$00,$01,$02,$03

;--------------------------------------------------
		;	  1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18

	.bank	0	; East
	.org	$8000
		.db	$3C,$B0,$A4,$9C,$14,$AB,$78,$A7,$0C,$94,$20,$91,$8C,$8E,$A0,$8B,$88,$88
		.db	$A0,$96,$8C,$A4,$F8,$A1,$64,$9F,$A8,$AD,$60,$99,$C8,$85,$DC,$82,$48,$80

	;.org	$8024
		.db	$CD,$BE,$E7,$B9,$83,$BD,$9C,$BC,$C1,$B7,$06,$B7,$61,$B6,$A6,$B5,$E0,$B4
		.db	$66,$B8,$E1,$BB,$3C,$BB,$97,$BA,$28,$BE,$16,$B9,$30,$B4,$75,$B3,$D0,$B2

	.bank	2	; East
	.org	$8000
		.db	$40,$AC,$34,$9A,$18,$A7,$84,$A4,$78,$92,$E4,$8F,$50,$8D,$BC,$8A,$28,$88
		.db	$0C,$95,$F0,$A1,$5C,$9F,$C8,$9C,$AC,$A9,$A0,$97,$94,$85,$00,$83,$6C,$80
	;.org	$8024
		.db	$C9,$B9,$46,$B5,$7F,$B8,$DA,$B7,$57,$B3,$B2,$B2,$0D,$B2,$68,$B1,$C3,$B0
		.db	$FC,$B3,$35,$B7,$90,$B6,$EB,$B5,$24,$B9,$A1,$B4,$1E,$B0,$79,$AF,$D4,$AE
	;.org	$8048
		.db	$6E,$BA,$9F,$BA,$D8,$BA,$11,$BB,$4A,$BB,$83,$BB,$BC,$BB,$F5,$BB,$2E,$BC
		.db	$6F,$BC,$A8,$BC,$E1,$BC,$1A,$BD,$4B,$BD,$8C,$BD,$BD,$BD,$F6,$BD,$2F,$BE

;--------------------------------------------------

	.org	$D32D
SetPrgLowBank:
		PHA
		JSR	DisableNmi
		PLA
		STA	PrgLowBankIndex
		STA	$FFF9		;\
		LSR	A		; | MMC1 バンク切り替え
		STA	$FFF9		; |   $8000-$BFFF
		LSR	A		; |
		STA	$FFF9		; |
		LSR	A		; |
		STA	$FFF9		; |
		LSR	A		; |
		STA	$FFF9		;/
		JMP	EnableNmi

	.org	$C046
DisableNmi:	LDA	PpuControlSetting
		AND	#$7F
		STA	PpuControlSetting
		STA	PpuControl_2000
		RTS

	.org	$C050
EnableNmi:	LDA	PpuControlSetting
		ORA	#$80
		STA	PpuControl_2000
		STA	PpuControlSetting
		RTS
