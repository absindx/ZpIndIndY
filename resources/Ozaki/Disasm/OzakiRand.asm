﻿;--------------------------------------------------
; ジャンボ尾崎のホールインワンプロフェッシュナル 乱数生成部
;--------------------------------------------------

; 引数		: なし
; 戻り値	: Aレジスタ（$32と同じ）
; $32		: 乱数
; $33		: 乱数生成補助
; 		  $32-$33（というかメモリの大部分）は起動時に初期化されないまま使用しているため、ハードウェアのメモリ初期値に依存する
	.org	$D2C2
OzakiRand:
		TXA		;\  Xレジスタの保護
		PHA		;/
		LDX	#11	;   ループ回数
.Loop		ASL	$32	;\
		ROL	$33	; |
		ROL	A	; | 撹拌部
		ROL	A	; | フィボナッチLFSR（線形帰還シフトレジスタ）
		EOR	$32	; | タップ位置は [16, 2, 1, 0]
		ROL	A	; |
		EOR	$32	; |
		LSR	A	; |
		LSR	A	; |
		EOR	#$FF	; |
		AND	#$01	; |
		ORA	$32	; |
		STA	$32	;/
		DEX		;
		BNE	.Loop	;
		PLA		;\  Xレジスタの復帰
		TAX		;/
		LDA	$32	;   戻り値
		RTS