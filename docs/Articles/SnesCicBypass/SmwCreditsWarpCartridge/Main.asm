;--------------------------------------------------
; SMW Credits warp cartridge
;--------------------------------------------------

;--------------------------------------------------
; ROM setting
;--------------------------------------------------

hirom
arch 65816

;--------------------------------------------------
; I/O define
;--------------------------------------------------

; PPU registers
!PPU_INIDISP		= $2100
!PPU_BGMODE		= $2105
!PPU_MOSAIC		= $2106
!PPU_BG12NBA		= $210B
!PPU_BG34NBA		= $210C
!PPU_BG1HOFS		= $210D
!PPU_BG1VOFS		= $210E
!PPU_VMAINC		= $2115
!PPU_VMADDL		= $2116
!PPU_VMADDH		= $2117
!PPU_VMDATAL		= $2118
!PPU_VMDATAH		= $2119
!PPU_M7A		= $211B
!PPU_CGADD		= $2121
!PPU_CGDATA		= $2122
!PPU_TM			= $212C
!PPU_TS			= $212D
!PPU_TMW		= $212E
!PPU_TSW		= $212F
!PPU_CGSWSEL		= $2130
!PPU_CGADSUB		= $2131
!PPU_COLDATA		= $2132
!APU_APUIO0		= $2140
!APU_APUIO1		= $2141
!APU_APUIO2		= $2142
!APU_APUIO3		= $2143

; CPU registers
!CPU_NMITIMEN		= $4200
!CPU_MDMAEN		= $420B
!CPU_HDMAEN		= $420C

; DMA / HDMA Registers
!DMA_DMAP0		= $4300
!DMA_BBAD0		= $4301
!DMA_A1T0L		= $4302
!DMA_A1T0H		= $4303
!DMA_A1B0		= $4304
!DMA_DAS0L		= $4305
!DMA_DAS0H		= $4306
!DMA_DASB0		= $4307
!DMA_A2A0L		= $4308
!DMA_A2A0H		= $4309
!DMA_NTLR0		= $430A

;--------------------------------------------------
; RAM map
;--------------------------------------------------

	org	$000000
ScratchMemory:	skip 16

	org	$000100
Stack:		skip 256

;--------------------------------------------------
; ROM header
;--------------------------------------------------

	org $00FFB0
AdditionalCartridgeInformation:
	db	"HK"					; $00FFB0 : Maker code
	db	"02CW"					; $00FFB2 : Game code
	db	0,0,0,0,0,0				; $00FFB6 : Reserved
	db	$00					; $00FFBC : Expansion flash size
	db	$00					; $00FFBD : Expansion ram size
	db	$00					; $00FFBE : Special version
	db	$00					; $00FFBF : Chipset subtype

	org $00FFC0
	padbyte $20
CartridgeInformation:
	db	"SMW Credits warp"			; $00FFC0 : Game title
	pad $00FFD5
	db	$20					; $00FFD5 : Map mode (Slow 2.68 MHz)
	db	$00					; $00FFD6 : Cartridge type (ROM Only)
	db	$06					; $00FFD7 : Rom size (64K Bit)
	db	$00					; $00FFD8 : Ram size (No RAM)
	db	$00					; $00FFD9 : Destination code (Japan)
	db	$33					; $00FFDA : Fixed value
	db	$00					; $00FFDB : Mask rom version
	dw	$FFFF					; $00FFDC : Complement check
	dw	$0000					; $00FFDE : Check sum

	org $00FFE0
Vectors:
	dw	UnusedHandler				; $00FFE0 : Native (Reserved)
	dw	UnusedHandler				; $00FFE2 : Native (Reserved)
	dw	UnusedHandler				; $00FFE4 : Native COP
	dw	UnusedHandler				; $00FFE6 : Native BRK
	dw	UnusedHandler				; $00FFE8 : Native ABORT
	dw	UnusedHandler				; $00FFEA : Native NMI
	dw	UnusedHandler				; $00FFEC : Native (Reserved)
	dw	UnusedHandler				; $00FFEE : Native IRQ
	dw	UnusedHandler				; $00FFF0 : Emulation (Reserved)
	dw	UnusedHandler				; $00FFF2 : Emulation (Reserved)
	dw	UnusedHandler				; $00FFF4 : Emulation COP
	dw	UnusedHandler				; $00FFF6 : Emulation (Reserved)
	dw	UnusedHandler				; $00FFF8 : Emulation ABORT
	dw	UnusedHandler				; $00FFFA : Emulation NMI
	dw	EmulationRESET				; $00FFFC : Emulation RESET
	dw	UnusedHandler				; $00FFFE : Emulation IRQ / BRK

	org $00FFAF
UnusedHandler:
		RTI

;--------------------------------------------------
; Program
;--------------------------------------------------

	padbyte $00
	org $008000
EmulationRESET:
		SEI					;   for emulator vector detection
		REP	#$CB				;   nv??dIzc
		XCE
		SEP	#$34				;   nvMXdIzC
		; .shortm, .shortx

		STZ	!CPU_NMITIMEN			;   disable NMI
		STZ	!CPU_HDMAEN			;   disable HDMA
		STZ	!CPU_MDMAEN			;   disable DMA
		STZ	!APU_APUIO0			;\
		STZ	!APU_APUIO1			; | clear APU port
		STZ	!APU_APUIO2			; |
		STZ	!APU_APUIO3			;/

		JML	.SetPBR				;\  set registers
.SetPBR		PHK					; |   D  = #$0000
		PLB					; |   PB = (PC Bank)
		PEA	$0000				; |   DB = (PC Bank)
		PLD					;/
		REP	#$11				;\
		; .shortm, .longx			; |   SP = #$01FF
		LDX.w	#(Stack+255)			; |
		TXS					;/
		SEP	#$30
		; .shortm, .shortx

		; Set I/O registers
		JSR	InitializeCpu
		JSR	InitializePpu

		; Clear VRAM
		JSR	ClearVram

		; Clear WRAM		- removed
		; Clear CGRAM		- remvoed
		; Clear OAM		- remvoed
		; Upload sound driver	- remvoed
		; Clear SRAM		- remvoed

		SEP	#$30
		; .shortm, .shortx

		;LDA.b	#%10000001			;\  enable NMI, Joypad auto-read
		;STA	!CPU_NMITIMEN			;/

		BRL	CreditsWarp

InitializeCpu:
		; SNES Development Manual book1 - Chapter 26 Register Clear (Initial Settings)
		; .shortm, .shortx

		LDX.b	#$0D
-		LDA	.InitialValue, X
		STA	!CPU_NMITIMEN, X
		DEX
		BPL	-

		RTS

.InitialValue
	db	$00, $FF, $00, $00, $00, $00, $00	; $4200
	db	$00, $00, $00, $00, $00, $00, $00	; $4207

InitializePpu:
		; SNES Development Manual book1 - Chapter 26 Register Clear (Initial Settings)
		; .shortm, .shortx

		LDX.b	#$33				;\
-		STZ	!PPU_INIDISP, X			; | clear to zero
		DEX					; |
		BNE	-				;/  $2100 not required

		LDX.b	#$07				;\
-		STZ	!PPU_BG1HOFS, X			; | set the second byte of the double write register
		STZ	!PPU_BG1HOFS, X			; |
		LDA	.InitialValue, X		; |
		STZ	!PPU_M7A, X			; |
		STA	!PPU_M7A, X			; |
		DEX					; |
		BPL	-				;/

		; reconfigure non-zero registers
		LDA.b	#$8F				;   forced blank
		STA	!PPU_INIDISP
		LDA.b	#$80				;   increment after access $2119 or $213A
		STA	!PPU_VMAINC
		LDA.b	#$30				;   disable color math
		STA	!PPU_CGSWSEL
		LDA.b	#$E0				;   write RGB
		STA	!PPU_COLDATA

		RTS

.InitialValue
	; reset $2121 to reuse the loop (8 bytes)
	;	$1B, $1C, $1D, $1E, $1F, $20, $21, $22
	db	$01, $00, $00, $01, $00, $00, $00, $00	; $211B

ClearVram:
		; Transfer zero to VRAM $0000 - $FFFF
		; .longm, .shortx

		STZ	!PPU_VMADDL
		LDA.w	#(%00001001)|(!PPU_VMDATAL<<8)	;\  DMA parameter = Bus: A to B / Address: Fixed / Transfer: 2 bytes, 2 addresses
							; | B-Bus address
		STA	!DMA_DMAP0			;/    with !WRAM_WMADDH
		LDA.w	#ZeroByte			;\
		STA	!DMA_A1T0L			; | A-Bus address
		LDX.b	#(ZeroByte>>16)			; |
		STX	!DMA_A1B0			;/
		LDA.w	#$0800				;\  DMA size
		STA	!DMA_DAS0L			;/
		LDX.b	#$01				;\  execute DMA #0
		STX	!CPU_MDMAEN			;/
		RTS

;--------------------------------------------------
; Common data

ZeroByte:
	db	$00, $00, $00, $00

;--------------------------------------------------
; Routines

InitializeScreen:
		PHP
		REP	#$20
		SEP	#$10
		; .longm, shortx

		JSR	TransferPalette
		JSR	TransferGraphics
		JSR	TransferTilemap

		LDX.b	#$0F				;   turn off forced blank
		STX	!PPU_INIDISP

		LDX.b	#%00000001			;   mode 1
		STX	!PPU_BGMODE

		LDX.b	#$00				;   mosaic none
		STX	!PPU_MOSAIC

		LDX.b	#%00000010			;   add subscreen
		STX	!PPU_CGSWSEL
		LDX.b	#%00100000			;   backdrop color math
		STX	!PPU_CGADSUB

		LDX.b	#%00000001			;   bg1
		STX	!PPU_TM
		STX	!PPU_TMW
		LDX.b	#%00000000			;   none
		STX	!PPU_TS
		STX	!PPU_TSW

		LDX.b	#$01				;   bg1 = $1000, (bg2 = unused)
		STX	!PPU_BG12NBA
		LDX.b	#$00				;   (bg3 = unused), (bg4 = unused)
		STX	!PPU_BG34NBA

		PLP
		RTS

TransferPalette:
		; .longm, .shortx

		LDA.w	#(%00000010)|(!PPU_CGDATA<<8)	;\  DMA parameter = Bus: A to B / Address: Increment A / Transfer: 2 byte, 1 address
							; | B-Bus address
		STA	!DMA_DMAP0			;/    with !DMA_BBAD0
		LDA.w	#.Palette			;\
		STA	!DMA_A1T0L			; | A-Bus address
		LDX.b	#(.Palette>>16)			; |
		STX	!DMA_A1B0			;/
		LDA.w	#$0010				;\  DMA size = $0010 (8 entries)
		STA	!DMA_DAS0L			;/
		LDX.b	#$00				;\  Set CGRAM address = $00
		STX	!PPU_CGADD			;/
		INX					;\  execute DMA #0
		STX	!CPU_MDMAEN			;/

		RTS

.Palette
	db	$00, $00, $00, $00, $FF, $7F, $10, $42
	db	$95, $7F, $2A, $7B, $A0, $76, $00, $00

TransferGraphics:
		; .longm, .shortx

		LDX.b	#%10000000			;   Increment at $2119, No remap, Increment 1 word
		STX	!PPU_VMAINC

		LDA.w	#$1000
		STA	!PPU_VMADDL			;   Set VRAM address = $1000

		LDA.w	#(%00000001)|(!PPU_VMDATAL<<8)	;\  DMA parameter = Bus: A to B / Address: Increment A / Transfer: 2 byte, 2 address
							; | B-Bus address
		STA	!DMA_DMAP0			;/    with !DMA_BBAD0
		LDA.w	#.Graphics			;\
		STA	!DMA_A1T0L			; | A-Bus address
		LDX.b	#(.Graphics>>16)		; |
		STX	!DMA_A1B0			;/
		LDA.w	#$1000				;\  DMA size
		STA	!DMA_DAS0L			;/
		INX					;\  execute DMA #0
		STX	!CPU_MDMAEN			;/

		RTS

.Graphics
incbin	"GFX_Font_4BPP_Gradation.bin"

TransferTilemap:
		; .longm, .shortx

		LDX.b	#%10000000			;   Increment at $2119, No remap, Increment 1 word
		STX	!PPU_VMAINC
		LDA.w	#($0000+(32*14)+((32-(.MessageEnd-.Message-1))/2))
		STA	!PPU_VMADDL			;   set VRAM address

		LDX.b	#$00
		BRA	.Start
-		STA	!PPU_VMDATAL
		INX
.Start		LDA	.Message, X
		AND.w	#$00FF
		BNE	-

		RTS

.Message
	db	"Swap to SMW", $00
.MessageEnd

;--------------------------------------------------
; SMW Credits warp

!GameMode			= $0100
!CutsceneID			= $13C6
!OamClearCode			= $7F8000

!ResumeAddress			= $00805E
!InitSub_UploadSoundDriver	= $008053
!InitSub_ClearMemory		= $00805C

!RamCodeDst			= $0110

CreditsWarp:
		; .shortm, .shortx

		JSR	SmwOriginalCode
		JSR	InitializeScreen

		; Copy resume code
		LDX.b	#(RamCodeEnd-RamCodeStart-1)
-		LDA	RamCodeStart, X
		STA	!RamCodeDst, X
		DEX
		BPL	-

		; Execute resume code
		REP	#$20
		; longm, shortx
		
		JMP	!RamCodeDst

SmwOriginalCode:
		REP	#$38
		; longm, longx

		; Generate OAM clear code
		LDA.w	#$F0A9			; LDA #$F0 ($F0: Y position to hide the object)
		STA	!OamClearCode
		LDX.w	#(127*3)
		LDY.w	#($200+(127*4)+1)
-		LDA.w	#$008D			; STA $????
		STA	!OamClearCode+2, X
		TYA				; STA $YYYY
		STA	!OamClearCode+3, X
		SEC
		SBC.w	#$0004			; Y -= 4 (OAM entry size)
		TAY
		DEX				; X -= 3 (Instruction length)
		DEX
		DEX
		BPL	-

		SEP	#$30
		; shortm, shortx

		LDA.b	#$6B			; RTL
		STA	!OamClearCode+(128*3)+2	; $7F8182

		RTS

RamCodeStart:
	base !RamCodeDst
		; longm, shortx
.Retry		LDX	#$10
-		LDA	$FFDE
		CMP.w	#$A0DA			; US
		BEQ	.Detect
		CMP.w	#$8C80			; JP
		BNE	.Retry
.Detect		DEX
		BNE	-

		SEP	#$30
		; shortm, shortx

		STZ	!PPU_INIDISP
		JSR.w	(!InitSub_UploadSoundDriver, X)
		JSR.w	(!InitSub_ClearMemory, X)

		LDA.b	#$19			; Load cutscene
		STA	!GameMode
		LDA.b	#$08			; Credits
		STA	!CutsceneID

		JMP.w	!ResumeAddress
	base off
RamCodeEnd:
