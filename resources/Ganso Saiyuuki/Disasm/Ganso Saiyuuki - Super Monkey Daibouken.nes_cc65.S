; Target assembler: cc65 v2.18.0 [--target none -C Ganso Saiyuuki - Super Monkey Daibouken.nes_cc65.cfg]
;*******************************************************************************
;* Ganso Saiyuuki - Super Monkey Daibouken Disassembly                         *
;*******************************************************************************
                .setcpu "6502"
Sound_Sq1_      =       $10
Sound_Sq1_MainSequencePointer = $11
Sound_Sq2_      =       $18
Sound_Sq2_MainSequencePointer = $19
Sound_Tri_      =       $20
Sound_Tri_MainSequencePointer = $21
Sound_Noi       =       $28
Sound_Noi_      =       $28
Sound_Noi_MainSequencePointer = $29
VmMem_Pointer   =       $32
VmMem_StackFramePointer = $34
VmMem_SecondStack =     $36
VmMem_IndirectJump =    $3A                             ;Dynamic code : JMP $xxxx (4C xx xx)
ProcessStateCounter =   $3D
ProcessedStateCounter = $3F
PpuControlBuffer =      $41                             ;$41=Base nametable, $42=Base nametable, $43=Increment direction, $44=SP Address, $45=BG Address, $46=Sprite size, $47=PPU master/slave, $48=NMI enable
PpuCtrlBuffer_Bit0_BaseNametable = $41
PpuCtrlBuffer_Bit1_BaseNametable = $42
PpuCtrlBuffer_Bit2_AddrDirection = $43
PpuCtrlBuffer_Bit4_BGAddress = $45
PpuCtrlBuffer_Bit5_SpriteSize = $46
PpuCtrlBuffer_Bit7_NmiEnable = $48
PpuMaskBuffer   =       $49                             ;$49=Greyscale, $4A=BG left, $4B=SP left, $4C=BG enable, $4D=SP enable, $4E=Emphasize R, $4F=Emphasize G, $50=Emphasize B
PpuMaskBuffer_Bit1_ShowBGLeft = $4A
PpuMaskBuffer_Bit2_ShowSPLeft = $4B
PpuMaskBuffer_Bit3_ShowBG = $4C
PpuMaskBuffer_Bit4_ShowSP = $4D
ScreenX         =       $57
ScreenY         =       $59
FieldPageY      =       $BC
FieldPageX      =       $BE
DrawTextPointer =       $C0
DrawTextRequest =       $C2
RleExpandIndex  =       $C9
ChrBankRequest  =       $CA
OamDmaRequest   =       $CF
FieldDstChipX   =       $D1
FieldDstChipY   =       $D2
FieldPartyAnimationFrame = $D9                          ;4cycles
FieldPartyDirection =   $DA                             ;0=Right, 1=Left
OamBuffer       =       $0200
PaletteBuffer   =       $0300
PadBuffer_Now   =       $0320                           ;ABsS^v<>
PadBuffer_Now_A =       $0320
PadBuffer_Now_B =       $0321
PadBuffer_Now_Start =   $0323
PadBuffer_Now_Up =      $0324
PadBuffer_Now_Down =    $0325
PadBuffer_Now_Left =    $0326
PadBuffer_Now_Right =   $0327
PadBuffer_Prev  =       $0328                           ;ABsS^v<>
PadBuffer_Trigger =     $0330                           ;ABsS^v<>
PadBuffer_Trigger_A =   $0330
PadBuffer_Trigger_B =   $0331
PadBuffer_Trigger_Select = $0332
PadBuffer_Trigger_Start = $0333
OperatingParty  =       $0354                           ;0=Goku, 1=Sanzo, 2=Horse, 3=Sagojo, 4=Chohakkai
HelperParty     =       $0355                           ;0=Goku, 1=Sanzo, 2=Horse, 3=Sagojo, 4=Chohakkai
PartyLifes      =       $03C8                           ;Goku, Sanzo, Horse, Sagojo, Chohakkai
FieldTime       =       $03D4                           ;Low:$00-$1F, High:$00-$3F
ContinuePasswordInput = $0459                           ;Used by continued field Y page
ContinuePasswordPressA = $045A
PartyIn_Chohakkai =     $047E
PartyIn_Sagojo  =       $047F
VmStack_Low     =       $0600
VmStack_High    =       $0680
VmSubStackA_Low =       $0780
VmSubStackA_High =      $07A0
VmSubStackB_Low =       $07C0
VmSubStackB_High =      $07E0
PPUCTRL         =       $2000                           ;W VPHB SINN  various
PPUMASK         =       $2001                           ;W BGRs bMmG  various
PPUSTATUS       =       $2002                           ;R VSO- ----  various; read resets $2005/2006
OAMADDR         =       $2003                           ;W OAM read/write address
PPUSCROLL       =       $2005                           ;WW fine scroll position (two writes: X,Y)
PPUADDR         =       $2006                           ;WW PPU read/write address (two writes: MSB, LSB)
PPUDATA         =       $2007                           ;RW PPU data read/write
SQ1_VOL         =       $4000                           ;DDLC VVVV
SQ1_SWEEP       =       $4001                           ;EPPP NSSS
SQ1_LO          =       $4002                           ;TTTT TTTT
SQ1_HI          =       $4003                           ;LLLL LTTT
DMC_FREQ        =       $4010                           ;IL-- RRRR
OAMDMA          =       $4014                           ;AAAA AAAA  OAM DMA high address
SND_CHN         =       $4015                           ;W:---D NT21 R:IF-D NT21
JOY1            =       $4016                           ;joystick 1 data (R) and joystick strobe (W)
JOY2            =       $4017                           ;joystick 2 data (R) and frame counter (W)

;*******************************************************************************
;* iNES Header                                                                 *
;*******************************************************************************
;                .segment "SEG000"
                .org    $7FF0
                .byte   "NES"
                .byte   $1A
                .byte   $02                             ;PRG
                .byte   $04                             ;CHR
                .byte   $31                             ;Mapper=3, Mirror=Vertical
                .res    9,$00
;*******************************************************************************
;* PRG                                                                         *
;*******************************************************************************
;                .segment "SEG001"
                .org    $8000
                .word   $8000
                .word   $4000
                .word   $2000
                .word   $1000
                .word   $0800
                .word   $0400
                .word   $0200
                .word   $0100
                .word   $0080
                .word   $0040
                .word   $0020
                .word   $0010
                .word   $0008
                .word   $0004
                .word   $0002
                .word   $0001
T8020:          .word   $0001
                .word   $0005
                .word   $0080
                .word   $00C0
                .word   $00F0
                .word   $00F0
                .word   $00FC
                .word   $80FF
                .word   $00FF
                .word   $00FE
                .word   $00F0
                .word   $00F8
                .word   $00F0
                .word   $00E0
                .byte   $80
T803D:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $C1
                .byte   $FF
                .byte   $81
                .byte   $7F
                .byte   $01
                .byte   $3F
                .byte   $03
                .byte   $3E
                .byte   $03
                .byte   $3E
                .byte   $03
                .byte   $1C
                .byte   $03
                .byte   $0C
                .byte   $03
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $06
                .byte   $00
T8058:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $FF
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $78
                .byte   $F8
                .byte   $38
                .byte   $E0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
T8073:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $3F
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $03
T808E:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $03
                .byte   $BF
                .byte   $02
                .byte   $3F
                .byte   $02
                .byte   $1F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $01
                .byte   $00
T80A9:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $FC
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $80
T80C4:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $80
T80DF:          .byte   $01
                .byte   $00
                .byte   $05
                .res    15,$FF
                .byte   $CF
                .byte   $FE
                .byte   $CF
                .byte   $FC
                .byte   $87
                .byte   $3C
                .byte   $03
                .byte   $3C
                .byte   $00
T80FA:          .byte   $01
                .byte   $00
                .byte   $05
                .res    13,$FF
                .byte   $9F
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $0F
                .byte   $FE
                .byte   $0F
                .byte   $F8
                .byte   $1F
T8115:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $F0
                .byte   $1F
                .byte   $F0
                .byte   $7F
                .byte   $F0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $80
                .byte   $7F
                .byte   $C0
                .byte   $3F
                .byte   $F0
                .byte   $1F
                .byte   $F8
                .byte   $1F
                .byte   $F8
                .byte   $1F
                .byte   $F0
                .byte   $0F
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
T8130:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $01
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $2F
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $BF
                .byte   $00
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $07
T814B:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $80
                .byte   $FE
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $C0
T8164:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $FE
                .byte   $E3
                .byte   $FF
                .byte   $C1
                .byte   $FF
                .byte   $C0
                .byte   $FC
                .byte   $C0
                .byte   $78
                .byte   $80
T817F:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $FF
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $80
                .byte   $FF
T819A:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $80
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $FF
                .byte   $80
                .byte   $FF
T81B5:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $FE
T81D0:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $00
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $C0
                .byte   $3F
                .byte   $F0
                .byte   $1F
                .byte   $F8
                .byte   $07
                .byte   $F0
                .res    6,$00
                .byte   $E0
                .byte   $00
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $FC
                .byte   $FF
T81EB:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $00
                .byte   $FF
                .byte   $18
                .byte   $FC
                .byte   $78
                .byte   $E0
                .byte   $F8
                .byte   $C0
                .byte   $F0
                .byte   $E1
                .byte   $F0
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $C0
                .byte   $FF
T8206:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $FF
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $FE
                .byte   $80
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $FE
                .byte   $FF
T8221:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $F0
                .byte   $01
                .byte   $E0
                .byte   $03
                .byte   $C0
                .byte   $33
                .byte   $80
                .byte   $7F
                .byte   $00
T823C:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $01
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $1F
                .byte   $00
T8257:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $3F
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $FC
                .byte   $01
                .byte   $F8
                .byte   $01
                .byte   $F0
                .byte   $03
                .byte   $E0
                .byte   $07
                .byte   $80
                .byte   $03
                .res    10,$00
T8272:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $00
                .byte   $00
                .byte   $40
                .byte   $00
                .byte   $F0
                .byte   $01
                .byte   $FC
                .byte   $07
                .byte   $FE
                .byte   $0F
                .byte   $FF
                .byte   $1F
                .byte   $FF
                .byte   $3F
                .byte   $FF
                .byte   $7F
                .res    8,$FF
T828D:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $FC
                .byte   $80
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $FF
                .byte   $FF
T82A8:          .byte   $01
                .byte   $00
                .byte   $05
                .res    7,$00
                .byte   $0C
                .byte   $C0
                .byte   $7F
                .byte   $F0
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $80
T82C3:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $01
T82DE:          .byte   $01
                .byte   $00
                .byte   $05
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $FE
                .res    5,$FF
                .byte   $0F
                .byte   $27
                .byte   $12
                .byte   $02
                .byte   $0F
                .byte   $27
                .byte   $29
                .byte   $1A
                .byte   $0F
                .byte   $27
                .byte   $10
                .byte   $00
                .byte   $0F
                .byte   $27
                .byte   $20
                .byte   $16
                .byte   $0F
                .byte   $36
                .byte   $28
                .byte   $15
                .byte   $0F
                .byte   $36
                .byte   $30
                .byte   $13
                .byte   $0F
                .byte   $30
                .byte   $3C
                .byte   $2B
                .byte   $0F
                .byte   $16
                .byte   $26
                .byte   $0F
                .byte   $04
                .byte   $05
                .byte   $06
                .byte   $07
                .byte   $08
                .byte   $09
                .byte   $0A
                .byte   $0B
                .byte   "*+,-"
                .byte   $1E
                .byte   $1F
                .byte   $20
                .byte   $21
                .byte   $1C
                .byte   $1C
                .byte   $1D
                .byte   $1D
                .byte   $0C
                .byte   $0D
                .byte   $0E
                .byte   $0F
                .byte   $10
                .byte   $11
                .byte   $12
                .byte   $13
                .byte   $14
                .byte   $15
                .byte   $16
                .byte   $17
                .byte   $22,"#$%"
                .byte   $18
                .byte   $19
                .byte   $1A
                .byte   $1B
                .byte   "0123456789:;<=>?@ABC&'()\]^_"
L835F:          .byte   $00
                .byte   $01
                .byte   $02
                .byte   $02
                .byte   $01
                .byte   $01
                .byte   $01
                .byte   $01
                .byte   $02
                .byte   $02
                .byte   $01
                .byte   $02
                .byte   $02
                .byte   $02
                .byte   $03
                .byte   $02
                .byte   $02
T8370:          .byte   $00
                .byte   $00
T8372:          .byte   $00
                .byte   $05
                .byte   $08
                .byte   $05
                .byte   $10
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $C0
                .byte   $03
                .byte   $C0
                .byte   $03
                .byte   $C0
                .byte   $03
                .byte   $C0
                .byte   $03
                .byte   $C0
                .byte   $03
                .byte   $C0
                .byte   $03
                .byte   $C0
                .byte   $03
                .byte   $C0
                .byte   $03
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
L838F:          .byte   $08
                .byte   $05
                .byte   $10
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $00
                .byte   $00
                .byte   $C0
                .byte   $03
                .byte   $C0
                .byte   $03
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $C0
                .byte   $03
                .byte   $C0
                .byte   $03
                .byte   $00
                .byte   $00
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
T83AA:          .byte   $03
                .byte   $05
                .byte   $04
                .byte   $00
                .byte   $00
                .byte   $DE
                .byte   $7B
                .byte   $DE
                .byte   $7B
                .byte   $DE
                .byte   $7B
                .byte   $00
                .byte   $00
                .byte   $DE
                .byte   $7B
                .byte   $DE
                .byte   $7B
                .byte   $DE
                .byte   $7B
                .byte   $00
                .byte   $00
                .byte   $DE
                .byte   $7B
                .byte   $DE
                .byte   $7B
                .byte   $DE
                .byte   $7B
T83C5:          .byte   $03
                .byte   $05
                .byte   $0D
                .res    12,$00
                .byte   $80
                .res    11,$00
T83E0:          .byte   $03
                .byte   $05
                .byte   $0E
                .res    8,$00
                .byte   $40
                .byte   $01
                .byte   $00
                .byte   $00
                .byte   $A0
                .byte   $02
                .byte   $00
                .byte   $00
                .byte   $40
                .byte   $01
                .res    6,$00
T83FB:          .byte   $03
                .byte   $05
                .byte   $0F
                .res    12,$00
                .byte   $80
                .res    11,$00
T8416:          .byte   $06
                .byte   $0A
                .byte   $00
                .byte   $F0
                .byte   $1F
                .byte   $F8
                .byte   $0F
                .byte   $F8
                .byte   $0F
                .byte   $FC
                .byte   $07
                .byte   $FC
                .byte   $07
                .byte   $FC
                .byte   $07
                .byte   $F8
                .byte   $0F
                .byte   $F8
                .byte   $0F
                .byte   $FC
                .byte   $07
                .byte   $FC
                .byte   $07
                .byte   $F8
                .byte   $0F
                .byte   $F0
                .byte   $1F
T8431:          .byte   $06
                .byte   $05
                .res    5,$00
                .byte   $7F
                .byte   $00
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $1F
                .byte   $FC
                .byte   $1F
                .byte   $F0
                .byte   $1F
                .byte   $F0
                .byte   $1F
                .byte   $F0
                .byte   $1F
T844C:          .byte   $06
                .byte   $05
                .byte   $00
                .byte   $F0
                .byte   $1F
                .byte   $F0
                .byte   $3F
                .byte   $F0
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $E0
                .res    8,$00
T8467:          .byte   $05
                .byte   $05
                .byte   $0A
                .res    12,$FF
                .byte   $F0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F8
T8482:          .byte   $05
                .byte   $05
                .byte   $0A
                .res    12,$FF
                .byte   $70
                .byte   $3F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $06
                .res    6,$00
T849D:          .byte   $01
                .byte   $05
                .byte   $01
                .byte   $00
                .byte   $00
                .byte   $10
                .byte   $00
                .byte   $00
                .byte   $10
                .byte   $00
                .byte   $00
                .byte   $08
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $08
                .byte   $01
                .byte   $00
                .byte   $00
                .byte   $10
                .byte   $04
                .byte   $00
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $01
T84B8:          .byte   $05
                .byte   $05
                .byte   $06
                .byte   $40
                .byte   $00
                .byte   $00
                .byte   $10
                .byte   $01
                .byte   $02
                .byte   $20
                .byte   $80
                .byte   $00
                .byte   $10
                .byte   $04
                .byte   $00
                .byte   $20
                .byte   $00
                .byte   $00
                .byte   $44
                .byte   $02
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $00
                .byte   $08
                .byte   $04
                .byte   $00
T84D3:          .byte   $05
                .byte   $05
                .byte   $09
                .byte   $00
                .byte   $22
                .byte   $08
                .byte   $04
                .byte   $41
                .byte   $20
                .byte   $00
                .byte   $00
                .byte   $08
                .byte   $02
                .byte   $08
                .byte   $80
                .byte   $00
                .byte   $80
                .byte   $41
                .byte   $18
                .byte   $09
                .byte   $10
                .byte   $01
                .byte   $02
                .byte   $40
                .byte   $00
                .byte   $08
                .byte   $20
T84EE:          .byte   $05
                .byte   $05
                .byte   $0A
                .res    12,$FF
                .byte   $7F
                .byte   $FE
                .byte   $7F
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $7F
                .byte   $00
T8509:          .byte   $05
                .byte   $05
                .byte   $0A
                .byte   $03
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $37
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $06
                .byte   $FF
                .byte   $1F
                .byte   $FF
                .byte   $7F
                .byte   $FF
                .byte   $FF
T8524:          .byte   $05
                .byte   $05
                .byte   $0A
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FC
                .byte   $F0
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FE
                .res    5,$FF
T853F:          .byte   $05
                .byte   $05
                .byte   $0A
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $00
T855A:          .byte   $00
                .byte   $03
                .byte   $08
                .byte   $00
                .byte   $08
                .byte   $21
                .byte   $01
                .byte   $00
                .byte   $20
                .byte   $24
                .byte   $00
                .byte   $00
                .byte   $04
                .byte   $00
                .byte   $18
                .byte   $08
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $84
                .byte   $00
                .byte   $00
                .byte   $20
                .byte   $00
                .byte   $01
                .byte   $02
                .byte   $C4
T8575:          .byte   $02
                .byte   $03
                .byte   $0B
                .byte   $01
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $1F
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
T8590:          .byte   $02
                .byte   $05
                .byte   $0B
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $80
T85AB:          .byte   $06
                .byte   $05
                .byte   $00
                .byte   $FC
                .byte   $07
                .byte   $F8
                .byte   $0F
                .byte   $F0
                .byte   $1F
                .byte   $E0
                .byte   $1F
                .byte   $F0
                .byte   $3F
                .byte   $FC
                .byte   $3F
                .byte   $7E
                .byte   $1F
                .byte   $3E
                .byte   $1F
                .byte   $0C
                .byte   $1E
                .byte   "88`x"
                .byte   $00
                .byte   $3C
T85C6:          .byte   $07
                .byte   $05
                .byte   $0A
                .res    12,$00
                .byte   $FE
                .byte   $00
                .byte   $FF
                .byte   $0F
                .byte   $F0
                .byte   $3F
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $F8
T85E1:          .byte   $04
                .byte   $05
                .byte   $0A
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $7F
                .byte   $FF
                .byte   $3F
                .byte   $9F
                .byte   $03
                .byte   $07
                .res    15,$00
T85FC:          .byte   $07
                .byte   $05
                .byte   $0A
                .res    9,$FF
                .byte   $8F
                .byte   $FF
                .byte   $03
                .byte   $DF
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $01
                .byte   $00
T8617:          .byte   $06
                .byte   $05
                .byte   $0A
                .byte   $00
                .byte   $80
                .byte   $00
.macro          HiAscii Arg
                .repeat .strlen(Arg), I
                .byte   .strat(Arg, I) | $80
                .endrep
.endmacro
                HiAscii "d@v`"
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $F0
                .byte   $FF
T8632:          .byte   $06
                .byte   $05
                .byte   $0A
                .res    8,$00
                .byte   $07
                .byte   $00
                .byte   $0F
                .byte   $7F
                .byte   $C7
                .byte   $FF
                .byte   $E7
                .byte   $FF
                .byte   $C3
                .byte   $FF
                HiAscii "`xpp`a"
T864D:          .byte   $05
                .byte   $05
                .byte   $0A
                .res    9,$00
                .byte   $F0
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $F9
                .byte   $7F
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $01
T8668:          .byte   $08
                .byte   $05
                .byte   $07
                .byte   $B8
                .byte   $0C
                .byte   ",G\p"
                .byte   $09
                .byte   $E9
                .byte   $22
                .byte   $00
                .byte   $D0
                .byte   $C2
                .byte   $46
                .byte   $68
                .byte   $00
                .byte   $C4
                .byte   $87
                .byte   $10
                .byte   $30
                .byte   $26
                .byte   $99
                .byte   $88
                .byte   $22
                .byte   $18
T8683:          .byte   $03
                .byte   $03
                .byte   $0B
                .res    18,$00
                .byte   $E0
                .res    5,$FF
T869E:          .byte   $03
                .byte   $03
                .byte   $0B
                .res    5,$FF
                .byte   $7F
                .byte   $FF
                .byte   $01
                .byte   $0F
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $CF
                .byte   $08
                .byte   $FF
                .byte   $1D
                .byte   $FF
                .byte   $7F
                .byte   $FF
                .byte   $7F
                .byte   $FF
                .byte   $FF
T86B9:          .byte   $03
                .byte   $05
                .byte   $0A
                .byte   $01
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $0F
                .byte   $80
                .byte   $1F
                .byte   $C0
                .byte   $3F
                .byte   $E0
                .byte   $7F
                .byte   $FC
                .byte   $7F
                .byte   $FE
                .byte   $3F
                .byte   $FC
                .byte   $3F
                .byte   $F8
                .byte   $1F
                .byte   $FC
                .byte   $0F
                .byte   $FE
                .byte   $87
                .byte   $FF
T86D4:          .byte   $07
                .byte   $05
                .byte   $0A
                .byte   $E0
                .byte   $E0
                .byte   $70
                .byte   $C0
                .byte   $C3
                .byte   $E1
                .byte   $07
                .byte   $F2
                .byte   $07
                .byte   $F0
                .byte   $47
                .byte   $F0
                .byte   $63
                .byte   $FC
                .byte   $63
                HiAscii "xcqccsGs"
                .byte   $8F
T86EF:          .byte   $06
                .byte   $05
                .byte   $0A
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $F8,$C1,$F0,$E0,$E0,$F1,$E1,$F1,$C7,$F1,$C7,$E1,$C7,$E3,$87,$C7
                .byte   $CF,$C7
T870A:          .byte   $07
                .byte   $05
                .byte   $0A
                .byte   $E0
                .byte   $01
                .byte   $C0
                .byte   $07
                .byte   $C0
                .byte   $0F
                .byte   $00
                .byte   $1F
                .byte   $01
                .byte   $0E
                .byte   $07
                .byte   $1E
                .byte   $0F
                .byte   $3C
                .byte   $1F
                .byte   $3C
                .byte   $3F
                .byte   $38
                .byte   $FE
                .byte   $30
                .byte   $F0
                .byte   $31
                .byte   $E0
                .byte   $33
T8725:          .byte   $08
                .byte   $05
                .byte   $0A
                .byte   $F0
                .byte   $00
                .byte   $78
                .byte   $00
                .byte   $7C
                .byte   $00
                .byte   $FE
                .byte   $03
                .byte   $FE
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $80
                .byte   $E7
                .byte   $00
                .byte   $02
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
T8740:          .byte   $02
                .byte   $05
                .byte   $0B
                .byte   $FF
                .byte   $3F
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $01
                .byte   $3F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $00
                .byte   $00
T875B:          .byte   $03
                .byte   $03
                .byte   $0B
                .byte   $01
                .byte   $C0
                .byte   $03
                .byte   $E0
                .byte   $07
                .byte   $E0
                .byte   $07
                .byte   $F0
                .byte   $03
                .byte   $F0
                .byte   $0F
                .byte   $E0
                .byte   $07
                .byte   $F0
                .byte   $0F
                .byte   $E0
                .byte   $0F
                .byte   $E0
                .byte   $0F
                .byte   $F0
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
T8776:          .byte   $02
                .byte   $05
                .byte   $0A
                .byte   $F0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $7E
                .byte   $00
                .byte   "<8<p8x"
                .byte   $18
                .byte   "?<?<"
                .byte   $1F
                .byte   $3E
                .byte   $0F
                .byte   $7E
                .byte   $07
                .byte   $7F
T8791:          .byte   $07
                .byte   $05
                .byte   $0A
                .byte   $87
                .byte   $7F
                .byte   $8F
                .byte   $1F
                .byte   $CC
                .byte   $0F
                .byte   $80
                .byte   $0F
                .byte   $00
                .byte   $1F
                .byte   $81
                .byte   $3F
                .byte   $83
                .byte   $7F
                .byte   $0F
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $1F
                .byte   $FE
                .byte   $0F
                .byte   $FF
                .byte   $3F
                .byte   $FE
T87AC:          .byte   $07
                .byte   $05
                .byte   $0A
                .byte   $F3
                .byte   $C3
                .byte   $F3
                .byte   $83
                .byte   $E1
                .byte   $07
                .byte   $C0
                .byte   $0F
                .byte   $80
                .byte   $3F
                .byte   $07
                .byte   $FE
                .byte   $1F
                .byte   $FC
                .byte   $3F
                .byte   $FC
                .byte   $7F
                HiAscii "xpp@a"
                .byte   $83
                .byte   $C3
T87C7:          .byte   $04
                .byte   $05
                .byte   $0A
                .byte   $C7,$CF,$87,$CF
                .byte   $0F
                .byte   $8F
                .byte   $07
                .byte   $0E
                .byte   $07
                .byte   $06
                .byte   $63
                .byte   $80
                .byte   $63
                HiAscii "@gAcCg"
                .byte   $07
                .byte   $E3
                .byte   $0F
                .byte   $C7
                .byte   $C3
T87E2:          .byte   $06
                .byte   $05
                .byte   $0A
                .byte   $F0
                .byte   $31
                .byte   $FC
                .byte   $01
                .byte   $FF
                .byte   $00
                .byte   $3F
                .byte   $18
                .byte   $3F
                .byte   $38
                .byte   $7F
                .byte   $38
                .byte   $79
                .byte   $1C
                .byte   $38
                .byte   $38
                .byte   $3E
                .byte   $1C
                .byte   $1F
                .byte   $38
                .byte   $7F
                .byte   $30
                .byte   $FF
                .byte   $31
T87FD:          .byte   $03
                .byte   $05
                .byte   $0A
                .byte   $FC
                .byte   $01
                .byte   $FE
                .byte   $0F
                .byte   $07
                .byte   $FF
                .byte   $E3
                .byte   $FF
                .byte   $02
                .byte   $E0
                .byte   $02
                .byte   $F0
                .byte   $07
                .byte   $FE
                .byte   $03
                .byte   $7E
                .byte   $E0
                .byte   $3F
                .byte   $F0
                .byte   $1F
                .byte   $F8
                .byte   $07
                .byte   $F0
                .byte   $00
T8818:          .byte   $01
                .byte   $05
                .byte   $0A
                .byte   $FF
                .byte   $FF
                .byte   $1F
                .byte   $3C
                .byte   $0F
                .byte   $1E
                .byte   $86
                .byte   $1F
                .byte   $80
                .byte   $3F
                .byte   $C0
                .byte   $3F
                .byte   $C0
                .byte   $3F
                .byte   $80
                .byte   $3F
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $7E
                .byte   $18
                .byte   $7E
                .byte   $3C
                .byte   $FC
T8833:          .byte   $07
                .byte   $05
                .byte   $0A
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $1F
                .byte   $80
                .byte   $3F
                .byte   $FF
                .byte   $7F
                .byte   $FF
                .byte   $7F
                .byte   $7F
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $C3
                .byte   $01
                .byte   $80
                .byte   $7F
                .byte   $C0
                .byte   $7F
                .byte   $E0
                .byte   $7F
                .byte   $FC
                .byte   $7F
T884E:          .byte   $07
                .byte   $05
                .byte   $0A
                .byte   $3F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $FF
                .byte   $01
                .byte   $FC
                .byte   $CD
                .byte   $F8
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $E0
                .byte   $7F
                .byte   $F0
                .byte   $1F
                .byte   $E0
                .byte   $0F
                .byte   $F0
                .byte   $07
T8869:          .byte   $05
                .byte   $05
                .byte   $0A
                .byte   $83
                .byte   $C3
                .byte   $01
                .byte   $C0
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $06
                .byte   $CC
                .byte   $07
                .byte   $CF
                .byte   $67
                .byte   $CF
                .byte   $E7
                .byte   $8F
                HiAscii "cGc`q"
                .byte   $00
                .byte   $F8
                .byte   $07
                .byte   $FC
T8884:          .byte   $06
                .byte   $05
                .byte   $0A
                .byte   $71
                .byte   $F8
                .byte   $71
                .byte   $FC
                .byte   "p|x<x"
                .byte   $00
                .byte   $78
                .byte   $00
                .byte   $7C
                .byte   $F8
                .byte   $3F
                .byte   $FC
                .byte   $1F
                .byte   $80
                .byte   $0F
                .byte   $00
                .byte   $07
                .byte   $1F
                .byte   $C1
                .byte   $FF
T889F:          .byte   $09
                .byte   $05
                .byte   $0A
                .byte   $7F
                .byte   $00
                .byte   $7E
                .byte   $00
                .byte   $FC
                .byte   $01
                .byte   $F8
                .byte   $07
                .byte   $E0
                .byte   $1F
                .byte   $80
                .byte   $3F
                .byte   $00
                .byte   $7E
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $C0
T88BA:          .byte   $04
                .byte   $05
                .byte   $00
                .byte   $C0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $F0
                .res    10,$00
T88D5:          .byte   $05
                .byte   $05
                .byte   $0A
                .byte   $3E
                .byte   $FC
                .byte   $3F
                .byte   $F8
                .byte   $0F
                .byte   $F8
                .byte   $00
                .byte   $70
                .byte   $C0
                .byte   $71
                .byte   $F0
                .byte   $31
                .byte   $F8
                .byte   "0|088"
                .byte   $00
                .byte   $38
                .byte   $00
                .byte   $7C
                .byte   $00
                .byte   $FE
T88F0:          .byte   $06
                .byte   $05
                .byte   $0A
                .byte   $01
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FE
                .byte   $03
                .byte   $FC
                .byte   $07
                .byte   $F8
                .byte   $07
                .byte   $F0
                .byte   $0F
                .byte   $F0
                .byte   $0F
                .byte   $F0
                .byte   $0F
                .byte   $F8
                .byte   $07
T890B:          .byte   $06
                .byte   $05
                .byte   $0A
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $C0
                .byte   $1F
                .byte   $C0
                .byte   $FF
                .byte   $E1
                .byte   $3F
                .byte   $F0
                .byte   $0F
                .byte   $F8
                .byte   $07
                .byte   $3E
                .byte   $81
                .byte   $1F
                .byte   $E0
                .byte   $0F
                .byte   $F0
                .byte   $03
                .byte   $78
                .byte   $00
                .byte   $0C
                .byte   $00
T8926:          .byte   $09
                .byte   $05
                .byte   $0A
                .byte   $F0
                .byte   $03
                .byte   $F8
                .byte   $07
                .byte   $F8
                .byte   $1F
                .byte   $F0
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $E1
                .byte   $FF
                .byte   $C1
                .byte   $FF
                .byte   $C3
                .byte   $7F
                .byte   $83
                .byte   $3F
                .byte   $83
                .byte   $3F
                .byte   $E3
                .byte   $0F
                .byte   $E3
                .byte   $03
T8941:          .byte   $08
                .byte   $05
                .byte   $0A
                .byte   $1F
                .byte   $3F
                .byte   $07
                .byte   $0F
                .byte   $83
                .byte   $03
                .byte   $E1
                .byte   $03
                .byte   $F0
                .byte   $81
                .byte   $F8
                .byte   $C3
                .byte   $FF
                .byte   $C3
                .byte   $FF
                .byte   $E3
                .byte   $FF
                .byte   $E0
                .byte   $7C
                .byte   $F0
                .byte   $30
                .byte   $FC
                .byte   $00
                .byte   $F8
T895C:          .byte   $06
                .byte   $05
                .byte   $0A
                .byte   $E3
                .byte   $FF
                .byte   $C3
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $07
                .byte   $FE
                .byte   $07,"|",$07,"0"
                .byte   $03
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $3E
                .byte   $00
                .byte   $FC
                .byte   $01
T8977:          .byte   $01
                .byte   $05
                .byte   $0A
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $E0
                .byte   $07
                .byte   $FE
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $00
                .byte   $E0
                .byte   $05
                .byte   $05
                .byte   $0A
                .byte   $03
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $3F
                .byte   $FC
                .byte   $7F
                .byte   $FE
                .res    5,$FF
                .byte   $07
                .byte   $7F
                .byte   $00
T89AD:          .byte   $04
                .byte   $05
                .byte   $0A
                .byte   $FC
                .byte   $07
                .byte   $FE
                .byte   $83
                .byte   $FF
                .byte   $C0
                .byte   $7F
                .byte   $C0
                .byte   $3F
                .byte   $E0
                .byte   $0F
                .byte   $E0
                .byte   $07
                .byte   $F8
                .byte   $03
                .byte   $FC
                .byte   $01
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $38
                .byte   $F0
T89C8:          .byte   $05
                .byte   $05
                .byte   $0A
                .res    7,$00
                .byte   $80
                .byte   $03
                .byte   $C0
                .byte   $07
                .byte   $F0
                .byte   $FF
                .byte   $38
                .byte   $33
                .byte   $00
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $FF
                .byte   $F8
                .byte   $3F
                .byte   $FF
                .byte   $0F
T89E3:          .byte   $06
                .byte   $05
                .byte   $00
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $E0
                .byte   $03
                .byte   $30
                .byte   $07
                .byte   $38
                .byte   $0F
                .byte   $1C
                .byte   $0F
                .byte   $38
                .byte   $1F
                .byte   $3C
                .byte   $3F
                .byte   $1E
                .byte   $7C
                .byte   $1E
                .byte   $F8
                .byte   $0F
                .byte   $E0
                .byte   $07
                .byte   $80
                .byte   $03
T89FE:          .byte   $06
                .byte   $05
                .byte   $00
                .byte   $F8
                .byte   $0F
                .byte   $FC
                .byte   $3F
                .res    6,$FF
                .byte   $7F
                .byte   $FE
                .byte   $07
                .byte   $F0
                .byte   $03
                .byte   $E0
                .res    8,$00
T8A19:          .byte   $06
                .byte   $05
                .res    5,$00
                .byte   $01
                .byte   $C0
                .byte   $07
                .byte   $E0
                .byte   $0F
                .byte   $E0
                .byte   $1F
                .byte   $F0
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $FF
                .byte   $FE
                .byte   $7F
                .byte   $F8
                .byte   $3F
                .byte   $E0
                .byte   $1F
                .byte   $80
                .byte   $07
T8A34:          .byte   $06
                .byte   $05
                .byte   $0A
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $0F
                .byte   $FE
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $00
                .byte   $8F
                .byte   $0F
                .byte   $FF
                .byte   $FF
                .byte   $87
                .byte   $FF
                .byte   $00
                .byte   $7E
                .byte   $00
                .byte   $7C
                .byte   $1F
                .byte   $3E
                .byte   $7F
                .byte   $1C
T8A4F:          .byte   $07
                .byte   $05
                .byte   $0A
                .byte   $00
                HiAscii "x@ppA~"
                .byte   $07
                .byte   $87
                .byte   $0F
                .byte   $03
                .byte   $FC
                .byte   $0F
                .byte   $F8
                .byte   $1F
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $F8
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $C0
T8A6A:          .byte   $06
                .byte   $05
                .byte   $0A
                .byte   $7F
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $7E
                .byte   $00
                .byte   $F8
                .byte   $02
                HiAscii "|bx~"
                .byte   $78
                .byte   $FE
                .byte   $F8
                .byte   $FF
                .byte   $F0
                .byte   $1F
                .byte   $C0
                .byte   $03
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
T8A85:          .byte   $09
                .byte   $05
                .byte   $0A
                .byte   $3F
                .byte   $0C
                .byte   $78
                .byte   $08
                .byte   $F0
                .byte   $80
                HiAscii "`Apa"
                .byte   $3C
                .byte   $E1
                .byte   $FE
                .byte   $00
                .byte   $7E
                .byte   $00
                .byte   $FC
                .byte   $01
                .byte   $FE
                .byte   $07
                .byte   $C0
                .byte   $7F
                .byte   $00
                .byte   $7F
T8AA0:          .byte   $04
                .byte   $05
                .byte   $0A
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $E0
                .byte   $03
                .byte   $F0
                .byte   $0F
                .byte   $F8
                .byte   $0F
                .byte   $F8
                .byte   $1F
                .byte   $70
                .byte   $3F
                .byte   $78
                .byte   $1F
                .byte   $F8
                .byte   $3F
                .byte   $7C
                .byte   $FE
                .byte   $3F
                .byte   $F0
                .byte   $1F
                .byte   $80
                .byte   $07
T8ABB:          .byte   $08
                .byte   $05
                .byte   $0A
                .byte   $01
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $1F
                .byte   $F0
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $F0
                .byte   $E1
                .byte   $38
                .byte   $C0
                .res    8,$00
T8AD6:          .byte   $08
                .byte   $05
                .byte   $0A
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $FE
                .byte   $E0
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $3F
                .byte   $9F
                .byte   $1F
                .byte   $0F
                .byte   $0F
                .byte   $1E
                .byte   $0E
                .byte   $3C
                .byte   $00
                .byte   $78
                .byte   $00
                .byte   $70
                .byte   $00
T8AF1:          .byte   $08
                .byte   $05
                .byte   $0A
                .byte   $1F
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $00
                .byte   $C7
                .byte   $E0
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $0F
                .byte   $1F
                .byte   $03
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $00
                .byte   $00
T8B0C:          .byte   $08
                .byte   $05
                .byte   $0A
                .byte   $1E
                .byte   $80
                .byte   $3F
                .byte   $C0
                .byte   $FF
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $1E
                .byte   $3C
                .byte   $FC
                .byte   $01
                .byte   $78
                .byte   $00
                .byte   $FC
                .byte   $01
                .byte   $F8
                .byte   $F0
                .byte   $3C
                .byte   $FC
                .byte   $F8
                .byte   $FF
                .byte   $F0
                .byte   $7F
T8B27:          .byte   $08
                .byte   $05
                .byte   $00
                .byte   $F0
                .byte   $1F
                .byte   $E0
                .byte   $3F
                .byte   $C0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $FC
                .byte   $E3
                .byte   $FE
                .byte   $01
                .byte   $3F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $0F
                .byte   $00
T8B42:          .byte   $06
                .byte   $05
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $0F
                .byte   $1C
                .byte   $1F
                .byte   $3E
                .byte   $3F
                .byte   $7E
                .byte   $1F
                .byte   $7E
                .byte   $1E
                .byte   $7E
                .byte   $0E
                .byte   $3E
                .byte   $1E
                .byte   $3F
                .byte   $FC
                .byte   $1F
                .byte   $F8
                .byte   $07
                .byte   $F0
                .byte   $03
                .byte   $C0
                .byte   $01
T8B5D:          .byte   $06
                .byte   $05
                .byte   $00
                .byte   $00
                .byte   $06
                .byte   $00
                .byte   $0F
                .byte   $07
                .byte   $1F
                .byte   $0F
                .byte   $3C
                .byte   $7F
                .byte   $7E
                .byte   $FF
                .byte   $7F
                .byte   $FF
                .byte   $FF
                .byte   $FC
                .byte   $7F
                .byte   $F0
                .byte   $3F
                .byte   $E0
                .byte   $1F
                .byte   $C0
                .byte   $07
                .byte   $C0
                .byte   $01
T8B78:          .byte   $06
                .byte   $05
                .byte   $00
                .byte   $3E
                .byte   $00
                .byte   $1E
                .byte   $00
                .byte   $3E
                .byte   $00
                .byte   $7C
                .byte   $00
                .byte   $7C
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $7C
                .byte   $00
                .byte   $7E
                .byte   $00
                .byte   $3E
                .byte   $00
                .byte   $0F
                .byte   $00
T8B93:          .byte   $05
                .byte   $05
                .byte   $0A
                .byte   $E0
                .byte   $01
                .byte   $F8
                .byte   $07
                .byte   $FE
                .byte   $1F
                .byte   $0E
                .byte   $3C
                .byte   $0F
                .byte   $38
                .byte   $0F
                .byte   $00
                .byte   $1E
                .byte   $00
                .byte   $3F
                .byte   $70
                .byte   $3F
                .byte   $FC
                .byte   $3F
                .byte   $CE
                .byte   $3F
                .byte   $0E
                .byte   $7F
                .byte   $1C
T8BAE:          .byte   $03
                .byte   $05
                .byte   $0C
                .res    12,$FF
                .byte   $3C
                .byte   $3E
                .byte   $18
                .byte   $18
                .byte   $00
                .byte   $08
                .res    6,$00
T8BC9:          .byte   $03
                .byte   $05
                .byte   $0C
                .res    12,$FF
                .byte   $7F
                .byte   $7F
                .byte   $07
                .byte   $3E
                .byte   $01
                .byte   $1F
                .byte   $E1
                .byte   $1F
                .byte   $C0
                .byte   $0F
                .byte   $00
                .byte   $00
T8BE4:          .byte   $03
                .byte   $05
                .byte   $0B
                .res    12,$FF
                .byte   $00
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $F8
                .res    7,$FF
T8BFF:          .byte   $03
                .byte   $05
                .byte   $0B
                .res    12,$FF
                .byte   $E0
                .byte   $07
                .byte   $00
                .byte   $00
                .byte   $1C
                .byte   $F8
                .res    6,$FF
T8C1A:          .byte   $03
                .byte   $05
                .byte   $0B
                .res    12,$FF
                .byte   $7F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $07
                .byte   $1F
                .byte   $87
                .byte   $FF
                .byte   $C7
                .byte   $FF
                .byte   $C7
                .byte   $FF
T8C35:          .byte   $00
                .byte   $0B
T8C37:          .byte   $00
                .byte   $0C
T8C39:          .byte   $03
                .byte   $05
                .byte   $0C
                .res    6,$00
                .byte   $0F
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $1F
                .byte   $FC
                .byte   $3F
                .byte   $F8
                .byte   $3F
                .byte   $FC
                .byte   $7F
                .byte   $FE
                .byte   $FF
                .byte   $FF
                .byte   $FF
T8C54:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $C7
                .byte   $82
                .byte   $E7
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FC
                .byte   $01
                .byte   $38
                .res    10,$00
T8C6F:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $E0
                .byte   $CF
                .byte   $38
                .byte   $FE
                .byte   $3C
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $0C
                .byte   $9F
                .byte   $80
                .byte   $07
                .byte   $80
                .byte   $01
                .byte   $80
                .byte   $03
                .byte   $C0
                .byte   $01
                .byte   $F8
                .byte   $00
T8C8A:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $01
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $01
                .byte   $7F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $03
T8CA5:          .byte   $03
                .byte   $03
                .byte   $0B
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $00
T8CC0:          .byte   $03
                .byte   $03
                .byte   $0B
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $00
                .byte   $00
                .byte   $FF
                .byte   $1D
                .byte   $FF
                .byte   $DD
                .byte   $00
                .byte   $C4
                .byte   $BD
                .byte   $D7
                .byte   $80
                .byte   $D7
                .byte   $2C
                HiAscii "P%W5W"
                .byte   $81
                .byte   $C7
T8CDB:          .byte   $03
                .byte   $03
                .byte   $0B
                .res    5,$FF
                .byte   $00
                .byte   $81
                .byte   $DE
                .byte   $BD
                .byte   $DE
                .byte   $2D
                .byte   $02
                .byte   $6D
                .byte   $FB
                .byte   $2D
                .byte   $F8
                .byte   $A1
                .byte   $0B
                .byte   $BF
                .byte   $EB
                .byte   $81
                .byte   $EB
                .byte   $FD
                .byte   $EB
T8CF6:          .byte   $03
                .byte   $03
                .byte   $0B
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $86
                .byte   $83
                .byte   $B6
                .byte   $EB
                .byte   $B6
                .byte   $0B
                .byte   $B6
                .byte   $7B
                .byte   $36
                .byte   $0A
                .byte   $B6
                .byte   $6A
                .byte   $B6
                .byte   $62
                .byte   $B0
                .byte   $7E
                .byte   $BE
                .byte   $08
                .byte   $B6
                .byte   $EB
T8D11:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $C7
                .byte   $FF
                .byte   $C6
                .byte   $FF
                .byte   $E7
                .byte   $01
                .byte   $F3
                .byte   $FD
                .byte   $F3
                .byte   $81
                .byte   $E3
                .byte   $BF
                .byte   $07
                .byte   $BE
                .byte   $FF
                HiAscii ">~0|7|7~0"
T8D2C:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $3F
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $00
                .byte   $00
T8D47:          .byte   $03
                .byte   $03
                .byte   $0B
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FE
                .byte   $E0
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $FF
                .byte   $FF
T8D62:          .byte   $03
                .byte   $03
                .byte   $0B
                .res    12,$FF
                .byte   $1C
                .byte   $7E
                .byte   $00
                .byte   $18
                .res    8,$00
T8D7D:          .byte   $03
                .byte   $03
                .byte   $0B
                HiAscii "=W<Q"
                .byte   $85
                .byte   $D5
                .byte   $34
                .byte   $D4,$87,$D5,$EF,$D5
                .byte   $00
                HiAscii "T;W;W"
                .byte   $38
                .byte   $C0
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
T8D98:          .byte   $03
                .byte   $03
                .byte   $0B
                .byte   $01
                .byte   $EB
                .byte   $7F
                .byte   $00
                .byte   $81
                .byte   $FF
                .byte   $3D
                .byte   $00
                HiAscii "?~?^"
                .byte   $81
                .byte   $50
                .byte   $FD
                .byte   $17
                .byte   $BD
                .byte   $F7
                .byte   $80
                .byte   $70
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
T8DB3:          .byte   $03
                .byte   $03
                .byte   $0B
                HiAscii "6h6n6"
                .byte   $80
                HiAscii "6g6g6g6a"
                .byte   $86
                .byte   $E5
                .byte   $F0
                .byte   $E5
                .byte   $1F
                .byte   $04
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
T8DCE:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $FF
                HiAscii ">~>p>p"
                .byte   $82
                HiAscii "xzxzp"
                .byte   $02
                .byte   $C0
                .byte   $F6
                .byte   $C0
                .byte   $00
                .byte   $E0
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $FE
                .byte   $FF
T8DE9:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $7F
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $3F
                .byte   $FF
                .byte   $7F
                .byte   $C7
                .byte   $3F
                .byte   $0F
                .byte   $1E
                .byte   $1F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $3F
                .byte   $00
T8E04:          .byte   $03
                .byte   $05
                .byte   $0C
                .res    12,$FF
                .byte   $7F
                .byte   $FF
                .byte   $1F
                .byte   $FF
                .byte   $87
                .byte   $FF
                .byte   $83
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $07
                .byte   $FF
T8E1F:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $FF
                .byte   $FF
                .byte   $FE
                .byte   $7F
                .byte   $78
                .byte   $3F
                .byte   $38
                .byte   $16
                .byte   $30
                .res    15,$00
T8E3A:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $1F
                .byte   $FF
                .byte   $1F
                .byte   $FF
                .byte   $3F
                .byte   $FF
                .byte   $7F
                .byte   $FF
                .byte   $7F
                .res    6,$FF
T8E55:          .byte   $03
                .byte   $03
                .byte   $0B
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $9F
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $FF
T8E70:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $7F
                .byte   $00
                .byte   $3F
                .byte   $E0
                .byte   $1F
                .byte   $F0
                .byte   $1F
                .byte   $C0
                .byte   $3F
                .byte   $E0
                .byte   $3F
                .byte   $F0
                .byte   $0F
                .byte   $F8
                .byte   $3F
                .byte   $F8
                .byte   $3F
                .byte   $FC
                .byte   $1F
                .byte   $FC
                .byte   $3F
                .byte   $FC
                .byte   $3F
                .byte   $F8
T8E8B:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $83
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $1F
                .byte   $FF
                .byte   $1F
                .byte   $FF
                .byte   $8F
                .byte   $FF
                .byte   $8F
                .byte   $FF
                .byte   $C7
                .byte   $FF
                .byte   $C7
                .byte   $FF
                .byte   $E7
                .byte   $FF
                .byte   $C7
                .byte   $FF
                .byte   $CF
                .byte   $FF
T8EA6:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $00
                .byte   $70
                .byte   $00
                .byte   $78
                .byte   $00
                .byte   $3C
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $07
                .byte   $80
                .byte   $03
                .byte   $80
                .byte   $03
                .byte   $E0
                .byte   $01
                .byte   $F8
                .byte   $01
                .byte   $FC
                .byte   $01
                .byte   $7E
                .byte   $00
                .byte   $3F
                .byte   $00
T8EC1:          .byte   $03
                .byte   $03
                .byte   $0B
                .byte   $FF
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $E0
                .byte   $80
                .byte   $FF
                .byte   $C0
                .byte   $FF
T8EDC:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $FF
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $00
                .byte   $1C
                .res    18,$00
T8EF7:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $3F
                .byte   $E0
                .byte   $3F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $01
                .byte   $00
T8F12:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $1F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $01
                .res    5,$00
T8F2D:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $FF
                .byte   $80
                .byte   $3F
                .byte   $C0
                .byte   $0F
                .byte   $C0
                .byte   $07
                .byte   $E0
                .byte   $01
                .byte   $F8
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FF
                .byte   $C0
                .res    9,$FF
T8F48:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $FF
                .byte   $FF
                .byte   $FE
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $80
T8F63:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $CF
                .byte   $FF
                .byte   $8F
                .byte   $FF
                .byte   $87
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $FE
                .res    7,$FF
T8F7E:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $C0
                .byte   $7F
                .byte   $E0
                .byte   $1F
                .byte   $F0
                .byte   $1F
                .byte   $FC
                .byte   $0F
                .byte   $FE
                .byte   $87
                .byte   $FF
                .byte   $C3
                .byte   $FF
                .byte   $C1
T8F99:          .byte   $03
                .byte   $05
                .byte   $0B
                .res    5,$FF
                .byte   $F0
                .byte   $3F
                .byte   $F0
                .byte   $1F
                .byte   $E0
                .byte   $07
                .byte   $E0
                .byte   $03
                .byte   $E0
                .byte   $03
                .byte   $F0
                .byte   $03
                .byte   $F0
                .byte   $03
                .byte   $F8
                .byte   $01
                .byte   $F0
                .byte   $01
                .byte   $C0
T8FB4:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $1F
                .byte   $FE
                .byte   $0F
                .byte   $FE
                .byte   $07
                .byte   $FC
                .byte   $03
                .byte   $F8
                .byte   $01
                .res    12,$00
T8FCF:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $7E
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $FC
                .byte   $01
                .byte   $F8
                .byte   $03
                .byte   $F0
                .byte   $03
                .byte   $F0
                .byte   $07
                .byte   $E0
                .byte   $07
                .byte   $C0
                .byte   $1F
                .byte   $80
                .byte   $3F
                .byte   $00
                .byte   $7C
                .byte   $00
                .byte   $F8
T8FEA:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $FF
                .byte   $C1
                .byte   $3F
                .byte   $C0
                .byte   $07
                .byte   $E0
                .byte   $03
                .byte   $E0
                .byte   $01
                .byte   $70
                .byte   $03
                .byte   $30
                .byte   $07
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $9F
                .byte   $03
                .byte   $FF
                .byte   $87
                .byte   $FF
                .byte   $CF
                .byte   $FF
                .byte   $C7
T9005:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F0
T9020:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $F0
                .byte   $FF
                .byte   $C0
                .byte   $0F
                .byte   $80
                .byte   $07
                .byte   $80
                .byte   $0F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $7E
                .byte   $0F
                .byte   $7C
                .byte   $3F
                .byte   $FC
                .byte   $7F
                .byte   $FC
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $7F
                .byte   $FF
                .byte   $3F
T903B:          .byte   $03
                .byte   $05
                .byte   $0B
                .res    10,$00
                .byte   $70
                .byte   $00
                .byte   $F8
                .byte   $C3
                .byte   $FF
                .byte   $E7
                .res    8,$FF
T9056:          .byte   $03
                .byte   $05
                .byte   $0B
                .res    15,$00
                .byte   $F0
                .byte   $00
                .byte   $FF
                .byte   $FE
                .res    5,$FF
T9071:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $01
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $07
                .byte   $01
                .byte   $CF
                .byte   $07
                .byte   $FF
                .byte   $1F
                .byte   $FF
                .byte   $3F
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
T908C:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $0F
                .byte   $0F
                .byte   $0E
                .byte   $0E
                .byte   $18
                .byte   $3C
                .byte   $00
                .byte   $1F
                .byte   $06
                .byte   $3C
                .byte   $1E
                .byte   $3E
                .byte   $70
                .byte   $78
                HiAscii "qpsCG"
                .byte   $81
                .byte   $87
                .byte   $03
                .byte   $0E
                .byte   $0F
T90A7:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $01
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $BF
                .byte   $03
                .byte   $7E
                .byte   $0E
                .byte   $FC
                .byte   $18
                .byte   $F8
                .byte   $03
                .byte   $E1
                .byte   $07
                .byte   $83
                .byte   $0F
                .byte   $8F
                .byte   $0F
                .byte   $0F
                .byte   $1F
                .byte   $1F
                .byte   $1F
T90C2:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $01
                .byte   $F8
                .byte   $07
                .byte   $F0
                .byte   $1F
                .byte   $E0
                .byte   $3F
                .byte   $C0
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $1F
                .res    10,$FF
T90DD:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $80
                .byte   $FF
T90F8:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $7F
                .byte   $80
                .byte   $7F
T9113:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $E0
                .byte   $FF
                .byte   $FC
                .res    11,$FF
T912E:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $0C
                .byte   $F0
                .byte   $3E
                .byte   $FC
                .byte   $3F
                .byte   $FC
                .byte   $1F
                .byte   $FE
                .byte   $1F
                .byte   $FC
                .byte   $0F
                .byte   $FC
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $80
T9149:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $1F
                .byte   $1F
                .byte   $1F
                .byte   $1E
                .byte   $1F
                .byte   $1E
                .byte   "?<?>?"
                .byte   $1C
                .byte   $3F
                .byte   $3C
                .byte   $7F
                .byte   $3C
                .byte   $FF
                .byte   $78
                .byte   $FF
                .byte   $78
                .byte   $FF
                .byte   $F1
                .byte   $FF
                .byte   $F0
T9164:          .byte   $03
                .byte   $05
                .res    6,$00
                .byte   $C0
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $7C
                .byte   $00
                .byte   $3C
                .byte   $00
                .byte   $1E
                .byte   $00
                .byte   $1F
                .byte   $C0
                .byte   $0F
                .byte   $F0
                .byte   $0F
                .byte   $F8
                .byte   $0F
T917F:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $FE
                .byte   $8F
                .byte   $FC
                .byte   $8F
                .byte   $FC
                .byte   $8F
                .byte   $F8
                .byte   $1F
                .byte   $C0
                .byte   $0F
                .byte   $01
                .byte   $87
                .byte   $0F
                .byte   $80
                .byte   $0F
                .byte   $C0
                .byte   $00
                .byte   $F0
                .byte   $80
                .res    5,$FF
T919A:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $C0
                .byte   $0F
                .byte   $F8
                .byte   $3F
                .byte   $FC
                .byte   $7F
                .byte   $FE
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $0F
                .byte   $F0
                .byte   $03
                .byte   $E0
                .byte   $C3
                .byte   $83
                .byte   $F1
                .byte   $07
                .byte   $E1
                .byte   $1F
                .byte   $E3
                .byte   $FF
                .byte   $C7
                .byte   $FF
T91B5:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $01
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $01
                .byte   $00
T91D0:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $FF
                .byte   $F0
                .byte   $FF
                HiAscii "p~`|A|A|"
                .byte   $81
                .byte   $F8
                .byte   $81
                .byte   $F8
                .byte   $83
                .byte   $F8
                .byte   $03
                .byte   $F0
                .byte   $03
                .byte   $F0
                .byte   $03
                .byte   $80
                .byte   $01
T91EB:          .byte   $03
                .byte   $05
                .byte   $00
                .byte   $F8
                .byte   $1F
                .byte   $FC
                .byte   $0F
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $00
                .byte   $1F
                .res    11,$00
T9206:          .byte   $03
                .byte   $05
                .res    6,$00
                .byte   $F0
                .byte   $00
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $F8
                .byte   $1F
                .byte   $F8
                .byte   $07
                .byte   $F8
                .byte   $03
                .byte   $FC
                .byte   $01
                .byte   $FC
                .byte   $00
T9221:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $C7
                .byte   $FF
                .byte   $87
                .byte   $FF
                .byte   $0E
                .byte   $FE
                .byte   $1E
                .byte   $E0
                .byte   $7C
                .byte   $80
                .byte   $F8
                .byte   $07
                .byte   $F0
                .byte   $07
                .byte   $F0
                .byte   $80
                .byte   $70
                .byte   $E0
                .byte   $78
                .byte   $F8
                .byte   $FC
                .byte   $F8
                .byte   $FF
                .byte   $F1
T923C:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $7F
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $3F
                .byte   $FF
                .byte   $3F
                .byte   $FF
                .byte   $7F
                .byte   $FF
                .byte   $7F
                .res    6,$FF
T9257:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $FC
                .byte   $C7
                .byte   $FF
                .byte   $C3
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $F0
                .byte   $00
                .res    15,$FF
T9272:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $3E
                .byte   $80
                .byte   $1F
                .byte   $C0
                .byte   $0F
                .byte   $80
                .byte   $8F
                .byte   $E0
                .byte   $8F
                .byte   $FC
                .byte   $8F
                .byte   $FC
                .byte   $83
                .byte   $FE
                .byte   $C1
                .byte   $FF
                .byte   $E1
T928D:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $00
                .byte   $00
                .byte   $80
                .byte   $07
                .byte   $98
                .byte   $07
                .byte   $D8
                .byte   $0F
                .byte   $F8
                .byte   $0F
                .byte   $FC
                .byte   $1F
                .byte   $FC
                .byte   $3F
                .byte   $FE
                .byte   $7F
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $FC
                .byte   $3F
                .byte   $00
                .byte   $00
T92A8:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $03
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $1E
                .byte   $00
                .byte   $1E
                .byte   $00
                .byte   $7C
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F0
                .byte   $01
                .byte   $F0
                .byte   $03
T92C3:          .byte   $03
                .byte   $05
                .byte   $0B
                .res    10,$00
                .byte   $F0
                .byte   $0F
                .res    12,$FF
T92DE:          .byte   $03
                .byte   $05
                .byte   $0B
                .res    18,$00
                .byte   $04
                .byte   $60
                .byte   $0F
                .byte   $F8
                .byte   $0F
                .byte   $FC
T92F9:          .byte   $03
                .byte   $00
                .byte   $0C
                .res    7,$FF
                .byte   $1F
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
T9314:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FF
T932F:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $FF
                .byte   $FF
                .byte   $FF
                .byte   $3F
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $01
                .byte   $1F
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $07
                .byte   $00
T934A:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $F8
                .byte   $03
                .byte   $F8
                .byte   $01
                .byte   $FC
                .byte   $01
                .byte   $FC
                .byte   $01
                .byte   $FC
                .byte   $03
                .byte   $FC
                .byte   $07
                .byte   $F8
                .byte   $0F
                .byte   $F8
                .byte   $3F
                .byte   $FC
                .byte   $7F
                .byte   $FC
                .byte   $FF
                .byte   $38
                .byte   $FC
                .byte   $00
                .byte   $60
T9365:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $0F
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $87
                .byte   $FF
                .byte   $87
                .byte   $FF
                .byte   $83
                .byte   $FF
                .byte   $81
                .byte   $FF
                .byte   $81
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FF
T9380:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $F0
                .res    6,$FF
                .byte   $7C
                .byte   $7F
                .byte   $38
T939B:          .byte   $03
                .byte   $05
                .byte   $02
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $B0
                .byte   $0D
                .byte   $B0
                .byte   $0D
                .byte   $B8
                .byte   $1D
                .byte   $F8
                .byte   $1F
                .byte   $F8
                .byte   $1F
                .byte   $FC
                .byte   $3F
                .byte   $FC
                .byte   $3F
                .byte   $FC
                .byte   $3F
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
T93B6:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $01
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $3F
                .byte   $FF
                .byte   $7F
                .byte   $FF
                .byte   $7F
                .byte   $FF
                .byte   $FF
T93D1:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $FF
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $1F
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $01
                .res    13,$00
T93EC:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $FF
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $FE
                .byte   $F0
                .byte   $7F
                .byte   $FF
                .byte   $3F
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $03
                .byte   $FF
                .byte   $01
                .byte   $FF
                .byte   $00
T9407:          .byte   $03
                .byte   $05
                .byte   $0B
                .res    15,$00
                .byte   $E0
                .byte   $80
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $FC
                .byte   $FF
                .byte   $FF
                .byte   $FF
T9422:          .byte   $03
                .byte   $05
                .byte   $0C
                .byte   $03
                .byte   $E0
                .byte   $0F
                .byte   $F8
                .byte   $3F
                .byte   $FC
                .byte   $7F
                .byte   $FE
                .byte   $7F
                .byte   $FE
                .byte   $7F
                .byte   $FF
                .byte   $7F
                .byte   $FF
                .byte   $7F
                .byte   $FE
                .byte   $FF
                .byte   $F8
                .byte   $FF
                .byte   $F8
                .byte   $7F
                .byte   $F0
                .byte   $7F
                .byte   $C0
T943D:          .byte   $03
                .byte   $05
                .byte   $00
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FE
T9458:          .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $F8
                .res    11,$FF
T9473:          .byte   $03
                .byte   $05
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $FF
                .byte   $C0
                .byte   $7F
                .byte   $FF
                .byte   $7F
                .byte   $FF
                .byte   $3F
                .byte   $FF
                .byte   $0F
                .byte   $FF
                .byte   $01
                .res    10,$00
T948E:          .byte   $03
                .byte   $00
                .byte   $0C
                .res    8,$00
                .res    16,$FF

; Return: Carry
;   C = 0 : Stack[0] > Stack[1]
;   C = 1 : Stack[0] <= Stack[1]
VmOp_Compare_BmA:
                SEC
                LDA     VmStack_Low+1,x
                SBC     VmStack_Low,x
                LDA     VmStack_High+1,x
                SBC     VmStack_High,x
                RTS

; Return: Carry
;   C = 0 : Stack[0] < Stack[1]
;   C = 1 : Stack[0] >= Stack[1]
VmOp_Compare_AmB:
                SEC
                LDA     VmStack_Low,x
                SBC     VmStack_Low+1,x
                LDA     VmStack_High,x
                SBC     VmStack_High+1,x
                RTS

VmOp_Compare_Equal:
                LDA     VmStack_Low,x
                CMP     VmStack_Low+1,x
                BNE     VmOp_PushFalse
                LDA     VmStack_High,x
                CMP     VmStack_High+1,x
                BNE     VmOp_PushFalse
VmOp_PushTrue:  INX
                LDA     #$01
                STA     VmStack_Low,x
                LDA     #$00
                STA     VmStack_High,x
                RTS

VmOp_PushFalse: INX
                LDA     #$00
                STA     VmStack_Low,x
                STA     VmStack_High,x
                RTS

VmOp_Compare_NotEqual:
                LDA     VmStack_Low,x
                CMP     VmStack_Low+1,x
                BNE     VmOp_PushTrue
                LDA     VmStack_High,x
                CMP     VmStack_High,x                  ;always equal, maybe bug
                BNE     VmOp_PushTrue                   ;never jump
                BEQ     VmOp_PushFalse

; Stack[0] > Stack[1]
VmOp_Compare_AGeatherThan:
                JSR     VmOp_Compare_BmA
                BCC     VmOp_PushTrue
                BCS     VmOp_PushFalse

; Stack[0] < Stack[1]
VmOp_Compare_BGeatherThan:
                JSR     VmOp_Compare_AmB
                BCC     VmOp_PushTrue
                BCS     VmOp_PushFalse

; Stack[0] >= Stack[1]
VmOp_Compare_AGeatherThanOrEqual:
                JSR     VmOp_Compare_AmB
                BCS     VmOp_PushTrue
                BCC     VmOp_PushFalse

; Stack[0] <= Stack[1]
VmOp_Compare_BGeatherThanOrEqual:
                JSR     VmOp_Compare_BmA
                BCS     VmOp_PushTrue
                BCC     VmOp_PushFalse

VmOp_And:       LDA     VmStack_Low,x
                AND     VmStack_Low+1,x
                STA     VmStack_Low+1,x
                LDA     VmStack_High,x
                AND     VmStack_High+1,x
                STA     VmStack_High+1,x
                INX
                RTS

VmOp_Or:        LDA     VmStack_Low,x
                ORA     VmStack_Low+1,x
                STA     VmStack_Low+1,x
                LDA     VmStack_High,x
                ORA     VmStack_High+1,x
                STA     VmStack_High+1,x
                INX
                RTS

VmOp_Xor:       LDA     VmStack_Low,x
                EOR     VmStack_Low+1,x
                STA     VmStack_Low+1,x
                LDA     VmStack_High,x
                EOR     VmStack_High+1,x
                STA     VmStack_High+1,x
                INX
                RTS

VmOp_CopyPointer:
                LDY     #$00
                LDA     VmStack_Low,x
                STA     VmMem_Pointer
                LDA     VmStack_High,x
                STA     VmMem_Pointer+1
                RTS

; Stack[0] = Address
; Stack[1] = Value
VmOp_WriteWord: JSR     VmOp_CopyPointer
                INX
                LDA     VmStack_Low,x
                STA     (VmMem_Pointer),y
                INY
                LDA     VmStack_High,x
                STA     (VmMem_Pointer),y
                INX
                RTS

; Stack[0] = Address
; Stack[1] = Value
VmOp_WriteByte: JSR     VmOp_CopyPointer
                INX
                LDA     VmStack_Low,x
                STA     (VmMem_Pointer),y
                INX
                RTS

VmOp_ReadAddressWord:
                JSR     VmOp_CopyPointer
                LDA     (VmMem_Pointer),y
                STA     VmStack_Low,x
                INY
                LDA     (VmMem_Pointer),y
                STA     VmStack_High,x
                RTS

; Argument: Y=Offset
VmOp_ReadOffsetByte:
                JSR     VmOp_Add_AB                     ;Stack[1] = Mem[Stack[0] + Stack[1]]
VmOp_ReadByte:  JSR     VmOp_CopyPointer                ;Stack[0] = Mem[Stack[0]]
                LDA     (VmMem_Pointer),y
                STA     VmStack_Low,x
                LDA     #$00
                STA     VmStack_High,x
                RTS

VmOp_Duplicate: DEX
                LDA     VmStack_Low+1,x
                STA     VmStack_Low,x
                LDA     VmStack_High+1,x
                STA     VmStack_High,x
                RTS

VmOp_PopDiscard:
                INX
                RTS

VmOp_Swap:      LDY     VmStack_Low,x
                LDA     VmStack_Low+1,x
                STA     VmStack_Low,x
                TYA
                STA     VmStack_Low+1,x
                LDY     VmStack_High,x
                LDA     VmStack_High+1,x
                STA     VmStack_High,x
                TYA
                STA     VmStack_High+1,x
                RTS

; Return : Carry (0=Zero, 1=Not Zero)
VmOp_CheckNotZero:
                LDA     VmStack_Low,x
                ORA     VmStack_High,x
                BNE     @ReturnTrue
@ReturnFalse:   CLC
                INX
                RTS

@ReturnTrue:    SEC
                INX
                RTS

VmOp_ExitFalse: JSR     VmOp_CheckNotZero
                BCC     ExitCaller
@ContinueCaller:
                RTS

                JSR     VmOp_CheckNotZero               ;pop?
VmOp_ExitTrue:  JSR     VmOp_CheckNotZero
                BCC     ContinueCaller
ExitCaller:     PLA
                PLA
ContinueCaller: RTS

                DEC     VmMem_SecondStack
                LDY     VmMem_SecondStack
                LDA     VmSubStackA_Low,y
                ADC     #$01
                STA     VmSubStackB_Low,y
                RTS

                LDY     VmMem_SecondStack
                LDA     VmSubStackA_Low,y
                CMP     VmSubStackB_Low,y
                BEQ     L9631
                CLC
                RTS

L9601:          DEC     VmMem_SecondStack
                LDY     VmMem_SecondStack
                LDA     VmStack_Low,x
                STA     VmSubStackA_Low,y
                LDA     VmStack_High,x
                STA     VmSubStackA_High,y
                INX
                LDA     VmStack_Low,x
                STA     VmSubStackB_Low,y
                LDA     VmStack_High,x
                STA     VmSubStackB_High,y
                INX
                RTS

L9620:          LDY     VmMem_SecondStack
                SEC
                LDA     VmSubStackA_Low,y
                SBC     VmSubStackB_Low,y
                LDA     VmSubStackA_High,y
                SBC     VmSubStackB_High,y
                BCC     L9635
L9631:          INC     VmMem_SecondStack
                SEC
                RTS

L9635:          TXA
                PHA
                TYA
                TAX
                INC     VmSubStackA_Low,x
                BNE     @L9641
                INC     VmSubStackA_High,x
@L9641:         PLA
                TAX
                CLC
                RTS

L9645:          LDY     VmMem_SecondStack
                SEC
                LDA     VmSubStackA_Low,y
                SBC     VmSubStackB_Low,y
                LDA     VmSubStackA_High,y
                SBC     VmSubStackB_High,y
                PHP
                CLC
                LDA     VmStack_Low,x
                ADC     VmSubStackA_Low,y
                STA     VmSubStackA_Low,y
                LDA     VmStack_High,x
                ADC     VmSubStackA_High,y
                STA     VmSubStackA_High,y
                SEC
                LDA     VmSubStackA_Low,y
                SBC     VmSubStackB_Low,y
                LDA     VmSubStackA_High,y
                SBC     VmSubStackB_High,y
                PHP
                PLA
                STA     VmMem_Pointer
                PLA
                EOR     VmMem_Pointer
                AND     #$01
                CLC
                BEQ     @L9684
                INC     VmMem_SecondStack
                SEC
@L9684:         INX
                RTS

                LDY     VmMem_SecondStack
                LDA     VmSubStackB_Low,y
                STA     VmSubStackA_Low,y
                LDA     VmSubStackB_High,y
                STA     VmSubStackA_High,y
                RTS

VmSecond_CopySecondStack_Reload:
                LDY     VmMem_SecondStack
VmSecond_CopySecondStack:
                DEX
                LDA     VmSubStackA_Low,y
                STA     VmStack_Low,x
                LDA     VmSubStackA_High,y
                STA     VmStack_High,x
                RTS

VmSecond_PopSecondStack:
                LDY     VmMem_SecondStack
                INY
                JMP     VmSecond_CopySecondStack

VmOp_PopRegister:
                LDY     VmStack_Low,x
                LDA     VmStack_High,x
                INX
                RTS

VmOp_DestroyStackFrame:
                JSR     VmOp_PushStackFramePointer
                JSR     VmOp_ReadAddressWord
VmOp_PopStackFramePointer:
                JSR     VmOp_PopRegister
                STY     VmMem_StackFramePointer
                STA     VmMem_StackFramePointer+1
                RTS

; [VmMem_Temp - (A + 2)] = [VmMem_Temp]
; Argument: A = Variables length
; Example:
;   VmMem_Temp = #$0780, A = #$06
;   => VmMem_Temp = $0778, $0778 = #$0780
; [PrevStackTop], [Var1], [Var2], ...
VmHelper_CreateStackFrame:
                JSR     VmOp_PushByte                   ;[0] arg
                JSR     VmOp_AddConst_02                ;[0] arg + #2
                JSR     VmOp_Duplicate                  ;[0] arg + #2, [1] arg + #2
                JSR     VmOp_PushStackFramePointer      ;[0] VmMem_Temp, [1] arg + #2, [2] arg + #2
                JSR     VmOp_Swap                       ;[0] arg + #2, [1] VmMem_Temp, [2] arg + #2
                JSR     VmOp_Sub_BA                     ;[0] VmMem_Temp - (arg + #2), [1] arg + #2
                JSR     VmOp_PopStackFramePointer       ;Update VmMem_Temp
                JSR     VmOp_PushStackFramePointer      ;[0] VmMem_Temp - (arg + #2), [1] arg + #2
                JSR     VmOp_Add_AB                     ;[0] VmMem_Temp
                JSR     VmOp_PushStackFramePointer      ;[0] VmMem_Temp - (arg + #2), [1] VmMem_Temp
                JMP     VmOp_WriteWord

VmHelper_CreateStackFrame_02:
                LDA     #$02
                BNE     VmHelper_CreateStackFrame

VmHelper_CreateStackFrame_04:
                LDA     #$04
                BNE     VmHelper_CreateStackFrame

VmHelper_CreateStackFrame_06:
                LDA     #$06
                BNE     VmHelper_CreateStackFrame

VmHelper_CreateStackFrame_08:
                LDA     #$08
                BNE     VmHelper_CreateStackFrame

VmHelper_CreateStackFrame_0A:
                LDA     #$0A
                BNE     VmHelper_CreateStackFrame

VmHelper_CreateStackFrame_0C:
                LDA     #$0C
                BNE     VmHelper_CreateStackFrame

VmHelper_CreateStackFrame_0E:
                LDA     #$0E
                BNE     VmHelper_CreateStackFrame

VmHelper_WriteTempAddressWord_02:
                LDY     #$02
                BNE     VmOp_WriteTempAddressWord

VmHelper_WriteTempAddressWord_04:
                LDY     #$04
                BNE     VmOp_WriteTempAddressWord

VmHelper_WriteTempAddressWord_06:
                LDY     #$06
                BNE     VmOp_WriteTempAddressWord

VmHelper_WriteTempAddressWord_08:
                LDY     #$08
                BNE     VmOp_WriteTempAddressWord

VmHelper_WriteTempAddressWord_0A:
                LDY     #$0A
                BNE     VmOp_WriteTempAddressWord

VmHelper_WriteTempAddressWord_0C:
                LDY     #$0C
                BNE     VmOp_WriteTempAddressWord

VmHelper_WriteTempAddressWord_0E:
                LDY     #$0E
                BNE     VmOp_WriteTempAddressWord       ;No need

; Argument: Y=Offset
; Implementation of local variables?
VmOp_WriteTempAddressWord:
                LDA     VmStack_Low,x
                STA     (VmMem_StackFramePointer),y
                INY
                LDA     VmStack_High,x
                STA     (VmMem_StackFramePointer),y
                INX
                RTS

VmHelper_ReadTempAddressWord_02:
                LDY     #$02
                BNE     VmOp_ReadTempAddressWord

VmHelper_ReadTempAddressWord_04:
                LDY     #$04
                BNE     VmOp_ReadTempAddressWord

VmHelper_ReadTempAddressWord_06:
                LDY     #$06
                BNE     VmOp_ReadTempAddressWord

VmHelper_ReadTempAddressWord_08:
                LDY     #$08
                BNE     VmOp_ReadTempAddressWord

VmHelper_ReadTempAddressWord_0A:
                LDY     #$0A
                BNE     VmOp_ReadTempAddressWord

VmHelper_ReadTempAddressWord_0C:
                LDY     #$0C
                BNE     VmOp_ReadTempAddressWord

VmHelper_ReadTempAddressWord_0E:
                LDY     #$0E
; Argument: Y=Offset
VmOp_ReadTempAddressWord:
                DEX
                LDA     (VmMem_StackFramePointer),y
                STA     VmStack_Low,x
                INY
                LDA     (VmMem_StackFramePointer),y
                STA     VmStack_High,x
                RTS

VmOp_Add_AB:    CLC
                LDA     VmStack_Low,x
                ADC     VmStack_Low+1,x
                STA     VmStack_Low+1,x
                LDA     VmStack_High,x
                ADC     VmStack_High+1,x
                STA     VmStack_High+1,x
                INX
                RTS

VmOp_Sub_BA:    SEC
                LDA     VmStack_Low+1,x
                SBC     VmStack_Low,x
                STA     VmStack_Low+1,x
                LDA     VmStack_High+1,x
                SBC     VmStack_High,x
                STA     VmStack_High+1,x
                INX
                RTS

                LDA     #$00
                STA     $37
                STA     $38
@L977E:         LSR     VmStack_High,x
                ROR     VmStack_Low,x
                BNE     @L978D
                BCS     @L978D
                LDA     VmStack_High,x
                BEQ     @L97A7
@L978D:         BCC     @L979E
                CLC
                LDA     VmStack_Low+1,x
                ADC     $37
                STA     $37
                LDA     VmStack_High+1,x
                ADC     $38
                STA     $38
@L979E:         ASL     VmStack_Low+1,x
                ROL     VmStack_High+1,x
                JMP     @L977E

@L97A7:         INX
                LDA     $37
                STA     VmStack_Low,x
                LDA     $38
                STA     VmStack_High,x
                RTS

; Jump to Stack[0]
VmOp_IndirectJump:
                LDA     #$4C                            ;#$4C = JMP
                STA     VmMem_IndirectJump
                LDA     VmStack_Low,x
                STA     VmMem_IndirectJump+1
                LDA     VmStack_High,x
                STA     VmMem_IndirectJump+2
                INX
                JMP     VmMem_IndirectJump              ;Same as : JMP ($003B)

L97C5:          JSR     VmHelper_PushConst_0000
                JSR     VmOp_Swap
                JMP     VmOp_Sub_BA

L97CE:          JSR     VmOp_Duplicate
                JSR     VmHelper_PushConst_0000
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JMP     L97C5

VmOp_Increment: INC     VmStack_Low,x
                BNE     @Skip
                INC     VmStack_High,x
@Skip:          RTS

VmOp_AddConst_02:
                LDA     #$02
VmOp_AddNativeAcc:
                CLC
                ADC     VmStack_Low,x
                STA     VmStack_Low,x
                LDA     VmStack_High,x
                ADC     #$00
                STA     VmStack_High,x
                RTS

VmOp_AddConst_03:
                LDA     #$03
                BNE     VmOp_AddNativeAcc

VmOp_DecrementTwice:
                JSR     VmOp_Decrement
VmOp_Decrement: LDA     VmStack_Low,x
                BNE     @Skip
                DEC     VmStack_High,x
@Skip:          DEC     VmStack_Low,x
                RTS

VmOp_Asl_06:    ASL     VmStack_Low,x
                ROL     VmStack_High,x
VmOp_Asl_05:    ASL     VmStack_Low,x
                ROL     VmStack_High,x
VmOp_Asl_04:    ASL     VmStack_Low,x
                ROL     VmStack_High,x
VmOp_Asl_03:    ASL     VmStack_Low,x
                ROL     VmStack_High,x
VmOp_Asl_02:    ASL     VmStack_Low,x
                ROL     VmStack_High,x
VmOp_Asl_01:    ASL     VmStack_Low,x
                ROL     VmStack_High,x
                RTS

VmOp_Lsr_04:    LSR     VmStack_High,x
                ROR     VmStack_Low,x
VmOp_Lsr_03:    LSR     VmStack_High,x
                ROR     VmStack_Low,x
VmOp_Lsr_02:    LSR     VmStack_High,x
                ROR     VmStack_Low,x
VmOp_Lsr_01:    LSR     VmStack_High,x
                ROR     VmStack_Low,x
                RTS

VmHelper_PushConst_0000:
                LDA     #$00
                BEQ     VmOp_PushByte

VmHelper_PushConst_0001:
                LDA     #$01
                BNE     VmOp_PushByte

VmHelper_PushConst_0002:
                LDA     #$02
                BNE     VmOp_PushByte

VmHelper_PushConst_0003:
                LDA     #$03
                BNE     VmOp_PushByte

VmHelper_PushConst_0004:
                LDA     #$04
                BNE     VmOp_PushByte

VmHelper_PushConst_0005:
                LDA     #$05
                BNE     VmOp_PushByte

VmHelper_PushConst_0006:
                LDA     #$06
                BNE     VmOp_PushByte

VmHelper_PushConst_0007:
                LDA     #$07
                BNE     VmOp_PushByte

VmHelper_PushConst_0008:
                LDA     #$08
                BNE     VmOp_PushByte

VmHelper_PushConst_0009:
                LDA     #$09
                BNE     VmOp_PushByte

VmHelper_PushConst_000A:
                LDA     #$0A
                BNE     VmOp_PushByte

VmHelper_PushConst_000B:
                LDA     #$0B
                BNE     VmOp_PushByte

VmHelper_PushConst_000C:
                LDA     #$0C
                BNE     VmOp_PushByte

VmHelper_PushConst_000D:
                LDA     #$0D
                BNE     VmOp_PushByte

VmHelper_PushConst_000E:
                LDA     #$0E
                BNE     VmOp_PushByte

VmHelper_PushConst_000F:
                LDA     #$0F
                BNE     VmOp_PushByte

VmHelper_PushConst_0010:
                LDA     #$10
                BNE     VmOp_PushByte

VmHelper_PushConst_0011:
                LDA     #$11
                BNE     VmOp_PushByte

VmHelper_PushConst_0012:
                LDA     #$12
                BNE     VmOp_PushByte

VmHelper_PushConst_0014:
                LDA     #$14
                BNE     VmOp_PushByte

VmHelper_PushConst_0016:
                LDA     #$16
                BNE     VmOp_PushByte

VmHelper_PushConst_0018:
                LDA     #$18
                BNE     VmOp_PushByte

VmHelper_PushConst_0019:
                LDA     #$19
                BNE     VmOp_PushByte

VmHelper_PushConst_001A:
                LDA     #$1A
                BNE     VmOp_PushByte

VmHelper_PushConst_001C:
                LDA     #$1C
                BNE     VmOp_PushByte

VmHelper_PushConst_001E:
                LDA     #$1E
                BNE     VmOp_PushByte

VmHelper_PushConst_001F:
                LDA     #$1F
                BNE     VmOp_PushByte

VmHelper_PushConst_0020:
                LDA     #$20
                BNE     VmOp_PushByte

VmHelper_PushConst_0021:
                LDA     #$21
                BNE     VmOp_PushByte

VmHelper_PushConst_0022:
                LDA     #$22
                BNE     VmOp_PushByte

VmHelper_PushConst_0025:
                LDA     #$25
                JSR     VmOp_PushByte
VmHelper_PushConst_0030:
                LDA     #$30
                BNE     VmOp_PushByte

VmHelper_PushConst_0032:
                LDA     #$32
; Argument : A
VmOp_PushByte:  DEX
                STA     VmStack_Low,x
                LDA     #$00
                STA     VmStack_High,x
                RTS

VmHelper_PushConst_0034:
                LDA     #$34
                BNE     VmOp_PushByte

VmHelper_PushConst_0036:
                LDA     #$36
                BNE     VmOp_PushByte

VmHelper_PushConst_0040:
                LDA     #$40
                BNE     VmOp_PushByte

VmHelper_PushConst_004A:
                LDA     #$4A
                BNE     VmOp_PushByte

VmHelper_PushConst_004E:
                LDA     #$4E
                BNE     VmOp_PushByte

VmHelper_PushConst_0050:
                LDA     #$50
                BNE     VmOp_PushByte

VmHelper_PushConst_005C:
                LDA     #$5C
                BNE     VmOp_PushByte

VmHelper_PushConst_0060:
                LDA     #$60
                BNE     VmOp_PushByte

VmHelper_PushConst_0080:
                LDA     #$80
                BNE     VmOp_PushByte

VmHelper_PushConst_0086:
                LDA     #$86
                BNE     VmOp_PushByte

VmHelper_PushConst_0088:
                LDA     #$88
                BNE     VmOp_PushByte

VmHelper_PushConst_008A:
                LDA     #$8A
                BNE     VmOp_PushByte

VmHelper_PushConst_008C:
                LDA     #$8C
                BNE     VmOp_PushByte

VmHelper_PushConst_0090:
                LDA     #$90
                BNE     VmOp_PushByte

VmHelper_PushConst_00A0:
                LDA     #$A0
                BNE     VmOp_PushByte

VmHelper_PushConst_00B4:
                LDA     #$B4
                BNE     VmOp_PushByte

VmHelper_PushConst_00B6:
                LDA     #$B6
                BNE     VmOp_PushByte

VmHelper_PushConst_00B8:
                LDA     #$B8
                BNE     VmOp_PushByte

VmHelper_PushConst_00BA:
                LDA     #$BA
                BNE     VmOp_PushByte

VmHelper_PushConst_00C0:
                LDA     #$C0
                BNE     VmOp_PushByte

VmHelper_PushConst_00CC:
                LDA     #$CC
                BNE     VmOp_PushByte

VmHelper_PushConst_00CE:
                LDA     #$CE
                BNE     VmOp_PushByte

VmHelper_PushConst_00D0:
                LDA     #$D0
                BNE     VmOp_PushByte

VmHelper_PushConst_00D2:
                LDA     #$D2
                BNE     VmOp_PushByte

VmHelper_PushConst_00D4:
                LDA     #$D4
                BNE     VmOp_PushByte

VmHelper_PushConst_00D8:
                LDA     #$D8
                BNE     VmOp_PushByte

VmHelper_PushConst_00DF:
                LDA     #$DF
                BNE     VmOp_PushByte

VmHelper_PushConst_00E0:
                LDA     #$E0
                BNE     VmOp_PushByte

VmHelper_PushConst_00F0:
                LDA     #$F0
                BNE     VmOp_PushByte

VmHelper_PushConst_00F8:
                LDA     #$F8
                JMP     VmOp_PushByte

VmHelper_PushConst_00FC:
                LDA     #$FC
                JMP     VmOp_PushByte

VmHelper_PushConst_00FE:
                LDA     #$FE
                JMP     VmOp_PushByte

VmHelper_PushConst_00FF:
                LDA     #$FF
                JMP     VmOp_PushByte

VmHelper_PushConst_0100:
                LDA     #$01
                LDY     #$00
                BEQ     VmOp_PushRegister

VmHelper_PushConst_01D0:
                LDA     #$01
                LDY     #$D0
                BNE     VmOp_PushRegister

VmHelper_PushConst_0204:
                LDA     #$02
                LDY     #$04
                BNE     VmOp_PushRegister

VmHelper_PushConst_0224:
                LDA     #$02
                LDY     #$24
                BNE     VmOp_PushRegister

VmHelper_PushConst_0244:
                LDA     #$02
                LDY     #$44
                BNE     VmOp_PushRegister

VmHelper_PushConst_0400:
                LDA     #$04
                LDY     #$00
                BEQ     VmOp_PushRegister

VmHelper_PushConst_23C0:
                LDA     #$23
                LDY     #$C0
                BNE     VmOp_PushRegister

VmHelper_PushConst_2BC0:
                LDA     #$2B
                LDY     #$C0
                BNE     VmOp_PushRegister

VmOp_PushStackFramePointer:
                LDY     VmMem_StackFramePointer
                LDA     VmMem_StackFramePointer+1
; High = A, Low = Y
VmOp_PushRegister:
                DEX
                STA     VmStack_High,x
                TYA
                STA     VmStack_Low,x
                RTS

                .word   T90DD
                .word   T8BAE
                .word   T8BAE
                .word   T8BAE
                .word   T8BAE
                .word   T8BAE
                .word   T8BAE
                .word   T8BC9
                .word   T8BE4
                .word   T8BFF
                .word   T8BFF
                .word   T8BFF
                .word   T8C1A
                .word   T8C35
                .word   T8D62
                .word   T8D62
                .word   T8D62
                .word   T8D62
                .word   T8D62
                .word   T8D62
                .word   T8D62
                .word   T8D62
                .word   T8D62
                .word   T8D62
                .word   T8416
                .word   T8482
                .word   T8467
                .word   T8482
                .word   T8482
                .word   T8482
                .word   T8482
                .word   T84EE
                .word   T9314
                .word   T83C5
                .word   T8C39
                .word   T8C54
                .word   T8C54
                .word   T8C6F
                .word   T83C5
                .word   T8C8A
                .word   T8CA5
                .word   T8CC0
                .word   T8CDB
                .word   T8CF6
                .word   T8D11
                .word   T8D2C
                .word   T8D47
                .word   T83C5
                .word   T855A
                .word   T855A
                .word   T855A
                .word   T855A
                .word   T83C5
                .word   T855A
                .word   T84D3
                .word   T8431
                .word   T844C
                .word   T8509
                .word   T8524
                .word   T84B8
                .word   T84B8
                .word   T84B8
                .word   T83C5
                .word   T853F
                .word   T9113
                .word   T83FB
                .word   T8C37
                .word   T8C8A
                .word   T8CA5
                .word   T8D62
                .word   T8D62
                .word   T8D62
                .word   T855A
                .word   T8D7D
                .word   T8D98
                .word   T8DB3
                .word   T8DCE
                .word   T83C5
                .word   T8DE9
                .word   T855A
                .word   T855A
                .word   T855A
                .word   T855A
                .word   T855A
                .word   T8575
                .word   T8590
                .word   T84D3
                .word   T85AB
                .word   T85C6
                .word   T85E1
                .word   T85FC
                .word   T8617
                .word   T80A9
                .word   T84B8
                .word   T84B8
                .word   T853F
                .word   T8E04
                .word   T8BAE
                .word   T8E1F
                .word   T8E3A
                .word   T855A
                .word   T855A
                .word   T855A
                .word   T855A
                .word   T855A
                .word   T855A
                .word   T855A
                .word   T8D62
                .word   T8D62
                .word   T8E55
                .word   T8E70
                .word   T855A
                .word   T855A
                .word   T855A
                .word   T8683
                .word   T8575
                .word   T8590
                .word   T8632
                .word   T864D
                .word   T85FC
                .word   T8617
                .word   T84D3
                .word   T83E0
                .word   T80A9
                .word   T823C
                .word   T80A9
                .word   T8370
                .word   T8370
                .word   T8E8B
                .word   T8EA6
                .word   T8EA6
                .word   T8EC1
                .word   T855A
                .word   T855A
                .word   T83C5
                .word   T8575
                .word   T8C35
                .word   T8F48
                .word   T8BAE
                .word   T8BAE
                .word   T8BAE
                .word   T8EDC
                .word   T8EF7
                .word   T8683
                .word   T8683
                .word   T855A
                .word   T83C5
                .word   T869E
                .word   T86B9
                .word   T86D4
                .word   T86EF
                .word   T870A
                .word   T8725
                .word   T84B8
                .word   T8206
                .word   T8370
                .word   T8257
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8E8B
                .word   T8F12
                .word   T8F2D
                .word   T8BFF
                .word   T8BFF
                .word   $00DB
                .word   T8575
                .word   T8C35
                .word   T8F48
                .word   T84D3
                .word   T84D3
                .word   T84D3
                .word   T83C5
                .word   T84D3
                .word   T84D3
                .word   T84D3
                .word   T8740
                .word   T875B
                .word   T8590
                .word   T8776
                .word   T8791
                .word   T87AC
                .word   T87C7
                .word   T87E2
                .word   T87FD
                .word   T84B8
                .word   T83FB
                .word   T8221
                .word   T8272
                .word   T82A8
                .word   T8370
                .word   T8370
                .word   T8F63
                .word   T8F7E
                .word   T8D2C
                .word   T8C35
                .word   T8F99
                .word   T8C35
                .word   T8F48
                .word   T8FB4
                .word   T84D3
                .word   T84D3
                .word   T84D3
                .word   T8FCF
                .word   T84D3
                .word   T83C5
                .word   T84D3
                .word   T84D3
                .word   T8818
                .word   T84B8
                .word   T83C5
                .word   T8833
                .word   T884E
                .word   T8869
                .word   T8884
                .word   T889F
                .word   T83C5
                .word   T84B8
                .word   T8431
                .word   T88BA
                .word   T817F
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8E04
                .word   T8FEA
                .word   T9005
                .word   T9020
                .word   T903B
                .word   T9056
                .word   T9071
                .word   T8F48
                .word   T84D3
                .word   T84D3
                .word   T90A7
                .word   T90C2
                .word   T90DD
                .word   T912E
                .word   T8C54
                .word   T90F8
                .word   T88D5
                .word   T83E0
                .word   T88F0
                .word   T890B
                .word   T8926
                .word   T8941
                .word   T895C
                .word   T83E0
                .word   T84B8
                .word   T8431
                .word   T844C
                .word   T84B8
                .word   T80C4
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T9113
                .word   T8FEA
                .word   T912E
                .word   T8C54
                .word   T8C54
                .word   T8C54
                .word   T912E
                .word   T908C
                .word   T908C
                .word   T83C5
                .word   T9149
                .word   T8C37
                .word   T9164
                .word   T84B8
                .word   T84B8
                .word   T8C37
                .word   T8977
                .word   T8725
                .word   T89AD
                .word   T89C8
                .word   T8725
                .word   T89E3
                .word   T89FE
                .word   T8A19
                .word   T89FE
                .word   T844C
                .word   T83C5
                .word   T84B8
                .word   T828D
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8C37
                .word   T917F
                .word   T919A
                .word   T84D3
                .word   T84D3
                .word   T84D3
                .word   T908C
                .word   T908C
                .word   T908C
                .word   T91B5
                .word   T91D0
                .word   T90DD
                .word   T91EB
                .word   T9206
                .word   T83C5
                .word   $00DB
                .word   T849D
                .word   T83AA
                .word   T83AA
                .word   T83C5
                .word   T8818
                .word   T8A34
                .word   T8A4F
                .word   T8A6A
                .word   T84B8
                .word   T84B8
                .word   T84B8
                .word   T84B8
                .word   T83C5
                .word   T81B5
                .word   T8370
                .word   T8370
                .word   T8C37
                .word   T8C37
                .word   T9221
                .word   T84D3
                .word   T84D3
                .word   T908C
                .word   T908C
                .word   T908C
                .word   T908C
                .word   T91B5
                .word   T83C5
                .word   T84B8
                .word   T84B8
                .word   T91EB
                .word   T9206
                .word   T8C37
                .word   T849D
                .word   T83AA
                .word   T83AA
                .word   T83AA
                .word   T88D5
                .word   T8A85
                .word   T84D3
                .word   T849D
                .word   T84B8
                .word   T83FB
                .word   T84B8
                .word   T8431
                .word   T89FE
                .word   T81D0
                .word   T8370
                .word   T8370
                .word   T90DD
                .word   T8C37
                .word   T9257
                .word   T9272
                .word   T928D
                .word   T83C5
                .word   T908C
                .word   T83C5
                .word   T8372
                .word   T92A8
                .word   T92C3
                .word   T92C3
                .word   T92DE
                .word   T92C3
                .word   T91EB
                .word   T92F9
                .word   T849D
                .word   T849D
                .word   T8AA0
                .word   T8ABB
                .word   T8AD6
                .word   T8AF1
                .word   T8B0C
                .word   T8431
                .word   T8A19
                .word   T89FE
                .word   T89FE
                .word   T844C
                .word   T83C5
                .word   T817F
                .word   T8370
                .word   T8370
                .word   T9314
                .word   T932F
                .word   T8C37
                .word   T9257
                .word   T9272
                .word   T928D
                .word   T928D
                .word   T908C
                .word   T8372
                .word   T934A
                .word   T8C35
                .word   T8C35
                .word   T9365
                .word   T8C35
                .word   T8C37
                .word   T943D
                .word   T849D
                .word   T849D
                .word   T83C5
                .word   T83FB
                .word   T8431
                .word   T89FE
                .word   T89FE
                .word   T844C
                .word   T83AA
                .word   T83FB
                .word   T83AA
                .word   T849D
                .word   T849D
                .word   T81EB
                .word   T8370
                .word   T8370
                .word   T9365
                .word   T9380
                .word   T8E1F
                .word   T932F
                .word   T9257
                .word   T9407
                .word   T939B
                .word   T908C
                .word   T8372
                .word   T93B6
                .word   T8F48
                .word   T84D3
                .word   T84D3
                .word   T849D
                .word   T84B8
                .word   T943D
                .word   T84B8
                .word   T84B8
                .word   T8431
                .word   T8A19
                .word   T8B27
                .word   T849D
                .word   T83AA
                .word   T8B42
                .word   T83C5
                .word   T83AA
                .word   T8B5D
                .word   T83AA
                .word   T8818
                .word   T819A
                .word   T8370
                .word   T8370
                .word   T9314
                .word   T93D1
                .word   T93EC
                .word   T9407
                .word   T932F
                .word   T8C37
                .word   T9422
                .word   T8C37
                .word   T9113
                .word   T84D3
                .word   T83C5
                .word   T93B6
                .word   T84D3
                .word   T83C5
                .word   T84B8
                .word   T943D
                .word   T83E0
                .word   T84B8
                .word   T85AB
                .word   T83FB
                .word   T8B78
                .word   T849D
                .word   T8B93
                .word   T83AA
                .word   T83AA
                .word   T83AA
                .word   T83AA
                .word   T85C6
                .word   T889F
                .word   T80C4
                .word   T8370
                .word   T8370
                .word   T9314
                .word   T84D3
                .word   T84D3
                .word   T8D2C
                .word   T9458
                .word   T9407
                .word   T923C
                .word   T8C37
                .word   T8C37
                .word   T9113
                .word   T8668
                .word   T8C37
                .word   T9113
                .word   T9407
                .word   T93B6
                .word   T9473
                .word   T89FE
                .word   T89FE
                .word   T88BA
                .word   T83C5
                .word   T8B78
                .word   T88F0
                .word   T8A6A
                .word   T83AA
                .word   T83AA
                .word   T8AF1
                .word   T8B0C
                .word   T83C5
                .word   T817F
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T9314
                .word   T849D
                .word   T84D3
                .word   T84D3
                .word   T8E1F
                .word   T8E1F
                .word   T932F
                .word   T8C37
                .word   T8C37
                .word   T8C37
                .word   T8668
                .word   T8C37
                .word   T8C37
                .word   T90DD
                .word   T8E1F
                .word   T8818
                .word   T8B0C
                .word   T85E1
                .word   T88D5
                .word   T8632
                .word   T8B78
                .word   T87E2
                .word   T864D
                .word   T83AA
                .word   T83AA
                .word   T83AA
                .word   T83AA
                .word   T84B8
                .word   T819A
                .word   T8130
                .word   T828D
                .word   T8370
                .word   T948E
                .word   T9206
                .word   T849D
                .word   T849D
                .word   T849D
                .word   T83C5
                .word   T849D
                .word   T932F
                .word   T8C37
                .word   T8C37
                .word   T8668
                .word   T8E1F
                .word   T8E1F
                .word   T849D
                .word   T8833
                .word   T884E
                .word   T8869
                .word   T8ABB
                .word   T85E1
                .word   T86D4
                .word   T8B78
                .word   T89AD
                .word   T8A34
                .word   T8A4F
                .word   T83AA
                .word   T8509
                .word   T8524
                .word   T83FB
                .word   T80C4
                .word   T82C3
                .word   T82DE
                .word   T8370
                .word   T9314
                .word   T91EB
                .word   T89FE
                .word   T89FE
                .word   T8A19
                .word   T89FE
                .word   T9206
                .word   T849D
                .word   T932F
                .word   T90DD
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8776
                .word   T86EF
                .word   T87E2
                .word   T87FD
                .word   T8725
                .word   T870A
                .word   T8B78
                .word   T83FB
                .word   T8A85
                .word   T84B8
                .word   T84B8
                .word   T85E1
                .word   T85FC
                .word   T80A9
                .word   T8370
                .word   T82C3
                .word   T8B0C
                .word   T8020
                .word   T9314
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8B78
                .word   T83FB
                .word   T80A9
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8791
                .word   T87AC
                .word   T8A6A
                .word   T89C8
                .word   T864D
                .word   T87E2
                .word   T8B78
                .word   T84B8
                .word   T84B8
                .word   T83C5
                .word   T8164
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T808E
                .word   T814B
                .word   T8370
                .word   T9314
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T80A9
                .word   T803D
                .word   T8058
                .word   T8370
                .word   T8073
                .word   T89E3
                .word   T9164
                .word   T8668
                .word   T8668
                .word   T83C5
                .word   T889F
                .word   T84D3
                .word   T84D3
                .word   T85FC
                .word   T86B9
                .word   T8B78
                .word   T80DF
                .word   T80FA
                .word   T80DF
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T9314
                .word   T8668
                .word   T83E0
                .word   T8668
                .word   T8668
                .word   T8020
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T808E
                .word   T8668
                .word   T91EB
                .word   T9206
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T85FC
                .word   T80C4
                .word   T8370
                .word   T8115
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T9314
                .word   T8668
                .word   T8668
                .word   T80A9
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8073
                .word   T8668
                .word   T91EB
                .word   T89FE
                .word   T9206
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T80A9
                .word   T8370
                .word   T8130
                .word   T828D
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T9314
                .word   T8668
                .word   T80A9
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T808E
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8B78
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8668
                .word   T8370
                .word   T8370
                .word   T808E
                .word   T814B
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T9113
                .word   T92C3
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T92C3
                .word   T92C3
                .word   T92C3
                .word   T8C37
                .word   T92C3
                .word   T92C3
                .word   T92C3
                .word   T92C3
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
                .word   T8370
MixedRlePointerTable:
                .word   $0300
                .word   TA4A7
                .word   TA4E8
                .word   TA554
                .word   TA57C
                .word   TA599
                .word   TA5F3
                .word   TA62A
                .word   TA672
                .word   TA6BA
                .word   TA702
                .word   TA74A
                .word   TA78F
                .word   RleNametable_TitleScreen        ;TitleScreen
                .word   TA7FD
                .word   $0000
RlePointerTable:
                .word   $0300
                .word   TA800
                .word   TA803
                .word   TA80A
                .word   TA825
                .word   TA82A
                .word   TA831
                .word   TA84E
                .word   TA855
                .word   TA85C
                .word   TA867
                .word   TA872
                .word   TA88F
                .word   RleAttribute_TitleScreen        ;TitleScreen
                .word   TA899
                .word   $0000
LA01B:          .byte   $00
                .byte   $00
                .byte   $00
                .byte   $01
                .byte   $01
                .byte   $00
                .byte   $00
                .byte   $01
                .byte   $01
                .byte   $01
                .byte   $01
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
LA02A:          .byte   $00
                .byte   $00
                .byte   $00
                .byte   $01
                .byte   $01
                .byte   $00
                .byte   $00
                .byte   $02
                .byte   $02
                .byte   $03
                .byte   $03
                .byte   $00
                .byte   $04
                .byte   $00
                .byte   $00
LA039:          .byte   $00
                .byte   $00
                .byte   $00
                .byte   $01
                .byte   $01
                .byte   $00
                .byte   $00
                .res    6,$01
                .byte   $00
                .byte   $01
LA048:          .res    7,$00
                .res    7,$01
                .byte   $00
LA057:          .word   TA0AB
                .word   TA0AB
                .word   TA0AB
                .word   TA0AB
                .word   TA0AB
                .word   TA22B
                .word   TA22B
                .word   TA22B
                .word   TA22B
                .word   TA22B
                .word   TA22B
                .word   TA39B
                .word   TA39B
                .word   TA3F7
                .word   TA0AB
                .word   $0000
LA077:          .byte   $FB
LA078:          .byte   $82
                .byte   $9C
                HiAscii "(<(\(\(|("
                .byte   $1C
                .byte   $A9
                .byte   $3C
                .byte   $A9
                .byte   $3C
                .byte   $A9
                .byte   $5C
                .byte   $A9
                .byte   $5C
                .byte   $A9
                .byte   $7C
                .byte   $A9
                .byte   $9C
                HiAscii ")<)\)|)"
                .byte   $1C
                .byte   $AA
                .byte   $00
                .byte   $00
BankNumberTable:
                .byte   "022221111113303"               ;ASCII...
                .byte   $00
TA0AB:          .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $01
                .byte   $01
                .byte   $01
                .byte   $01
                .byte   $02
                .byte   $02
                .byte   $02
                .byte   $02
                .byte   $03
                .byte   $03
                .byte   $03
                .byte   $03
                .byte   $00
                .byte   $06
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $0E
                .byte   $0C
                .byte   $0F
                .byte   $01
                .byte   $01
                .byte   $0D
                .byte   $10
                .byte   $00
                .byte   $00
                .byte   $11
                .byte   $13
                .byte   $12
                .byte   $14
                .byte   $01
                .byte   $15
                .byte   $00
                .byte   $00
                .byte   $16
                .byte   $19
                .byte   $17
                .byte   $1A
                .byte   $18
                .byte   $01
                .byte   $00
                .byte   $00
                .byte   $1B
                .byte   $1E
                .byte   $1C
                .byte   $1F
                .byte   $1D
                .byte   $20
                .byte   $00
                .byte   $00
                .byte   $21
                .byte   $00
                .byte   $22
                .byte   $00
                .byte   $23
                .byte   $24
                .byte   $00
                .byte   $00
                .byte   $25
                .byte   $27
                .byte   $04
                .byte   $08
                .byte   $05
                .byte   $29
                .byte   $09
                .byte   $04
                .byte   $2A
                .byte   $0B
                .byte   $26
                .byte   $28
                .byte   $01
                .byte   $01
                .byte   $01
                .byte   $01
                .byte   $2B
                .byte   $2B
                .byte   $01
                .byte   $01
                .byte   $2D
                .byte   $2D
                .byte   $01
                .byte   $01
                .byte   $2F
                .byte   $2F
                .byte   $01
                .byte   $01
                .byte   $31
                .byte   $31
                .byte   $01
                .byte   $01
                .byte   "337:88,,"
                .byte   $03
                .byte   $03
                .byte   $2E
                .byte   $2E
                .byte   $03
                .byte   $03
                .byte   $30
                .byte   $30
                .byte   $03
                .byte   $03
                .byte   $32
                .byte   $32
                .byte   $03
                .byte   $03
                .byte   $34
                .byte   $34
                .byte   $03
                .byte   $03
                .byte   $39
                .byte   $39
                .byte   $03
                .byte   $03
                .byte   "=>?@;"
                .byte   $02
                .byte   $02
                .byte   "<;<AB"
                .byte   $02
                .byte   ";<??@=>"
                .byte   $02
                .byte   $02
                .byte   $43
                .byte   $44
                .byte   $02
                .byte   $46
                .byte   $45
                .byte   $03
                .byte   $47
                .byte   $48
                .byte   $03
                .byte   $49
                .byte   $4A
                .byte   $02
                .byte   $4B
                .byte   $4C
                .byte   $02
                .byte   $02
                .byte   $4D
                .byte   $4E
                .byte   $02
                .byte   "SOPT"
                .byte   $02
                .byte   $51
                .byte   $52
                .byte   $02
                .byte   $02
                .byte   $58
                .byte   $55
                .byte   $02
                .byte   $02
                .byte   "VWjiXUhgVW"
                .byte   $02
                .byte   "gXUhiVWj"
                .byte   $02
                .byte   $58
                .byte   $55
                .byte   $00
                .byte   $00
                .byte   $5C
                .byte   $5B
                .byte   $00
                .byte   $00
                .byte   $5A
                .byte   $59
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $66
                .byte   $00
                .byte   $00
                .byte   $65
                .byte   $64
                .byte   $00
                .byte   $00
                .byte   $63
                .byte   $62
                .byte   $00
                .byte   $00
                .byte   $61
                .byte   $61
                .byte   $00
                .byte   $00
                .byte   $60
                .byte   $60
                .byte   $00
                .byte   $00
                .byte   $62
                .byte   $63
                .byte   $00
                .byte   $00
                .byte   $64
                .byte   $65
                .byte   $00
                .byte   $00
                .byte   $66
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $5A
                .byte   $5B
                .byte   $00
                .byte   $00
                .byte   $5C
                .byte   $5D
                .byte   $00
                .byte   $89
                .byte   $84
                .byte   $85
                .byte   $8A
                .byte   $8B
                .byte   $86
                .byte   $87
                .byte   $00
                .byte   $8C
                .res    5,$00
                .byte   $8E
                .byte   $00
                .byte   $8F
                .byte   $88
                .byte   $90
                .byte   $01
                .byte   $01
                .byte   $8D
                .byte   $01
                .byte   $00
                .byte   $91
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $97
                .byte   $00
                .byte   $00
                .byte   $92
                .byte   $98
                .byte   $93
                .byte   $99
                .byte   $01
                .byte   $9A
                .byte   $01
                .byte   $9B
                .byte   $01
                .byte   $9C
                .byte   $94
                .byte   $9D
                .byte   $01
                .byte   $9E
                .byte   $95
                .byte   $9F
                .byte   $96
                .byte   $A0
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $A1
                .byte   $A9
                .byte   $A2
                .byte   $02
                .byte   $A3
                .byte   $AA
                .byte   $02
                .byte   $AB
                .byte   $02
                HiAscii ",$-%"
                .byte   $00
                .byte   $A6
                .byte   $B2
                .byte   $A7
                .byte   $00
                .byte   $A8
                .res    5,$00
                HiAscii ".0/1"
                .byte   $00
                .byte   $00
                .byte   $B3
                .byte   $00
                .byte   $B4
                .byte   $B5
                .byte   $00
                .byte   $00
                .byte   $B6
                .byte   $00
                .byte   $00
                .byte   $B7
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $88
                .byte   $00
                .byte   $01
                .byte   $BC
                .byte   $B8
                .byte   $01
                .byte   $B9
                .byte   $01
                .byte   $BA
                .byte   $01
                .byte   $BB
                .byte   $BD
                .byte   $00
                .byte   $00
                .byte   $BE
                .byte   $00
                .byte   $01
                HiAscii "B?C@D"
                .byte   $01
                .byte   $C5
                .byte   $C1
                .byte   $C6
                .byte   $00
                .byte   $00
                .byte   $C7
                .byte   $00
                .byte   $A6
                .byte   $B2
                .byte   $C8
                .byte   $00
                .byte   $C9
                .byte   $00
                .byte   $CA
                .byte   $CB
TA22B:          .res    6,$00
                .byte   $04
                .byte   $05
                .byte   $06
                .byte   $07
                .byte   $08
                .byte   $09
                .byte   $06
                .byte   $07
                .byte   $0A
                .byte   $0B
                .byte   $06
                .byte   $07
                .byte   $14
                .byte   $15
                .byte   $06
                .byte   $07
                .byte   $16
                .byte   $17
                .byte   $0C
                .byte   $0D
                .byte   $10
                .byte   $11
                .byte   $0E
                .byte   $0F
                .byte   $12
                .byte   $13
                .byte   $18
                .byte   $19
                .byte   $1C
                .byte   $1D
                .byte   $1A
                .byte   $1B
                .byte   $1E
                .byte   $1F
                .byte   $03
                .byte   $20
                .byte   $03
                .byte   $03
                .byte   $03
                .byte   $21
                .byte   $03
                .byte   $03
                .byte   $22
                .res    6,$01
                .byte   $22
                .byte   $23
                .byte   $01
                .byte   $24
                .byte   $25
                .byte   $01
                .byte   $01
                .byte   $01
                .byte   $01
                .byte   "*+-.,"
                .byte   $00
                .byte   "/012BC34DE569:78;<=>BC?"
                .byte   $00
                .byte   $44
                .byte   $45
                .byte   $00
                .byte   $00
                .byte   $40
                .byte   $41
                .byte   $00
                .byte   $00
                .byte   $46
                .byte   $47
                .byte   $00
                .byte   $00
                .byte   $48
                .byte   $00
                .byte   $00
                .byte   $51
                .byte   $51
                .byte   $03
                .byte   $49
                .byte   $4A
                .byte   $03
                .byte   "RKLSSMNSSOPT"
                .byte   $03
                .byte   $55
                .byte   $00
                .byte   $03
                .byte   $55
                .res    5,$03
                .byte   $56
                .byte   $03
                .byte   $58
                .byte   $57
                .byte   $03
                .byte   $59
                .byte   $03
                .byte   $5A
                .byte   $03
                .byte   $00
                .byte   $5D
                .byte   $5B
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   "\\\\"
                .byte   $00
                .byte   $5A
                .byte   $00
                .byte   $00
                .byte   $03
                .byte   $5B
                .byte   $5F
                .byte   $00
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $61
                .byte   $00
                .byte   "fbcghcdhie"
                .byte   $00
                .byte   $6A
                .byte   $00
                .byte   $60
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   "ol\p\\m\qn"
                .byte   $00
                .byte   $72
                .byte   $00
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $03
                .byte   $03
                .byte   $73
                .byte   $03
                .byte   $73
                .byte   $00
                .byte   $5A
                .byte   $00
                .byte   $00
                .byte   $03
                .byte   $74
                .byte   $77
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $79
                .byte   $7A
                .byte   $77
                .byte   $00
                .byte   $7B
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $75
                .byte   $03
                .byte   $00
                .byte   $78
                .byte   $76
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $78
                .byte   $00
                .byte   $7C
                .byte   $00
                .byte   $00
                .byte   $7D
                .byte   $7E
                .byte   $03
                .byte   $00
                .byte   $74
                .byte   $00
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $75
                .byte   $55
                .byte   $00
                .byte   $5B
                .byte   $00
                .byte   $7F
                .byte   $80
                .byte   $81
                .byte   $82
                .byte   $00
                .byte   $83
                .byte   $00
                .byte   $85
                .byte   $84
                .byte   $00
                .byte   $86
                .byte   $00
                .byte   $87
                .byte   $88
                .byte   $00
                .byte   $8F
                .byte   $89
                .byte   $8A
                .byte   $90
                .byte   $90
                .byte   $8B
                .byte   $8C
                .byte   $90
                .byte   $90
                .byte   $8D
                .byte   $8E
                .byte   $91
                .byte   $00
                .byte   $92
                .byte   $93
                .byte   $9A
                .byte   $9B
                .byte   $94
                .byte   $95
                .byte   $9C
                .byte   $9D
                .byte   $02
                .byte   $02
                .byte   $9E
                .byte   $9F
                .byte   $02
                .byte   $02
                .byte   $A0
                .byte   $A1
                .byte   $96
                .byte   $97
                .byte   $A2
                .byte   $A3
                .byte   $98
                .byte   $99
                HiAscii "$%&',-()./*+01223344"
                .byte   $01
                .byte   $01
                .byte   $00
                .byte   $00
                HiAscii "56789:;<=>?@ABCDEFEFEF"
                .byte   $00
                .byte   $00
                .byte   $00
                HiAscii "GHIJK"
                .byte   $00
                .byte   $51
                .byte   $00
                .byte   $5A
TA39B:          .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   "z{|}z"
                .byte   $80
                .byte   $7C
                .byte   $81
                .byte   $80
                .byte   $7B
                .byte   $81
                .byte   "}z{~"
                .byte   $7F
                .byte   $7E
                .byte   $7F
                .byte   "|}^_"
                .byte   $82
                .byte   $83
                .byte   $82
                .byte   $83
                .byte   $82
                .byte   $83
                .byte   $82
                .byte   $83
                .byte   $84
                .byte   $85
                .byte   $0F
                .byte   $10
                .byte   $11
                .byte   $12
                .byte   $60
                .byte   $61
                .byte   $6E
                .byte   $03
                .byte   $62
                .byte   $63
                .byte   $03
                .byte   "hdei"
                .byte   $03
                .byte   $66
                .byte   $67
                .byte   $03
                .byte   $72
                .byte   $6F
                .byte   $03
                .byte   $70
                .byte   $03
                .byte   $03
                .byte   $6A
                .byte   $03
                .byte   $6C
                .byte   $6B
                .byte   $03
                .byte   $6D
                .byte   $03
                .byte   $03
                .byte   $73
                .byte   $03
                .byte   $74
                .byte   $71
                .byte   $03
                .byte   $03
                .byte   $03
                .byte   $03
                .byte   $75
                .byte   $03
                .byte   $03
                .byte   $00
                .byte   $76
                .byte   $00
                .byte   $78
                .byte   $77
                .byte   $00
                .byte   $79
                .byte   $00
                .byte   $03
                .byte   $03
                .byte   $03
                .byte   $03
TA3F7:          .res    5,$00
                .byte   $44
                .byte   $00
                .byte   "GEFHI"
                .byte   $00
                .byte   $00
                .byte   $4A
                .byte   $4B
                .byte   $00
                .byte   $00
                .byte   $4C
                .byte   $4D
                .byte   $00
                .byte   $00
                .byte   "NOPQVWRSXYTUZ["
                .byte   $00
                .byte   $00
                .byte   $68
                .byte   $69
                .byte   $00
                .byte   $00
                .byte   $6A
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $00
                .byte   $6C
                .byte   $6D
                .byte   $00
                .byte   $00
                .byte   $6E
                .byte   $6F
                .byte   $00
                .byte   $00
                .byte   $70
                .byte   $71
                .byte   $00
                .byte   $00
                .byte   $72
                .byte   $73
                .byte   $67
                .byte   $00
                .byte   "tuvw"
                .byte   $85
                .byte   $86
                .byte   $78
                .byte   $79
                .byte   $87
                .byte   $88
                .byte   $7A
                .byte   $7B
                .byte   $89
                .byte   $8A
                .byte   $7C
                .byte   $7D
                .byte   $8B
                .byte   $8C
                .byte   $79
                .byte   $7A
                .byte   $00
                .byte   $00
                .byte   $7E
                .byte   $7F
                .byte   $8D
                .byte   $8E
                .byte   $80
                .byte   $81
                .byte   $8F
                .byte   $90
                .byte   $82
                .byte   $83
                .byte   $91
                .byte   $92
                .byte   $84
                .byte   $00
                .byte   $93
                .byte   $94
                .byte   $00
                HiAscii "(23)*4"
                .byte   $00
                HiAscii "+,56-.78/09:1"
                .byte   $00
                .byte   $BB
                .byte   $00
                HiAscii "<=GH>?IJ@AKLBCMNDEOPF"
                .byte   $00
                .byte   $D1
                .byte   $00
                HiAscii "abdec"
                .byte   $00
                .byte   $E6
                .byte   $00
                .byte   $E7
                .byte   $E8
                .byte   $00
                .byte   $00
                .byte   $E9
                .byte   $EA
                .byte   $00
                .byte   $ED
                .byte   $EB
                .byte   $00
                .byte   $EC
                .byte   $00
                HiAscii "pqno"
TA4A7:          .byte   $80,$70,$32,$33,$34,$35,$36,$37,$B8,$03,$39,$3A,$3B,$3C,$33,$3C
                .byte   $3D,$2C,$2D,$2E,$2B,$2C,$2B,$2C,$2B,$2C,$2B,$2C,$2F,$30,$31,$2C
                .byte   $2B,$02,$29,$2A,$02,$29,$2A,$02,$29,$2A,$02,$29,$2A,$02,$29,$2A
                .byte   $82,$11,$24,$25,$26,$27,$28,$82,$03,$24,$25,$26,$27,$28,$82,$03
                .byte   $FF
TA4E8:          .byte   $80,$35,$0B,$80,$07,$0B,$80,$02,$04,$00,$05,$07,$09,$0C,$0D,$00
                .byte   $04,$00,$05,$07,$09,$0C,$0D,$00,$10,$11,$06,$08,$0A,$01,$0E,$0F
                .byte   $10,$11,$06,$08,$0A,$01,$0E,$0F,$81,$07,$12,$81,$07,$12,$13,$94
                .byte   $02,$15,$16,$17,$18,$17,$16,$95,$02,$94,$02,$93,$03,$19,$9A,$02
                .byte   $1B,$1C,$1D,$1E,$1D,$1E,$9B,$02,$9A,$02,$99,$03,$82,$11,$1F,$23
                .byte   $02,$9F,$02,$23,$82,$02,$1F,$23,$02,$9F,$02,$23,$02,$20,$82,$02
                .byte   $21,$82,$03,$22,$20,$82,$02,$21,$82,$03,$22
                .byte   $FF
TA554:          .byte   $80,$29,$4B,$51,$80,$0C,$41,$46,$4C,$52,$80,$0A,$3E,$3F,$42,$47
                .byte   $4D,$80,$0C,$40,$43,$48,$4E,$80,$0D,$44,$49,$4F,$53,$54,$80,$0B
                .byte   $45,$4A,$50,$80,$26,$82,$20
                .byte   $FF
TA57C:          .byte   $80,$45,$3E,$3F,$56,$80,$0E,$40,$57,$5A,$5D,$80,$0C,$55,$58,$5B
                .byte   $5E,$53,$54,$80,$0B,$59,$5C,$5F,$80,$26,$82,$20
                .byte   $FF
TA599:          .byte   $80,$50,$81,$10,$02,$03,$02,$03,$02,$03,$02,$03,$04,$05,$02,$03
                .byte   $04,$05,$04,$05,$06,$07,$06,$07,$06,$07,$06,$07,$06,$07,$06,$07
                .byte   $06,$07,$06,$07,$08,$09,$08,$09,$08,$09,$08,$09,$08,$09,$08,$09
                .byte   $08,$09,$08,$09,$0A,$0B,$0A,$0B,$0A,$0B,$0A,$0B,$0A,$0B,$0A,$0B
                .byte   $0A,$0B,$0A,$0B,$8F,$04,$0C,$8F,$09,$0D,$0F,$0E,$8F,$04,$0E,$8F
                .byte   $02,$0C,$8F,$02,$0D,$0F,$8E,$02,$0F
                .byte   $FF
TA5F3:          .byte   $80,$32,$42,$43,$80,$04,$53,$80,$08,$44,$45,$46,$47,$80,$03,$54
                .byte   $80,$07,$48,$49,$4A,$4B,$4C,$4D,$80,$02,$55,$00,$57,$D9,$03,$80
                .byte   $03,$4E,$CF,$02,$50,$80,$03,$56,$00,$58,$DA,$03,$80,$02,$D1,$10
                .byte   $D2,$10,$8F,$20,$C1,$10
                .byte   $FF
TA62A:          .byte   $80,$16,$14,$15,$80,$0D,$18,$16,$17,$19,$1A,$80,$0A,$1B,$1C,$1D
                .byte   $1E,$1F,$20,$80,$0A,$21,$22,$8F,$02,$23,$21,$80,$0A,$24,$25,$A6
                .byte   $02,$27,$28,$80,$0A,$29,$2A,$2B,$2C,$2D,$2E,$80,$0B,$2F,$30,$31
                .byte   $32,$80,$0B,$5B,$21,$3E,$21,$39,$80,$0B,$37,$38,$00,$3A,$3B,$80
                .byte   $0E,$3C,$3D,$80,$07,$8F,$10
                .byte   $FF
TA672:          .byte   $80,$16,$14,$15,$80,$0D,$18,$16,$17,$19,$1A,$80,$0A,$1B,$1C,$1D
                .byte   $1E,$1F,$20,$80,$0A,$21,$22,$8F,$02,$23,$21,$80,$0A,$24,$25,$A6
                .byte   $02,$27,$28,$80,$0A,$29,$2A,$2B,$2C,$2D,$2E,$80,$0B,$2F,$30,$31
                .byte   $32,$80,$0C,$33,$34,$3F,$21,$40,$80,$0B,$35,$36,$00,$3C,$3D,$80
                .byte   $0B,$37,$38,$80,$09,$8F,$10
                .byte   $FF
TA6BA:          .byte   $80,$16,$10,$11,$80,$0D,$18,$12,$13,$19,$1A,$80,$0A,$1B,$1C,$1D
                .byte   $1E,$1F,$20,$80,$0A,$21,$22,$8F,$02,$23,$21,$80,$0A,$24,$25,$A6
                .byte   $02,$27,$28,$80,$0A,$29,$2A,$2B,$2C,$2D,$2E,$80,$0B,$2F,$30,$31
                .byte   $32,$80,$0B,$5B,$21,$3E,$21,$39,$80,$0B,$37,$38,$00,$3A,$3B,$80
                .byte   $0E,$3C,$3D,$80,$07,$8F,$10
                .byte   $FF
TA702:          .byte   $80,$16,$10,$11,$80,$0D,$18,$12,$13,$19,$1A,$80,$0A,$1B,$1C,$1D
                .byte   $1E,$1F,$20,$80,$0A,$21,$22,$8F,$02,$23,$21,$80,$0A,$24,$25,$A6
                .byte   $02,$27,$28,$80,$0A,$29,$2A,$2B,$2C,$2D,$2E,$80,$0B,$2F,$30,$31
                .byte   $32,$80,$0C,$33,$34,$3F,$21,$40,$80,$0B,$35,$36,$00,$3C,$3D,$80
                .byte   $0B,$37,$38,$80,$09,$8F,$10
                .byte   $FF
TA74A:          .byte   $80,$02,$06,$80,$0F,$07,$80,$0F,$07,$80,$02,$01,$00,$02,$03,$00
                .byte   $01,$00,$02,$03,$00,$01,$80,$02,$07,$80,$0F,$07,$80,$0F,$07,$80
                .byte   $02,$04,$80,$04,$04,$80,$04,$04,$80,$02,$07,$80,$02,$05,$80,$04
                .byte   $05,$80,$04,$05,$80,$02,$07,$80,$0F,$07,$80,$0F,$07,$80,$0F,$08
                .byte   $80,$0D,$89,$10
                .byte   $FF
TA78F:          .byte   $80,$35,$0A,$0B,$0C,$0D,$80,$0C,$0E,$0F,$10,$11,$80,$0C,$12,$96
                .byte   $02,$13,$80,$0C,$96,$04,$80,$0C,$96,$04,$80,$0C,$96,$04,$80,$0C
                .byte   $96,$04,$80,$0B,$14,$96,$04,$15,$80,$06,$89,$10
                .byte   $FF
RleNametable_TitleScreen:
                .byte   $80,$23,$01,$02,$03,$04,$05,$80,$0D,$06,$07,$08,$00,$26,$27,$80
                .byte   $08,$09,$0A,$0B,$0C,$00,$0D,$0E,$0F,$10,$80,$07,$11,$12,$13,$14
                .byte   $15,$16,$17,$18,$19,$15,$80,$09,$1A,$1B,$1C,$1D,$1E,$1F,$80,$08
                .byte   $26,$27,$20,$21,$22,$23,$24,$25,$80,$3A,$2A,$28,$29,$2B,$80,$06
                .byte   $FF
TA7FD:          .byte   $83,$C0
                .byte   $FF
TA800:          .byte   $30,$AA                         ;Attribute = All #$AA(#2, #2, #2, #2)
                .byte   $00
TA803:          .byte   $20,$00
                .byte   $08,$A5
                .byte   $08,$AA
                .byte   $00
TA80A:          .byte   $08,$00
                .byte   $03,$55
                .byte   $01,$11
                .byte   $04,$55
                .byte   $04,$00
                .byte   $01,$55
                .byte   $01,$11
                .byte   $05,$00
                .byte   $01,$88
                .byte   $01,$AA
                .byte   $01,$55
                .byte   $0A,$00
                .byte   $08,$FF
                .byte   $00
TA825:          .byte   $28,$00
                .byte   $08,$FF
                .byte   $00
TA82A:          .byte   $20,$00
                .byte   $08,$55
                .byte   $08,$AA
                .byte   $00
TA831:          .byte   $0C,$00
                .byte   $01,$30
                .byte   $07,$00
                .byte   $01,$22
                .byte   $03,$00
                .byte   $01,$04
                .byte   $02,$05
                .byte   $01,$00
                .byte   $01,$02
                .byte   $01,$0D
                .byte   $01,$0F
                .byte   $01,$03
                .byte   $08,$55
                .byte   $08,$A5
                .byte   $00
TA84E:          .byte   $08,$55
                .byte   $20,$00
                .byte   $08,$F0
                .byte   $00
TA855:          .byte   $08,$00
                .byte   $20,$AA
                .byte   $08,$FA
                .byte   $00
TA85C:          .byte   $08,$55
                .byte   $03,$00
                .byte   $01,$05
                .byte   $1C,$00
                .byte   $08,$F0
                .byte   $00
TA867:          .byte   $08,$AA
                .byte   $03,$00
                .byte   $01,$0A
                .byte   $1C,$00
                .byte   $08,$F0
                .byte   $00
TA872:          .byte   $01,$00
                .byte   $01,$11
                .byte   $07,$00
                .byte   $01,$11
                .byte   $07,$00
                .byte   $01,$11
                .byte   $07,$00
                .byte   $01,$11
                .byte   $07,$00
                .byte   $01,$11
                .byte   $06,$00
                .byte   $01,$AA
                .byte   $01,$A5
                .byte   $06,$AA
                .byte   $00
TA88F:          .byte   $30,$00
                .byte   $00
RleAttribute_TitleScreen:
                .byte   $10,$00
                .byte   $10,$55
                .byte   $10,$AA
                .byte   $00
TA899:          .byte   $30,$00                         ;Attribute = All #$AA(#2, #2, #2, #2)
                .byte   $00
                .byte   $3C
                .byte   $00
                .byte   $30
                .byte   $01
                .byte   $3C
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $3C
                .byte   $00
                .byte   $10
                .byte   " <7("
                .byte   $15
                .byte   $3C
                .byte   $27
                .byte   $38
                .byte   $16
                .byte   $3C
                .byte   $27
                .byte   $30
                .byte   $03
                .byte   $3C
                .byte   $25
                .byte   $28
                .byte   $15
                .byte   "<0,+,"
                .byte   $02
                .byte   $12
                .byte   $22
                .byte   $2C
                .byte   $19
                .byte   $12
                .byte   $10
                .byte   $2C
                .byte   $00
                .byte   $10
                .byte   " ,7("
                .byte   $15
                .byte   $2C
                .byte   $27
                .byte   $38
                .byte   $16
                .byte   $2C
                .byte   $27
                .byte   $30
                .byte   $03
                .byte   $2C
                .byte   $25
                .byte   $28
                .byte   $15
                .byte   ",0<+,'0"
                .byte   $05
                .byte   $2C
                .byte   $27
                .byte   $28
                .byte   $00
                .byte   $2C
                .byte   $27
                .byte   $0F
                .byte   $00
                .byte   $2C
                .byte   $37
                .byte   $28
                .byte   $15
                .byte   $2C
                .byte   $27
                .byte   $38
                .byte   $16
                .byte   $2C
                .byte   $27
                .byte   $30
                .byte   $03
                .byte   $2C
                .byte   $25
                .byte   $28
                .byte   $15
                .byte   ",0<+,",$22
                .byte   $11
                .byte   $01
                .byte   $2C
                .byte   $22
                .byte   $11
                .byte   $10
                .byte   $2C
                .byte   $10
                .byte   $2A
                .byte   $19
                .byte   $2C
                .byte   $37
                .byte   $28
                .byte   $15
                .byte   $2C
                .byte   $27
                .byte   $28
                .byte   $16
                .byte   $2C
                .byte   $37
                .byte   $30
                .byte   $03
                .byte   $2C
                .byte   $2A
                .byte   $38
                .byte   $16
                .byte   ",0,+,'("
                .byte   $18
                .byte   $2C
                .byte   $15
                .byte   $27
                .byte   $05
                .byte   $2C
                .byte   $00
                .byte   $10
                .byte   "2,7("
                .byte   $16
                .byte   $2C
                .byte   $27
                .byte   $28
                .byte   $06
                .byte   $2C
                .byte   $37
                .byte   $30
                .byte   $03
                .byte   $2C
                .byte   $1C
                .byte   "0&,0<+"
                .byte   $0F
                .byte   $28
                .byte   $38
                .byte   $05
                .byte   $0F
                .byte   $30
                .byte   $2C
                .byte   $05
                .byte   $0F
                .byte   $28
                .byte   $3C
                .byte   $06
                .byte   $0F
                .byte   $37
                .byte   $28
                .byte   $15
                .byte   $0F
                .byte   $27
                .byte   $28
                .byte   $16
                .byte   $0F
                .byte   $37
                .byte   $30
                .byte   $03
                .byte   $0F
                .byte   $1C
                .byte   $30
                .byte   $26
                .byte   $0F
                .byte   $30
                .byte   $3C
                .byte   $2B
                .byte   $0F
                .byte   $10
                .byte   $30
                .byte   $04
                .byte   $0F
                .byte   $10
                .byte   $2A
                .byte   $1A
                .byte   $0F
                .byte   $2A
                .byte   $2C
                .byte   $1A
                .byte   $0F
                .byte   $37
                .byte   $28
                .byte   $15
                .byte   $0F
                .byte   $27
                .byte   $38
                .byte   $16
                .byte   $0F
                .byte   $37
                .byte   $30
                .byte   $03
                .byte   $0F
                .byte   $1C
                .byte   $30
                .byte   $26
                .byte   $0F
                .byte   $30
                .byte   $3C
                .byte   $2B
                .byte   $0F
                .byte   $11
                .byte   $28
                .byte   $15
                .byte   $0F
                .byte   $25
                .byte   $15
                .byte   $05
                .byte   $0F
                .byte   $19
                .byte   $1A
                .byte   $0A
                .byte   $0F
                .byte   $37
                .byte   $28
                .byte   $16
                .byte   $0F
                .byte   $27
                .byte   $28
                .byte   $16
                .byte   $0F
                .byte   $37
                .byte   $30
                .byte   $02
                .byte   $0F
                .byte   $11
                .byte   $2C
                .byte   $15
                .byte   $0F
                .byte   $30
                .byte   $2C
                .byte   $2B
                .byte   $0F
                .byte   $12
                .byte   $28
                .byte   $03
                .byte   $0F
                .byte   $24
                .byte   $14
                .byte   $04
                .byte   $0F
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $0F
                .byte   $37
                .byte   $28
                .byte   $15
                .byte   $0F
                .byte   $27
                .byte   $28
                .byte   $16
                .byte   $0F
                .byte   $10
                .byte   $30
                .byte   $02
                .byte   $0F
                .byte   $2A
                .byte   $20
                .byte   $14
                .byte   $0F
                .byte   $30
                .byte   $2C
                .byte   $2B
                .byte   $0F
                .byte   $3C
                .byte   $30
                .byte   $16
                .byte   $0F
                .byte   $2C
                .byte   $28
                .byte   $15
                .byte   $0F
                .byte   $28
                .byte   $30
                .byte   $15
                .byte   $0F
                .byte   $37
                .byte   $28
                .byte   $15
                .byte   $0F
                .byte   $27
                .byte   $28
                .byte   $16
                .byte   $0F
                .byte   $10
                .byte   $30
                .byte   $15
                .byte   $0F
                .byte   $01
                .byte   $28
                .byte   $13
                .byte   $0F
                .byte   $30
                .byte   $2C
                .byte   $2B
                .byte   $01
                .byte   $01
                .byte   $30
                .res    29,$01
                .byte   $0F
                .byte   $20
                .byte   $3C
                .byte   $2B
                .byte   $0F
                .byte   $20
                .byte   $3C
                .byte   $3B
                .byte   $0F
                .byte   $20
                .byte   $3C
                .byte   $2B
                .byte   $0F
                .byte   $37
                .byte   $28
                .byte   $15
                .byte   $0F
                .byte   $27
                .byte   $28
                .byte   $16
                .byte   $0F
                .byte   $37
                .byte   $20
                .byte   $03
                .byte   $0F
                .byte   $1C
                .byte   $30
                .byte   $26
                .byte   $0F
                .byte   $30
                .byte   $3C
                .byte   $2B
                .res    5,$0F
                .byte   $24
                .byte   $14
                .byte   $04
                .byte   $0F
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $0F
                .byte   $37
                .byte   $28
                .byte   $15
                .byte   $0F
                .byte   $27
                .byte   $28
                .byte   $16
                .byte   $0F
                .byte   $37
                .byte   $20
                .byte   $03
                .byte   $0F
                .byte   $1C
                .byte   $30
                .byte   $26
                .byte   $0F
                .byte   $30
                .byte   $3C
                .byte   $2B
TextData_01:    .byte   $22,$3A,$3A,$4A,$20,$36,$45,$5D,$41,$4E,$33,$20,$43,$5E,$3D,$23 ;「ここは かなんちほう です」
                .byte   $2A
TextData_02:    .byte   $22,$3A,$3A,$4A,$20,$3A,$5E,$4B,$5E,$3B,$4A,$5E,$38,$20,$43,$5E ;「ここは ごびさばく です」
                .byte   $3D,$23,$2A
TextData_03:    .byte   $22,$3A,$3A,$4A,$20,$40,$38,$57,$4F,$36,$5D,$3B,$4A,$5E,$38,$20 ;「ここは たくらまかんさばく です」
                .byte   $43,$5E,$3D,$23,$2A
TextData_04:    .byte   $41,$2E,$33,$31,$5D,$49,$20,$50,$54,$3A,$40,$5E,$21,$2A ;ちょうあんの みやこだ！
TextData_05:    .byte   $57,$38,$56,$33,$49,$20,$50,$54,$3A,$40,$5E,$21,$2A ;らくようの みやこだ！
TextData_06:    .byte   $41,$2E,$33,$3C,$2D,$33,$49,$20,$50,$54,$3A,$40,$5E,$21,$2A ;ちょうしゅうの みやこだ！
TextData_07:    .byte   $41,$2E,$5D,$42,$33,$49,$20,$50,$54,$3A,$40,$5E,$21,$2A ;ちょんつうの みやこだ！
TextData_08:    .byte   $22,$45,$36,$4F,$26,$20,$31,$42,$52,$45,$3B,$32,$23,$2A ;「なかまを あつめなさい」
TextData_09:    .byte   $22,$37,$40,$4D,$20,$3D,$3D,$52,$23,$2A ;「きたへ すすめ」
TextData_0A:    .byte   $22,$44,$37,$49,$20,$53,$5D,$26,$20,$44,$35,$5A,$23,$2A ;「ときの もんを とおれ」
TextData_0B:    .byte   $22,$56,$59,$4A,$20,$37,$39,$5D,$40,$5E,$23,$2A ;「よるは きけんだ」
TextData_0C:    .byte   $22,$46,$3C,$46,$20,$36,$34,$5D,$3B,$5E,$5D,$36,$5E,$20,$31,$58 ;「にしに かえんざんが あります」
                .byte   $4F,$3D,$23,$2A
TextData_0D:    .byte   $22,$43,$5D,$3C,$5E,$38,$4A,$20,$36,$34,$5D,$3B,$5E,$5D,$49,$20 ;「てんじくは かえんざんの むこう」
                .byte   $51,$3A,$33,$23,$2A
TextData_0E:    .byte   $22,$57,$3E,$42,$3C,$5E,$2E,$26,$20,$40,$35,$3E,$4A,$5E,$36,$34 ;「らせつじょを たおせば かえんざんの・・」
                .byte   $5D,$3B,$5E,$5D,$49,$25,$25,$23,$2A
TextData_0F:    .byte   $22,$37,$5D,$36,$38,$4A,$20,$3B,$4A,$5E,$38,$49,$20,$4A,$43,$46 ;「きんかくは さばくの はてにいる」
                .byte   $32,$59,$23,$2A
TextData_10:    .byte   $22,$4C,$3C,$41,$2E,$33,$20,$4E,$33,$35,$33,$26,$20,$3B,$36,$5E ;「ふしちょう ほうおうを さがせ」
                .byte   $3E,$23,$2A
TextData_11:    .byte   $37,$5D,$36,$38,$40,$5E,$32,$35,$33,$20,$22,$37,$5E,$5D,$36,$38 ;きんかくだいおう 「ぎんかくのかたき！」
                .byte   $49,$36,$40,$37,$21,$23,$2A
TextData_12:    .byte   $37,$5E,$5D,$36,$38,$40,$5E,$32,$35,$33,$20,$22,$3A,$3A,$4A,$44 ;ぎんかくだいおう 「ここはとおさんぞ！」
                .byte   $35,$3B,$5D,$3F,$5E,$21,$23,$2A
TextData_13:    .byte   $22,$5C,$40,$3C,$36,$5E,$20,$57,$3E,$42,$3C,$5E,$2E,$40,$5E,$21 ;「わたしが らせつじょだ！」
                .byte   $23,$2A
TextData_14:    .byte   $22,$43,$5D,$3C,$5E,$38,$4A,$53,$33,$3D,$38,$5E,$43,$5E,$3D,$23 ;「てんじくはもうすぐです」
                .byte   $2A
TextData_15:    .byte   $45,$36,$5E,$32,$40,$4B,$5E,$36,$5E,$20,$4A,$3C,$5E,$4F,$59,$25 ;「ながいたびが はじまる・・」
                .byte   $25,$2A
TextData_16:    .byte   $3A,$5D,$3E,$32,$4F,$35,$33,$20,$22,$56,$38,$3A,$3A,$4F,$43,$5E ;こんせいまおう 「よくここまできたな・・」
                .byte   $37,$40,$45,$25,$25,$23,$2A
TextData_17:    .byte   $3A,$5E,$38,$33,$32,$2F,$3A,$33,$49,$2A ;ごくういっこうの
TextData_18:    .byte   $45,$36,$5E,$32,$20,$45,$36,$5E,$32,$20,$40,$4B,$5E,$4A,$20,$35 ;ながい ながい たびは おわり
                .byte   $5C,$58,$2A
TextData_19:    .byte   $3A,$5A,$36,$57,$41,$2D,$33,$3A,$5E,$38,$49,$20,$5A,$37,$3C,$36 ;これからちゅうごくの れきしが はじまる
                .byte   $5E,$20,$4A,$3C,$5E,$4F,$59,$2A
TextData_1A:    .byte   $35,$3C,$2C,$36,$3B,$4F,$56,$58,$2A ;おしゃかさまより
TextData_1B:    .byte   $31,$58,$36,$5E,$40,$32,$35,$37,$2E,$33,$26,$20,$32,$40,$40,$5E ;ありがたいおきょうを いただいて
                .byte   $32,$43,$2A
TextData_1C:    .byte   $4B,$44,$4B,$5E,$44,$46,$20,$35,$3C,$34,$26,$20,$42,$40,$34,$4F ;ひとびとに おしえを つたえましょう
                .byte   $3C,$2E,$33,$2A
TextData_1D:    .byte   $31,$31,$20,$3C,$5D,$3C,$5E,$2C,$2F,$40,$21,$2A ;ああ しんじゃった！
TextData_1E:    .byte   $35,$3C,$4F,$32,$2A             ;おしまい
TextData_1F:    .byte   $4A,$2F,$36,$32,$20,$22,$40,$5E,$5A,$36,$20,$40,$3D,$39,$43,$21 ;はっかい 「だれか たすけて！」
                .byte   $23,$2A
TextData_21:    .byte   $22,$3B,$4A,$5E,$38,$49,$20,$32,$58,$38,$5E,$41,$4A,$20,$4E,$38 ;「さばくの いりぐちは ほくせい」
                .byte   $3E,$32,$23,$2A
TextData_22:    .byte   $22,$36,$5E,$5D,$4A,$5E,$2F,$43,$38,$40,$5E,$3B,$32,$48,$23,$2A ;「がんばってくださいね」
TextData_24:    .byte   $3B,$3A,$5E,$3C,$5E,$2E,$33,$20,$22,$35,$44,$53,$3C,$4F,$3D,$21 ;さごじょう 「おともします！」
                .byte   $23,$2A
TextData_25:    .byte   $22,$C1,$C2,$20,$C1,$C2,$23,$2A ;「AB AB」
TextData_26:    .byte   $22,$C1,$C2,$20,$C1,$C2,$20,$C1,$C2,$23,$2A ;「AB AB AB」
TextData_27:    .byte   $22,$C1,$C2,$20,$C1,$20,$C1,$20,$C1,$C2,$23,$2A ;「AB A A AB」
TextData_28:    .byte   $22,$C1,$C2,$20,$C1,$20,$C1,$23,$2A ;「AB A A」
TextData_29:    .byte   $22,$C1,$C2,$20,$C1,$20,$C1,$C2,$20,$C1,$C2,$23,$2A ;「AB A AB AB」

LACB6:          LDA     #$20                            ;$60 = $2000
                STA     $61
                LDA     #$00
                STA     $60
                LDA     #$C0                            ;$68 = $23C0
                STA     $68
                LDA     #$23
                STA     $69
                LDA     $55                             ;$55 &= #$0F (chip?)
                AND     #$0F
                STA     $55
                LDA     $54                             ;$54 &= #$1F (page?)
                AND     #$1F
                STA     $54
                CMP     #$10
                BCC     @LACDE
                LDA     #$24
                STA     $61
                LDA     #$27
                STA     $69
@LACDE:         RTS

LACDF:          JSR     LACB6
                LDA     PpuCtrlBuffer_Bit2_AddrDirection
                BNE     @LAD12
                LDA     $55
                ROR     A
                ROR     A
                ROR     A
                AND     #$C0
                CLC
                ADC     $60
                TAY
                LDA     $55
                PHP
                ROR     A
                ROR     A
                AND     #$3F
                PLP
                ADC     $61
                BIT     PPUSTATUS
                STA     PPUADDR
                STY     PPUADDR
                LDY     #$00
@LAD06:         LDA     $0401,y
                STA     PPUDATA
                INY
                CPY     #$40
                BNE     @LAD06
                RTS

@LAD12:         LDA     $54
                AND     #$0F
                ASL     A
                ADC     $60
                TAY
                LDA     $61
                ADC     #$00
                BIT     PPUSTATUS
                STA     PPUADDR
                STY     PPUADDR
                LDY     #$00
@LAD29:         LDA     $0401,y
                STA     PPUDATA
                INY
                CPY     #$1E
                BNE     @LAD29
                LDA     $54
                AND     #$0F
                ASL     A
                SEC
                ADC     $60
                TAY
                LDA     $61
                ADC     #$00
                BIT     PPUSTATUS
                STA     PPUADDR
                STY     PPUADDR
                LDY     #$00
@LAD4C:         LDA     $0421,y
                STA     PPUDATA
                INY
                CPY     #$1E
                BNE     @LAD4C
                LDA     #$00
                STA     $D3
                RTS

                LDA     $55
                AND     #$0E
                ASL     A
                ASL     A
                ADC     $68
                STA     $68
                LDA     PPUSTATUS
                LDA     $69
                STA     PPUADDR
                LDA     $68
                STA     PPUADDR
                LDY     #$00
@LAD75:         LDA     ($8A),y
                STA     PPUDATA
                INY
                CPY     #$08
                BNE     @LAD75
LAD7F:          RTS

LAD80:          LDA     $53
                BEQ     LAD7F
                LDA     #$00
                STA     $53
                LDA     PPUSTATUS
                LDA     $60
                CLC
                ADC     #$C0
                TAY
                LDA     $61
                ADC     #$03
                STA     PPUADDR
                STY     PPUADDR
                LDY     #$00
@LAD9D:         LDA     ($62),y
                STA     PPUDATA
                INY
                CPY     #$30
                BNE     @LAD9D
                LDA     #$FF
@LADA9:         STA     PPUDATA
                INY
                CPY     #$40
                BNE     @LADA9
                RTS

TransferPalette:
                LDA     PpuCtrlBuffer_Bit2_AddrDirection
                ORA     $D3
                BNE     @Return
                LDA     PPUSTATUS                       ;Clear VBlank flag
                LDA     #$3F                            ;Set PPU dst addr = $3F00 (palette)
                STA     PPUADDR
                LDA     #$00
                STA     PPUADDR
                LDA     $0484
                BNE     @ClearDarkBlue
                LDY     #$00
@LoopCopyPalette:
                LDA     PaletteBuffer,y
                STA     PPUDATA
                INY
                CPY     #$20
                BNE     @LoopCopyPalette
@ResetScreenPosition:
                LDA     PPUSTATUS
                LDA     #$3F                            ;Set PPU dst addr = $3F00 (palette)
                STA     PPUADDR
                LDA     #$00
                STA     PPUADDR
                STA     PPUADDR                         ;Set screen position (0, 0)
                STA     PPUADDR
@Return:        RTS

@ClearDarkBlue: LDY     #$00
                LDA     #$01
@LoopBluePalette:
                STA     PPUDATA
                INY
                CPY     #$20
                BNE     @LoopBluePalette
                BEQ     @ResetScreenPosition

NMI:            PHA                                     ;Prologue
                TXA
                PHA
                TYA
                PHA
                LDA     OamDmaRequest
                ORA     $03FE
                BEQ     @SkipSpriteDma
                LDA     #$00
                STA     OAMADDR                         ;Reset OAM pointer
                STA     OamDmaRequest
                LDA     #$02                            ;Execute sprite DMA
                STA     OAMDMA
@SkipSpriteDma: INC     ProcessStateCounter             ;Increment state counter (between $00 - $1F)
                LDA     ProcessStateCounter
                AND     #$1F
                STA     ProcessStateCounter
                AND     #$07
                STA     $3E
                LDA     ChrBankRequest                  ;Switch CHR bank (incorrect procedure...)
                AND     #$03
                TAY
                LDA     ChrBankRequest
                STA     LFFF4,y
                STA     LFFF4,y
                STA     LFFF4,y
                INC     $56
                LDA     $52
                BNE     @LAE3C
                JSR     TransferPalette
                LDA     #$00
                STA     $5F
                BEQ     @LAE45

@LAE3C:         JSR     LACDF
                LDA     #$00
                STA     $52
                STA     PpuCtrlBuffer_Bit2_AddrDirection
@LAE45:         JSR     LAD80
                LDA     $03FE
                BNE     @LAE58
                LDA     RleExpandIndex
                CMP     #$0C
                BEQ     @LAE58
                LDY     #$60
@LAE55:         DEY
                BNE     @LAE55
@LAE58:         LDA     $FE
                BEQ     @LAE61
                DEC     $FE
                JSR     @LAE6E
@LAE61:         JSR     SetDisplayScreenPosition
                LDA     #$01
                STA     $51
                PLA
                TAY
                PLA
                TAX
                PLA
                RTI

@LAE6E:         LDA     ScreenX
                LDY     ScreenX+1
                CLC
                ADC     #$20
                BCS     @LAE7D
                PHA
                TYA
                EOR     #$01
                TAY
                PLA
@LAE7D:         LSR     A
                LSR     A
                LSR     A
                STA     $FD
                TYA
                ASL     A
                ASL     A
                ORA     #$20
                LDY     $FD
                BIT     PPUSTATUS
                STA     PPUADDR
                STA     $C4
                STY     PPUADDR
                STY     $C3
                LDY     #$1A
@LAE98:         LDA     #$00
                STA     PPUDATA
                INC     $C3
                LDA     $C3
                AND     #$1F
                BNE     @LAEB4
                LDA     $C4
                EOR     #$04
                BIT     PPUSTATUS
                STA     PPUADDR
                LDA     #$00
                STA     PPUADDR
@LAEB4:         DEY
                BNE     @LAE98
                RTS

ReadJoypad:     TXA                                     ;Save software stack pointer
                PHA
                LDA     #$01                            ;Latch the pad status
                STA     JOY1
                LDA     #$00
                STA     JOY1
                TAX
@Loop:          LDA     JOY1                            ;Read buttons status
                AND     #$03
                STA     PadBuffer_Now,x                 ;1button, 1byte...
                INX
                CPX     #$08
                BNE     @Loop
                JSR     @CheckButtons
                PLA                                     ;Restore software stack pointer
                TAX
                RTS

@CheckButtons:  LDX     #$00
@Loop1:         JSR     @CheckButton
                INX
                CPX     #$08
                BCC     @Loop1
                RTS

@CheckButton:   LDA     PadBuffer_Prev,x
                BNE     @NotTrigger
                LDA     PadBuffer_Now,x
                BEQ     @NotTrigger
                STA     PadBuffer_Prev,x                ;Copy to previous input
                LDA     #$01
                STA     PadBuffer_Trigger,x
                RTS

@NotTrigger:    LDA     #$00
                STA     PadBuffer_Trigger,x
                LDA     PadBuffer_Now,x
                STA     PadBuffer_Prev,x
                RTS

ClearPpuControlBuffer:
                LDY     #$07
                LDA     #$00
@Loop:          STA     PpuControlBuffer,y
                DEY
                BPL     @Loop
                RTS

ClearPpuMaskBuffer:
                LDY     #$07
                LDA     #$00
@Loop:          STA     PpuMaskBuffer,y
                DEY
                BPL     @Loop
                RTS

; Read from $41-$48 each bytes
; Concat to PpuControl setting value
ReadPpuControl: LDY     #$07
                LDA     #$00
                STA     $C5
@Loop:          LDA     PpuControlBuffer,y
                LSR     A
                ROL     $C5
                DEY
                BPL     @Loop
                LDA     $C5
                RTS

SetPpuControl:  JSR     ReadPpuControl
                STA     PPUCTRL
                RTS

SetPpuMask:     LDY     #$07
                LDA     #$00
                STA     $C5
@Loop:          LDA     PpuMaskBuffer,y
                LSR     A
                ROL     $C5
                DEY
                BPL     @Loop
                LDA     $C5
                STA     PPUMASK
                RTS

VmHelper_PopPpuAddress:
                LDA     PPUSTATUS                       ;Clear NMI
                JSR     VmOp_PopRegister
                STA     PPUADDR
                STY     PPUADDR
                RTS

VmHelper_PushPpuData:
                LDA     PPUDATA
                JMP     VmOp_PushByte

VmHelper_PopPpuData:
                JSR     VmOp_PopRegister
                STY     PPUDATA
                RTS

SetDisplayScreenPosition:
                LDA     ScreenX
                STA     PPUSCROLL
                LDA     ScreenX+1
                STA     PpuCtrlBuffer_Bit0_BaseNametable ;Base nametable
                LDA     ScreenY
                STA     PPUSCROLL
                LDA     ScreenY+1
                STA     PpuCtrlBuffer_Bit1_BaseNametable ;Base nametable
                JMP     SetPpuControl

VmHelper_PushConst_0405:
                LDA     #$04
                LDY     #$05
                JMP     VmOp_PushRegister

LAF7C:          LDA     $CD
                BEQ     @Decrement
@Increment:     INC     ScreenX
                INC     ScreenX
                BNE     @Return
                INC     ScreenX+1                       ;High byte
                RTS

@Decrement:     LDA     $CC
                BEQ     @Return
                DEC     ScreenX
                DEC     ScreenX
                LDA     ScreenX
                CMP     #$FE
                BNE     @Return
                DEC     ScreenX+1                       ;High byte
@Return:        RTS

LAF9A:          LDA     RleExpandIndex
                CMP     #$20
                BCC     @Expand                         ;Index < #$20
@Reset:         LDA     #$00
                STA     RleExpandIndex
                BEQ     @SkipExpand

@Expand:        JSR     ExpandMixedRleData              ;Nametable
                JSR     ExpandRleData                   ;Attribute
@SkipExpand:    JSR     @LAFC7
                JSR     LAFE2
                LDY     RleExpandIndex
                LDA     LA01B,y
                BEQ     @LAFC1
                INC     RleExpandIndex
                JSR     ExpandMixedRleData
                JSR     ExpandRleData
@LAFC1:         JSR     @LAFC7
                JMP     LB02D

@LAFC7:         LDA     RleExpandIndex
                ASL     A
                TAY
                LDA     LA057,y
                STA     $64
                LDA     LA057+1,y
                STA     $65
                RTS

LAFD6:          LDA     $62
                CLC
                ADC     #$10
                STA     $62
                BCC     @LAFE1
                INC     $63
@LAFE1:         RTS

LAFE2:          LDA     #$00
                STA     $54
LAFE6:          LDA     RleExpandIndex
                ASL     A
                TAY
                LDA     #$00
                STA     $62
                LDA     #$05
                STA     $63
                LDA     #$FF
                STA     $55
@LAFF6:         INC     $55
                JSR     LB6AD
                JSR     LB04F
                INC     $52
                JSR     WaitNmiFinish
                JSR     LAFD6
                LDA     $55
                CMP     #$0B
                BCC     @LAFF6
                JSR     LB04F
                INC     $53
                JSR     WaitNmiFinish
LB014:          LDA     RleExpandIndex
                ASL     A
                TAY
                LDA     LA077,y
                STA     $30
                LDA     LA078,y
                STA     $31
                LDY     #$1F
@LB024:         LDA     ($30),y
                STA     PaletteBuffer,y
                DEY
                BPL     @LB024
                RTS

LB02D:          LDA     #$10
                STA     $54
                JMP     LAFE6

LB034:          LDA     #$BE
                STA     OamBuffer
                LDA     #$FF
                STA     OamBuffer+1
                LDA     #$20
                STA     OamBuffer+2
                LDA     #$00
                STA     OamBuffer+3
                RTS

                JSR     SetOamDmaRequest
                JMP     LB034

LB04F:          LDA     PpuCtrlBuffer_Bit0_BaseNametable
                PHA
                LDA     $51
                BEQ     @LB096
                JSR     LB034
                LDA     #$00
                STA     PpuCtrlBuffer_Bit0_BaseNametable
                JSR     ReadPpuControl
                TAY
                LDA     #$00
                STA     PPUSTATUS
@LB066:         LDA     $56
                BNE     @LB096
                LDA     PPUSTATUS
                AND     #$40
                BEQ     @LB066
                LDA     $03FE
                BNE     @LB096
                LDA     #$33
                STA     LFFF7
                STY     PPUCTRL
                LDA     #$00
                STA     PPUSCROLL
                STA     PPUSCROLL
                JSR     PlaySubSequence
                LDA     $0473
                BNE     @LB091
                JSR     LDE68
@LB091:         LDY     #$00
                JSR     LEA45
@LB096:         PLA
                STA     PpuCtrlBuffer_Bit0_BaseNametable
                LDA     #$00
                STA     $51
                RTS

                .byte   $04
                .byte   $05
                .res    6,$03
                .byte   $04
                .byte   $05
                .byte   $1F
                .byte   $03
                .byte   $04
                .byte   $05
                .byte   $20
                .byte   $03
                .byte   $04
                .byte   $05
                .byte   $21
                .byte   $03
                .byte   $04
                .byte   $05
                .byte   $22
                .byte   $03
                .byte   $04
                .byte   $05
                .byte   $23
                .byte   $03
                .byte   $04
                .byte   $05
                .byte   $16
                .byte   $03
                .byte   $04
                .byte   $05
                .byte   $17
                .byte   $03
                .byte   $03
                .byte   $00
                .byte   $03
                .byte   $00
                .byte   $04
                .byte   $05
                .byte   $0A
                .byte   $03
                .byte   $04
                .byte   $05
                .byte   $1E
                .byte   $03
                .byte   $13
                .byte   $14
                .byte   $03
                .byte   $03
                .byte   $14
                .byte   $14
                .byte   $03
                .byte   $03
                .byte   $14
                .byte   $15
                .byte   $03
                .byte   $03
                .byte   $03
                .byte   $09
                .byte   $03
                .byte   $03
                .byte   $00
                .byte   $00
                .byte   $0A
                .byte   $00
                .byte   $0B
                .byte   $00
                .byte   $02
                .byte   $03
                .byte   $04
                .byte   $05
                .byte   $06
                .byte   $00
                .byte   $00
                .byte   $07
                .byte   $08
                .byte   $00
                .byte   $01
                .byte   $0C
                .byte   $0D
                .byte   $0D
                .byte   $0E
                .byte   $01
                .res    5,$09
                .byte   $01
                .byte   $01
                .byte   $09
                .byte   $09
                .byte   $01
                .res    16,$00

LB10E:          LDA     $55
                LSR     A
                BCS     @LB11D
                LDA     $8A
                ADC     #$08
                STA     $8A
                BCC     @LB11D
                INC     $8B
@LB11D:         RTS

LB11E:          LDA     #$8C
                STA     $8A
                LDA     #$00
                STA     $8B
                RTS

LB127:          JSR     LB6AD
                JSR     LB04F
                INC     $52
                JSR     WaitNmiFinish
                JSR     LAFD6
                JSR     LB10E
                INC     $55
                RTS

LB13B:          JSR     WaitNmiFinish
                LDA     #$B0
                STA     $65
                LDA     #$9E
                STA     $64
                LDA     #$B0
                STA     $63
                LDA     #$DE
                STA     $62
                LDA     #$00
                STA     $54
                LDA     #$0C
                STA     $55
                JSR     LB127
                JSR     LB127
                JSR     LB127
                JSR     LB04F
                JSR     WaitNmiFinish
                JMP     LB11E

LB168:          .byte   $BC
                .byte   $7E
                .byte   $00
                .byte   $68
                .byte   $BC
                .byte   $80
                .byte   $01
                .byte   $78
                .byte   $BC
                .byte   $82
                .byte   $01
                .byte   $88
                .byte   $BC
                .byte   $84
                .byte   $02
                .byte   $98
                .byte   $BC
                .byte   $86
                .byte   $01
                .byte   $A8
                .byte   $BC
                .byte   $88
                .byte   $02
                .byte   $D8
                .byte   $BC
                .byte   $8A
                .byte   $03
                .byte   $E8
                .byte   $BC
                .byte   $FC
                .byte   $01
                .byte   $00
LB188:          .byte   $CC
                .byte   $90
                .byte   $01
                .byte   $10
                .byte   $CC
                .byte   $92
                .byte   $01
                .byte   $18
                .byte   $CC
                .byte   $92
                .byte   $01
                .byte   $20
                .byte   $CC
                .byte   $92
                .byte   $01
                .byte   $28
                .byte   $CC
                .byte   $92
                .byte   $01
                .byte   $30
                .byte   $CC
                .byte   $92
                .byte   $01
                .byte   $38
                .byte   $CC
                .byte   $92
                .byte   $01
                .byte   $40
                .byte   $CC
                .byte   $94
                .byte   $01
                .byte   $48

LB1A8:          LDA     LE708
                BEQ     @LB1D8
                LDY     #$1C
@LB1AF:         LDA     #$E0
                STA     OamBuffer+128,y
                LDA     #$FC
                STA     OamBuffer+129,y
                LDA     #$00
                STA     OamBuffer+130,y
                STA     OamBuffer+131,y
                DEY
                DEY
                DEY
                DEY
                BPL     @LB1AF
                LDY     #$1F
@LB1C9:         LDA     LB168,y
                STA     OamBuffer+224,y
                LDA     LB188,y
                STA     OamBuffer+192,y
                DEY
                BPL     @LB1C9
@LB1D8:         RTS

VmHelper_LoadFieldTime_Low:
                LDA     FieldTime
                JMP     VmOp_PushByte

VmHelper_WriteFieldTime_Low:
                JSR     VmOp_PopRegister
                STY     FieldTime
                RTS

LB1E6:          LDA     PartyLifes-1
                JMP     VmOp_PushByte

LB1EC:          JSR     VmOp_PopRegister
                STY     PartyLifes-1
                RTS

                LDA     #$68
                JMP     VmOp_PushByte

LB1F8:          LDA     #$02
                LDY     #$E0
                JSR     VmOp_PushRegister
                JSR     LB1E6
                JSR     VmOp_Asl_02
                JSR     VmOp_Add_AB
                JSR     LE708
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0040
                JMP     VmOp_Sub_BA

LB214:          JSR     VmHelper_PushConst_0020
                JMP     VmOp_Or

LB21A:          JSR     LE708
                JSR     VmOp_CheckNotZero
                BCC     @LB225
                JMP     VmHelper_PushConst_008C

@LB225:         JMP     VmHelper_PushConst_0019

LB228:          JSR     LB21A
                JSR     LB1F8
                JSR     VmOp_Increment
                JSR     VmOp_WriteByte
                JSR     VmHelper_PushConst_0001
                JSR     LB214
                JSR     LB1F8
                JSR     VmOp_AddConst_02
                JMP     VmOp_WriteByte

LB243:          JSR     VmOp_PopRegister
                TYA
                LDY     PartyLifes-1
                STA     PartyLifes,y
                RTS

LB24E:          LDY     PartyLifes-1
                LDA     PartyLifes,y
                AND     #$0F
                JMP     VmOp_PushByte

LB259:          JSR     VmHelper_PushConst_000F
                JSR     VmOp_And
                JSR     VmHelper_PushConst_00E0
                JSR     VmOp_Swap
                JSR     VmOp_Sub_BA
                JSR     LB1F8
                JMP     VmOp_WriteByte

                .byte   $68
                .byte   $78
                .byte   $88
                .byte   $98
                .byte   $A8
                .byte   $D8
                .byte   $E8

LB275:          LDA     #$B2
                LDY     #$6E
                JMP     VmOp_PushRegister

LB27C:          JSR     LB1E6
                JSR     LB275
                JSR     VmOp_Add_AB
                JSR     VmOp_ReadByte
                JSR     LB1F8
                JSR     VmOp_AddConst_03
                JMP     VmOp_WriteByte

LB291:          JSR     LB1EC
                JSR     LB24E
                JSR     LB259
                JSR     LB228
                JMP     LB27C

VmHelper_LoadFieldTime_High:
                LDA     FieldTime+1
                JMP     VmOp_PushByte

VmHelper_WriteFieldTime_High:
                JSR     VmOp_PopRegister
                STY     FieldTime+1
                RTS

LB2AD:          JSR     LB1EC
                JSR     LB24E
                JSR     VmOp_ExitFalse
                JSR     LB24E
                JSR     VmOp_Decrement
                JMP     LB243

LB2BF:          JSR     VmHelper_LoadFieldTime_Low
                JSR     VmOp_ExitTrue
                JSR     VmHelper_LoadFieldTime_High
                JSR     VmHelper_PushConst_0010
                JSR     VmOp_Compare_Equal
                JSR     VmHelper_LoadFieldTime_High
                JSR     VmHelper_PushConst_0030
                JSR     VmOp_Compare_Equal
                JSR     VmOp_Or
                JSR     VmOp_ExitFalse
                JSR     LB1E6
                JSR     VmHelper_PushConst_0005
                JSR     LB2AD
                JSR     VmHelper_PushConst_0006
                JSR     LB2AD
                JMP     LB1EC

LB2EF:          JSR     LB1E6
                JSR     VmHelper_PushConst_0005
                JSR     LB1EC
                JSR     LB24E
                JSR     VmHelper_PushConst_0006
                JSR     LB1EC
                JSR     LB24E
                JSR     VmOp_Or
                JSR     VmOp_Swap
                JMP     LB1EC

LB30D:          JSR     LB24E
                JSR     VmOp_ExitFalse
                JSR     LB24E
                JSR     VmHelper_PushConst_000F
                JSR     VmOp_Compare_Equal
                JSR     VmOp_ExitTrue
                JSR     LB24E
                JSR     VmOp_Increment
                JMP     LB243

LB328:          JSR     LB1EC
                JMP     LB30D

LB32E:          JSR     VmHelper_PushConst_0005
                JSR     LB1EC
                JSR     LB24E
                JSR     VmOp_CheckNotZero
                BCC     @LB348
                JSR     VmHelper_PushConst_0002
                JSR     LB328
                JSR     VmHelper_PushConst_0003
                JMP     LB328

@LB348:         JSR     VmHelper_PushConst_0002
                JSR     LB2AD
                JSR     VmHelper_PushConst_0003
                JMP     LB2AD

LB354:          JSR     VmHelper_PushConst_0006
                JSR     LB1EC
                JSR     LB24E
                JSR     VmOp_CheckNotZero
                BCC     @LB36E
                JSR     VmHelper_PushConst_0000
                JSR     LB328
                JSR     VmHelper_PushConst_0004
                JMP     LB328

@LB36E:         JSR     VmHelper_PushConst_0000
                JSR     LB2AD
                JSR     VmHelper_PushConst_0004
                JMP     LB2AD

LB37A:          JSR     LB2EF
                JSR     VmOp_CheckNotZero
                BCC     @LB388
                JSR     VmHelper_PushConst_0001
                JMP     LB328

@LB388:         JSR     VmHelper_PushConst_0001
                JMP     LB2AD

LB38E:          JSR     VmHelper_LoadFieldTime_Low
                JSR     VmHelper_PushConst_001F
                JSR     VmOp_And
                JSR     VmOp_ExitTrue
                JSR     LB1E6
                JSR     LB37A
                JSR     LB32E
                JSR     LB354
                JMP     LB1EC

LB3A9:          JSR     LB1EC
                JSR     VmHelper_PushConst_000F
                JSR     LB24E
                JSR     L9601
@LB3B5:         JSR     VmSecond_CopySecondStack_Reload
                JSR     LB243
                JSR     LB04F
                JSR     WaitNmiRaised
                JSR     L9620
                BCC     @LB3B5
                RTS

LB3C7:          JSR     VmSecond_CopySecondStack_Reload
                JSR     VmHelper_PushConst_0004
                JSR     VmOp_Compare_Equal
                LDA     PartyIn_Chohakkai
                JSR     VmOp_PushByte
                JSR     VmHelper_PushConst_0000
                JSR     VmOp_Compare_Equal
                JMP     VmOp_And

LB3DF:          JSR     VmSecond_CopySecondStack_Reload
                JSR     VmHelper_PushConst_0003
                JSR     VmOp_Compare_Equal
                LDA     PartyIn_Sagojo
                JSR     VmOp_PushByte
                JSR     VmHelper_PushConst_0000
                JSR     VmOp_Compare_Equal
                JMP     VmOp_And

LB3F7:          JSR     LB3C7
                JSR     VmOp_ExitTrue
                JSR     LB3DF
                JSR     VmOp_ExitTrue
                JSR     VmSecond_CopySecondStack_Reload
                JMP     LB3A9

LB409:          JSR     VmHelper_PushConst_0006
                JSR     VmHelper_PushConst_0000
                JSR     L9601
@LB412:         JSR     LB3F7
                JSR     L9620
                BCC     @LB412
                RTS

LB41B:          LDA     $03FE
                BEQ     @LB425
                LDA     #$96
                JMP     VmOp_PushByte

@LB425:         LDA     #$25
                JMP     VmOp_PushByte

LB42A:          JSR     VmHelper_LoadFieldTime_High     ;FieldTime_High++
                JSR     VmOp_Increment
                LDA     #$3F
                JSR     VmOp_PushByte
                JSR     VmOp_And
                JSR     VmHelper_WriteFieldTime_High
                JMP     LB5FF

LB43E:          JSR     VmHelper_LoadFieldTime_High
                JSR     VmHelper_PushConst_0010
                JMP     VmOp_Add_AB

LB447:          JSR     VmHelper_PushConst_0007
                JSR     LB1EC
                JSR     VmHelper_PushConst_00D8
                JSR     LB1F8
                JSR     VmOp_WriteByte
                JSR     LB41B
                JSR     LB1F8
                JSR     VmOp_Increment
                JSR     VmOp_WriteByte
                JSR     VmHelper_PushConst_0001
                JSR     LB1F8
                JSR     VmOp_AddConst_02
                JSR     VmOp_WriteByte
                JSR     LB38E
                JSR     LB43E
                JSR     LB1F8
                JSR     VmOp_AddConst_03
                JSR     VmOp_WriteByte
                JSR     VmHelper_LoadFieldTime_Low      ;Increment field time
                JSR     VmOp_Increment                  ;FieldTime_Low++
                JSR     VmHelper_WriteFieldTime_Low
                JSR     VmHelper_LoadFieldTime_Low      ;carry high byte
                JSR     VmHelper_PushConst_0020
                JSR     VmOp_Compare_BGeatherThanOrEqual ;0x20 <= FieldTime_Low
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0000
                JSR     VmHelper_WriteFieldTime_Low
                JMP     LB42A

                .byte   $07
                .byte   $17
                .byte   "'7'",$07
                .byte   $0F
                .byte   $0F
                .byte   $0C
                .byte   $1C
                .byte   $2C
                .byte   $3C
                .byte   $2C
                .byte   $0C
                .byte   $0F
                .byte   $0F

LB4AB:          LDA     #$B4
                LDY     #$9B
                JSR     VmOp_PushRegister
                JSR     LE708
                JSR     VmOp_ExitTrue
                JSR     VmHelper_PushConst_0008
                JMP     VmOp_Add_AB

LB4BE:          LDY     RleExpandIndex
                LDA     LA048,y
                JMP     VmOp_PushByte

LB4C6:          LDA     $0472
                JMP     VmOp_PushByte

LB4CC:          JSR     VmOp_PopRegister
                STY     $0472
                RTS

                .byte   $0F
                .byte   $06
                .byte   $16
                .byte   $0F
                .byte   $06
                .byte   $16
                .byte   $0F
                .byte   $06

LB4DB:          JSR     @LB500
                JSR     VmHelper_LoadFieldTime_Low
                JSR     VmHelper_PushConst_0007
                JSR     VmOp_And
                JSR     VmOp_Duplicate
                LDA     #$B4
                LDY     #$D3
                JSR     VmOp_PushRegister
                JSR     VmOp_ReadOffsetByte
                JSR     VmOp_Swap
                JSR     VmOp_ExitTrue
                JSR     VmHelper_PushConst_0000
                JMP     LB4CC

@LB500:         JSR     VmHelper_LoadFieldTime_Low
                JSR     VmHelper_PushConst_0003
                JSR     VmOp_And
                JSR     VmOp_ExitTrue
                JMP     SongRequest_13

LB50F:          JSR     LB4C6
                JSR     VmOp_ExitFalse
                JSR     VmOp_PopDiscard
                JMP     LB4DB

LB51B:          JSR     VmHelper_LoadFieldTime_High
                JSR     VmOp_Lsr_03
                JSR     LB4AB
                JSR     VmOp_Add_AB
                JSR     VmOp_ReadByte
                JSR     LB50F
                JSR     LB4BE
                JSR     VmOp_ExitFalse
                JSR     VmOp_PopDiscard
                JMP     VmHelper_PushConst_000F

LB539:          LDA     #$03
                LDY     #$00
                JMP     VmOp_PushRegister

LB540:          JSR     VmHelper_CreateStackFrame_06
                JSR     LB51B
                LDA     $03FE
                BEQ     @LB57C
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     LB539
                JSR     VmHelper_PushConst_0010
                JSR     VmOp_Add_AB
                JSR     VmOp_Increment
                JSR     LB539
                LDA     $03FE
                BEQ     @LB565
                JSR     VmOp_Increment
@LB565:         JSR     L9601
@LB568:         JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmSecond_CopySecondStack_Reload
                JSR     VmOp_WriteByte
                JSR     VmHelper_PushConst_0004
                JSR     L9645
                BCC     @LB568
                JMP     VmOp_DestroyStackFrame

@LB57C:         JSR     VmOp_PopRegister
                TYA
                LDY     #$00
@LB582:         STA     PaletteBuffer,y
                INY
                INY
                INY
                INY
                CPY     #$20
                BCC     @LB582
                JMP     VmOp_DestroyStackFrame

LB590:          JSR     VmHelper_PushConst_0000
                JSR     LB291
                JSR     LB2BF
                JSR     VmHelper_PushConst_0001
                JSR     LB291
                JSR     LB2BF
                JSR     VmHelper_PushConst_0002
                JSR     LB291
                JSR     LB2BF
                JSR     VmHelper_PushConst_0003
                JSR     LB291
                JSR     LB2BF
                JSR     VmHelper_PushConst_0004
                JSR     LB291
                JMP     LB2BF

LB5BD:          JSR     VmHelper_PushConst_0005
                JSR     LB291
                JSR     VmHelper_PushConst_0006
                JSR     LB291
                JSR     LB447
                JMP     LB540

LB5CF:          JSR     VmHelper_LoadFieldTime_High
                JSR     VmHelper_PushConst_0030
                JSR     VmOp_Compare_Equal
                JSR     VmOp_ExitFalse
                LDY     #$20
@LB5DD:         LDA     L838F,y
                STA     $00DB,y
                DEY
                BPL     @LB5DD
                RTS

LB5E7:          JSR     VmHelper_LoadFieldTime_High
                JSR     VmHelper_PushConst_0010
                JSR     VmOp_Compare_Equal
                JSR     VmOp_ExitFalse
LB5F3:          LDY     #$20
@LB5F5:         LDA     T8372+2,y
                STA     $00DB,y
                DEY
                BPL     @LB5F5
                RTS

LB5FF:          JSR     LB5CF
                JMP     LB5E7

LB605:          JSR     VmSecond_CopySecondStack_Reload
                JMP     VmOp_Add_AB

LB60B:          JSR     VmSecond_CopySecondStack_Reload
                JSR     VmOp_Asl_01
                JMP     VmOp_Add_AB

LB614:          INC     $52
                RTS

SetFieldChrBank:
                LDA     #$30                            ;ASCII...
                STA     ChrBankRequest
                RTS

VmHelper_PushFieldPageY:
                LDA     FieldPageY
                JMP     VmOp_PushByte

VmHelper_PopFieldPageY:
                JSR     VmOp_PopRegister
                STY     FieldPageY
                RTS

VmHelper_PushFieldPageX:
                LDA     FieldPageX
                JMP     VmOp_PushByte

VmHelper_PopFieldPageX:
                JSR     VmOp_PopRegister
                STY     FieldPageX
                RTS

VmHelper_PushScreenX:
                LDA     ScreenX+1
                LDY     ScreenX
                JMP     VmOp_PushRegister

VmHelper_PopScreenX:
                JSR     VmOp_PopRegister
                STY     ScreenX
                AND     #$01
                STA     ScreenX+1
                RTS

VmHelper_PushFieldScreenY:
                LDA     ScreenY+1
                LDY     ScreenY
                JMP     VmOp_PushRegister

VmHelper_PopScreenY:
                JSR     VmOp_PopRegister
                STA     ScreenY+1
                STY     ScreenY
                RTS

                LDA     $CD
                JMP     VmOp_PushByte

VmHelper_PushConst_999B:
                LDA     #$99
                LDY     #$9B
                JMP     VmOp_PushRegister

VmHelper_PushConst_8000:
                LDA     #$80
                LDY     #$00
                JMP     VmOp_PushRegister

                JSR     LB04F
                JSR     SetFieldChrBank
                JSR     WaitNmiFinish
                RTS

PpuControl_EnableDirection:
                LDA     #$01
                STA     PpuCtrlBuffer_Bit2_AddrDirection
                JMP     SetPpuControl

PpuControl_DisableDirection:
                LDA     #$00
                STA     PpuCtrlBuffer_Bit2_AddrDirection
                JMP     SetPpuControl

VmHelper_PushConst_0401:
                LDA     #$04
                LDY     #$01
                JMP     VmOp_PushRegister

VmHelper_PushConst_0421:
                LDA     #$04
                LDY     #$21
                JMP     VmOp_PushRegister

LB68B:          LDA     $63
                LDY     $62
                JMP     VmOp_PushRegister

                JSR     VmOp_PopRegister
                STA     $63
                STY     $62
                RTS

LB69A:          LDA     $65
                LDY     $64
                JMP     VmOp_PushRegister

LB6A1:          JSR     VmOp_ReadByte
                JSR     VmOp_Asl_02
                JSR     LB69A
                JMP     VmOp_Add_AB

LB6AD:          JSR     VmHelper_PushConst_000F
                JSR     VmHelper_PushConst_0000
                JSR     L9601
@LB6B6:         JSR     LB68B
                JSR     LB605
                JSR     LB6A1
                JSR     VmOp_Duplicate
                JSR     VmOp_ReadAddressWord
                JSR     VmHelper_PushConst_0401
                JSR     LB60B
                JSR     VmOp_WriteWord
                JSR     VmOp_AddConst_02
                JSR     VmOp_ReadAddressWord
                JSR     VmHelper_PushConst_0421
                JSR     LB60B
                JSR     VmOp_WriteWord
                JSR     L9620
                BCC     @LB6B6
                JMP     PpuControl_DisableDirection

LB6E5:          LDA     #$80
                LDY     #$00
                JMP     VmOp_PushRegister

LB6EC:          LDA     $54
                JMP     VmOp_PushByte

LB6F1:          JSR     VmOp_PopRegister
                STY     $54
                RTS

                LDA     $55
                JMP     VmOp_PushByte

LB6FC:          JSR     VmOp_PopRegister
                STY     $55
                RTS

                JSR     VmHelper_PushFieldPageY
                JSR     VmOp_Asl_06
                JSR     VmHelper_PushFieldPageX
                JSR     VmOp_Asl_01
                JSR     VmOp_Add_AB
                JSR     VmHelper_PushConst_999B
                JSR     VmOp_Add_AB
                JMP     VmOp_ReadAddressWord

HideNormalSprites:
                LDY     #$04
                LDA     #$F0
@ClearLoop:     STA     OamBuffer,y                     ;Set #$F0 to OAM $04-$FF
                INY
                BNE     @ClearLoop
                RTS

SongRequest_01: JSR     EnableApuChannel
                LDA     #$01
                BNE     SongRequest

SongRequest_03: JSR     EnableApuChannel
                LDA     #$03
                BNE     SongRequest

SongRequest_04: JSR     EnableApuChannel
                LDA     #$04
                BNE     SongRequest

SongRequest_05: JSR     EnableApuChannel
                LDA     #$05
                BNE     SongRequest

SongRequest_06: LDA     #$06
                BNE     SongRequest

SongRequest_09: LDA     #$09
                BNE     SongRequest

SongRequest_0A: LDA     #$0A
                BNE     SongRequest

SongRequest_0E: LDA     #$0E
                BNE     SongRequest

SongRequest_0F: LDA     #$0F
                BNE     SongRequest

SongRequest_11: LDA     #$11
                BNE     SongRequest

SongRequest_12: LDA     #$12
                BNE     SongRequest

SongRequest_13: LDA     #$13
                BNE     SongRequest

SongRequest_15: LDA     #$15
                BNE     SongRequest

SongRequest_16: LDA     #$16
                BNE     SongRequest

SongRequest_00: LDA     #$00
SongRequest:    TAY
                TXA
                PHA
                TYA
                JSR     JumpSongRequest
                PLA
                TAX
                RTS

InitializeSounddriver:
                TXA
                PHA
                JSR     JumpInitializeSounddriver
                PLA
                TAX
                RTS

PlaySubSequence:
                TXA
                PHA
                JSR     JumpPlaySubSequence
                PLA
                TAX
                RTS

DisableApuChannel:
                TXA
                PHA
                JSR     JumpDisableApuChannel
                PLA
                TAX
                RTS

EnableApuChannel:
                TXA
                PHA
                JSR     JumpEnableApuChannel
                PLA
                TAX
Return:         RTS

CheckPause:     LDA     PadBuffer_Trigger_Select        ;Select
                BEQ     Return
                JSR     DisableApuChannel               ;Pausing
@CheckLoop:     JSR     VmProc_ProcessFieldFrame        ;Wait next frame
                JSR     ReadJoypad
                LDA     PadBuffer_Trigger_Select
                BEQ     @CheckLoop
                JMP     EnableApuChannel

VmProc_ProcessFieldFrame:
                JSR     SetOamDmaRequest
                JSR     WaitNextFrame
                JSR     WaitProcessStateIncrement
                JMP     SetFieldChrBank

VmProc_ProcessFieldFrameWithMove:
                JSR     VmProc_MoveScreen
                JMP     VmProc_ProcessFieldFrame

Wait2Frames:    JSR     WaitNextFrame_WasteCycle        ;1=NoOperation, 2=Move (even frames need to be moved)
LB7C0:          JSR     VmProc_MoveScreen
WaitNextFrame_WasteCycle:
                TXA                                     ;Waste 16730 cycles, after jump to wait frame
                PHA
                LDX     #$0D
@OuterLoop:     LDY     #$00
@InnerLoop:     DEY
                BNE     @InnerLoop
                DEX
                BNE     @OuterLoop
                PLA
                TAX
                JMP     VmProc_ProcessFieldFrame

Field_MainLoop: JSR     IsAnnihilation
                JSR     VmOp_ExitTrue                   ;Exit the loop when the party is dead
                JSR     EnableApuChannel
                JSR     VmProc_SetTargetPointScreenX
                JSR     VmProc_SetTargetPointScreenY
                JSR     ReadJoypad
                JSR     VmProc_CheckFieldTile
                JSR     CheckPause
                JSR     VmProc_ProcessFieldFrame        ;[1F] Wait frame
                JSR     SetFieldPartySprite
                JSR     VmProc_ProcessFieldFrame        ;[00] Wait frame
                LDA     #$00
                STA     $0484                           ;Message screen flag?
                JSR     VmProc_MoveFieldLeft
                JSR     VmProc_ProcessFieldFrame        ;[01] Wait frame
                JSR     VmProc_CheckDstField_Up
                JSR     VmProc_CheckDstField_Down
                JSR     VmProc_ProcessFieldFrameWithMove ;[02] Wait frame
                JSR     VmProc_SetDstField_Right
                JSR     VmProc_SetDstField_Left
                JSR     VmProc_ProcessFieldFrame        ;[03] Wait frame
                JSR     LBF2F
                JSR     LBF71
                JSR     VmProc_ProcessFieldFrameWithMove ;[04] Wait frame
                JSR     WaitNextFrame_WasteCycle        ;[05] Wait frame
                JSR     LC22F
                JSR     VmProc_ProcessFieldFrameWithMove ;[06] Wait frame
                JSR     LC238
                JSR     VmProc_ProcessFieldFrame        ;[07] Wait frame
                JSR     LC241
                JSR     VmProc_ProcessFieldFrameWithMove ;[08] Wait frame
                JSR     LBF83
                JSR     LBFA1
                JSR     VmProc_ProcessFieldFrame        ;[09] Wait frame
                JSR     LC10E
                JSR     LC15C
                JSR     VmProc_ProcessFieldFrameWithMove ;[0A] Wait frame
                JSR     LC129
                JSR     LC168
                JSR     VmProc_ProcessFieldFrame        ;[0B] Wait frame
                JSR     LB7C0                           ;[0C] Wait frame
                JSR     LC2D3
                JSR     VmProc_ProcessFieldFrame        ;[0D] Wait frame
                JSR     LC2D9
                JSR     VmProc_ProcessFieldFrameWithMove ;[0E] Wait frame
                JSR     LC2E0
                JSR     VmProc_ProcessFieldFrame        ;[0F] Wait frame
                JSR     LC2E7
                JSR     VmProc_ProcessFieldFrameWithMove ;[10] Wait frame
                JSR     LC2EE
                JSR     VmProc_ProcessFieldFrame        ;[11] Wait frame
                JSR     LC2FD
                JSR     VmProc_ProcessFieldFrameWithMove ;[12] Wait frame
                INC     $FE
                JSR     VmProc_ProcessFieldFrame        ;[13] Wait frame
                INC     $FE
                JSR     VmProc_ProcessFieldFrameWithMove ;[14] Wait frame
                JSR     Wait2Frames                     ;[15, 16] Wait frame
                JSR     Wait2Frames                     ;[17, 18] Wait frame
                JSR     Wait2Frames                     ;[19, 1A] Wait frame
                JSR     WaitNextFrame_WasteCycle        ;[1B] Wait frame
                JSR     LBF0B
                JSR     VmProc_ProcessFieldFrameWithMove ;[1C] Wait frame
                JSR     LB9B9
                JSR     LB590
                JSR     LBC22
                JSR     VmProc_ProcessFieldFrame        ;[1D] Wait frame
                JSR     LB5BD
                JSR     LB1A8
                JSR     SetOamDmaRequest
                JSR     VmProc_ProcessFieldFrameWithMove ;[1E] Wait frame
                JMP     Field_MainLoop

VmHelper_PushPositions:
                JSR     VmHelper_PushFieldPageX
                JSR     VmHelper_PushFieldPageY
                JSR     VmHelper_PushFieldChipX
                JMP     VmHelper_PushFieldChipY

VmHelper_PopPositions:
                JSR     VmHelper_PopFieldChipY
                JSR     VmHelper_PopFieldChipX
                JSR     VmHelper_PopFieldPageY
                JMP     VmHelper_PopFieldPageX

VmProc_ModScreenTileYOffset:
                JSR     VmOp_Duplicate                  ;mod 15
                JSR     VmHelper_PushConst_000E
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_000F
                JMP     VmOp_Sub_BA

VmProc_ModScreenTileXOffset:
                JSR     VmOp_Duplicate                  ;mod 16
                JSR     VmHelper_PushConst_000F
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0010
                JMP     VmOp_Sub_BA

; Check the destination tile and invalidate the controller input
; if it is a wall attribute.
; Wall : 0, 1, 6, 7, 8, 9, 10, 11, 12, 16
; Argument:
;   Stack[0] = Y offset (base:6)
;   Stack[1] = X offset (base:8)
VmProc_CheckFieldDestinationTile:
                JSR     VmHelper_CreateStackFrame_06    ;prologue
                JSR     VmProc_GetMemoryOffsetY_ChipY
                JSR     VmOp_Add_AB                     ;(Y + (6 + yArg)) % 15
                JSR     VmProc_ModScreenTileYOffset
                JSR     VmOp_Asl_04
                JSR     VmOp_Swap                       ;save Y, calculate X
                JSR     VmHelper_PushFieldChipX
                JSR     VmOp_Add_AB                     ;(X + (8 + xArg)) % 16
                JSR     VmProc_ModScreenTileXOffset
                JSR     VmOp_Add_AB                     ;(Y << 4) + X
                JSR     VmHelper_PushConst_0500         ;$0500 = Map data (reg Y = 0)
                JSR     VmOp_ReadOffsetByte             ;read map tile
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmHelper_PushConst_0000
                JSR     VmOp_Compare_Equal              ;if(  (tile ==  0) // sea
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmHelper_PushConst_0001
                JSR     VmOp_Compare_Equal              ;  || (tile ==  1) // bushes
                JSR     VmOp_Or
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmHelper_PushConst_0010         ;  || (tile == 16) // door of time
                JSR     VmOp_Compare_Equal
                JSR     VmOp_Or
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmHelper_PushConst_0006
                JSR     VmOp_Compare_BGeatherThanOrEqual ;  || ((6 <= tile) && (tile <= 12))
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmHelper_PushConst_000C
                JSR     VmOp_Compare_AGeatherThanOrEqual
                JSR     VmOp_And
                JSR     VmOp_Or
                JSR     VmOp_CheckNotZero               ;){
                BCC     @Accept                         ;  ClearJoypad();
                JSR     ClearJoypad                     ;}
@Accept:        JMP     VmOp_DestroyStackFrame          ;epilogue

VmProc_CheckFieldTile_Up:
                JSR     VmHelper_PushPad_Up
                JSR     VmOp_ExitFalse                  ;not press : Exit
                JSR     VmHelper_PushConst_0008         ;8+0
                JSR     VmHelper_PushConst_0005         ;6-1
                JMP     VmProc_CheckFieldDestinationTile

VmProc_CheckFieldTile_Down:
                JSR     VmHelper_PushPad_Down
                JSR     VmOp_ExitFalse                  ;not press : Exit
                JSR     VmHelper_PushConst_0008         ;8+0
                JSR     VmHelper_PushConst_0007         ;6+1
                JMP     VmProc_CheckFieldDestinationTile

VmProc_CheckFieldTile_Right:
                JSR     VmHelper_PushPad_Right
                JSR     VmOp_ExitFalse                  ;not press : Exit
                JSR     VmHelper_PushConst_0009         ;8+1
                JSR     VmHelper_PushConst_0006         ;6+0
                JMP     VmProc_CheckFieldDestinationTile

VmProc_CheckFieldTile_Left:
                JSR     VmHelper_PushPad_Left
                JSR     VmOp_ExitFalse                  ;not press : Exit
                JSR     VmHelper_PushConst_0007         ;8-1
                JSR     VmHelper_PushConst_0006         ;6+0
                JMP     VmProc_CheckFieldDestinationTile

VmProc_CheckFieldTile:
                JSR     VmProc_CheckFieldTile_Up
                JSR     VmProc_CheckFieldTile_Down
                JSR     VmProc_CheckFieldTile_Right
                JMP     VmProc_CheckFieldTile_Left

PushMapEventProcessAddressList:
                LDA     #>MapEventProcessAddressList
                LDY     #<MapEventProcessAddressList
                JMP     VmOp_PushRegister

LB99F:          LDA     $03FC
                JMP     VmOp_PushByte

LB9A5:          JSR     VmOp_PopRegister
                STY     $03FC
                RTS

LB9AC:          LDA     $03FD
                JMP     VmOp_PushByte

LB9B2:          JSR     VmOp_PopRegister
                STY     $03FD
                RTS

LB9B9:          JSR     VmHelper_PushFieldPageX         ;Check event table out of range
                JSR     VmHelper_PushConst_001F
                JSR     VmOp_Compare_AGeatherThanOrEqual ;if(0x1F >= FieldPageX) return
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushFieldPageY
                JSR     VmHelper_PushConst_0018
                JSR     VmOp_Compare_AGeatherThanOrEqual ;if(0x18 >= FieldPageY) return
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushFieldPageX
                JSR     LB99F
                JSR     VmOp_Compare_NotEqual
                JSR     VmHelper_PushFieldPageY
                JSR     LB9AC
                JSR     VmOp_Compare_NotEqual
                JSR     VmOp_Or
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushFieldPageX
                JSR     LB9A5
                JSR     VmHelper_PushFieldPageY
                JSR     LB9B2
                JSR     VmHelper_PushFieldPageY
                JSR     VmOp_Asl_06
                JSR     VmHelper_PushFieldPageX
                JSR     VmOp_Asl_01
                JSR     VmOp_Add_AB
                JSR     PushMapEventProcessAddressList
                JSR     VmOp_Add_AB
                JSR     VmOp_ReadAddressWord
                JMP     VmOp_IndirectJump

VmHelper_PushProcessStateCounter:
                LDA     ProcessStateCounter
                JMP     VmOp_PushByte

WaitProcessStateIncrement:
                LDA     ProcessStateCounter
                CMP     ProcessedStateCounter
                BNE     @NextState
                JSR     WaitNextFrame                   ;Same state -> Lag frame
                JMP     WaitProcessStateIncrement       ;Wait until incremented by NMI

@NextState:     STA     ProcessedStateCounter           ;Processed
                RTS

WaitNmiRaised:  LDA     $3E
                CMP     $40
                BEQ     WaitNmiRaised
                STA     $40
                RTS

SetZeroSprite:  LDA     #$BC                            ;[0] Y = 188
                STA     OamBuffer
                LDA     #$03                            ;[1] Tile = #$03
                STA     OamBuffer+1
                LDA     #$B8                            ;[3] X = 184
                STA     OamBuffer+3
                RTS

LBA3D:          JSR     SetZeroSprite
                JSR     SetOamDmaRequest
                JSR     LD2BC
                LDA     #$01
                STA     $0484
                JSR     LB5F3
                JSR     VmHelper_PopFieldPageX
                JSR     VmHelper_PopFieldPageY
                JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PopFieldChipX
                JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PopFieldChipY
                JSR     LB409
                JSR     LE425
                JSR     LE437
                LDA     #$0F
                STA     $03FE
                JSR     LE7D1
                JSR     Field_MainLoop
                JSR     DisableApuChannel
                JSR     LD2FC
                JMP     EnableApuChannel

@LBA7D:         LDA     #$00
                LDY     #$02
@LBA81:         STA     $0401,y
                STA     $0421,y
                INY
                CPY     #$1E
                BCC     @LBA81
                RTS

@LBA8D:         JSR     @LBA7D
                JMP     LC309

                LDA     $04DC
                LSR     A
                BCC     @LBAA1
                JSR     @LBA8D
                LDA     #$00
                STA     $54
                RTS

@LBAA1:         JSR     @LBA8D
                LDA     #$10
                STA     $54
                RTS

VmProc_IncrementFieldPageY:
                JSR     VmHelper_PushFieldPageY
                JSR     VmOp_Increment
                JMP     VmHelper_PopFieldPageY

VmProc_IncrementFieldPageX:
                JSR     VmHelper_PushFieldPageX
                JSR     VmOp_Increment
                JMP     VmHelper_PopFieldPageX

ClearJoypad:    LDY     #$07
                LDA     #$00
@Loop:          STA     PadBuffer_Now,y
                DEY
                BPL     @Loop
                RTS

LBAC6:          JSR     LD5C4
                JSR     VmOp_ExitFalse
                JSR     ClearJoypad
                LDA     #$01
                STA     PadBuffer_Now_Up
Return1:        RTS

LBAD5:          JSR     VmHelper_PushPositions
                JSR     VmProc_IncrementFieldPageY
                JSR     VmProc_SetDstField_Down
                LDA     #$1F
                STA     ProcessStateCounter
                STA     ProcessedStateCounter
                JSR     LBAC6
                JSR     VmHelper_PushConst_000C
                JSR     VmHelper_PushConst_0000
                JSR     L9601
@LBAF0:         JSR     WaitNmiRaised
                JSR     VmProc_CheckDstField_Up
                JSR     WaitNmiRaised
                JSR     LBF83
                JSR     WaitNmiRaised
                LDA     FieldPageX
                STA     $04DC
                JSR     LC0FF
                JSR     WaitNmiRaised
                JSR     LC11A
                JSR     WaitNmiRaised
                JSR     L9620
                BCC     @LBAF0
                JSR     VmHelper_PopPositions
                JSR     SetFieldChrBank
                JSR     LB5BD
                JSR     SetOamDmaRequest
                JMP     WaitNmiRaised

WaitNextFrame:  LDA     $04DA
                BNE     Return1
                LDA     $0484
                BNE     Return1
                TXA                                     ;Save software stack pointer
                PHA
                LDY     ScreenX+1
                LDA     ScreenX
                CMP     #$21
                BCC     @LBB40                          ;Screen X low <= #$20
                CMP     #$40
                BCS     @LBB40
                LDA     #$40                            ;#$21 < ScreenX < #$3F : ScreenX = #$40
                BNE     @LBB54

@LBB40:         AND     #$7F
                CMP     #$61
                BCC     @LBB52
                CMP     #$80
                BCS     @LBB52
                LDA     ScreenX                         ;#$61 < ScreenX < #$7F : ScreenX += #$60
                ADC     #$60
                BCC     @FlipScreen
                BCS     @LBB5F

@LBB52:         LDA     ScreenX
@LBB54:         CLC
                ADC     #$40
                BCS     @LBB5F
@FlipScreen:    PHA
                TYA
                EOR     #$01                            ;Flip screen
                TAY
                PLA
@LBB5F:         CMP     #$C0
                BCC     @LBB67
                LDA     #$00
                BEQ     @FlipScreen

@LBB67:         LSR     A
                LSR     A
                LSR     A
                STA     $0451
                TYA
                ASL     A
                ASL     A
                ORA     #$20
                LDY     $0451
@WaitSprite0Hit:
                BIT     PPUSTATUS
                BVC     @WaitSprite0Hit
                LDX     #$02                            ;Waste 11 cycles
@LoopWaste:     DEX
                BNE     @LoopWaste
                LDX     #$29
@StatusareaBlackLoop:
                STA     PPUADDR
                STY     PPUADDR
                STA     PPUADDR
                STY     PPUADDR
                STA     PPUADDR
                STY     PPUADDR
                STA     PPUADDR
                STY     PPUADDR
                STA     PPUADDR
                STY     PPUADDR
                STA     PPUADDR
                STY     PPUADDR
                STA     PPUADDR
                STY     PPUADDR
                STA     PPUADDR
                STY     PPUADDR
                STA     PPUADDR
                STY     PPUADDR
                STA     PPUADDR
                STY     PPUADDR
                STA     PPUADDR
                STY     PPUADDR
                STA     PPUADDR
                STY     PPUADDR
                STA     PPUADDR
                STY     PPUADDR
                NOP
                STA     $FC
                DEX
                BNE     @StatusareaBlackLoop
                PLA                                     ;Restore software stack pointer
                TAX
                JSR     PlaySubSequence
                JSR     SetZeroSprite
                JSR     SetOamDmaRequest
; Bug : 1/7 chance that NMI will not be executed
; BIT abs(4), BVS rel(3) => 7 cycles
; If the NMI is turned on in the 4th cycle of the BIT instruction,
; it will be skipped.
@WaitVBlankExit:
                BIT     PPUSTATUS
                BVS     @WaitVBlankExit                 ;Wait *Sprite 0hit*, loop during VBlank
                JMP     SetDisplayScreenPosition

; Argument:
;   Stack[0] = Warp destination page X
;   Stack[1] = Warp destination page Y
LBBE8:          JSR     DisableApuChannel
                JSR     SongRequest_15                  ;Stop noise channel
                JSR     VmHelper_PopFieldPageX          ;Set warp destination
                JSR     VmHelper_PopFieldPageY
                LDA     #$01
                STA     $04DA
                JSR     DisablePpuMask_BGDisable
                JSR     LBAD5
                JSR     LBAD5
                LDA     FieldPageX
                AND     #$01
                STA     ScreenX+1
                STA     PpuCtrlBuffer_Bit0_BaseNametable
                JSR     SetPpuControl
                JSR     SongRequest_16
                JSR     EnableApuChannel
                JSR     VmProc_SetTargetPointScreenX
                JSR     VmProc_SetTargetPointScreenY
                JSR     DisablePpuMask_BGEnable
                LDA     #$00
                STA     $04DA
                RTS

LBC22:          LDA     $033C
                BEQ     @LBC29
                DEC     FieldPageY
@LBC29:         LDA     $033D
                BEQ     @LBC30
                INC     FieldPageY
@LBC30:         LDA     $033E
                BEQ     @LBC37
                DEC     FieldPageX
@LBC37:         LDA     $033F
                BEQ     @LBC3E
                INC     FieldPageX
@LBC3E:         RTS

VmProc_CheckMoveUp:
                JSR     VmHelper_PushPad_Up
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushFieldScreenY
                JSR     VmOp_Decrement
                JMP     VmHelper_PopScreenY

VmProc_CheckMoveDown:
                JSR     VmHelper_PushPad_Down
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushFieldScreenY
                JSR     VmOp_Increment
                JMP     VmHelper_PopScreenY

VmProc_CheckMoveRight:
                JSR     VmHelper_PushPad_Right
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushScreenX
                JSR     VmOp_Increment
                JMP     VmHelper_PopScreenX

VmProc_CheckMoveLeft:
                JSR     VmHelper_PushPad_Left
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushScreenX
                JSR     VmOp_Decrement
                JMP     VmHelper_PopScreenX

VmProc_MoveScreen:
                JSR     VmHelper_PushProcessStateCounter ;Update screen position
                JSR     VmOp_ExitFalse
                JSR     VmProc_CheckMoveUp
                JSR     VmProc_CheckMoveDown
                JSR     VmProc_CheckMoveRight
                JMP     VmProc_CheckMoveLeft

VmHelper_PushConst_0500:
                LDA     #$05
                LDY     #$00
                JMP     VmOp_PushRegister

LBC94:          JSR     VmOp_Asl_05                     ;read $999B[(y * 32 + x) * 2]
                JSR     VmOp_Add_AB
                JSR     VmOp_Asl_01
                JSR     VmHelper_PushConst_999B
                JSR     VmOp_Add_AB
                JMP     VmOp_ReadAddressWord

VmHelper_PushFieldChipX:
                LDA     FieldDstChipX
                JMP     VmOp_PushByte

VmHelper_PopFieldChipX:
                JSR     VmOp_PopRegister
                STY     FieldDstChipX
                RTS

VmHelper_PushFieldChipY:
                LDA     FieldDstChipY
                JMP     VmOp_PushByte

VmHelper_PopFieldChipY:
                JSR     VmOp_PopRegister
                STY     FieldDstChipY
                RTS

LBCBC:          JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmOp_ReadByte
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmOp_Increment
                JSR     VmOp_ReadByte
                JSR     VmHelper_WriteTempAddressWord_04
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmOp_AddConst_02
                JSR     VmOp_ReadByte
                JSR     VmHelper_WriteTempAddressWord_06
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmOp_AddConst_03
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     VmOp_ExitTrue
                JSR     VmHelper_ReadTempAddressWord_04
                JMP     VmHelper_WriteTempAddressWord_06

LBCEC:          JSR     VmOp_Asl_01
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmOp_Add_AB
                JSR     VmOp_ReadAddressWord
                JSR     VmOp_Swap
                JSR     VmOp_Asl_01
                JSR     LB6E5
                JSR     VmOp_Add_AB
                JSR     VmOp_ReadAddressWord
                JSR     VmOp_And
                JSR     VmOp_CheckNotZero
                BCC     @LBD12
                JMP     VmHelper_ReadTempAddressWord_06

@LBD12:         JMP     VmHelper_ReadTempAddressWord_04

LBD15:          JSR     VmHelper_PushPad_Right
                JSR     VmOp_ExitTrue
                JMP     VmOp_Decrement

LBD1E:          JSR     VmHelper_CreateStackFrame_0E
                JSR     VmOp_Asl_04
                JSR     VmHelper_PushConst_0500
                JSR     VmOp_Add_AB
                JSR     VmHelper_WriteTempAddressWord_08
                JSR     VmHelper_PushFieldPageX
                JSR     VmHelper_PushFieldPageY
                JSR     LBC94
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     LBCBC
                JSR     VmHelper_PushConst_000F
                JSR     VmHelper_PushFieldChipX
                JSR     L9601
@LBD45:         JSR     VmSecond_CopySecondStack_Reload
                JSR     VmHelper_PushFieldChipY
                JSR     LBCEC
                JSR     VmHelper_ReadTempAddressWord_08
                JSR     VmSecond_CopySecondStack_Reload
                JSR     VmOp_Add_AB
                JSR     VmOp_WriteByte
                JSR     L9620
                BCC     @LBD45
                JSR     VmHelper_PushFieldPageX
                JSR     VmOp_Increment
                JSR     VmHelper_PushFieldPageY
                JSR     LBC94
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     LBCBC
                JSR     VmHelper_PushFieldChipX
                JSR     VmOp_CheckNotZero
                BCC     @LBD9F
                JSR     VmHelper_PushFieldChipX
                JSR     LBD15
                JSR     VmHelper_PushConst_0000
                JSR     L9601
@LBD85:         JSR     VmSecond_CopySecondStack_Reload
                JSR     VmHelper_PushFieldChipY
                JSR     LBCEC
                JSR     VmHelper_ReadTempAddressWord_08
                JSR     VmSecond_CopySecondStack_Reload
                JSR     VmOp_Add_AB
                JSR     VmOp_WriteByte
                JSR     L9620
                BCC     @LBD85
@LBD9F:         JMP     VmOp_DestroyStackFrame

LBDA2:          JSR     VmHelper_PushFieldPageX
                JSR     VmHelper_PushFieldPageY
                JSR     LBC94
                JSR     VmHelper_WriteTempAddressWord_02
                JMP     LBCBC

LBDB1:          JSR     VmHelper_PushFieldChipX
                JSR     VmSecond_CopySecondStack_Reload
                JSR     LBCEC
                JSR     VmSecond_CopySecondStack_Reload
                JSR     VmProc_GetMemoryOffsetY
                JSR     VmOp_Asl_04
                JSR     VmHelper_ReadTempAddressWord_08
                JSR     VmOp_Add_AB
                JMP     VmOp_WriteByte

LBDCC:          JSR     VmOp_Duplicate
                JSR     VmHelper_PushConst_000B
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_ExitFalse
                JSR     VmOp_PopDiscard
                JMP     VmHelper_PushConst_000B

LBDDE:          JSR     VmHelper_PushPositions
                JSR     VmHelper_CreateStackFrame_0E
                JSR     VmHelper_PushConst_0500
                JSR     VmHelper_PushFieldChipX
                JSR     VmOp_Add_AB
                JMP     VmHelper_WriteTempAddressWord_08

LBDF0:          JSR     LBDDE
                JSR     LBDA2
                JSR     VmHelper_PushConst_000B
                JSR     VmHelper_PushFieldChipY
                JSR     L9601
@LBDFF:         JSR     LBDB1
                JSR     L9620
                BCC     @LBDFF
                JSR     VmOp_DestroyStackFrame
                JMP     VmHelper_PopPositions

LBE0D:          JSR     LBDDE
                JSR     VmProc_IncrementFieldPageY
                JSR     LBDA2
                JSR     VmHelper_PushFieldChipY
                JSR     VmOp_Increment
                JSR     LBDCC
                JSR     VmHelper_PushConst_0000
                JSR     L9601
@LBE25:         JSR     LBDB1
                JSR     L9620
                BCC     @LBE25
                JSR     VmOp_DestroyStackFrame
                JMP     VmHelper_PopPositions

LBE33:          JSR     VmHelper_PushFieldChipX
                JSR     VmOp_Add_AB
                JSR     VmOp_Duplicate
                JSR     VmHelper_PopFieldChipX
                JSR     VmHelper_PushConst_000F
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushFieldChipX
                JSR     VmHelper_PushConst_0010
                JSR     VmOp_Sub_BA
                JSR     VmHelper_PopFieldChipX
                JSR     VmHelper_PushFieldPageX
                JSR     VmOp_Increment
                JMP     VmHelper_PopFieldPageX

LBE5D:          JSR     VmHelper_PushFieldPageX
                JSR     VmHelper_PushConst_001F
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0001
                JMP     LBE33

VmProc_MoveFieldLeftChip:
                JSR     VmHelper_PushFieldPageX         ;if(FieldX == #$0000){
                JSR     VmHelper_PushFieldChipX
                JSR     VmOp_Or                         ;    return;
                JSR     VmOp_ExitFalse                  ;}
                JSR     VmHelper_PushFieldChipX
                JSR     VmOp_Decrement
                JSR     VmOp_Duplicate
                JSR     VmHelper_PopFieldChipX          ;FieldChipX--;
                JSR     VmHelper_PushConst_000F
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_ExitFalse                  ;if(#$0F < ChipX){
                JSR     VmHelper_PushConst_000F
                JSR     VmHelper_PopFieldChipX          ;    FieldChipX = #$0F;
                JSR     VmHelper_PushFieldPageX
                JSR     VmOp_Decrement                  ;    FieldPageX--;
                JMP     VmHelper_PopFieldPageX          ;}

VmProc_SetDstField_Down_Main:
                JSR     VmHelper_PushFieldChipY         ;FieldChipY++;
                JSR     VmOp_Add_AB
                JSR     VmOp_Duplicate
                JSR     VmHelper_PopFieldChipY
                JSR     VmHelper_PushConst_000B
                JSR     VmOp_Compare_BGeatherThan       ;(0x0B < FieldChipY)
                JSR     VmOp_ExitFalse                  ;check page boundaries 11 -> 12
                JSR     VmHelper_PushFieldChipY         ;set page upper position
                JSR     VmHelper_PushConst_000C
                JSR     VmOp_Sub_BA
                JSR     VmHelper_PopFieldChipY
                JSR     VmHelper_PushFieldPageY         ;increment pange
                JSR     VmOp_Increment
                JMP     VmHelper_PopFieldPageY

VmProc_SetDstField_Down:
                JSR     VmHelper_PushFieldPageY         ;check
                JSR     VmHelper_PushConst_0018
                JSR     VmOp_Compare_AGeatherThan       ;(0x0018 > FieldPageY)
                JSR     VmOp_ExitFalse                  ;page overrange
                JSR     VmHelper_PushConst_0001
                JMP     VmProc_SetDstField_Down_Main    ;update

VmProc_SetDstField_Up:
                JSR     VmHelper_PushFieldPageY
                JSR     VmHelper_PushFieldChipY
                JSR     VmOp_Or
                JSR     VmOp_ExitFalse                  ;check Y=0x0000
                JSR     VmHelper_PushFieldChipY
                JSR     VmOp_Decrement
                JSR     VmOp_Duplicate
                JSR     VmHelper_PopFieldChipY
                JSR     VmHelper_PushConst_000B
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_ExitFalse                  ;check page boundaries 0 -> -1(overflow)
                JSR     VmHelper_PushConst_000B         ;set page bottom position
                JSR     VmHelper_PopFieldChipY
                JSR     VmHelper_PushFieldPageY         ;decrement page
                JSR     VmOp_Decrement
                JMP     VmHelper_PopFieldPageY

LBF0B:          JSR     VmHelper_PushPad_Right
                JSR     VmOp_ExitFalse
                JMP     LBE5D

VmProc_SetDstField_Right_Inc:
                JSR     VmHelper_PushFieldPageX
                JSR     VmOp_Duplicate
                JSR     VmOp_Increment
                JMP     VmHelper_PopFieldPageX

VmProc_SetDstField_Right:
                JSR     VmHelper_PushPad_Right
                JSR     VmOp_ExitFalse
                JSR     VmProc_SetDstField_Right_Inc    ;push FieldX
                JSR     LBDF0
                JMP     VmHelper_PopFieldPageX          ;pop FiledX

LBF2F:          JSR     VmHelper_PushPad_Right
                JSR     VmOp_ExitFalse
                JSR     VmProc_SetDstField_Right_Inc
                JSR     LBE0D
                JMP     VmHelper_PopFieldPageX

VmProc_SetTargetPointScreenX:
                JSR     VmHelper_PushFieldChipX
                JSR     VmOp_Asl_04
                JSR     VmHelper_PopScreenX
                JSR     VmHelper_PushFieldPageX
                JSR     VmHelper_PushConst_0001
                JSR     VmOp_And
                JSR     VmOp_ExitFalse                  ;Show left nametable screen
                JSR     VmHelper_PushScreenX            ;Show right nametable screen
                JSR     VmHelper_PushConst_0100
                JSR     VmOp_Add_AB
                JMP     VmHelper_PopScreenX

VmProc_MoveFieldLeft:
                JSR     VmHelper_PushPad_Left
                JSR     VmOp_ExitFalse
                JMP     VmProc_MoveFieldLeftChip

VmProc_SetDstField_Left:
                JSR     VmHelper_PushPad_Left
                JSR     VmOp_ExitFalse
                JMP     LBDF0

LBF71:          JSR     VmHelper_PushPad_Left
                JSR     VmOp_ExitFalse
                JMP     LBE0D

VmProc_CheckDstField_Up:
                JSR     VmHelper_PushPad_Up
                JSR     VmOp_ExitFalse
                JMP     VmProc_SetDstField_Up

LBF83:          JSR     VmHelper_PushPad_Up
                JSR     VmOp_ExitFalse
                JSR     VmProc_GetMemoryOffsetY_ChipY
                JMP     LBD1E

VmProc_SetTargetPointScreenY:
                JSR     VmProc_GetMemoryOffsetY_ChipY
                JSR     VmOp_Asl_04
                JMP     VmHelper_PopScreenY

VmProc_CheckDstField_Down:
                JSR     VmHelper_PushPad_Down
                JSR     VmOp_ExitFalse
                JMP     VmProc_SetDstField_Down

LBFA1:          JSR     VmHelper_PushPad_Down
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushFieldPageY
                JSR     VmHelper_PushFieldPageY
                JSR     VmOp_Increment
                JSR     VmHelper_PopFieldPageY
                JSR     VmProc_GetMemoryOffsetY_ChipY
                JSR     LBD1E
                JMP     VmHelper_PopFieldPageY

LBFBC:          LDA     #$04
                LDY     #$01
                JMP     VmOp_PushRegister

LBFC3:          LDA     #$83
                LDY     #$1B
                JMP     VmOp_PushRegister

LBFCA:          JSR     VmHelper_CreateStackFrame_06
                JSR     VmOp_Asl_04
                JSR     VmHelper_PushConst_0500
                JSR     VmOp_Add_AB
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     VmHelper_PushConst_000F
                JSR     VmHelper_PushConst_0000
                JSR     L9601
@LBFE2:         JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmSecond_CopySecondStack_Reload
                JSR     VmOp_Add_AB
                JSR     VmOp_ReadByte
                JSR     VmOp_Asl_02
                JSR     LBFC3
                JSR     VmOp_Add_AB
                JSR     VmHelper_WriteTempAddressWord_04
                JSR     LBFBC
                JSR     VmSecond_CopySecondStack_Reload
                JSR     VmOp_Asl_01
                JSR     VmOp_Add_AB
                JSR     VmHelper_WriteTempAddressWord_06
                JSR     VmHelper_ReadTempAddressWord_04
                JSR     VmOp_ReadAddressWord
                JSR     VmHelper_ReadTempAddressWord_06
                JSR     VmOp_WriteWord
                JSR     VmHelper_ReadTempAddressWord_04
                JSR     VmOp_AddConst_02
                JSR     VmOp_ReadAddressWord
                JSR     VmHelper_ReadTempAddressWord_06
                JSR     VmHelper_PushConst_0020
                JSR     VmOp_Add_AB
                JSR     VmOp_WriteWord
                JSR     L9620
                BCC     @LBFE2
                JMP     VmOp_DestroyStackFrame

LC032:          LDY     #$3F
@LC034:         LDA     $0401,y
                STA     $049A,y
                DEY
                BPL     @LC034
                RTS

LC03E:          LDY     #$3F
@LC040:         LDA     $049A,y
                STA     $0401,y
                DEY
                BPL     @LC040
                RTS

LC04A:          JSR     VmHelper_PushFieldChipX
                JSR     VmOp_PopRegister
                TYA
                ASL     A
                TAY
                LDA     #$00
                RTS

LC056:          JSR     LC04A
                DEY
                BMI     LC065
@LC05C:         STA     $0401,y
                STA     $0421,y
                DEY
                BPL     @LC05C
LC065:          RTS

LC066:          JSR     LC04A
                CPY     #$1E
                BCS     LC065
                INY
                INY
@LC06F:         STA     $0401,y
                STA     $0421,y
                INY
                CPY     #$20
                BCC     @LC06F
                RTS

LC07B:          LDA     FieldPageX
                LSR     A
                BCS     @LC083
                JMP     LC056

@LC083:         JMP     LC066

LC086:          LDA     FieldPageX
                LSR     A
                BCS     @LC08E
                JMP     LC066

@LC08E:         JMP     LC056

LC091:          JSR     LC032
                BMI     LC07B
LC096:          JSR     LC03E
                BMI     LC086
FieldPageY_MemoryOffset:
                .byte   $00,$0C,$09,$06,$03,$00,$0C,$09,$06,$03 ;field : mod 15, chip : mod 12
                .byte   $00,$0C,$09,$06,$03,$00,$0C,$09,$06,$03 ;=> (12 * index) % 15
                .byte   $00,$0C,$09,$06,$03,$00,$0C,$09,$06,$03

VmHelper_PushConst_C09B:
                LDA     #>FieldPageY_MemoryOffset
                LDY     #<FieldPageY_MemoryOffset
                JMP     VmOp_PushRegister

; Argument: [0] Chip Y position
; Return: [0] MemoryOffset Y (high nibble)
VmProc_GetMemoryOffsetY:
                JSR     VmHelper_PushConst_C09B         ;// arg = FieldChipY or ???
                JSR     VmHelper_PushFieldPageY         ;Stack[0] = MemoryOffset[FieldPageY] + arg
                JSR     VmOp_Add_AB
                JSR     VmOp_ReadByte
                JSR     VmOp_Add_AB
                JSR     VmOp_Duplicate                  ;return mod 15 (field memory height = 15)
                JSR     VmHelper_PushConst_000E         ;if(#$000F <= Stack[0]){ Stack[0] -= #$000F; }
                JSR     VmOp_Compare_BGeatherThan       ;  // #$000E < Stack[0]
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_000F         ;  // Stack[0] -= #$000F
                JMP     VmOp_Sub_BA

VmProc_GetMemoryOffsetY_ChipY:
                JSR     VmHelper_PushFieldChipY
                JMP     VmProc_GetMemoryOffsetY

LC0E7:          JSR     VmProc_GetMemoryOffsetY_ChipY
                JSR     VmOp_Duplicate
                JSR     LBFCA
                JSR     LB6FC
                JSR     VmHelper_PushFieldChipX
                JSR     LB6F1
                JSR     PpuControl_DisableDirection
                JMP     LB614

LC0FF:          JSR     LC0E7
                JSR     LB6EC
                JSR     VmHelper_PushConst_000F
                JSR     VmOp_And
                JMP     LB6F1

LC10E:          JSR     VmHelper_PushPad_Up
                JSR     VmOp_ExitFalse
                JSR     LC0FF
                JMP     LC091

LC11A:          JSR     LC0E7
                JSR     LB6EC
                JSR     VmHelper_PushConst_0010
                JSR     VmOp_Or
                JMP     LB6F1

LC129:          JSR     VmHelper_PushPad_Up
                JSR     VmOp_ExitFalse
                JSR     LC11A
                JMP     LC096

LC135:          JSR     VmHelper_PushFieldPageY
                JSR     VmHelper_PushFieldPageY
                JSR     VmOp_Increment
                JSR     VmHelper_PopFieldPageY
                JSR     VmProc_GetMemoryOffsetY_ChipY
                JSR     VmOp_Duplicate
                JSR     LBFCA
                JSR     LB6FC
                JSR     VmHelper_PopFieldPageY
                JSR     VmHelper_PushFieldChipX
                JSR     LB6F1
                JSR     PpuControl_DisableDirection
                JMP     LB614

LC15C:          JSR     VmHelper_PushPad_Down
                JSR     VmOp_ExitFalse
                JSR     LC135
                JMP     LC091

LC168:          JSR     VmHelper_PushPad_Down
                JSR     VmOp_ExitFalse
                JSR     LC135
                JSR     LC096
                JSR     LB6EC
                JSR     VmHelper_PushConst_0010
                JSR     VmOp_Or
                JMP     LB6F1

LC180:          JSR     VmOp_ReadByte
                JMP     VmHelper_ReadTempAddressWord_06

LC186:          JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmSecond_CopySecondStack_Reload
                JSR     VmOp_Asl_04
                JSR     VmOp_Add_AB
                JSR     VmOp_ReadByte
                JSR     VmOp_Asl_02
                JSR     LBFC3
                JSR     VmOp_Add_AB
                JSR     VmHelper_WriteTempAddressWord_04
                JSR     LBFBC
                JSR     VmSecond_CopySecondStack_Reload
                JSR     VmOp_Asl_01
                JSR     VmOp_Add_AB
                JSR     VmHelper_WriteTempAddressWord_06
                JSR     VmHelper_ReadTempAddressWord_04
                JSR     LC180
                JSR     VmOp_WriteByte
                JSR     VmHelper_ReadTempAddressWord_04
                JSR     VmOp_AddConst_02
                JSR     LC180
                JSR     VmOp_Increment
                JSR     VmOp_WriteByte
                JSR     VmHelper_ReadTempAddressWord_04
                JSR     VmOp_Increment
                JSR     LC180
                JSR     VmHelper_PushConst_0020
                JSR     VmOp_Add_AB
                JSR     VmOp_WriteByte
                JSR     VmHelper_ReadTempAddressWord_04
                JSR     VmOp_AddConst_03
                JSR     LC180
                JSR     VmHelper_PushConst_0021
                JSR     VmOp_Add_AB
                JMP     VmOp_WriteByte

LC1EC:          JSR     VmHelper_CreateStackFrame_06
                JSR     VmHelper_PushFieldChipX
                JSR     VmHelper_PushConst_0500
                JSR     VmOp_Add_AB
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     L9601
@LC1FE:         JSR     LC186
                JSR     L9620
                BCC     @LC1FE
                JMP     VmOp_DestroyStackFrame

LC209:          LDA     #$FF
                STA     $D3
                RTS

LC20E:          JSR     VmHelper_PushConst_0001
                JSR     VmOp_And
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0010
                JMP     VmOp_Add_AB

LC21D:          JSR     VmHelper_PushPad_Right
                JSR     VmOp_ExitFalse
                JSR     LB6EC
                JSR     VmHelper_PushConst_0010
                JSR     VmOp_Xor
                JMP     LB6F1

LC22F:          JSR     VmHelper_PushConst_0005
                JSR     VmHelper_PushConst_0000
                JMP     LC1EC

LC238:          JSR     VmHelper_PushConst_000A
                JSR     VmHelper_PushConst_0006
                JMP     LC1EC

LC241:          JSR     VmHelper_PushPad_Right
                JSR     VmHelper_PushPad_Left
                JSR     VmOp_Or
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_000E
                JSR     VmHelper_PushConst_000B
                JSR     LC1EC
                JSR     VmHelper_PushFieldChipX
                JSR     VmHelper_PushFieldPageX
                JSR     LC20E
                JSR     LB6F1
                JSR     LC21D
                JSR     VmProc_GetMemoryOffsetY_ChipY
                JSR     LB6FC
                JSR     LC209
                JSR     PpuControl_EnableDirection
                JMP     LB614

LC274:          STY     $D6
                TAY
                LDA     L835F,y
                LDY     $D6
                RTS

LC27D:          ASL     A
                ASL     A
                ORA     $0401,x
                STA     $0401,x
                RTS

LC286:          STA     $D8
                CLC
                ADC     #$10
                STA     $D7
                TXA
                PHA
                LDX     $D8
@LC291:         LDA     $0500,y
                JSR     LC274
                STA     $0401,x
                LDA     $0501,y
                JSR     LC274
                JSR     LC27D
                LDA     $0510,y
                JSR     LC274
                ASL     A
                ASL     A
                JSR     LC27D
                LDA     $0511,y
                JSR     LC274
                ASL     A
                ASL     A
                ASL     A
                ASL     A
                JSR     LC27D
                INY
                INY
                TYA
                AND     #$0F
                BNE     @LC2C7
                TYA
                CLC
                ADC     #$10
                TAY
@LC2C7:         INX
                CPX     #$40
                BEQ     @LC2D0
                CPX     $D7
                BCC     @LC291
@LC2D0:         PLA
                TAX
                RTS

LC2D3:          LDA     #$00
                TAY
                JMP     LC286

LC2D9:          LDA     #$10
                LDY     #$40
                JMP     LC286

LC2E0:          LDA     #$20
                LDY     #$80
                JMP     LC286

LC2E7:          LDA     #$30
                LDY     #$C0
                JMP     LC286

LC2EE:          JSR     VmHelper_PushConst_0000
                JSR     LB6F1
                JSR     VmHelper_PushConst_000F
                JSR     LB6FC
                JMP     LC309

LC2FD:          JSR     VmHelper_PushConst_0010
                JSR     LB6F1
                JSR     VmHelper_PushConst_000F
                JSR     LB6FC
LC309:          JSR     PpuControl_DisableDirection
                JMP     LB614

; Field patry sprite information table
; Goku, Chohakkai, Sagojo, Sanzo(1), Sanzo(2), Sanzo(3), Sanzo(4), Null
FieldPartyTilesTable:
                .byte   $04,$48,$5A,$10,$12,$14,$16,$00 ;using 8x16 mode
                .byte   $06,$4A,$5C,$18,$1A,$1C,$1E,$00
                .byte   $08,$4C,$5E,$10,$20,$14,$22,$00
                .byte   $06,$4A,$5C,$18,$1A,$1C,$1E,$00
                .byte   $04,$48,$5A,$14,$16,$10,$12,$00 ;Invert
                .byte   $06,$4A,$5C,$1C,$1E,$18,$1A,$00
                .byte   $08,$4C,$5E,$14,$22,$10,$20,$00
                .byte   $06,$4A,$5C,$1C,$1E,$18,$1A,$00
FieldPartyPaletteIndexes:
                .byte   $00,$01,$02,$01,$01,$01,$01,$00
FieldPartyXPositions:
                .byte   $7C,$84,$8C,$80,$80,$88,$88,$00
FieldPartyYPositions:
                .byte   $60,$60,$60,$44,$54,$44,$54,$F0

SetOamBuffer_FieldPartySprite:
                TXA
                PHA
                LDA     FieldPartyAnimationFrame        ;A = AnimationFrame * 8
                ASL     A
                ASL     A
                ASL     A
                LDX     FieldPartyDirection
                BEQ     @SkipInvert
                CLC
                ADC     #$20                            ;Reference invert index table
@SkipInvert:    TAX
                LDY     #$00                            ;Oam buffer index
; Sprite tile
@CharacterLoop: LDA     FieldPartyTilesTable,x
                STA     OamBuffer+17,y                  ;[1] Tile number
                TXA
                PHA                                     ;Save index
                AND     #$07                            ;To palette, position index
                TAX
                CPX     #$01
                BNE     @NotChohakkai
                LDA     PartyIn_Chohakkai               ;Is Chohakkai partying in
                BEQ     @HidePosition
@NotChohakkai:  CPX     #$02
                BNE     @ShowPosition
                LDA     PartyIn_Sagojo                  ;Is Sagojo partying in
                BNE     @ShowPosition
@HidePosition:  LDA     #$F0
                BNE     @WriteYPosition

@ShowPosition:  LDA     FieldPartyYPositions,x
@WriteYPosition:
                STA     OamBuffer+16,y                  ;[0] Y position
                LDA     FieldPartyPaletteIndexes,x
                STA     OamBuffer+18,y                  ;[2] Attribute
                LDA     FieldPartyDirection
                BEQ     @SkipFlip
                LDA     #$40
                ORA     OamBuffer+18,y
                STA     OamBuffer+18,y                  ;[2] Attribute (Flip)
@SkipFlip:      LDA     FieldPartyXPositions,x
                STA     OamBuffer+19,y                  ;[3] X position
                INY                                     ;Y : Next OAM index
                INY
                INY
                INY
                PLA                                     ;Restore index
                TAX
                INX                                     ;X : Next character index
                CPY     #$1C                            ;7 times
                BCC     @CharacterLoop
                PLA
                TAX
                RTS

IncrementPartyAnimationFrame:
                INC     FieldPartyAnimationFrame
                LDA     FieldPartyAnimationFrame
                AND     #$03
                STA     FieldPartyAnimationFrame
                RTS

SetFieldPartySprite:
                JSR     IncrementPartyAnimationFrame
                LDA     PadBuffer_Now_Left              ;Left
                BEQ     @SkipLeft
                LDA     #$01
                STA     FieldPartyDirection
@SkipLeft:      LDA     PadBuffer_Now_Right             ;Right
                BEQ     @SkipRight
                LDA     #$00
                STA     FieldPartyDirection
@SkipRight:     JSR     SetOamBuffer_FieldPartySprite
                JSR     SetOamDmaRequest
                RTS

MapEventProcessAddressList:
                .word   VmProc_MapEventProcess_None     ;Row #00
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCAFA
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD054
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD054
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCE91
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #01
                .word   TCDD7
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCBB0
                .word   VmProc_MapEventProcess_None
                .word   TD198
                .word   VmProc_MapEventProcess_None
                .word   TCE91
                .word   VmProc_MapEventProcess_None
                .word   TCE44
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCBCB
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD054
                .word   VmProc_MapEventProcess_None
                .word   TCC49
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCF2A
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCBB0
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #02
                .word   TCB03
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD198
                .word   VmProc_MapEventProcess_None
                .word   TD198
                .word   TD198
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCC8B
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD198
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCAB3
                .word   TD126
                .word   TD042
                .word   VmProc_MapEventProcess_None
                .word   TD150
                .word   VmProc_MapEventProcess_None
                .word   TD033
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #03
                .word   TD0B7
                .word   VmProc_MapEventProcess_None
                .word   TD198
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD198
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD081
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD054
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCD12
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD150
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #04
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD198
                .word   VmProc_MapEventProcess_None
                .word   TCCBE
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD171
                .word   TD06C
                .word   TD171
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCC58
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD126
                .word   VmProc_MapEventProcess_None
                .word   TD042
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #05
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD171
                .word   TD06C
                .word   TD1C2
                .word   TD171
                .word   TCBB0
                .word   TD06C
                .word   TD1C2
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCAAA
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD150
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #06
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD06C
                .word   TD171
                .word   TD1C2
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCBCB
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD042
                .word   VmProc_MapEventProcess_None
                .word   TCC67
                .word   TCE03
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCC3A
                .word   TD042
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD06C                           ;Row #07
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD081
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCD27
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD090
                .word   VmProc_MapEventProcess_None
                .word   TCD00
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #08
                .word   VmProc_MapEventProcess_None
                .word   TD0CF
                .word   TD1C2
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD081
                .word   VmProc_MapEventProcess_None
                .word   TCC9A
                .word   VmProc_MapEventProcess_None
                .word   TD090
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD171
                .word   VmProc_MapEventProcess_None
                .word   TD090
                .word   TD090
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD10B
                .word   VmProc_MapEventProcess_None
                .word   TCB98
                .word   TD150
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #09
                .word   VmProc_MapEventProcess_None
                .word   TD171
                .word   TD1C2
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD1C2
                .word   VmProc_MapEventProcess_None
                .word   TD1C2
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD171
                .word   TCC76
                .word   VmProc_MapEventProcess_None
                .word   TD090
                .word   TD090
                .word   VmProc_MapEventProcess_None
                .word   TCBB0
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD10B
                .word   TCA9F
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD033
                .word   VmProc_MapEventProcess_None
                .word   TCB80
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #0A
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCE91
                .word   TD1C2
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD171
                .word   TCBB0
                .word   TD06C
                .word   TD06C
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD10B
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCA8D
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #0B
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD171
                .word   TCCA9
                .word   VmProc_MapEventProcess_None
                .word   TCCE2
                .word   TD1C2
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD081
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD126
                .word   TD090
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD0E7
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCB98
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #0C
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD1C2
                .word   TCA33
                .word   TCA33
                .word   TCA33
                .word   TD171
                .word   VmProc_MapEventProcess_None
                .word   TD081
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD126
                .word   TD090
                .word   TD090
                .word   TCBCB
                .word   TCAE4
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCEF3
                .word   TCA96
                .word   TD150
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #0D
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCA33
                .word   TCA33
                .word   TCA33
                .word   TD1C2
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCE91
                .word   TD090
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD033
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCC1C
                .word   VmProc_MapEventProcess_None
                .word   TD033
                .word   VmProc_MapEventProcess_None
                .word   TD033
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #0E
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCA33
                .word   TCEAF
                .word   TCA33
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCBB0
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCBCB
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCD3C
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCAEF
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD150
                .word   VmProc_MapEventProcess_None
                .word   TD10B
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #0F
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD0E7
                .word   VmProc_MapEventProcess_None
                .word   TCCF1
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD150
                .word   VmProc_MapEventProcess_None
                .word   TCC0D
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #10
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD10B
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD150
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCB17
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #11
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCCD3
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD0E7
                .word   TD0E7
                .word   VmProc_MapEventProcess_None
                .word   TD150
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCAD0
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #12
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCE91
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCABC
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCAD9
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #13
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCB0C
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD0E7
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCC2B
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #14
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD0E7
                .word   TD0E7
                .word   VmProc_MapEventProcess_None
                .word   TCBB0
                .word   VmProc_MapEventProcess_None
                .word   TD0E7
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #15
                .word   VmProc_MapEventProcess_None
                .word   TCD4E
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD090
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD0E7
                .word   VmProc_MapEventProcess_None
                .word   TD150
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #16
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD0E7
                .word   VmProc_MapEventProcess_None
                .word   TD0E7
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TD0E7
                .word   VmProc_MapEventProcess_None
                .word   TD0E7
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #17
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   TCAC5
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None     ;Row #18
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None
                .word   VmProc_MapEventProcess_None

LCA2A:          JSR     VmHelper_LoadFieldTime_High
                JSR     VmHelper_PushConst_0020
                JMP     VmOp_Compare_BGeatherThan

TCA33:          LDA     $047A
                BNE     @LCA69
                JSR     VmHelper_PushConst_0000
                JSR     LB9A5
                LDA     #$01
                STA     $0472
                JSR     VmHelper_PushConst_0005
                JSR     LB2AD
                JSR     VmHelper_PushConst_0005
                JSR     LB1EC
                JSR     LB24E
                JSR     VmOp_ExitTrue
                JSR     VmHelper_PushConst_0004
                JSR     VmHelper_PushConst_0000
                JSR     L9601
@LCA5E:         JSR     VmSecond_CopySecondStack_Reload
                JSR     LB2AD
                JSR     L9620
                BCC     @LCA5E
@LCA69:         RTS

; Argument:
;   Stack[0] = Warp destination page X
;   Stack[1] = Warp destination page Y
LCA6A:          JSR     VmHelper_CreateStackFrame_06
                JSR     VmHelper_WriteTempAddressWord_02 ;Save to local area
                JSR     VmHelper_WriteTempAddressWord_04
                JSR     VmProc_CheckMapEventExecute     ;Check (0, 0)
                JSR     VmOp_CheckNotZero
                BCS     @Return
                JSR     VmProc_CheckMapEventExecute
                JSR     VmHelper_ReadTempAddressWord_04 ;Restore from local area
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     LBBE8
                JSR     LCD9E
@Return:        JMP     VmOp_DestroyStackFrame

TCA8D:          JSR     VmHelper_PushConst_000C
                JSR     VmHelper_PushConst_0019
                JMP     LCA6A

TCA96:          JSR     VmHelper_PushConst_000A
                JSR     VmHelper_PushConst_0019
                JMP     LCA6A

TCA9F:          JSR     VmHelper_PushConst_0008
                LDA     #$17
                JSR     VmOp_PushByte
                JMP     LCA6A

TCAAA:          JSR     VmHelper_PushConst_0005
                JSR     VmHelper_PushConst_001C
                JMP     LCA6A

TCAB3:          JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_0016
                JMP     LCA6A

TCABC:          JSR     VmHelper_PushConst_0016
                JSR     VmHelper_PushConst_0016
                JMP     LCA6A

TCAC5:          JSR     VmHelper_PushConst_0012
                LDA     #$15
                JSR     VmOp_PushByte
                JMP     LCA6A

TCAD0:          JSR     VmHelper_PushConst_0012
                JSR     VmHelper_PushConst_001E
                JMP     LCA6A

TCAD9:          JSR     VmHelper_PushConst_0011
                LDA     #$1B
                JSR     VmOp_PushByte
                JMP     LCA6A

TCAE4:          JSR     VmHelper_PushConst_000E
                LDA     #$13
                JSR     VmOp_PushByte
                JMP     LCA6A

TCAEF:          JSR     VmHelper_PushConst_000C
                LDA     #$13
                JSR     VmOp_PushByte
                JMP     LCA6A

TCAFA:          JSR     VmHelper_PushConst_0001         ;Warp Y Page
                JSR     VmHelper_PushConst_0005         ;Warp X Page
                JMP     LCA6A

TCB03:          JSR     VmHelper_PushConst_000A
                JSR     VmHelper_PushConst_0006
                JMP     LCA6A

TCB0C:          LDA     #$13
                JSR     VmOp_PushByte
                JSR     VmHelper_PushConst_0005
                JMP     LCA6A

TCB17:          JSR     VmHelper_PushConst_0004
                JSR     VmHelper_PushConst_001C
                JMP     LCA6A

LCB20:          LDA     #$01
                STA     $0498
                RTS

LCB26:          JSR     LCB20
                JSR     LE41F
                JSR     LE431
                JSR     LCBF5
                JSR     LCDB6
                JSR     SongRequest_05
                JSR     LE76A
                JMP     LCBFB

LCB3E:          JSR     LCB20
                JSR     LE41F
                JSR     LCBF5
                JSR     LCDB6
                JSR     SongRequest_05
                JSR     LE76A
                JMP     LCBFB

LCB53:          JSR     LCB20
                JSR     LE41F
                JSR     LE431
                JSR     LCC01
                JSR     LCDB6
                JSR     SongRequest_05
                JSR     LE76A
                JMP     LCC07

LCB6B:          JSR     LCB20
                JSR     LE431
                JSR     LCC01
                JSR     LCDB6
                JSR     SongRequest_05
                JSR     LE76A
                JMP     LCC07

TCB80:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     LCB20
                JSR     LE431
                JSR     LCDB6
                JSR     SongRequest_05
                JSR     LE76A
                JMP     LCD9E

TCB98:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     LCB20
                JSR     LE41F
                JSR     LCDB6
                JSR     SongRequest_05
                JSR     LE76A
                JMP     LCD9E

TCBB0:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     LCB20
                JSR     LE41F
                JSR     LE431
                JSR     LCDB6
                JSR     SongRequest_05
                JSR     LE76A
                JMP     LCD9E

TCBCB:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     LCDB6
                JSR     LD018
                JSR     VmHelper_PushConst_0001
                JSR     LE37F
                JSR     LCDAA
                JSR     LD018
                JSR     VmHelper_PushConst_0002
                JSR     LE37F
                JSR     LCDAA
                JSR     SongRequest_01
                JSR     LE76A
                JMP     LCD9E

LCBF5:          LDA     #$01
                STA     $0482
                RTS

LCBFB:          LDA     #$00
                STA     $0482
                RTS

LCC01:          LDA     #$01
                STA     $0483
                RTS

LCC07:          LDA     #$00
                STA     $0483
                RTS

TCC0D:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     RequestDrawText_08
                JSR     LCB26
                JMP     LCD9E

TCC1C:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     RequestDrawText_01
                JSR     LCB6B
                JMP     LCD9E

TCC2B:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     RequestDrawText_09
                JSR     LCB3E
                JMP     LCD9E

TCC3A:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     LD274
                JSR     LCB26
                JMP     LCD9E

TCC49:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     RequestDrawText_02
                JSR     LCB53
                JMP     LCD9E

TCC58:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     RequestDrawText_0A
                JSR     LCB3E
                JMP     LCD9E

TCC67:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     LD264
                JSR     LCB6B
                JMP     LCD9E

TCC76:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD32C
                JSR     RequestDrawText_0B
                JSR     LCB26
                JMP     LCD9E

TCC8B:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     LD26C
                JSR     LCB3E
                JMP     LCD9E

TCC9A:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     LD270
                JSR     LCB3E
                JMP     LCD9E

TCCA9:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD33C
                JSR     LD268
                JSR     LCB53
                JMP     LCD9E

TCCBE:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD334
                JSR     RequestDrawText_03
                JSR     LCB53
                JMP     LCD9E

TCCD3:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     LD278
                JSR     LCB53
                JMP     LCD9E

TCCE2:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     LD27C
                JSR     LCB26
                JMP     LCD9E

TCCF1:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     LD280
                JSR     LCB53
                JMP     LCD9E

TCD00:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD284
                JSR     LCDC2
                JMP     LCD9E

TCD12:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD28C
                JSR     LD31C
                JSR     LCDC2
                JMP     LCD9E

TCD27:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD294
                JSR     LD324
                JSR     LCDC2
                JMP     LCD9E

TCD3C:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD29C
                JSR     LCDC2
                JMP     LCD9E

TCD4E:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     SongRequest_04                  ;Set ending music
                JSR     LD2CC
                JSR     LD2D4
                JSR     LD2DC
                JSR     LD2E4
                JSR     LD2EC
                JSR     LD2F4
                JSR     LD304
@InfLoop:       JSR     WaitNmiRaised
                JSR     PlaySubSequence
                JMP     @InfLoop

VmProc_MapEventProcess_None:
                NOP
                RTS

LCD77:          JSR     VmHelper_PushConst_0001
                JMP     LE37F

LCD7D:          JSR     VmHelper_PushConst_0002
                JMP     LE37F

LCD83:          JSR     VmHelper_PushConst_0003
                JMP     LE37F

; Check that the page coordinates of the map are (0, 0)
; Return:
;   Stack[0] : False(0) = (0, 0), True(1) otherwise
VmProc_CheckMapEventExecute:
                JSR     VmHelper_PushConst_0000
                JSR     LB9A5                           ;$03FC = #$00
                JSR     VmHelper_PushConst_0000
                JSR     LB9B2                           ;$03FD = #$00
                JSR     VmHelper_PushFieldChipX
                JSR     VmHelper_PushFieldChipY
                JMP     VmOp_Or

LCD9E:          JSR     VmHelper_PushFieldPageX
                JSR     LB9A5
                JSR     VmHelper_PushFieldPageY
                JMP     LB9B2

LCDAA:          JSR     VmHelper_PushConst_0001
                JMP     LD944

LCDB0:          JSR     VmHelper_PushConst_0001
                JMP     LD963

LCDB6:          JSR     VmHelper_PushConst_000B
                JMP     LE362

LCDBC:          JSR     VmHelper_PushConst_0006
                JMP     LE362

LCDC2:          JSR     LCDBC
                JSR     LCF5B
                JSR     LCD77
                JSR     LE171
                JSR     LCDB0
                JSR     SongRequest_01
                JMP     LE76A

TCDD7:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                LDA     $047A
                BNE     @LCDF1
                JSR     DisableApuChannel
                JSR     LD2B4
                JSR     LCF76
                JSR     LCD77
                JSR     LE168
@LCDF1:         JSR     LCDB6
                JSR     SongRequest_01
                JSR     LE76A
                JSR     LCD9E
                LDA     #$01
                STA     $047A
                RTS

TCE03:          LDA     $047B
                BNE     @LCE43
                JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD2AC
                JSR     VmHelper_PushConst_0009
                JSR     LE362
                JSR     LCF7F
                JSR     LCD77
                JSR     LCDB0
                JSR     LCF7F
                JSR     LCD7D
                JSR     LCDB0
                JSR     LCF7F
                JSR     LCD83
                LDA     #$1F
                STA     $045D
                JSR     SongRequest_01
                JSR     LE76A
                JSR     LCD9E
                INC     $047B
@LCE43:         RTS

TCE44:          LDA     $047C
                BNE     @LCE90
                JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD2A4
                JSR     VmHelper_PushConst_0007
                JSR     LE362
                JSR     LCF64
                JSR     LCD77
                JSR     LE171
                JSR     LCDB0
                JSR     LCF64
                JSR     LCD7D
                JSR     LE171
                JSR     LCDB0
                JSR     LCF64
                JSR     LCD83
                JSR     LE171
                JSR     LCDB0
                LDA     #$1F
                STA     $045D
                JSR     SongRequest_01
                JSR     LE76A
                JSR     LCD9E
                INC     $047C
@LCE90:         RTS

TCE91:          JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     VmHelper_PushConst_0003
                JSR     LE362
                JSR     LB409
                JSR     SongRequest_05
                JSR     LE76A
                JMP     LCD9E

LCEA9:          JSR     LE168
                JMP     LCDAA

TCEAF:          LDA     PartyIn_Chohakkai-1
                BNE     @LCEF2
                JSR     VmProc_CheckMapEventExecute
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD2C4
                JSR     LCF88
                JSR     LCD77
                JSR     LCEA9
                JSR     LCF91
                JSR     LCD7D
                JSR     LCEA9
                JSR     LCF9A
                JSR     LCD83
                JSR     LCEA9
                JSR     VmHelper_PushConst_000C
                JSR     LE362
                LDA     #$1F
                STA     $045D
                JSR     SongRequest_01
                JSR     LE76A
                JSR     LCD9E
                INC     PartyIn_Chohakkai-1
@LCEF2:         RTS

TCEF3:          LDA     PartyIn_Chohakkai
                BNE     @LCF29
                JSR     DisableApuChannel
                JSR     LD30C
                JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     LCFA3
                JSR     LCD7D
                JSR     LCDB0
                JSR     LCFA3
                JSR     LCD83
                JSR     LCDB0
                LDA     #$01
                STA     $0480
                JSR     SongRequest_01
                JSR     LE76A
                INC     PartyIn_Chohakkai
                LDA     #$00
                STA     $0480
@LCF29:         RTS

TCF2A:          LDA     PartyIn_Sagojo
                BNE     @LCF5A
                JSR     DisableApuChannel
                JSR     LD314
                JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     LCF5B
                JSR     LCD7D
                JSR     LE171
                JSR     LCDB0
                LDA     #$01
                STA     $0481
                JSR     SongRequest_01
                JSR     LE76A
                INC     PartyIn_Sagojo
                LDA     #$00
                STA     $0481
@LCF5A:         RTS

LCF5B:          JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_0006
                JMP     VmHelper_PushConst_000A

LCF64:          JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PushConst_0008
                JMP     VmHelper_PushConst_000A

LCF6D:          JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_000A
                JMP     VmHelper_PushConst_000A

LCF76:          JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_000B
                JMP     VmHelper_PushConst_0007

LCF7F:          JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PushConst_0008
                JMP     VmHelper_PushConst_0006

LCF88:          JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_00E0
                JMP     VmHelper_PushConst_0008

LCF91:          JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_00E0
                JMP     VmHelper_PushConst_0009

LCF9A:          JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_00E0
                JMP     VmHelper_PushConst_000A

LCFA3:          JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_0008
                JMP     VmHelper_PushConst_000B

LCFAC:          JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_000B
                JMP     VmHelper_PushConst_000B

LCFB5:          JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PushConst_0008
                JMP     VmHelper_PushConst_0009

LCFBE:          JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PushConst_000A
                JMP     VmHelper_PushConst_000A

LCFC7:          JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PushConst_0006
                JMP     VmHelper_PushConst_000B

LCFD0:          JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_000A
                JMP     VmHelper_PushConst_000B

LCFD9:          JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_000A
                JMP     VmHelper_PushConst_0007

LCFE2:          JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_000E
                JMP     VmHelper_PushConst_0007

LCFEB:          JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_0004
                JMP     VmHelper_PushConst_0009

LCFF4:          JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_0018
                JMP     VmHelper_PushConst_0006

LCFFD:          JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_000F
                JMP     VmHelper_PushConst_0008

LD006:          JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_0004
                JMP     VmHelper_PushConst_0007

LD00F:          JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_000F
                JMP     VmHelper_PushConst_0008

LD018:          JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_0008
                JMP     VmHelper_PushConst_0006

LD021:          JSR     LCDB0
                JSR     SongRequest_01
                JMP     LE76A

LD02A:          JSR     LCDAA
LD02D:          JSR     SongRequest_01
                JMP     LE76A

TD033:          JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     LCFA3
                JSR     LCD77
                JMP     LD021

TD042:          JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     LCF5B
                JSR     LCD77
                JSR     LE171
                JMP     LD021

TD054:          JSR     VmHelper_PushConst_0001
                JSR     LE362
                JSR     LCFB5
                JSR     LCD77
                JSR     LCDB0
                JSR     LCFB5
                JSR     LCD7D
                JMP     LD021

TD06C:          JSR     VmHelper_PushConst_0002
                JSR     LE362
                JSR     LCA2A
                JSR     VmOp_ExitFalse
                JSR     LCFC7
                JSR     LCD77
                JMP     LD02A

TD081:          JSR     VmHelper_PushConst_0002
                JSR     LE362
                JSR     LCFD9
                JSR     LCD77
                JMP     LD02D

TD090:          JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     LCA2A
                JSR     VmOp_ExitFalse
                JSR     LCFEB
                JSR     LCD77
                JSR     LCDAA
                JSR     LCFEB
                JSR     LCD7D
                JSR     LCDAA
                JSR     LCFEB
                JSR     LCD83
                JMP     LD02A

TD0B7:          JSR     VmHelper_PushConst_0002
                JSR     LE362
                JSR     LCFD9
                JSR     LCD77
                JSR     LCFF4
                JSR     LCD7D
                JSR     LE168
                JMP     LD02D

TD0CF:          JSR     VmHelper_PushConst_0002
                JSR     LE362
                JSR     LCFD9
                JSR     LCD77
                JSR     LCFFD
                JSR     LCD7D
                JSR     LE168
                JMP     LD02D

TD0E7:          JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     LD006
                JSR     LCD77
                JSR     LCDB0
                JSR     LD006
                JSR     LCD7D
                JSR     LCDB0
                JSR     LD006
                JSR     LCD83
                JSR     LE168
                JMP     LD02D

TD10B:          JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     LCFA3
                JSR     LCD77
                JSR     LCDB0
                JSR     LD00F
                JSR     LCD83
                JSR     LE168
                JMP     LD02D

TD126:          JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     LCF5B
                JSR     LCD77
                JSR     LE171
                JSR     LCDB0
                JSR     LCF5B
                JSR     LCD7D
                JSR     LE171
                JSR     LCDB0
                JSR     LCF6D
                JSR     LCD83
                JSR     LE171
                JMP     LD021

TD150:          JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     LCFA3
                JSR     LCD77
                JSR     LCDB0
                JSR     LCFA3
                JSR     LCD7D
                JSR     LCDB0
                JSR     LCFAC
                JSR     LCD83
                JMP     LD021

TD171:          JSR     VmHelper_PushConst_0002
                JSR     LE362
                JSR     LCA2A
                JSR     VmOp_ExitFalse
                JSR     LCFC7
                JSR     LCD77
                JSR     LCDAA
                JSR     LCFC7
                JSR     LCD7D
                JSR     LCDAA
                JSR     LCFD0
                JSR     LCD83
                JMP     LD02A

TD198:          JSR     VmHelper_PushConst_0001
                JSR     LE362
                JSR     LCFBE
                JSR     LCD77
                JSR     LE168
                JSR     LCDB0
                JSR     LCFBE
                JSR     LCD7D
                JSR     LE168
                JSR     LCDB0
                JSR     LCFBE
                JSR     LCD83
                JSR     LE168
                JMP     LD021

TD1C2:          JSR     VmHelper_PushConst_0002
                JSR     LE362
                JSR     LCFD9
                JSR     LCD77
                JSR     LCDB0
                JSR     LCFD9
                JSR     LCD7D
                JSR     LCDB0
                JSR     LCFE2
                JSR     LCD83
                JMP     LD02D

TextAddressTable:
                .word   $0000                           ;#00 ?
                .word   TextData_01                     ;#01 「ここは かなんちほう です」
                .word   TextData_02                     ;#02 「ここは ごびさばく です」
                .word   TextData_03                     ;#03 「ここは たくらまかんさばく です」
                .word   TextData_04                     ;#04 ちょうあんの みやこだ！
                .word   TextData_05                     ;#05 らくようの みやこだ！
                .word   TextData_06                     ;#06 ちょうしゅうの みやこだ！
                .word   TextData_07                     ;#07 ちょんつうの みやこだ！
                .word   TextData_08                     ;#08 「なかまを あつめなさい」
                .word   TextData_09                     ;#09 「きたへ すすめ」
                .word   TextData_0A                     ;#0A 「ときの もんを とおれ」
                .word   TextData_0B                     ;#0B 「よるは きけんだ」
                .word   TextData_0C                     ;#0C 「にしに かえんざんが あります」
                .word   TextData_0D                     ;#0D 「てんじくは かえんざんの むこう」
                .word   TextData_0E                     ;#0E 「らせつじょを たおせば かえんざんの・・」
                .word   TextData_0F                     ;#0F 「きんかくは さばくの はてにいる」
                .word   TextData_10                     ;#10 「ふしちょう ほうおうを さがせ」
                .word   TextData_11                     ;#11 きんかくだいおう 「ぎんかくのかたき！」
                .word   TextData_12                     ;#12 ぎんかくだいおう 「ここはとおさんぞ！」
                .word   TextData_13                     ;#13 「わたしが らせつじょだ！」
                .word   TextData_14                     ;#14 「てんじくはもうすぐです」
                .word   TextData_15                     ;#15 「ながいたびが はじまる・・」
                .word   TextData_16                     ;#16 こんせいまおう 「よくここまできたな・・」
                .word   TextData_17                     ;#17 ごくういっこうの
                .word   TextData_18                     ;#18 ながい ながい たびは おわり
                .word   TextData_19                     ;#19 これからちゅうごくの れきしが はじまる
                .word   TextData_1A                     ;#1A おしゃかさまより
                .word   TextData_1B                     ;#1B ありがたいおきょうを いただいて
                .word   TextData_1C                     ;#1C ひとびとに おしえを つたえましょう
                .word   TextData_1D                     ;#1D ああ しんじゃった！
                .word   TextData_1E                     ;#1E おしまい
                .word   TextData_1F                     ;#1F はっかい 「だれか たすけて！」
                .word   $0000                           ;#20 ?
                .word   TextData_21                     ;#21 「さばくの いりぐちは ほくせい」
                .word   TextData_22                     ;#22 「がんばってくださいね」
                .word   $0000                           ;#23 ?
                .word   TextData_24                     ;#24 さごじょう 「おともします！」
                .word   TextData_25                     ;#25 「AB AB」
                .word   TextData_26                     ;#26 「AB AB AB」
                .word   TextData_27                     ;#27 「AB A A AB」
                .word   TextData_28                     ;#28 「AB A A」
                .word   TextData_29                     ;#29 「AB A AB AB」

RequestDrawText:
                ASL     A
                TAY
                LDA     TextAddressTable+1,y
                STA     DrawTextPointer+1
                LDA     TextAddressTable,y
                STA     DrawTextPointer
                LDA     #$01
                STA     DrawTextRequest
                RTS

RequestDrawText_01:
                LDA     #$01
                BNE     RequestDrawText

RequestDrawText_02:
                LDA     #$02
                BNE     RequestDrawText

RequestDrawText_03:
                LDA     #$03
                BNE     RequestDrawText

RequestDrawText_08:
                LDA     #$08
                BNE     RequestDrawText

RequestDrawText_09:
                LDA     #$09
                BNE     RequestDrawText

RequestDrawText_0A:
                LDA     #$0A
                BNE     RequestDrawText

RequestDrawText_0B:
                LDA     #$0B
                BNE     RequestDrawText

LD264:          LDA     #$0C
                BNE     RequestDrawText

LD268:          LDA     #$0D
                BNE     RequestDrawText

LD26C:          LDA     #$0E
                BNE     RequestDrawText

LD270:          LDA     #$0F
                BNE     RequestDrawText

LD274:          LDA     #$10
                BNE     RequestDrawText

LD278:          LDA     #$14
                BNE     RequestDrawText

LD27C:          LDA     #$21
                BNE     RequestDrawText

LD280:          LDA     #$22
                BNE     RequestDrawText

LD284:          LDA     #$04
                JSR     RequestDrawText
                JMP     LE856

LD28C:          LDA     #$05
                JSR     RequestDrawText
                JMP     LE856

LD294:          LDA     #$06
                JSR     RequestDrawText
                JMP     LE856

LD29C:          LDA     #$07
                JSR     RequestDrawText
                JMP     LE856

LD2A4:          LDA     #$11
                JSR     RequestDrawText
                JMP     LE856

LD2AC:          LDA     #$12
                JSR     RequestDrawText
                JMP     LE856

LD2B4:          LDA     #$13
                JSR     RequestDrawText
                JMP     LE856

LD2BC:          LDA     #$15
                JSR     RequestDrawText
                JMP     LE856

LD2C4:          LDA     #$16
                JSR     RequestDrawText
                JMP     LE856

LD2CC:          LDA     #$17
                JSR     RequestDrawText
                JMP     LE856

LD2D4:          LDA     #$18
                JSR     RequestDrawText
                JMP     LE851

LD2DC:          LDA     #$19
                JSR     RequestDrawText
                JMP     LE851

LD2E4:          LDA     #$1A
                JSR     RequestDrawText
                JMP     LE851

LD2EC:          LDA     #$1B
                JSR     RequestDrawText
                JMP     LE851

LD2F4:          LDA     #$1C
                JSR     RequestDrawText
                JMP     LE851

LD2FC:          LDA     #$1D
                JSR     RequestDrawText
                JMP     LE856

LD304:          LDA     #$1E
                JSR     RequestDrawText
                JMP     LE851

LD30C:          LDA     #$1F
                JSR     RequestDrawText
                JMP     LE856

LD314:          LDA     #$24
                JSR     RequestDrawText
                JMP     LE856

LD31C:          LDA     #$25
                JSR     RequestDrawText
                JMP     LE856

LD324:          LDA     #$26
                JSR     RequestDrawText
                JMP     LE856

LD32C:          LDA     #$27
                JSR     RequestDrawText
                JMP     LE856

LD334:          LDA     #$28
                JSR     RequestDrawText
                JMP     LE856

LD33C:          LDA     #$29
                JSR     RequestDrawText
                JMP     LE856

                .byte   $C3
                .byte   $E5
                .byte   $E7
                .byte   $00
                .byte   $A9
                .byte   $D3
                .byte   $A0
                .byte   $44
                .byte   $4C
                .byte   $92
                .byte   $99
                .byte   $05
                .byte   $00
                .byte   $02
                .byte   $04
                .byte   $06
                .byte   $0F
                .byte   $08
                .byte   $0A
                .byte   $0C
                .byte   $0E
                .byte   $0F
                .byte   $10
                .byte   $12
                .byte   $04
                .byte   $14
                .byte   $0F
                .byte   $08
                .byte   $0A
                .byte   $0C
                .byte   $0E
                .byte   $00
                .byte   $05
                .byte   $FD
                .byte   $FD
                .byte   $56
                .byte   $58
                .byte   $02
                .byte   $FD
                .byte   $FD
                .byte   $56
                .byte   $5A
                .byte   $00
                .byte   $05
                .byte   "prtv"
                .byte   $02
                .byte   "xz|~"
                .byte   $02
                .byte   $70
                .byte   $80
                .byte   $74
                .byte   $84
                .byte   $02
                .byte   "xz|~"
                .byte   $00
                .byte   $05
                .byte   "\^`b"
                .byte   $02
                .byte   "dfhj"
                .byte   $02
                .byte   "ln`b"
                .byte   $02
                .byte   "dfhj"
                .byte   $00
                .byte   $07,">@BDFH"
                .byte   $02
                .byte   "JLBNPH"
                .byte   $00
                .byte   $07
                .byte   $8A
                .byte   $FD
                .byte   $88
                .byte   $FD
                .byte   $86
                .byte   $FD
                .byte   $02
                .byte   $8C
                .byte   $FD
                .byte   $88
                .byte   $FD
                .byte   $86
                .byte   $FD
                .byte   $02
                .byte   $8E
                .byte   $FD
                .byte   $88
                .byte   $FD
                .byte   $86
                .byte   $FD
                .byte   $02
                .byte   $8C
                .byte   $FD
                .byte   $88
                .byte   $FD
                .byte   $86
                .byte   $FD
                .byte   $00
                .byte   $05
                HiAscii "0}}}"
                .byte   $02
                HiAscii "2}}}"
                .byte   $02
                .byte   $82
                .byte   $FD
                .byte   $FD
                .byte   $FD
                .byte   $02
                HiAscii "2}}}"
                .byte   $00
                .byte   $05
                HiAscii "468:"
                .byte   $02
                HiAscii "<>@B"
                .byte   $02
                HiAscii "DFHJ"
                .byte   $02
                HiAscii "<>@B"
                .byte   $00
                .byte   $05
                .byte   $FD
                .byte   $9C
                .byte   $FD
                .byte   $9E
                .byte   $02
                .byte   $FD,$A0,$FD,$A2
                .byte   $00
                .byte   $06
                HiAscii "LNPR"
                .byte   $50
                .byte   $02
                HiAscii "TVXZ"
                .byte   $46
                .byte   $02
                HiAscii "\^`b"
                .byte   $50
                .byte   $02
                HiAscii "TVXZ"
                .byte   $46
                .byte   $00
                .byte   $05
                .byte   $FD
                .byte   $90
                .byte   $FD
                .byte   $92
                .byte   $02
                .byte   $FD
                .byte   $94
                .byte   $FD
                .byte   $96
                .byte   $02
                .byte   $FD
                .byte   $98
                .byte   $FD
                .byte   $9A
                .byte   $02
                .byte   $FD
                .byte   $94
                .byte   $FD
                .byte   $96
                .byte   $00
                .byte   $05
                HiAscii "MOQS"
                .byte   $02
                HiAscii "MUQW"
                .byte   $02
                HiAscii "MUY["
                .byte   $02
                HiAscii "MOY]"
                .byte   $00
                .byte   $05
                HiAscii "LNPR"
                .byte   $02
                HiAscii "LTPV"
                .byte   $02
                HiAscii "LXPZ"
                .byte   $02
                HiAscii "LTPV"
                .byte   $00
                .byte   $05
                HiAscii "468:"
                .byte   $02
                HiAscii "4<8>"
                .byte   $02
                HiAscii "4@8B"
                .byte   $02
                HiAscii "4<8>"
                .byte   $00
                .byte   $05
                .byte   $90
                .byte   $92
                .byte   $94
                .byte   $96
                .byte   $02
                .byte   $98
                .byte   $9A
                .byte   $9C
                .byte   $9E
                .byte   $02
                .byte   $A0,$A2,$A4,$A6
                .byte   $02
                .byte   $98
                .byte   $9A
                .byte   $9C
                .byte   $9E
                .byte   $00
                .byte   $05
                HiAscii "}d}f"
                .byte   $02
                HiAscii "}h}j"
                .byte   $02
                HiAscii "}l}n"
                .byte   $02
                HiAscii "}h}j"
                .byte   $00
                .byte   $05
                HiAscii "}(}*"
                .byte   $02
                HiAscii "},}."
                .byte   $02
                HiAscii "}D}F"
                .byte   $02
                HiAscii "}H}J"
                .byte   $00
                .byte   $07
                HiAscii "MOQSUW"
                .byte   $02
                HiAscii "YO[S]W"
                .byte   $02
                HiAscii "_OaScW"
                .byte   $02
                HiAscii "YO[S]W"
                .byte   $00
                .byte   $05
                .byte   $90
                .byte   $92
                .byte   $94
                .byte   $96
                .byte   $02
                .byte   $90
                .byte   $98
                .byte   $94
                .byte   $9A
                .byte   $00
                .byte   $05
                HiAscii "NPRT"
                .byte   $02
                HiAscii "VXRZ"
                .byte   $02
                HiAscii "V\RT"
                .byte   $02
                HiAscii "VXRZ"
                .byte   $00
                .byte   $07
                HiAscii "468:<>"
                .byte   $00
                .byte   $05
                HiAscii "(}*}"
                .byte   $00
                .byte   $05
                HiAscii ",}.}"
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $4F
                .byte   $D3
                .byte   $64
                .byte   $D3
                .byte   $99
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $6F
                .byte   $D3
                .byte   $99
                .byte   $D3
                .byte   $4F
                HiAscii "SoSzS"
                .byte   $13
                .byte   $D4
                .byte   $28
                .byte   $D4
                .byte   $DA
                .byte   $D3
                .byte   $4F
                .byte   $D3
                .byte   $64
                .byte   $D3
                .byte   $99
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $6F
                .byte   $D3
                .byte   $99
                .byte   $D3
                .byte   $3D
                .byte   $D4
                .byte   $52
                .byte   $D4
                .byte   $67
                .byte   $D4
                .byte   $7C
                .byte   $D4
                .byte   $91
                .byte   $D4
                .byte   $A6
                .byte   $D4
                .byte   $4F
                .byte   $D3
                .byte   $64
                .byte   $D3
                .byte   $99
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $6F
                .byte   $D3
                .byte   $99
                HiAscii "SCTNTcTqTkTwTyT"
                .byte   $11
                .byte   $D5
                .byte   $29
                .byte   $D5

LD547:          LDA     #$D5
                LDY     #$3F
                JSR     VmOp_PushRegister
                JSR     LE31C
                JSR     VmHelper_PushConst_000F
                JSR     VmOp_And
                JSR     VmOp_Asl_01
                JSR     VmOp_Add_AB
                JMP     VmOp_ReadAddressWord

                .byte   $87
                .byte   $1A
                .byte   $1C
                .byte   $1E
                .byte   $20
                .byte   $FD
                .byte   $FD
                .byte   $02
                .byte   $22,"$&("
                .byte   $FD
                .byte   $FD
                .byte   $02
                .byte   "*,.02"
                .byte   $FD
                .byte   $02
                .byte   "468:"
                .byte   $FD
                .byte   $3C
                .byte   $02
                .byte   $1A
                .byte   $1C
                .byte   $1E
                .byte   $20
                .byte   $FD
                .byte   $FD
                .byte   $00
                .byte   $60
                HiAscii "UZSoSzS"
                .byte   $13
                .byte   $D4
                .byte   $4F
                .byte   $D3
                .byte   $3D
                .byte   $D4
                .byte   $52
                .byte   $D4
                .byte   $67
                .byte   $D4
                .byte   $4F
                .byte   $D3
                .byte   $4F
                .byte   $D3
                .byte   $4F
                .byte   $D3

LD59C:          LDA     #$D5
                LDY     #$84
                JMP     VmOp_PushRegister

                .byte   $85
                HiAscii "}p}r"
                .byte   $02
                HiAscii "}t}v"
                .byte   $02
                HiAscii "}x}z"
                .byte   $02
                HiAscii "}|}}"
                .byte   $02
                HiAscii "}}}}"
                .byte   $00

LD5BD:          LDA     #$D5
                LDY     #$A3
                JMP     VmOp_PushRegister

LD5C4:          LDA     $3E
                JMP     VmOp_PushByte

                JSR     VmHelper_ReadTempAddressWord_08
                JSR     VmOp_ExitFalse
                JMP     L97C5

LD5D2:          LDA     OamBuffer+51
                JMP     VmOp_PushByte

LD5D8:          LDA     OamBuffer+48
                JMP     VmOp_PushByte

LD5DE:          JSR     VmOp_PopRegister
                STY     OamBuffer+51
                RTS

LD5E5:          JSR     VmOp_PopRegister
                STY     OamBuffer+48
                RTS

LD5EC:          JSR     VmHelper_PushConst_0000
                JMP     VmHelper_WriteTempAddressWord_08

LD5F2:          JSR     VmHelper_PushConst_0040
                JMP     VmHelper_WriteTempAddressWord_08

LD5F8:          JSR     LE159
                JSR     VmOp_AddConst_02
                JSR     VmOp_ReadByte
                JSR     VmHelper_PushConst_0040
                JSR     VmOp_And
                JMP     VmHelper_WriteTempAddressWord_08

LD60A:          LDA     #$00
                STA     $CD
                STA     $CC
                RTS

LD611:          LDY     RleExpandIndex
                LDA     LA039,y
                BEQ     @LD628
                JSR     LD60A
                LDA     OamBuffer+51
                CMP     #$E0
                BCC     LD63A
                LDA     #$E0
                STA     OamBuffer+51
                RTS

@LD628:         LDA     OamBuffer+51
                CMP     #$A0
                BCC     LD63A
                JSR     LE53E
                JSR     VmOp_ExitTrue
                LDA     #$A0
                STA     $CD
LD639:          RTS

LD63A:          JSR     LDED7
                JSR     LE53E
                JSR     VmOp_ExitTrue
                JMP     LD60A

LD646:          LDY     RleExpandIndex
                LDA     LA039,y
                BEQ     @LD65A
                JSR     LD60A
                LDA     OamBuffer+51
                CMP     #$20
                BCC     LD639
                JMP     LDECC

@LD65A:         LDA     OamBuffer+51
                CMP     #$61
                BCS     @LD66C
                JSR     LE53E
                JSR     VmOp_ExitTrue
                LDA     #$60
                STA     $CC
                RTS

@LD66C:         JSR     LDECC
                JSR     LE53E
                JSR     VmOp_ExitTrue
                JMP     LD60A

LD678:          LDA     OamBuffer+48
                CMP     #$11
                BCC     LD639
                JMP     LDEEB

LD682:          LDA     OamBuffer+48
                CMP     #$A0
                BCC     @LD68F
                LDA     #$A0
                STA     OamBuffer+48
                RTS

@LD68F:         JMP     LDEE2

LD692:          JSR     LD731
                JSR     VmOp_ExitTrue
                LDY     $035A
                JSR     LDEBA
                JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmOp_ExitFalse
                LDA     PadBuffer_Now_Up
                BEQ     @LD6AC
                JSR     LD678
@LD6AC:         LDA     PadBuffer_Now_Down
                BEQ     @LD6B4
                JSR     LD682
@LD6B4:         LDA     PadBuffer_Now_Left
                BEQ     @LD6BC
                JSR     LD646
@LD6BC:         LDA     PadBuffer_Now_Right
                BEQ     @LD6C4
                JSR     LD611
@LD6C4:         LDY     RleExpandIndex
                LDA     LA039,y
                BNE     @LD6E3
                JSR     LD979
                JSR     LD93B
                JSR     VmOp_Or
                JSR     VmOp_ExitTrue
                JSR     VmHelper_PushPad_Right
                JSR     VmHelper_PushPad_Left
                JSR     VmOp_Or
                JSR     VmOp_ExitTrue
@LD6E3:         JMP     LD60A

LD6E6:          LDA     #$03
                LDY     #$91
LD6EA:          JSR     VmOp_PushRegister
                JSR     LD731
                JSR     VmOp_Asl_01
                JSR     VmOp_Add_AB
                JMP     VmOp_ReadAddressWord

LD6F9:          LDA     #$03
                LDY     #$91
LD6FD:          JSR     VmOp_PushRegister
                JSR     LD731
                JSR     VmOp_Asl_01
                JSR     VmOp_Add_AB
                JMP     VmOp_WriteWord

LD70C:          LDA     #$03
                LDY     #$9D
                JMP     LD6EA

LD713:          LDA     #$03
                LDY     #$9D
                JMP     LD6FD

LD71A:          LDY     $035A
                BNE     @LD728
                JSR     VmHelper_PushPad_Right
                JSR     VmHelper_PushPad_Left
                JMP     VmOp_Or

@LD728:         LDA     $0373,y
                ORA     $0379,y
                JMP     VmOp_PushByte

LD731:          LDA     $035A
                JMP     VmOp_PushByte

LD737:          JSR     LE1F8
                JSR     VmOp_Asl_01
                JSR     VmOp_Add_AB
                JMP     VmOp_ReadAddressWord

LD743:          JSR     LD59C
                JMP     LD737

LD749:          JSR     LD547
                JMP     LD737

LD74F:          LDA     $03FB
                JMP     VmOp_PushByte

LD755:          JSR     VmOp_PopRegister
                STY     $03FB
                RTS

LD75C:          JSR     LD6E6
                JSR     VmOp_ReadByte
                JSR     VmHelper_PushConst_000F
                JMP     VmOp_And

LD768:          JSR     LD75C
                JSR     LD70C
                JMP     VmOp_Add_AB

LD771:          JSR     VmHelper_PushConst_0080
                JSR     LD6E6
                JSR     VmOp_ReadByte
                JMP     VmOp_And

LD77D:          JSR     VmHelper_CreateStackFrame_02
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     VmHelper_PushConst_00F0
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmOp_Decrement
                JSR     VmOp_Asl_02
                JSR     LE159
                JSR     VmOp_Add_AB
                JSR     VmOp_WriteByte
                JSR     VmHelper_PushConst_00F0
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmOp_Asl_02
                JSR     LE159
                JSR     VmOp_Add_AB
                JSR     VmOp_WriteByte
                JMP     VmOp_DestroyStackFrame

LD7AD:          JSR     L9601
@LD7B0:         JSR     LE159
                JSR     VmSecond_CopySecondStack_Reload
                ASL     VmStack_Low,x
                ASL     VmStack_Low,x
                JSR     VmOp_Add_AB
                JSR     VmHelper_WriteTempAddressWord_0C
                JSR     VmHelper_ReadTempAddressWord_06
                JSR     @LD7E6
                JSR     VmHelper_PushConst_0001
                JSR     @LD7DD
                JSR     VmHelper_ReadTempAddressWord_04
                JSR     VmHelper_PushConst_0002
                JSR     @LD7DD
                JSR     L9620
                BCC     @LD7B0
                RTS

@LD7DD:         JSR     VmHelper_ReadTempAddressWord_0C
                JSR     VmOp_Add_AB
                JMP     VmOp_WriteByte

@LD7E6:         JSR     VmSecond_CopySecondStack_Reload
                JMP     VmOp_ReadOffsetByte

LD7EC:          JSR     VmOp_PopRegister
                TYA
                LDY     $035A
                STA     $037F,y
                RTS

LD7F7:          JSR     LD75C
                JSR     VmOp_Duplicate
                JSR     VmHelper_WriteTempAddressWord_0E
                JSR     VmOp_Decrement
                JSR     LD7EC
                JSR     VmHelper_ReadTempAddressWord_08
                JSR     VmHelper_ReadTempAddressWord_06
                JSR     VmOp_Or
                JSR     VmHelper_WriteTempAddressWord_04
                JSR     LD70C
                JSR     VmOp_Increment
                JSR     VmHelper_WriteTempAddressWord_06
                JSR     VmHelper_ReadTempAddressWord_0E
                JSR     VmOp_Decrement
                JSR     VmHelper_PushConst_0000
                JSR     LD7AD
                JSR     VmHelper_ReadTempAddressWord_0E
                JMP     LD77D

LD82D:          JSR     LD6E6
                JSR     LD5BD
                JSR     VmOp_Compare_Equal
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0003
                JMP     VmHelper_WriteTempAddressWord_06

LD83F:          JSR     LD768
                JMP     VmOp_ReadByte

LD845:          JSR     LD83F
                JSR     VmOp_ExitTrue
                JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmOp_ExitFalse
                JSR     LD6E6
                JSR     LD5BD
                JSR     VmOp_Compare_Equal
                JSR     VmOp_ExitFalse
                JSR     LD749
                JMP     LE0ED

LD863:          JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmOp_ExitTrue
                JSR     LD6E6
                JSR     LD5BD
                JSR     VmOp_Compare_Equal
                JSR     VmOp_ExitTrue
                JSR     SongRequest_09
                JSR     LD5BD
                JMP     LE0ED

LD87E:          JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmOp_ExitFalse
                JSR     LE1F8
                JSR     VmOp_ExitTrue
                JSR     VmHelper_PushConst_0001
                JSR     LD755
                JSR     LDB0C
                JSR     VmOp_ExitFalse
                JSR     LD743
                JSR     LE0ED
                JMP     SongRequest_11

LD89F:          JSR     LD83F
                JSR     VmOp_ExitTrue
                JSR     LD749
                JSR     LD6E6
                JSR     VmOp_Compare_Equal
                JSR     VmOp_ExitTrue
                JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmOp_ExitFalse
                JSR     LD71A
                JSR     VmOp_ExitFalse
                JSR     LD979
                JSR     VmOp_ExitTrue
                JSR     LD749
                JMP     LE0ED

LD8C9:          JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmOp_ExitFalse
                JSR     LE1F8
                JSR     VmOp_ExitTrue
                JSR     VmHelper_PushConst_0000
                JMP     LD755

LD8DB:          JSR     LD771
                JSR     VmOp_ExitFalse
                JSR     LD6E6
                JSR     LD5BD
                JSR     VmOp_Compare_Equal
                JSR     VmOp_ExitFalse
                JSR     LE21E
                JSR     VmOp_ExitTrue
                JSR     VmHelper_PushConst_0000
                JMP     LE23B

LD8F9:          JSR     LD7F7
                JSR     LD83F
                JSR     VmOp_Duplicate
                JSR     VmOp_ExitFalse
                JSR     LD768
                JMP     LD713

LD90B:          JSR     LD8F9
                JSR     VmOp_ExitTrue
                JSR     LD8C9
                JSR     LD8DB
                JSR     LD771
                JSR     VmOp_ExitTrue
                JSR     LD71A
                JSR     VmOp_ExitFalse
                JSR     LD6E6
                JMP     LD713

LD929:          JSR     LD82D
                JSR     LD845
                JSR     LD863
                JSR     LD87E
                JSR     LD89F
                JMP     LD90B

LD93B:          LDY     $035A
                LDA     $03B5,y
                JMP     VmOp_PushByte

LD944:          JSR     VmOp_PopRegister
                TYA
                LDY     $035A
                STA     $03B5,y
                RTS

LD94F:          LDY     #$06
                LDA     #$00
@LD953:         STA     $03B5,y
                DEY
                BPL     @LD953
                RTS

LD95A:          LDY     $035A
                LDA     $03BB,y
                JMP     VmOp_PushByte

LD963:          JSR     VmOp_PopRegister
                TYA
                LDY     $035A
                STA     $03BB,y
                RTS

LD96E:          LDY     #$06
                LDA     #$00
@LD972:         STA     $03BB,y
                DEY
                BPL     @LD972
                RTS

LD979:          LDY     $035A
                LDA     $038B,y
                JMP     VmOp_PushByte

LD982:          JSR     VmOp_PopRegister
                TYA
                LDY     $035A
                STA     $038B,y
                RTS

LD98D:          LDY     #$05
                LDA     #$00
@LD991:         STA     $038B,y
                DEY
                BNE     @LD991
                RTS

LD998:          JSR     LDA44
                JSR     VmOp_ExitFalse
                JSR     LD979
                JSR     VmOp_CheckNotZero
                BCC     @LD9B9
                JSR     VmHelper_PushConst_0000
                JSR     LD982
                JSR     VmHelper_PushConst_0001
                JSR     LDA7A
                JSR     VmHelper_PushConst_0001
                JSR     LDA66
                SEC
@LD9B9:         BCS     @LD9E5
                JSR     LD95A
                JSR     VmOp_ExitTrue
                JSR     LDA5D
                JSR     VmOp_ExitFalse
                JSR     LDEAA
                JSR     LDA93
                JSR     VmHelper_PushConst_0020
                JSR     VmOp_Sub_BA
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0001
                JSR     LD982
                JSR     VmHelper_PushConst_0000
                JSR     LDA66
@LD9E5:         RTS

LD9E6:          JSR     LD979
                JSR     VmOp_ExitTrue
                JSR     LDA5D
                JSR     VmOp_ExitTrue
                JSR     VmHelper_PushConst_0001
                JSR     LDA7A
                JSR     VmHelper_PushConst_0001
                JMP     LDA66

LD9FE:          JSR     VmHelper_PushConst_0000
                JSR     LD982
                JMP     LD9E6

LDA07:          JSR     LE1F8
                JSR     VmHelper_PushConst_0005
                JMP     VmOp_Compare_Equal

LDA10:          JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmOp_ExitTrue
                LDA     OperatingParty
                CMP     #$05
                BNE     @LDA20
                JMP     LDBCA

@LDA20:         JSR     LE17A
                JSR     VmHelper_PushConst_0003
                JSR     VmHelper_WriteTempAddressWord_06
                JSR     VmHelper_PushConst_0000
                JSR     LD944
                JSR     VmHelper_PushConst_0000
                JSR     LD963
                JSR     LD979
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0000
                JSR     LD982
                JMP     LD9E6

LDA44:          LDY     $035A
                BNE     @LDA4C
                JMP     LDB12

@LDA4C:         LDA     $0385,y
                JMP     VmOp_PushByte

LDA52:          JSR     VmOp_PopRegister
                TYA
                LDY     $035A
                STA     $0385,y
                RTS

LDA5D:          LDY     $035A
                LDA     $03A9,y
                JMP     VmOp_PushByte

LDA66:          JSR     VmOp_PopRegister
                TYA
                LDY     $035A
                STA     $03A9,y
                RTS

                LDY     $035A
                LDA     $03AF,y
                JMP     VmOp_PushByte

LDA7A:          JSR     VmOp_PopRegister
                TYA
                LDY     $035A
                STA     $03AF,y
                RTS

LDA85:          TXA
                PHA
                LDX     $035A
                INC     $03AF,x
                INC     $03AF,x
                PLA
                TAX
                RTS

LDA93:          LDA     #$A0
                JMP     VmOp_PushByte

LDA98:          JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmOp_ExitFalse
                JSR     LDA44
                JSR     VmOp_ExitFalse
                JSR     LD979
                JSR     VmOp_ExitTrue
                JSR     LDA5D
                JSR     VmOp_ExitTrue
                JSR     SongRequest_0A
                LDA     #$FA
                JSR     VmOp_PushByte
                JSR     LDA7A
                JSR     VmHelper_PushConst_0001
                JMP     LDA66

LDAC1:          JSR     LDA5D
                JSR     VmOp_ExitFalse
                JSR     LDA85
                JSR     LDEAA
                JSR     LDA93
                JSR     VmOp_Compare_BGeatherThanOrEqual
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0000
                JMP     LDA66

LDADC:          JSR     LD93B
                JSR     VmOp_ExitTrue
                JSR     LD998
                JSR     LDAC1
                JSR     LDA98
                JMP     LD9E6

LDAEE:          JSR     LDEFD
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0003
                JSR     VmHelper_WriteTempAddressWord_06
                JSR     VmHelper_PushConst_0000
                JMP     LDF03

LDB00:          LDA     PadBuffer_Now_A
                JMP     VmOp_PushByte

                LDA     PadBuffer_Now_B
                JMP     VmOp_PushByte

LDB0C:          LDA     PadBuffer_Trigger_A
                JMP     VmOp_PushByte

LDB12:          LDA     PadBuffer_Trigger_B
                JMP     VmOp_PushByte

LDB18:          LDA     PadBuffer_Now_Start
                JMP     VmOp_PushByte

VmHelper_PushPad_Left:
                LDA     PadBuffer_Now_Left
                JMP     VmOp_PushByte

VmHelper_PushPad_Right:
                LDA     PadBuffer_Now_Right
                JMP     VmOp_PushByte

VmHelper_PushPad_Up:
                LDA     PadBuffer_Now_Up
                JMP     VmOp_PushByte

VmHelper_PushPad_Down:
                LDA     PadBuffer_Now_Down
                JMP     VmOp_PushByte

LDB36:          LDA     PadBuffer_Trigger_Start
                JMP     VmOp_PushByte

LDB3C:          LDA     $0349
                JMP     VmOp_PushByte

LDB42:          JSR     LE1F8
                JSR     VmHelper_PushConst_0000
                JMP     VmOp_Compare_Equal

LDB4B:          JSR     LDB42
                JSR     VmOp_CheckNotZero
                BCC     @LDB5D
                JSR     VmHelper_PushConst_0000
                JSR     LB1EC
                JSR     LB24E
                SEC
@LDB5D:         BCS     LDB68
                JSR     LE1F8
                JSR     LB1EC
                JSR     LB24E
LDB68:          RTS

LDB69:          JSR     LDB42
                JSR     VmOp_CheckNotZero
                BCC     @LDB7B
                JSR     VmHelper_PushConst_0000
                JSR     LB1EC
                JSR     LB243
                SEC
@LDB7B:         BCS     LDB68
                JSR     LE1F8
                JSR     LB1EC
                JMP     LB243

LDB86:          JSR     LDB18
                JSR     VmOp_ExitFalse
                JSR     LDB0C
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0000
                JSR     LB1EC
                JSR     VmHelper_PushConst_000F
                JSR     LB243
                LDY     #$08
                LDA     #$08
@LDBA2:         STA     $03DC,y
                DEY
                BPL     @LDBA2
                RTS

                LDA     $0474
                JMP     VmOp_PushByte

                JSR     VmOp_PopRegister
                STY     $0474
                RTS

LDBB6:          JSR     LDB36
                JSR     VmOp_ExitFalse
                JSR     LE1F8
                JSR     VmHelper_PushConst_0005
                JSR     VmOp_Compare_Equal
                JSR     VmOp_CheckNotZero
                BCC     LDBEA
LDBCA:          LDA     #$00
                STA     OperatingParty
                STA     $03B5
                LDY     $035A
                LDA     #$01
                STA     $0361
                JSR     SongRequest_09
                JSR     LD5BD
                JSR     LE0ED
                JSR     LDB4B
                JSR     VmHelper_WriteTempAddressWord_0A
LDBE9:          RTS

LDBEA:          BCS     LDBE9
                JSR     LE1F8
                JSR     VmOp_ExitTrue
                LDA     $03CD
                BEQ     LDBE9
                JSR     VmHelper_PushConst_0005
                JSR     LE201
                JSR     VmHelper_PushConst_0001
                JSR     LD944
                JSR     VmHelper_PushConst_0000
                JSR     LD982
                LDA     #$00
                STA     $03FB
                STA     $0361
                JMP     SongRequest_09

LDC14:          JSR     LDB0C
                JSR     VmOp_ExitFalse
                JSR     LDA07
                JSR     VmOp_ExitFalse
                JMP     @LDC23

@LDC23:         LDY     #$81
                JMP     LEA45

LDC28:          JSR     LEF35
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0000
                JSR     LE217
                JSR     LDBB6
                JSR     LE0CE
                JSR     LE101
                JSR     VmHelper_CreateStackFrame_0E
                JSR     LDB4B
                JSR     VmHelper_WriteTempAddressWord_0A
                JSR     LDB86
                JSR     LE24C
                JSR     VmHelper_WriteTempAddressWord_06
                JSR     LDAEE
                JSR     LD5F8
                JSR     LD692
                JSR     LDA10
                JSR     LD929
                JSR     LDADC
                JSR     LDC14
                JSR     VmHelper_ReadTempAddressWord_0A
                JSR     LDB69
                JMP     VmOp_DestroyStackFrame

LDC6D:          JSR     LDCEA
                JMP     LDE9A

LDC73:          JSR     LDC6D
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JMP     LDECC

LDC7F:          JSR     LDC6D
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_ExitFalse
                JMP     LDED7

LDC8B:          JSR     LDC73
                JMP     LDC7F

LDC91:          JSR     LDCEA
                JSR     LDE9A
                JSR     LDF6C
                JSR     VmHelper_PushConst_0010
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JSR     LDCFE
                JSR     LDEAA
                JSR     LDF6C
                JSR     VmHelper_PushConst_0010
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JSR     LDCEA
                JSR     LDEA1
                JSR     LDCFE
                JSR     LDEB1
                JMP     LDEBA

LDCC4:          JSR     LE58F
                JSR     VmOp_ExitFalse
                JSR     LDEBA
                JSR     LDC8B
                JSR     LDCFE
                JSR     LDEAA
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_CheckNotZero
                BCC     @LDCE2
                JSR     LDEEB
                SEC
@LDCE2:         BCS     @LDCE7
                JSR     LDEE2
@LDCE7:         JMP     LDC91

LDCEA:          LDY     $035A
                LDA     $03EE,y
                JMP     VmOp_PushByte

                JSR     VmOp_PopRegister
                TYA
                LDY     $035A
                STA     $03EE,y
                RTS

LDCFE:          LDY     $035A
                LDA     $03F4,y
                JMP     VmOp_PushByte

                JSR     VmOp_PopRegister
                TYA
                LDY     $035A
                STA     $03F4,y
                RTS

LDD12:          JSR     LDFF2
                JSR     LD731
                JSR     VmOp_Asl_03
                JSR     VmOp_Add_AB
                JSR     VmHelper_PushConst_0010
                JMP     VmOp_Compare_AGeatherThanOrEqual

LDD24:          JSR     LD5D2
                JSR     LDD12
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0010
                JMP     VmOp_Sub_BA

LDD33:          JSR     LD5D8
                JSR     LDD12
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0020
                JMP     VmOp_Sub_BA

LDD42:          LDY     #$06
@LDD44:         LDA     $03E2,y
                BNE     @LDD4C
                DEY
                BNE     @LDD44
@LDD4C:         TYA
                ASL     A
                ASL     A
                ASL     A
                ASL     A
                ASL     A
                TAY
                LDA     OamBuffer+39,y
                JMP     VmOp_PushByte

LDD59:          LDY     #$06
@LDD5B:         LDA     $03E2,y
                BNE     @LDD63
                DEY
                BNE     @LDD5B
@LDD63:         TYA
                ASL     A
                ASL     A
                ASL     A
                ASL     A
                ASL     A
                TAY
                LDA     OamBuffer+36,y
                JMP     VmOp_PushByte

LDD70:          JSR     LD731
                JSR     VmOp_CheckNotZero
                BCC     @LDD7F
                JSR     LDD24
                JSR     LDE9A
                SEC
@LDD7F:         BCS     @LDD87
                JSR     LDD42
                JSR     LD5D2
@LDD87:         RTS

LDD88:          JSR     LD731
                JSR     VmOp_CheckNotZero
                BCC     @LDD97
                JSR     LDD33
                JSR     LDEAA
                SEC
@LDD97:         BCS     @LDD9F
                JSR     LDD59
                JSR     LD5D8
@LDD9F:         RTS

LDDA0:          .byte   $02
                .byte   $01
                .byte   $02
                .byte   $03
                .byte   $01
                .byte   $02
                .byte   $03
                .byte   $02
                .byte   $02
                .byte   $02
LDDAA:          .byte   $02
                .byte   $03
                .byte   $01
                .byte   $02
                .byte   $01
                .byte   $03
                .byte   $01
                .byte   $02
                .byte   $02
                .byte   $02

LDDB4:          LDA     OamBuffer+48,x
                CMP     #$20
                BCS     @LDDC0
                LDA     #$00
                STA     $0367,y
@LDDC0:         RTS

LDDC1:          LDA     $038B,y
                BNE     @LDDD3
                LDA     OamBuffer+48,x
                CMP     #$A0
                BCC     @LDDD2
@LDDCD:         LDA     #$00
                STA     $036D,y
@LDDD2:         RTS

@LDDD3:         LDA     OamBuffer+48,x
                CMP     #$88
                BCC     @LDDD2
                BCS     @LDDCD

LDDDC:          LDA     $03A9,y
                BEQ     @LDDF1
                LDA     OamBuffer+48,x
                CLC
                ADC     $03AF,y
                CMP     #$A0
                BCC     @LDDF1
                LDA     #$00
                STA     $03A9,y
@LDDF1:         RTS

                LDA     OamBuffer+36,x
                CMP     #$F0
                BEQ     @LDE63
                LDA     $038B,y
                BNE     @LDE1F
                LDA     #$F0
                STA     OamBuffer+36,x
                JMP     @LDE63

                LDA     OamBuffer+36,x
                CMP     #$F0
                BEQ     @LDE63
                LDA     $03A9,y
                BEQ     @LDE1F
                CLC
                LDA     OamBuffer+36,x
                ADC     $03AF,y
                STA     OamBuffer+36,x
                JMP     @LDE45

@LDE1F:         LDA     $038B,y
                ORA     $03B5,y
                BEQ     @LDE45
                LDA     $0367,y
                BEQ     @LDE36
                SEC
                LDA     OamBuffer+36,x
                SBC     LDDAA,y
                STA     OamBuffer+36,x
@LDE36:         LDA     $036D,y
                BEQ     @LDE45
                CLC
                LDA     OamBuffer+36,x
                ADC     LDDAA,y
                STA     OamBuffer+36,x
@LDE45:         LDA     $0379,y
                BEQ     @LDE54
                SEC
                LDA     OamBuffer+39,x
                SBC     LDDA0,y
                STA     OamBuffer+39,x
@LDE54:         LDA     $0373,y
                BEQ     @LDE63
                CLC
                LDA     OamBuffer+39,x
                ADC     LDDA0,y
                STA     OamBuffer+39,x
@LDE63:         INX
                INX
                INX
                INX
                RTS

LDE68:          TXA
                PHA
                LDA     #$00
                TAY
                TAX
@LDE6E:         JSR     LDDB4
                JSR     LDDC1
                JSR     LDDDC
                TXA
                CLC
                ADC     #$20
                TAX
                INY
                CPY     #$04
                BCC     @LDE6E
                JSR     LEC54
                LDA     $0495
                BNE     @LDE92
                TAY
@LDE8A:         STA     $0385,y
                INY
                CPY     #$04
                BCC     @LDE8A
@LDE92:         LDA     #$00
                STA     $0495
                PLA
                TAX
                RTS

LDE9A:          LDY     #$0F
                LDA     ($66),y
                JMP     VmOp_PushByte

LDEA1:          JSR     VmOp_PopRegister
                TYA
                LDY     #$0F
                STA     ($66),y
                RTS

LDEAA:          LDY     #$0C
                LDA     ($66),y
                JMP     VmOp_PushByte

LDEB1:          JSR     VmOp_PopRegister
                TYA
                LDY     #$0C
                STA     ($66),y
                RTS

LDEBA:          LDY     $035A
                LDA     #$00
                STA     $0367,y
                STA     $036D,y
                STA     $0379,y
                STA     $0373,y
                RTS

LDECC:          LDY     $035A
                LDA     #$01
                STA     $0379,y
                JMP     LD5F2

LDED7:          LDY     $035A
                LDA     #$01
                STA     $0373,y
                JMP     LD5EC

LDEE2:          LDY     $035A
                LDA     #$01
                STA     $036D,y
                RTS

LDEEB:          LDY     $035A
                LDA     #$01
                STA     $0367,y
                RTS

LDEF4:          JSR     LE1F8
                JSR     VmHelper_PushConst_0004
                JMP     VmOp_Compare_AGeatherThanOrEqual

LDEFD:          LDA     FieldTime-1
                JMP     VmOp_PushByte

LDF03:          JSR     VmOp_PopRegister
                STY     FieldTime-1
                RTS

LDF0A:          LDY     $035A
                LDA     $046A,y
                BEQ     @LDF1A
                LDA     #$00
                STA     $046A,y
                JMP     LDF2A

@LDF1A:         RTS

LDF1B:          JSR     LD74F
                LDA     HelperParty
                JSR     VmOp_PushByte
                JSR     VmOp_Or
                JSR     VmOp_ExitFalse
LDF2A:          JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmOp_ExitFalse
                JSR     SongRequest_06
                JSR     VmHelper_PushConst_0003
                JSR     VmHelper_WriteTempAddressWord_06
                JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmOp_Decrement
                JSR     VmHelper_WriteTempAddressWord_0A
                JMP     LD9FE

LDF45:          JSR     LD74F
                JSR     VmOp_ExitTrue
                JSR     VmHelper_PushConst_0001
                JSR     LDF03
                LDY     OperatingParty
                LDA     PartyLifes,y
                BEQ     @LDF5F
                SEC
                SBC     #$01
                STA     PartyLifes,y
@LDF5F:         RTS

LDF60:          JSR     LDEF4
                JSR     VmOp_ExitTrue
                JSR     LDF1B
                JMP     LDF45

LDF6C:          JSR     VmOp_Sub_BA
                JMP     L97CE

LDF72:          JSR     LDF0A
                JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmOp_ExitFalse
                JSR     LDD70
                JSR     LDF6C
                JSR     VmHelper_PushConst_000F
                JSR     VmOp_Compare_AGeatherThan
                JSR     LDD88
                JSR     LDF6C
                JSR     VmHelper_PushConst_000F
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_And
                JSR     VmOp_ExitFalse
                JSR     LDF60
LDF9C:          JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmOp_ExitFalse
                LDA     $035A
                CMP     #$01
                BEQ     @LDFE2
                LDA     HelperParty
                CMP     #$06
                BCS     @LDFE2
                LDA     OamBuffer+80
                JSR     VmOp_PushByte
                JSR     LDEAA
                JSR     LDF6C
                JSR     VmHelper_PushConst_000F
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                LDA     OamBuffer+83
                JSR     VmOp_PushByte
                JSR     LDE9A
                JSR     LDF6C
                JSR     VmHelper_PushConst_000F
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JSR     LDF2A
                LDA     #$01
                STA     $046B
@LDFE2:         RTS

LDFE3:          LDY     $035A
                LDA     $035B,y
                CLC
                ADC     #$01
                AND     #$3F
                STA     $035B,y
                RTS

LDFF2:          LDY     $035A
                LDA     $035B,y
                JMP     VmOp_PushByte

LDFFB:          JSR     LDD88
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JSR     LD979
                JSR     LD93B
                JSR     VmOp_Or
                JSR     VmOp_CheckNotZero
                BCC     @LE016
                JSR     LDEEB
                SEC
@LE016:         BCS     @LE01E
                JSR     VmHelper_PushConst_0001
                JSR     LDA52
@LE01E:         RTS

LE01F:          JSR     LDD88
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_ExitFalse
                JSR     LD93B
                JSR     VmOp_CheckNotZero
                BCC     @LE034
                JSR     LDEE2
                SEC
@LE034:         BCS     @LE056
                JSR     LD979
                JSR     VmOp_ExitFalse
                JSR     LD5D8
                JSR     VmHelper_PushConst_0040
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_CheckNotZero
                BCC     @LE04E
                JSR     LDEE2
                SEC
@LE04E:         BCS     @LE056
                JSR     VmHelper_PushConst_0001
                JSR     LDA52
@LE056:         RTS

LE057:          JSR     LDF6C
                JSR     VmHelper_PushConst_0020
                JMP     VmOp_Compare_AGeatherThan

LE060:          JSR     LE58F
                JSR     VmOp_ExitFalse
                JMP     LDEBA

LE069:          JSR     LE060
                JSR     LE58F
                JSR     VmOp_ExitTrue
                JSR     LDEF4
                JSR     LDD70
                JSR     LE057
                JSR     LDD88
                JSR     LE057
                JSR     VmOp_And
                JSR     VmOp_And
                JSR     VmOp_ExitTrue
                JSR     LDFF2
                JSR     LD731
                JSR     VmOp_Add_AB
                JSR     VmHelper_PushConst_000F
                JSR     VmOp_And
                JSR     VmHelper_PushConst_0003
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmOp_ExitFalse
                JSR     LDEBA
                JSR     LDD70
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_CheckNotZero
                BCC     @LE0B9
                JSR     LDECC
@LE0B9:         JSR     LDD70
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_CheckNotZero
                BCC     @LE0C7
                JSR     LDED7
@LE0C7:         JSR     LDFFB
                JSR     LE01F
                RTS

LE0CE:          LDA     $035A
                ASL     A
                ASL     A
                ASL     A
                ASL     A
                ASL     A
                CLC
                ADC     #$24
                STA     $66
                LDA     #$00
                ADC     #$02
                STA     $67
                RTS

                LDY     #$05
                LDA     #$00
@LE0E6:         STA     $0361,y
                DEY
                BPL     @LE0E6
                RTS

LE0ED:          JSR     VmOp_Duplicate
                JSR     LD6F9
                JMP     LD713

LE0F6:          LDY     #$05
                LDA     #$00
@LE0FA:         STA     $0361,y
                DEY
                BPL     @LE0FA
                RTS

LE101:          LDY     $035A
                LDA     $0361,y
                BNE     @LE158
                LDA     #$01
                STA     $0361,y
                LDA     $035A
                BEQ     @LE11F
                JSR     VmHelper_PushConst_0080
                JSR     LDEA1
                JSR     VmHelper_PushConst_0040
                JSR     LDEB1
@LE11F:         LDY     $035A
                LDA     OperatingParty,y
                CMP     #$05
                BCS     @LE12E
                LDA     #$00
                STA     $03B5,y
@LE12E:         JSR     LD5BD
                JSR     LE0ED
                JSR     LD731
                JSR     VmOp_ExitTrue
                JSR     LE1F8
                JSR     VmHelper_PushConst_0005
                JSR     VmOp_Compare_Equal
                JSR     VmOp_ExitTrue
                JSR     LD749
                JSR     LE0ED
                JSR     VmHelper_PushConst_0020
                JSR     LD5DE
                JSR     VmHelper_PushConst_0020
                JMP     LD5E5

@LE158:         RTS

LE159:          LDA     $67
                LDY     $66
                JMP     VmOp_PushRegister

                JSR     VmOp_PopRegister
                STA     $67
                STY     $66
                RTS

LE168:          LDA     #$81
                LDY     $035A
                STA     $03C1,y
                RTS

LE171:          LDA     #$01
                LDY     $035A
                STA     $03C1,y
                RTS

LE17A:          LDA     #$00
                LDY     $035A
                STA     $03C1,y
                RTS

                JSR     LDD70
                JSR     LDF6C
                JSR     VmHelper_PushConst_0020
                JSR     VmOp_Compare_BGeatherThan
                JSR     LDD88
                JSR     LDF6C
                JSR     VmHelper_PushConst_0020
                JSR     VmOp_Compare_AGeatherThan
                JMP     VmOp_And

LE19E:          LDY     #$06
                LDA     #$00
@LE1A2:         STA     $03C1,y
                DEY
                BPL     @LE1A2
                RTS

LE1A9:          LDY     $035A
                LDA     $03C1,y
                BEQ     @LE1B5
                TAY
                JMP     LEA45

@LE1B5:         RTS

LE1B6:          JSR     LD6E6
                JSR     LD5BD
                JSR     VmOp_Compare_Equal
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0003
                JMP     VmHelper_WriteTempAddressWord_06

LE1C8:          JSR     LDEF4
                JSR     VmOp_CheckNotZero
                BCC     @LE1DA
                JSR     LE1F8
                JSR     LB1EC
                JSR     LB24E
                SEC
@LE1DA:         BCS     @LE1DF
                JSR     LE21E
@LE1DF:         RTS

LE1E0:          JSR     LDEF4
                JSR     VmOp_CheckNotZero
                BCC     @LE1F2
                JSR     LE1F8
                JSR     LB1EC
                JSR     LB243
                SEC
@LE1F2:         BCS     @LE1F7
                JSR     LE227
@LE1F7:         RTS

LE1F8:          LDY     $035A
                LDA     OperatingParty,y
                JMP     VmOp_PushByte

LE201:          JSR     VmOp_PopRegister
                TYA
                LDY     $035A
                STA     OperatingParty,y
                RTS

LE20C:          LDY     #$05
                LDA     #$00
@LE210:         STA     OperatingParty,y
                DEY
                BPL     @LE210
                RTS

LE217:          JSR     VmOp_PopRegister
                STY     $035A
                RTS

LE21E:          LDY     $035A
                LDA     $03DC,y
                JMP     VmOp_PushByte

LE227:          JSR     VmOp_PopRegister
                TYA
                LDY     $035A
                STA     $03DC,y
                RTS

LE232:          LDY     $035A
                LDA     $03E2,y
                JMP     VmOp_PushByte

LE23B:          JSR     VmOp_PopRegister
                TYA
                LDY     $035A
                STA     $03E2,y
                RTS

LE246:          .byte   $00
                .byte   $01
                .byte   $01
                .byte   $01
                .byte   $01
                .byte   $00

LE24C:          LDY     $035A
                CPY     #$02
                BCS     @LE261
                LDA     OperatingParty,y
                CMP     #$06
                BCS     @LE261
                TAY
                LDA     LE246,y
                JMP     VmOp_PushByte

@LE261:         LDY     $035A
                LDA     $03E8,y
                JMP     VmOp_PushByte

LE26A:          JSR     VmOp_PopRegister
                TYA
                LDY     $035A
                STA     $03E8,y
                RTS

LE275:          JSR     LD731
                JSR     VmHelper_PushConst_0001
                JSR     VmOp_Compare_Equal
                JSR     LEF3B
                JSR     VmHelper_PushConst_0000
                JSR     VmOp_Compare_Equal
                JSR     VmOp_And
                JSR     VmOp_ExitTrue
                JSR     LE0CE
                JSR     LDFE3
                JSR     VmHelper_CreateStackFrame_0C
                JSR     LE24C
                JSR     VmHelper_WriteTempAddressWord_06
                JSR     LE1B6
                JSR     LE1C8
                JSR     VmHelper_WriteTempAddressWord_0A
                JSR     LE159
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     LD5F8
                JSR     LE069
                JSR     LDCC4
                JSR     LDF72
                JSR     LDF9C
                JSR     LDADC
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmHelper_ReadTempAddressWord_04
                JSR     VmHelper_ReadTempAddressWord_06
                JSR     VmHelper_ReadTempAddressWord_08
                JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmHelper_ReadTempAddressWord_0C
                LDA     #$01
                STA     $0495
                STA     $0496
                JMP     VmOp_DestroyStackFrame

LE2DA:          LDA     $0496
                BNE     @LE2E0
                RTS

@LE2E0:         LDA     #$00
                STA     $0496
                JSR     LE0CE
                JSR     LE101
                JSR     VmHelper_CreateStackFrame_0C
                JSR     VmHelper_WriteTempAddressWord_0C
                JSR     VmHelper_WriteTempAddressWord_0A
                JSR     VmHelper_WriteTempAddressWord_08
                JSR     VmHelper_WriteTempAddressWord_06
                JSR     VmHelper_WriteTempAddressWord_04
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     LDA10
                JSR     LE1A9
                JSR     LD929
                JSR     VmHelper_ReadTempAddressWord_0A
                JSR     LE1E0
                JMP     VmOp_DestroyStackFrame

                LDA     #$31
                JMP     VmOp_PushByte

                LDA     #$33
                JMP     VmOp_PushByte

LE31C:          LDA     ChrBankRequest
                JMP     VmOp_PushByte

LE321:          JSR     LE217
                JSR     LE232
                JSR     VmOp_ExitFalse
                JMP     LE275

LE32D:          JSR     LE217
                JSR     LE232
                JSR     VmOp_ExitFalse
                JMP     LE2DA

LE339:          JSR     VmHelper_PushConst_0001
                JMP     LE321

LE33F:          JSR     VmHelper_PushConst_0001
                JMP     LE32D

LE345:          JSR     VmHelper_PushConst_0002
                JMP     LE321

LE34B:          JSR     VmHelper_PushConst_0002
                JMP     LE32D

LE351:          JSR     VmHelper_PushConst_0003
                JMP     LE321

LE357:          JSR     VmHelper_PushConst_0003
                JMP     LE32D

                LDA     RleExpandIndex
                JMP     VmOp_PushByte

LE362:          JSR     VmOp_PopRegister
                STY     RleExpandIndex
                RTS

LE368:          LDY     #$05
@LE36A:         LDA     $03E2,y
                BNE     @LE375
                DEY
                BNE     @LE36A
@LE372:         JMP     VmHelper_PushConst_0001

@LE375:         LDA     OperatingParty,y
                CMP     #$05
                BCC     @LE372
                JMP     VmHelper_PushConst_0000

LE37F:          JSR     LE217
                JSR     LE201
                JSR     LE227
                JSR     LE26A
                JSR     VmHelper_PushConst_0001
                JMP     LE23B

LE391:          .byte   $A0
                .byte   $CA
                .byte   $00
                .byte   $80
LE395:          .byte   $A0
                .byte   $CC
                .byte   $01
                .byte   $90
LE399:          .byte   $90
                .byte   $9C
                .byte   $01
                .byte   $D0
                .byte   $A0
                .byte   $9E
                .byte   $01
                .byte   $D0
                .byte   $90
                .byte   $A0
                .byte   $01
                .byte   $D8
                .byte   $A0
                .byte   $A2
                .byte   $01
                .byte   $D8
LE3A9:          .byte   $90
                .byte   $E2
                .byte   $01
                .byte   $D0
                .byte   $A0
                .byte   $E4
                .byte   $01
                .byte   $D0
                .byte   $90
                .byte   $E6
                .byte   $01
                .byte   $D8
                .byte   $A0
                .byte   $E8
                .byte   $01
                .byte   $D8

LE3B9:          LDY     #$03
@LE3BB:         LDA     LE391,y
                STA     OamBuffer+4,y
                DEY
                BPL     @LE3BB
                RTS

LE3C5:          LDY     #$03
@LE3C7:         LDA     LE395,y
                STA     OamBuffer+8,y
                DEY
                BPL     @LE3C7
                RTS

LE3D1:          LDY     #$0F
@LE3D3:         LDA     LE3A9,y
                STA     OamBuffer+12,y
                DEY
                BPL     @LE3D3
                RTS

LE3DD:          LDY     #$0F
@LE3DF:         LDA     LE399,y
                STA     OamBuffer+12,y
                DEY
                BPL     @LE3DF
                RTS

LE3E9:          LDY     #$1F
                LDA     #$F0
@LE3ED:         STA     OamBuffer+4,y
                DEY
                BPL     @LE3ED
                LDA     $0482
                BEQ     @LE3FB
                JSR     LE3D1
@LE3FB:         LDA     $0483
                BEQ     @LE403
                JSR     LE3DD
@LE403:         RTS

LE404:          LDA     #$F0
                STA     OamBuffer+4
                RTS

LE40A:          LDA     #$F0
                STA     OamBuffer+8
                RTS

                LDA     #$F0
                STA     OamBuffer+12
                STA     OamBuffer+16
                RTS

LE419:          LDA     $0470
                JMP     VmOp_PushByte

LE41F:          LDA     #$01
                STA     $0470
                RTS

LE425:          LDA     #$00
                STA     $0470
                RTS

LE42B:          LDA     $0471
                JMP     VmOp_PushByte

LE431:          LDA     #$01
                STA     $0471
                RTS

LE437:          LDA     #$00
                STA     $0471
@LE43C:         RTS

                LDA     $0480
                BEQ     @LE448
                JSR     VmHelper_PushConst_0003
                JMP     LB3A9

@LE448:         LDA     $0481
                BEQ     @LE43C
                JSR     VmHelper_PushConst_0002
                JMP     LB3A9

LE453:          JSR     VmHelper_PushConst_0005
                JMP     LB3A9

LE459:          JSR     VmHelper_PushConst_0006
                JMP     LB3A9

LE45F:          JSR     LE419
                JSR     VmOp_ExitFalse
                JSR     LE3C5
                JSR     LD5D2
                JSR     VmHelper_PushConst_0090
                JSR     LDF6C
                JSR     VmHelper_PushConst_0008
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JSR     LD5D8
                JSR     VmHelper_PushConst_0090
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_ExitFalse
                JSR     SongRequest_0E
                JSR     LE459
                JSR     LE425
                JMP     LE40A

LE492:          JSR     LE42B
                JSR     VmOp_ExitFalse
                JSR     LE3B9
                JSR     LD5D2
                JSR     VmHelper_PushConst_0080
                JSR     LDF6C
                JSR     VmHelper_PushConst_0008
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JSR     LD5D8
                JSR     VmHelper_PushConst_0090
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_ExitFalse
                JSR     SongRequest_0E
                JSR     LE453
                JSR     LE437
                JMP     LE404

LE4C5:          LDA     $0482
                ORA     $0483
                JMP     VmOp_PushByte

LE4CE:          LDA     #$00
                STA     $0482
                STA     $0483
                RTS

LE4D7:          JSR     LE4C5
                JSR     VmOp_ExitFalse
                JSR     LE3E9
                JSR     VmHelper_PushConst_00D0
                JSR     LD5D2
                JSR     LDF6C
                JSR     VmHelper_PushConst_0008
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JSR     LE4CE
                JSR     VmHelper_PushConst_0001
                JSR     LE70E
                JSR     LE4CE
                RTS

LE4FF:          JSR     LE4D7
                JSR     LE45F
                JMP     LE492

LE508:          LDA     #$8A
                STA     OamBuffer+165
                STA     OamBuffer+181
                STA     OamBuffer+197
                STA     OamBuffer+213
                LDA     #$88
                STA     OamBuffer+169
                STA     OamBuffer+185
                STA     OamBuffer+201
                STA     OamBuffer+217
                LDA     #$86
                STA     OamBuffer+173
                STA     OamBuffer+189
                STA     OamBuffer+205
                STA     OamBuffer+221
                RTS

DisablePpuMask_BGDisable:
                LDA     #$00
                BEQ     WriteDisablePpuMask_BGEnable

DisablePpuMask_BGEnable:
                LDA     #$01
WriteDisablePpuMask_BGEnable:
                STA     PpuMaskBuffer_Bit3_ShowBG       ;BG enable
                JMP     SetPpuMask

LE53E:          LDY     RleExpandIndex
                LDA     LA02A,y
                JMP     VmOp_PushByte

LE546:          LDA     $D0
                JMP     VmOp_PushByte

LE54B:          JSR     VmOp_PopRegister
                STY     $D0
                RTS

LE551:          JSR     LE53E
                JSR     VmOp_ExitFalse
                JSR     LE546
                JSR     VmOp_Increment
                JSR     LE54B
                JSR     LE546
                JSR     VmHelper_PushConst_0003
                JSR     VmOp_And
                JSR     VmOp_ExitTrue
                JSR     VmHelper_PushScreenX
                JSR     VmHelper_PushConst_0100
                JSR     VmOp_Add_AB
                JSR     VmHelper_PopScreenX
                JSR     SetDisplayScreenPosition
                LDA     RleExpandIndex
                CMP     #$04
                BNE     @LE58E
                INC     $0499
                LDA     $0499
                AND     #$03
                BNE     @LE58E
                JSR     SongRequest_0F
@LE58E:         RTS

LE58F:          LDA     $03FA
                JMP     VmOp_PushByte

LE595:          JSR     VmOp_PopRegister
                STY     $03FA
LE59B:          RTS

LE59C:          LDA     RleExpandIndex
                CMP     #$0C
                BNE     LE59B
                JSR     VmHelper_PushConst_0000
                JSR     LE595
                LDA     $0493
                BNE     @LE5BA
                LDA     RleExpandIndex
                PHA
                LDA     #$10
                STA     RleExpandIndex
                JSR     LB014
                PLA
                STA     RleExpandIndex
@LE5BA:         JSR     LE53E
                JSR     VmHelper_PushConst_0004
                JSR     VmOp_Compare_Equal
                JSR     VmOp_ExitFalse
                JSR     LE546
                LDA     #$7F
                JSR     VmOp_PushByte
                JSR     VmOp_And
                JSR     VmHelper_PushConst_0030
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                LDA     $0493
                BNE     @LE5E2
                JSR     LB014
@LE5E2:         JSR     VmHelper_PushConst_0001
                JMP     LE595

LE5E8:          JSR     VmHelper_PushScreenX
                JSR     VmOp_DecrementTwice
                JMP     VmHelper_PopScreenX

LE5F1:          JSR     VmHelper_PushScreenX
                JSR     VmOp_AddConst_02
                JMP     VmHelper_PopScreenX

LE5FA:          JSR     VmOp_ExitFalse
                JSR     VmHelper_ReadTempAddressWord_06
                JSR     VmHelper_PushConst_00D0
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JMP     LE5E8

LE60C:          JSR     VmOp_ExitTrue
                JSR     VmHelper_PushConst_0040
                JSR     VmHelper_ReadTempAddressWord_06
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JMP     LE5F1

LE61E:          JSR     VmHelper_PushConst_0080
                JSR     VmHelper_PushScreenX
                JSR     VmOp_Sub_BA
                JSR     VmHelper_PushConst_00FF
                JSR     VmOp_And
                JSR     VmHelper_WriteTempAddressWord_06
                JSR     VmHelper_ReadTempAddressWord_06
                JSR     LD5D2
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_Duplicate
                JSR     LE5FA
                JSR     LE60C
                NOP
                RTS

LE644:          JSR     LE53E
                JSR     VmHelper_PushConst_0001
                JSR     VmOp_Compare_Equal
                JSR     VmOp_ExitFalse
                JMP     LE5F1

LE653:          JSR     LE53E
                JSR     VmHelper_PushConst_0002
                JSR     VmOp_Compare_BGeatherThanOrEqual
                JSR     VmOp_ExitFalse
                JSR     LE8E8
                JSR     LE53E
                JSR     VmHelper_PushConst_0004
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JSR     VmHelper_CreateStackFrame_06
                JSR     LE61E
                JMP     VmOp_DestroyStackFrame

LE677:          JSR     LE653
                JSR     LE551
                JMP     LE59C

LE680:          JSR     LAF7C
                JSR     SetOamDmaRequest
                JMP     LE644

LE689:          LDA     PadBuffer_Trigger_Select
                JSR     VmOp_PushByte
                JSR     VmOp_ExitFalse
                JSR     LD60A
                LDA     #$01
                STA     $0473
                JSR     DisableApuChannel
@LE69D:         JSR     ReadJoypad
                JSR     LE7BE
                LDA     PadBuffer_Trigger_Select
                BEQ     @LE69D
                LDA     #$00
                STA     $0473
                JMP     EnableApuChannel

Fight_MainLoop: JSR     LE7BE
                JSR     ReadJoypad
                JSR     LE689
                JSR     LEE9A
                JSR     LE7BE
                JSR     LDC28
                JSR     LE7BE
                JSR     LE339
                LDA     #$00
                STA     $0484
                JSR     LE7BE
                JSR     LE33F
                JSR     LE7BE
                JSR     LE345
                JSR     LE7BE
                JSR     LE34B
                JSR     LE7BE
                JSR     LE351
                JSR     LE7BE
                JSR     LE357
                JSR     LE7BE
                JSR     LE677
                JSR     LB590
                JSR     LE7BE
                JSR     LB5BD
                JSR     LE4FF
                JSR     LE721
                LDA     $03FE
                BEQ     Fight_MainLoop
                JMP     LE7D1

LE708:          LDA     $03FE
                JMP     VmOp_PushByte

LE70E:          JSR     VmOp_PopRegister
                STY     $03FE
                RTS

                LDA     $045D
                JSR     VmOp_PushByte
                JSR     VmHelper_PushConst_0000
                JMP     VmOp_Compare_Equal

LE721:          JSR     @LE727
                JMP     @LE733

@LE727:         JSR     IsAnnihilation
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0001
                JMP     LE70E

@LE733:         JSR     LE368
                JSR     VmOp_ExitFalse
                LDA     $045D
                JSR     VmOp_PushByte
                JSR     VmOp_ExitTrue
                JSR     LDB00
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0001
                JMP     LE70E

LE74E:          LDY     #$07
                LDA     #$00
@LE752:         STA     $03A9,y
                DEY
                BPL     @LE752
                RTS

LE759:          LDY     #$03
                LDA     #$00
@LE75D:         STA     $0455,y
                DEY
                BPL     @LE75D
                RTS

                JSR     LDB3C
                JSR     VmOp_ExitFalse
LE76A:          JSR     DisableApuChannel
                JSR     LEE39
                LDA     #$01
                STA     $0484
                JSR     LE759
                JSR     DisablePpuMask_BGDisable
                JSR     HideNormalSprites
                JSR     LB034
                LDY     #$04
                LDA     #$00
@LE785:         STA     $0475,y
                DEY
                BPL     @LE785
                JSR     SetOamDmaRequest
                JSR     LE74E
                JSR     WaitNmiRaised
                JSR     LE0F6
                JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PopScreenY
                JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PopScreenX
                JSR     VmHelper_PushConst_0000
                JSR     LE70E
                JSR     LAF9A
                JSR     WaitNmiRaised
                JSR     LB13B
                JSR     DisablePpuMask_BGEnable
                JSR     LE508
                JSR     EnableApuChannel
                JMP     Fight_MainLoop

LE7BE:          JSR     SetOamDmaRequest
                JSR     LB04F
                JSR     WaitNmiFinish
                LDY     RleExpandIndex
                LDA     BankNumberTable,y
                STA     ChrBankRequest
                JMP     LE680

LE7D1:          LDA     #$01
                STA     $04DA
                JSR     DisableApuChannel
                JSR     LE425
                JSR     LE40A
                JSR     LE437
                JSR     LE404
                JSR     LE20C
                JSR     LE19E
                JSR     LD96E
                JSR     LD94F
                JSR     HideNormalSprites
                JSR     WaitNmiRaised
                JSR     LE856
                LDA     #$01
                STA     $0484
                JSR     DisablePpuMask_BGDisable
                JSR     SetZeroSprite
                JSR     SetOamDmaRequest
                JSR     WaitNmiRaised
                LDA     #$00
                STA     $0498
                STA     RleExpandIndex
                JSR     LBAD5
                JSR     LBAD5
                JSR     LBAD5
                JSR     LB014
                JSR     WaitNmiRaised
                LDA     #$02
                JSR     SongRequest
                JSR     LB1A8
                JSR     SetOamDmaRequest
                JSR     WaitNmiRaised
                JSR     LD98D
                JSR     @LE841
                JSR     LEE0A
                JSR     DisablePpuMask_BGEnable
                LDA     #$00
                STA     $04DA
                RTS

@LE841:         LDY     #$05
                LDA     #$00
@LE845:         STA     $03E2,y
                DEY
                BPL     @LE845
                LDA     #$00
                STA     OperatingParty
                RTS

LE851:          TXA
                PHA
                JMP     LE879

LE856:          LDA     DrawTextRequest
                BNE     @Accept
                RTS

@Accept:        TXA
                PHA
                LDA     #$01                            ;Set flag
                STA     $0484
                JSR     HideNormalSprites
                JSR     SetOamDmaRequest
                JSR     WaitNmiRaised
                JSR     PlaySubSequence
                LDA     #$00
                STA     DrawTextRequest
                LDA     #$0E
                STA     RleExpandIndex
                JSR     LAF9A
LE879:          LDY     #$00
                LDA     #$03
@LE87D:         STA     $0401,y
                INY
                CPY     #$40
                BNE     @LE87D
                LDY     #$00
@LE887:         LDA     (DrawTextPointer),y
                INY
                CMP     #$2A
                BNE     @LE887
                TYA
                LSR     A
                EOR     #$FF
                SEC
                ADC     #$10
                TAX
                LDY     #$FF
@LE898:         INX
                INY
                LDA     (DrawTextPointer),y
                CLC
                ADC     #$80
                STA     $0401,x
                CMP     #$AA
                BNE     @LE898
                LDA     #$03
                STA     $0401,x
                LDA     #$04
                STA     $63
                LDA     #$01
                STA     $62
                LDA     #$00
                STA     ScreenX
                STA     ScreenX+1
                STA     ScreenY
                STA     ScreenY+1
                LDA     #$33                            ;Bank #3
                STA     ChrBankRequest
                LDA     #$06
                STA     $55
                LDA     #$00
                STA     $54
                JSR     LB614
                LDA     #$00
                STA     $0484                           ;Clear flag
                JSR     VmHelper_PushConst_00F0
                JSR     VmHelper_PushConst_0000
                JSR     L9601
@LE8DA:         JSR     WaitNmiRaised
                JSR     PlaySubSequence
                JSR     L9620
                BCC     @LE8DA
                PLA
                TAX
                RTS

LE8E8:          TXA
                PHA
                LDA     $045C
                BNE     @LE90C
                LDY     #$03
@LE8F1:         LDA     OperatingParty,y
                STA     $0464,y
                LDA     $03DC,y
                STA     $045E,y
                DEY
                BNE     @LE8F1
                LDA     #$01
                STA     $045C
                LDA     #$40
                STA     $045D
                BNE     @LE93C

@LE90C:         LDA     $0493
                BEQ     @LE919
                JSR     LB014
                LDA     #$00
                STA     $0493
@LE919:         LDA     #$70
                SEC
                SBC     ScreenX
                SEC
                SBC     OamBuffer+51
                STA     $045B
                LDY     RleExpandIndex
                LDA     LA02A,y
                AND     #$04
                STA     ContinuePasswordPressA
                BNE     @LE942
                LDA     OamBuffer+48
                CMP     #$80
                BCS     @LE94F
                CMP     #$20
                BCC     @LE960
@LE93C:         JSR     @LE9BF
@LE93F:         PLA
                TAX
                RTS

@LE942:         LDA     OamBuffer+48
                CMP     #$40
                BCS     @LE93F
                CMP     #$20
                BCC     @LE93F
                BCS     @LE960

@LE94F:         LDA     $045B
                BMI     @LE95A
                CMP     #$20
                BCC     @LE9A9
                BCS     @LE93C

@LE95A:         CMP     #$E0
                BCS     @LE9A9
                BCC     @LE93C

@LE960:         LDA     $045B
                BMI     @LE96B
                CMP     #$08
                BCS     @LE93C
                BCC     @LE96F

@LE96B:         CMP     #$F8
                BCC     @LE93C
@LE96F:         LDA     $045D
                BEQ     @LE9AF
                LDA     ContinuePasswordPressA
                BEQ     @LE97E
                LDA     $03FA
                BEQ     @LE93C
@LE97E:         LDA     $03FB
                BEQ     @LE93C
                LDA     $0493
                BNE     @LE93C
                DEC     $045D
                LDA     #$06
                JSR     SongRequest
                LDA     RleExpandIndex
                STA     $0494
                LDA     #$0F
                STA     RleExpandIndex
                JSR     LB014
                LDA     $0494
                STA     RleExpandIndex
                LDA     #$01
                STA     $0493
                JMP     @LE93C

@LE9A9:         JSR     LDF45
                JMP     @LE93C

@LE9AF:         LDA     #$00
                LDY     #$06
@LE9B3:         STA     $03DC,y
                STA     $03E2,y
                DEY
                BNE     @LE9B3
                JMP     @LE93F

@LE9BF:         LDA     ContinuePasswordPressA
                BNE     @LE9E7
                LDY     #$03
@LE9C6:         LDA     $03DC,y
                ORA     $03E2,y
                BNE     @LE9E4
                LDA     #$00
                STA     $0361,y
                LDA     #$01
                STA     $03E2,y
                LDA     $0464,y
                STA     OperatingParty,y
                LDA     $045E,y
                STA     $03DC,y
@LE9E4:         DEY
                BNE     @LE9C6
@LE9E7:         RTS

CheckExitTitleScreen:
                JSR     ReadJoypad
                LDA     PadBuffer_Now_Start             ;Check if start button is pressed
                BNE     @StartPressed
                LDA     PadBuffer_Now_A                 ;Check A button press down
                CMP     ContinuePasswordPressA          ;Compare with previous input
                BEQ     @Return
                STA     ContinuePasswordPressA          ;Update previous input
                LSR     A
                BCC     @Return                         ;Not press
                LDA     ContinuePasswordInput
                ASL     A
                ADC     PadBuffer_Now_B                 ;Shift in B button input to password buffer
                AND     #$0F                            ;Recent 4 inputs
                STA     ContinuePasswordInput
@Return:        CLC                                     ;Return false (continue title screen)
                RTS

@StartPressed:  LDA     #$01                            ;Party in when continue
                STA     PartyIn_Chohakkai
                STA     PartyIn_Sagojo
                LDY     ContinuePasswordInput
                LDA     ContinueFieldXPageList,y
                BNE     @InvalidEntry
                STA     PartyIn_Chohakkai               ;Cancel party in (start from the beginning)
                STA     PartyIn_Sagojo
                LDA     #$1E                            ;Start field X page
                LDY     #$10                            ;Start field Y page
@InvalidEntry:  PHA
                TYA
                JSR     VmOp_PushByte                   ;Push field Y page
                PLA
                JSR     VmOp_PushByte                   ;Push field X page
                SEC                                     ;Return true (continue next screen)
                RTS

ContinueFieldXPageList:
                .byte   $00
                .byte   $14                             ;($14, $01)          AB : Gobi Desert
                .byte   $00
                .byte   $1A                             ;($1A, $03)       AB AB : Luoyang
                .byte   $06                             ;($06, $04)    AB A  A  : Taklimakan Desert
                .byte   $00
                .byte   $00
                .byte   $11                             ;($11, $07)    AB AB AB : Choshu
                .byte   $00
                .byte   $0E                             ;($0E, $09) AB A  A  AB : House
                .byte   $1A                             ;($1A, $0A) AB A  AB A  : (No building)
                .byte   $05                             ;($05, $0B) AB A  AB AB : House
                .byte   $00
                .byte   $18                             ;($18, $0D) AB AB A  AB : Henan
                .byte   $10                             ;($10, $0E) AB AB AB A  : Chengdu
                .byte   $00
LEA41:          .byte   $B0
                .byte   $B2
                .byte   $82
                .byte   $B2

LEA45:          TXA
                PHA
                TYA
                PHA
                ROR     A
                BCC     @LEA92
                LDX     $035A
                LDA     $0455,x
                BNE     @LEA92
                JSR     LEB96
                PLA
                PHA
                EOR     #$80
                ASL     A
                LDA     #$0C
                ADC     #$00
                STX     ContinuePasswordPressA
                STY     $045B
                JSR     SongRequest                     ;#12 or #13
                LDX     ContinuePasswordPressA
                LDY     $045B
                LDA     OamBuffer+48,y
                SEC
                SBC     #$04
                STA     OamBuffer+64,y
                LDA     OamBuffer+51,y
                STA     OamBuffer+67,y
                LDA     OamBuffer+50,y
                AND     #$40
                STA     OamBuffer+66,y
                PLA
                PHA
                AND     #$80
                ORA     OamBuffer+66,y
                ORA     #$01
                STA     $0455,x
@LEA92:         PLA
                LDX     #$03
@LEA95:         JSR     LEB96
                LDA     $0455,x
                BNE     @LEAA0
                JMP     @LEB8D

@LEAA0:         ASL     A
                BPL     @LEAAE
                LDA     OamBuffer+67,y
                SEC
                SBC     #$08
                BCS     @LEAB9
                JMP     @LEB8A

@LEAAE:         LDA     OamBuffer+67,y
                CLC
                ADC     #$08
                BCC     @LEAB9
                JMP     @LEB8A

@LEAB9:         STA     OamBuffer+67,y
                LDA     $0455,x
                BMI     @LEAC8
                LDA     #$DF
                STA     OamBuffer+65,y
                BNE     @LEADC

@LEAC8:         LDA     OamBuffer+67,y
                LSR     A
                LSR     A
                AND     #$03
                STX     $0451
                TAX
                LDA     LEA41,x
                STA     OamBuffer+65,y
                LDX     $0451
@LEADC:         TXA
                BNE     @LEAE2
                JMP     @LEB41

@LEAE2:         LDA     OamBuffer+67,y
                STA     $C3
                LDA     OamBuffer+51
                STA     $C5
                LDA     OamBuffer+64,y
                STA     $C4
                LDA     OamBuffer+48
                STA     $C6
                JSR     LEBB2
                BCC     @LEB16
                STX     ContinuePasswordPressA
                STY     $045B
                PLA
                TAX
                JSR     LDF45
                TXA
                PHA
                LDA     #$08
                JSR     SongRequest
                LDX     ContinuePasswordPressA
                LDY     $045B
                JMP     @LEB8A

@LEB16:         LDA     HelperParty
                CMP     #$05
                BCC     @LEB20
                JMP     @LEB8D

@LEB20:         LDA     OamBuffer+67,y
                STA     $C3
                LDA     OamBuffer+83
                STA     $C5
                LDA     OamBuffer+64,y
                STA     $C4
                LDA     OamBuffer+80
                STA     $C6
                JSR     LEBB2
                BCC     @LEB8D
                LDA     #$01
                STA     $046B
                JMP     @LEB8A

@LEB41:         STX     ContinuePasswordPressA
                STY     $045B
                LDX     #$03
@LEB49:         LDA     $0455
                BEQ     @LEB81
                LDA     $03E2,x
                BEQ     @LEB7E
                JSR     LEB96
                LDA     OamBuffer+67
                STA     $C3
                LDA     OamBuffer+51,y
                STA     $C5
                LDA     OamBuffer+64
                STA     $C4
                LDA     OamBuffer+48,y
                STA     $C6
                JSR     LEBB2
                BCC     @LEB7E
                LDA     #$01
                STA     $046A,x
                LDA     #$08
                JSR     SongRequest
                JSR     LEB9E
                BNE     @LEB81
@LEB7E:         DEX
                BNE     @LEB49
@LEB81:         LDX     ContinuePasswordPressA
                LDY     $045B
                JMP     @LEB8D

@LEB8A:         JSR     LEB9E
@LEB8D:         DEX
                BMI     @LEB93
                JMP     @LEA95

@LEB93:         PLA
                TAX
                RTS

LEB96:          TXA
                ASL     A
                ASL     A
                ASL     A
                ASL     A
                ASL     A
                TAY
                RTS

LEB9E:          LDA     #$00
                STA     $0455,x
                LDA     #$F0
                STA     OamBuffer+64,y
                STA     OamBuffer+65,y
                STA     OamBuffer+66,y
                STA     OamBuffer+67,y
                RTS

LEBB2:          LDA     $C3
                SEC
                SBC     $C5
                BMI     @LEBBD
                CMP     #$08
                BCS     @LEBD4
@LEBBD:         CMP     #$F8
                BCC     @LEBD4
                LDA     $C4
                SEC
                SBC     $C6
                BMI     @LEBCE
                CMP     #$08
                BCS     @LEBD4
                BCC     @LEBD2

@LEBCE:         CMP     #$F8
                BCC     @LEBD4
@LEBD2:         SEC
                RTS

@LEBD4:         CLC
                RTS

SrcPtr          .set    $C3
DstPtr          .set    $C5
ExpandMixedRleData:
                TXA
                PHA
                LDA     RleExpandIndex
                ASL     A
                TAX
                LDA     MixedRlePointerTable,x          ;SrcPtr = Pointers[Index]
                STA     SrcPtr
                LDA     MixedRlePointerTable+1,x
                STA     SrcPtr+1
                LDA     #$00                            ;DstPtr = #$0500
                STA     DstPtr
                LDA     #$05
                STA     DstPtr+1
                LDY     #$00
@Loop:          LDX     #$01                            ;Length
                LDA     (SrcPtr),y
                BPL     @WriteLoop                      ;Plus : single byte / Minus : Repeat bytes
                CMP     #$FF                            ;Terminator
                BEQ     Return2
                AND     #$7F                            ;To plus
                PHA
                JSR     IncSrcPtr
                LDA     (SrcPtr),y
                TAX                                     ;Length
                PLA                                     ;Data
@WriteLoop:     STA     (DstPtr),y
                JSR     IncDstPtr
                DEX
                BNE     @WriteLoop
                JSR     IncSrcPtr
                JMP     @Loop

Return2:        PLA
                TAX
                RTS

ExpandRleData:  TXA
                PHA
                LDA     RleExpandIndex
                ASL     A
                TAX
                LDA     RlePointerTable,x               ;SrcPtr = Pointers[Index]
                STA     SrcPtr
                LDA     RlePointerTable+1,x
                STA     SrcPtr+1
                LDA     #$C0                            ;DstPtr = #$05C0
                STA     DstPtr
                LDA     #$05
                STA     DstPtr+1
                LDY     #$00
@Loop:          LDA     (SrcPtr),y                      ;Length
                BEQ     Return2                         ;Terminator
                TAX
                JSR     IncSrcPtr
                LDA     (SrcPtr),y                      ;Data
                JSR     IncSrcPtr
@WriteLoop:     STA     (DstPtr),y
                JSR     IncDstPtr
                DEX
                BNE     @WriteLoop
                BEQ     @Loop

IncSrcPtr:      INC     SrcPtr
                BNE     Return3
                INC     SrcPtr+1
Return3:        RTS

IncDstPtr:      INC     DstPtr
                BNE     Return3
                INC     DstPtr+1                        ;High byte
                RTS

LEC54:          TXA
                PHA
                TYA
                PHA
                LDX     #$06
@CopyLoop:      LDA     LDDA0,x
                STA     $0485,x
                LDA     LDDAA,x
                STA     $048B,x
                DEX
                BPL     @CopyLoop
                LDA     $03FA
                BEQ     @LECB8
                LDX     #$03
@LEC70:         LDA     #$00
                STA     $0367,x
                STA     $036D,x
                STA     $0373,x
                STA     $0379,x
                JSR     LEB96
                LDA     OamBuffer+48,y
                SEC
                SBC     @LEDD7-1,x
                BEQ     @LEC98
                BPL     @LEC93
                LDA     #$01
                STA     $036D,x
                BNE     @LEC98

@LEC93:         LDA     #$01
                STA     $0367,x
@LEC98:         STA     $048B,x
                LDA     OamBuffer+51,y
                SEC
                SBC     @LEDD9,x
                BEQ     @LECB2
                BPL     @LECAD
                LDA     #$01
                STA     $0373,x
                BNE     @LECB2

@LECAD:         LDA     #$01
                STA     $0379,x
@LECB2:         STA     $0485,x
                DEX
                BNE     @LEC70
@LECB8:         LDA     #$03
                STA     SrcPtr
@LECBC:         LDX     SrcPtr
                JSR     LEB96
                LDA     OamBuffer+48,y
                CMP     #$F0
                BNE     @LECCB
                JMP     @LEDBB

@LECCB:         STA     $045B
                LDA     OamBuffer+51,y
                STA     ContinuePasswordPressA
                LDA     OamBuffer+50,y
                AND     #$40
                ORA     #$03
                STA     $0491
                AND     #$40
                ASL     A
                ASL     A
                SBC     #$00
                EOR     #$FF
                STA     SrcPtr+1
                AND     #$01
                STA     DstPtr+1
                LDA     $03AF,x
                LDY     $03A9,x
                BNE     @LED0E
                LDA     $038B,x
                ORA     $03B5,x
                BEQ     @LED15
                LDA     $048B,x
                LDY     $036D,x
                BNE     @LED0E
                LDY     $0367,x
                BEQ     @LED15
                EOR     #$FF
                CLC
                ADC     #$01
@LED0E:         CLC
                ADC     $045B
                STA     $045B
@LED15:         LDA     $0485,x
                LDY     $0373,x
                BNE     @LED27
                LDY     $0379,x
                BEQ     @LED2E
                EOR     #$FF
                CLC
                ADC     #$01
@LED27:         CLC
                ADC     ContinuePasswordPressA
                STA     ContinuePasswordPressA
@LED2E:         LDX     #$05
@LED30:         TXA
                LDY     SrcPtr
                CMP     $037F,y
                BCC     @LED3F
                JSR     @LEDCA
                LDA     #$F0
                BNE     @LED4B

@LED3F:         JSR     @LEDCA
                TXA
                LSR     A
                LDA     $045B
                BCS     @LED4B
                SBC     #$0F
@LED4B:         STA     OamBuffer+36,y
                TXA
                LSR     A
                SEC
                SBC     #$01
                ASL     A
                ASL     A
                ASL     A
                EOR     SrcPtr+1
                CLC
                ADC     DstPtr+1
                CLC
                ADC     ContinuePasswordPressA
                STA     OamBuffer+39,y
                DEX
                BPL     @LED30
                LDX     SrcPtr
                LDA     $038B,x
                BNE     @LED84
                TXA
                ASL     A
                ASL     A
                ASL     A
                ASL     A
                ADC     #$80
                TAX
                LDY     #$02
                LDA     #$F0
@LED78:         STA     OamBuffer+36,x
                INX
                INX
                INX
                INX
                DEY
                BPL     @LED78
                BMI     @LEDBB

@LED84:         TXA
                ASL     A
                ASL     A
                ASL     A
                ASL     A
                ADC     #$80
                TAX
                LDY     #$02
@LED8E:         LDA     $045B
                CLC
                ADC     #$10
                STA     OamBuffer+36,x
                TYA
                ASL     A
                ASL     A
                ASL     A
                STA     DstPtr
                LDA     #$00
                SEC
                SBC     DstPtr
                EOR     SrcPtr+1
                CLC
                ADC     DstPtr+1
                CLC
                ADC     ContinuePasswordPressA
                STA     OamBuffer+39,x
                LDA     $0491
                STA     OamBuffer+38,x
                INX
                INX
                INX
                INX
                DEY
                BPL     @LED8E
@LEDBB:         DEC     SrcPtr
                BMI     @LEDC2
                JMP     @LECBC

@LEDC2:         JSR     @LEDDD
                PLA
                TAY
                PLA
                TAX
                RTS

@LEDCA:         LDA     SrcPtr
                ASL     A
                ASL     A
                ASL     A
                STX     DstPtr
                ADC     DstPtr
                ASL     A
                ASL     A
                TAY
                RTS

@LEDD7:         .byte   $26
                .byte   $60
@LEDD9:         .byte   $60
                .byte   $6B
                .byte   $50
                .byte   $88

@LEDDD:         LDA     $0498
                BEQ     @LEDE3
                RTS

@LEDE3:         LDA     PPUSTATUS
                AND     #$40
                BEQ     @LEDFF
                INC     $0497
                LDA     $0497
                LSR     A
                BCC     @LEDFF
                LDY     #$18
@LEDF5:         LDA     OamBuffer+132,y
                STA     OamBuffer+4,y
                DEY
                BPL     @LEDF5
                RTS

@LEDFF:         LDY     #$18
                LDA     #$F0
@LEE03:         STA     OamBuffer+4,y
                DEY
                BPL     @LEE03
                RTS

LEE0A:          TXA
                PHA
                LDY     #$00
                LDX     #$00
@LEE10:         TYA
                STA     OamBuffer+80,x
                CLC
                ADC     #$10
                TAY
                LDA     #$FE
                STA     OamBuffer+81,x
                LDA     #$03
                STA     OamBuffer+82,x
                LDA     #$F8
                STA     OamBuffer+83,x
                INX
                INX
                INX
                INX
                CPX     #$30
                BNE     @LEE10
                LDA     #$00
                STA     PpuMaskBuffer_Bit1_ShowBGLeft
                JSR     SetPpuMask
                PLA
                TAX
                RTS

LEE39:          LDA     #$01
                STA     PpuMaskBuffer_Bit1_ShowBGLeft
                JSR     SetPpuMask
                JMP     HideNormalSprites

LEE43:          JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmOp_Decrement
                JMP     VmHelper_WriteTempAddressWord_02

IsAnnihilation: LDY     #$04                            ;5 characters
@Loop:          LDA     PartyLifes,y
                BNE     @Alive
                DEY
                BPL     @Loop
@Dead:          JMP     VmHelper_PushConst_0001

@Alive:         JMP     VmHelper_PushConst_0000

VmProc_PushAlivePartyCount:
                LDY     #$00                            ;Y : Number of alive parties
                LDA     PartyLifes                      ;Goku
                BEQ     @CheckSanzo
                INY
@CheckSanzo:    LDA     PartyLifes+1                    ;Sanzo
                BEQ     @CheckHorse
                INY
@CheckHorse:    LDA     PartyLifes+2                    ;Horse
                BEQ     @CheckSagojo
                INY
@CheckSagojo:   LDA     PartyLifes+3                    ;Sagojo
                BEQ     @CheckChohakkai
                INY
@CheckChohakkai:
                LDA     PartyLifes+4                    ;Chohakkai
                BEQ     @Return
                INY
@Return:        TYA
                JMP     VmOp_PushByte

VmHelper_PushOperatingPartyLife:
                LDY     OperatingParty
                LDA     PartyLifes,y
                JMP     VmOp_PushByte

VmProc_NormalizeOperatingParty:
                JSR     VmHelper_PushGokuLife
                JSR     VmOp_ExitFalse                  ;if(GokuLife == 0){ return; }
                LDA     OperatingParty
                CMP     #$05                            ;Saturation
                BEQ     @Return
                JSR     SetOperatingPartyGoku
@Return:        RTS

LEE9A:          JSR     VmProc_NormalizeOperatingParty
                JSR     VmHelper_CreateStackFrame_08
                JSR     VmHelper_PushOperatingPartyLife
                JSR     VmOp_CheckNotZero
                BCC     @OperatingPartyAlive
                JSR     LEF69
                SEC                                     ;BRA
@OperatingPartyAlive:
                BCS     @Return
                JSR     LEEF4
                JSR     LEF69
@Return:        JMP     VmOp_DestroyStackFrame

VmHelper_PushGokuLife:
                LDA     PartyLifes                      ;Party[0] : Goku
                JMP     VmOp_PushByte

SetOperatingPartyGoku:
                LDA     #$00
                STA     OperatingParty
                RTS

LEEC3:          LDA     OperatingParty
                JMP     VmOp_PushByte

LEEC9:          LDA     HelperParty
                JMP     VmOp_PushByte

LEECF:          JSR     VmHelper_PushConst_0000
                JMP     LEED8

LEED5:          JSR     VmHelper_PushConst_0001
LEED8:          JSR     LE217
                JMP     LE201

LEEDE:          LDA     #$03
                LDY     #$C8
                JMP     VmOp_PushRegister

LEEE5:          LDA     HelperParty
                BEQ     @PushFalse
                CMP     #$06
                BCC     @PushTrue
@PushFalse:     JMP     VmHelper_PushConst_0000         ;0 or >= 6

@PushTrue:      JMP     VmHelper_PushConst_0001         ;0 < HelperParty < 6

LEEF4:          LDA     PartyLifes
                BEQ     @LEEFA
                RTS

@LEEFA:         JSR     VmProc_PushAlivePartyCount
                JSR     VmOp_ExitFalse
                JSR     VmProc_PushAlivePartyCount
                JSR     VmHelper_PushConst_0001
                JSR     VmOp_Compare_Equal              ;C = 1 >= alive
                JSR     LEEE5
                JSR     VmOp_And
                JSR     VmOp_ExitTrue
                JSR     LEEC9
                JSR     VmHelper_WriteTempAddressWord_06
                JSR     LF037
                JSR     LEECF
                LDA     #$00
                STA     $0361
                JSR     VmHelper_PushConst_0020
                JSR     LD5E5
                JSR     VmHelper_PushConst_0080
                JSR     LD5DE
                JSR     VmHelper_ReadTempAddressWord_04
                JMP     LEF41

LEF35:          LDA     $03FF
                JMP     VmOp_PushByte

LEF3B:          LDA     $0400
                JMP     VmOp_PushByte

LEF41:          JSR     VmOp_PopRegister
                STY     $03FF
                RTS

LEF48:          JSR     VmOp_PopRegister
                STY     $0400
                RTS

LEF4F:          LDA     $03E3
                JSR     VmOp_PushByte
                LDY     HelperParty
                CPY     #$06
                BCS     @LEF61
                LDA     PartyLifes,y
                BNE     @LEF63
@LEF61:         LDA     #$00
@LEF63:         JSR     VmOp_PushByte
                JMP     VmOp_Or

LEF69:          LDA     $045D
                BNE     @Return
                LDA     $0480
                ORA     $0481
                BNE     @LEFA4
                JSR     LEF4F
                JSR     VmOp_ExitTrue
                JSR     VmProc_PushAlivePartyCount
                JSR     VmHelper_PushConst_0002
                JSR     VmOp_Compare_BGeatherThanOrEqual
                JSR     VmOp_ExitFalse
                JSR     LEEC3
                JSR     VmHelper_WriteTempAddressWord_06
                JSR     LF037
@LEF91:         JSR     LEED5
                LDY     #$00
                STY     $0362
                INY
                STY     $03E3
                JSR     VmHelper_ReadTempAddressWord_04
                JSR     LEF48
@Return:        RTS

@LEFA4:         LDA     $0480
                BEQ     @LEFCE
                LDA     PartyIn_Chohakkai
                BNE     @Return
                INC     PartyIn_Chohakkai
                JSR     VmHelper_PushConst_0000
                JSR     VmHelper_WriteTempAddressWord_04
                LDA     #$00
                STA     $0362
                JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_0004
                JSR     VmHelper_PushConst_0004
@LEFC5:         JSR     LB3A9
                JSR     @LEF91
                JMP     LEF48

@LEFCE:         LDA     PartyIn_Sagojo
                BNE     @Return
                INC     PartyIn_Sagojo
                JSR     VmHelper_PushConst_0000
                JSR     VmHelper_WriteTempAddressWord_04
                LDA     #$00
                STA     $0362
                JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_0003
                JSR     VmHelper_PushConst_0003
                JMP     @LEFC5

LEFED:          JSR     VmHelper_ReadTempAddressWord_02
                JSR     LEEDE
                JSR     VmOp_Add_AB
                JMP     VmOp_ReadByte

LEFF9:          JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmOp_ExitFalse
                JSR     LEE43
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmHelper_ReadTempAddressWord_06
                JSR     VmOp_Compare_Equal
                JSR     VmOp_CheckNotZero
                BCC     @LF014
                JSR     LEFF9
                SEC
@LF014:         BCS     @LF036
                JSR     VmHelper_ReadTempAddressWord_04
                JSR     LEFED
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_CheckNotZero
                BCC     @LF031
                JSR     LEFED
                JSR     VmHelper_WriteTempAddressWord_04
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmHelper_WriteTempAddressWord_08
                SEC
@LF031:         BCS     @LF036
                JSR     LEFF9
@LF036:         RTS

LF037:          JSR     VmHelper_PushConst_0005
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     VmHelper_PushConst_0000
                JSR     VmHelper_WriteTempAddressWord_04
                JSR     LEFF9
                JMP     VmHelper_ReadTempAddressWord_08

RST:            SEI
                LDA     #$00                            ;Disable display
                STA     PPUCTRL
                STA     PPUMASK
                STA     OAMADDR
                STA     SND_CHN
                STA     DMC_FREQ
@WaitVBlank1:   LDA     PPUSTATUS                       ;Wait VBlank at twice
                BPL     @WaitVBlank1
@WaitVBlank2:   LDA     PPUSTATUS
                BPL     @WaitVBlank2
                LDA     #$02
                STA     OAMDMA                          ;Memory is not clean...
                LDA     #$40
                STA     JOY2                            ;APU IRQ=Disable
                LDY     #$00
                LDA     #$00
@MemoryClearLoop:
                STA     $0000,y
                STA     OamBuffer,y                     ;Skip stack
                STA     PaletteBuffer,y
                STA     $0400,y
                STA     $0500,y
                STA     VmStack_Low,y
                STA     $0700,y
                INY
                BNE     @MemoryClearLoop
                LDX     #$FF
                TXS                                     ;Initialize stack pointer
                JSR     ClearVram
                LDA     #$1C
                STA     VmMem_SecondStack
                LDX     #$7C
                LDA     #$80
                STA     VmMem_StackFramePointer
                LDA     #$07
                STA     VmMem_StackFramePointer+1
                LDA     #$0A                            ;Set field page (unused???)
                STA     FieldPageY
                LDA     #$19
                STA     FieldPageX
                CLI
                JSR     ClearPpuControlBuffer
                LDA     #$01
                STA     PpuCtrlBuffer_Bit7_NmiEnable    ;NMI enable
                STA     PpuCtrlBuffer_Bit4_BGAddress    ;BG address ($0000)
                STA     PpuCtrlBuffer_Bit5_SpriteSize   ;SP size (8x16)
                JSR     SetPpuControl
                JSR     ClearPpuMaskBuffer
                LDA     #$01
                STA     PpuMaskBuffer_Bit1_ShowBGLeft   ;Show BG left 8px
                STA     PpuMaskBuffer_Bit2_ShowSPLeft   ;Show SP left 8px
                STA     PpuMaskBuffer_Bit3_ShowBG       ;Show BG
                STA     PpuMaskBuffer_Bit4_ShowSP       ;Show SP
                JSR     SetPpuMask
                LDA     #$38
                STA     $39
                JMP     LF0E2

WaitNmiFinish:  LDA     #$00
                STA     $56
@WaitFrame:     LDA     $56
                BEQ     @WaitFrame
                JSR     SetDisplayScreenPosition
                LDA     #$00
                STA     $56
                RTS

SetOamDmaRequest:
                LDA     #$01
                STA     OamDmaRequest
                RTS

LF0E2:          JSR     ForceClearVram
                LDA     #$30
                STA     LFFF4                           ;Set bank #0
                LDA     #$00
                STA     ScreenX
                STA     ScreenX+1
                STA     ScreenY
                STA     $045D
                STA     $0472
                JSR     VmHelper_PushConst_0001         ;Write 1 to $03FF
                JSR     LEF41
                JSR     VmHelper_PushConst_0001         ;Write 1 to $0400
                JSR     LEF48
                JSR     HideAllSprites
                JSR     WaitNmiRaised
                JSR     DisablePpuMask_BGDisable
                LDA     #$0D                            ;Title screen index
                STA     RleExpandIndex
                JSR     LAF9A
                JSR     InitializeSounddriver
                JSR     DisablePpuMask_BGEnable
                LDA     #$00
                STA     $0484
                JSR     SongRequest_03                  ;BGM : Title
@WaitLoop:      JSR     HideAllSprites
                JSR     PlaySubSequence
                JSR     WaitNmiRaised
                JSR     CheckExitTitleScreen            ;Carry = IsNextScreen
                LDA     LFFF4                           ;Set bank #0
                STA     LFFF4
                BCC     @WaitLoop                       ;Loop until start button is pressed
                JSR     SongRequest_00                  ;Song mute
                JSR     LBA3D
                JMP     LF0E2

HideAllSprites: LDA     #$F0                            ;Hide sprite #0
                STA     OamBuffer
                JSR     HideNormalSprites               ;Hide sprites #1-#63
                JMP     SetOamDmaRequest

ForceClearVram: TXA
                PHA
                LDA     #$00
                STA     PPUCTRL                         ;Fource blanking
                STA     PPUMASK
                JSR     ClearVram
                JSR     SetPpuControl                   ;Revert draw
                JSR     SetPpuMask
                PLA
                TAX
                RTS

ClearVram:      LDY     #$00
                STY     PPUMASK                         ;All disable
                TXA                                     ;Save X register
                PHA
                LDX     #$20                            ;Claer VRAM $2000-$3FFF
@ClearVramLoop: LDA     PPUSTATUS
                TXA
                STA     PPUADDR
                LDA     #$00
                STA     PPUADDR
@ClearPageLoop: STA     PPUDATA
                INY
                BNE     @ClearPageLoop
                INX
                CPX     #$40
                BCC     @ClearVramLoop
                LDA     #$3F                            ;VramAddress = $3F00 (?)
                STA     PPUADDR
                LDA     #$00
                STA     PPUADDR
                STA     PPUADDR                         ;VramAddress = $0000
                STA     PPUADDR
                PLA                                     ;Restore X register
                TAX
                RTS

; Junk data (Uncompiled source)
; PC:0x40E8, ROM:$C0D8 (Maybe)
                .byte   "SR"
                .byte   $09
                .byte   "TRUE_CASE",$0D,$0A
                .byte   $09
                .byte   "JSR"
                .byte   $09
                .byte   "NF",$0D,$0A
                .byte   $09
                .byte   "JMP"
                .byte   $09
                .byte   "SUB",$0D,$0A,$0D,$0A,"CVTYLN"
                .byte   $09
                .byte   "JSR"
                .byte   $09
                .byte   "UGY",$0D,$0A
                .byte   $09
                .byte   "JMP"
                .byte   $09
                .byte   "CVTYL"

JumpSongRequest:
                JMP     Sound_SongRequest

JumpPlaySubSequence:
                JMP     Sound_PlaySubSequence

JumpDisableApuChannel:
                JMP     Sound_ApuDisable

JumpEnableApuChannel:
                JMP     Sound_ApuEnable

JumpInitializeSounddriver:
                JMP     Sound_InitializeSounddriver

; Argument: A = Song number
Sound_SongRequest:
                CMP     #$17
                BCS     @Return                         ;if overflow song number, return
                ASL     A
                TAX
                LDA     SounddriverProcessPointerTable+1,x
                PHA
                LDA     SounddriverProcessPointerTable,x
                PHA
@Return:        RTS                                     ;Jump to process routine / Return caller

SounddriverProcessPointerTable:
                .word   SoundPlay_Mute-1
                .word   SoundPlay_Battle-1
                .word   SoundPlay_Field-1
                .word   SoundPlay_Title-1
                .word   SoundPlay_Ending-1
                .word   SoundPlay_Shrine-1
                .word   SoundPlay_SE_Damage-1
                .word   SoundPlay_SE_02-1
                .word   SoundPlay_SE_03-1
                .word   SoundPlay_SE_Kill-1
                .word   SoundPlay_SE_Jump-1
                .word   SoundPlay_SE_06-1
                .word   SoundPlay_SE_07-1
                .word   SoundPlay_SE_08-1
                .word   SoundPlay_SE_GetItem-1
                .word   SoundPlay_SE_10-1
                .word   SoundPlay_SE_11-1
                .word   SoundPlay_SE_Attack-1
                .word   SoundPlay_SE_13-1
                .word   SoundPlay_SE_14-1
                .word   SoundPlay_SE_15-1               ;Stop noise channel
                .word   SoundPlay_SE_16-1
                .word   SoundPlay_SE_17-1

SoundPlay_Mute: JMP     Sound_InitializeSounddriver

SoundPlay_Battle:
                JSR     Sound_InitializeSounddriver
                LDA     #<Music_01_Main_Sq1
                STA     Sound_Sq1_MainSequencePointer
                LDA     #>Music_01_Main_Sq1
                STA     Sound_Sq1_MainSequencePointer+1
                LDA     #$A1
                STA     Sound_Tri_MainSequencePointer
                LDA     #$F5
                STA     Sound_Tri_MainSequencePointer+1
                JSR     Sound_PlayMainSequence_Sq1
                JMP     Sound_PlayMainSequence_Tri

SoundPlay_Field:
                JSR     Sound_InitializeSounddriver
                LDA     #$54
                STA     Sound_Sq1_MainSequencePointer
                LDA     #$F7
                STA     Sound_Sq1_MainSequencePointer+1
                LDA     #$EF
                STA     Sound_Sq2_MainSequencePointer
                LDA     #$F7
                STA     Sound_Sq2_MainSequencePointer+1
                LDA     #$A4
                STA     Sound_Tri_MainSequencePointer
                LDA     #$F7
                STA     Sound_Tri_MainSequencePointer+1
                JSR     Sound_PlayMainSequence_Sq1
                JSR     Sound_PlayMainSequence_Sq2
                JMP     Sound_PlayMainSequence_Tri

SoundPlay_Title:
                JSR     Sound_InitializeSounddriver
                LDA     #$A1
                STA     Sound_Sq1_MainSequencePointer
                LDA     #$FE
                STA     Sound_Sq1_MainSequencePointer+1
                LDA     #$C2
                STA     Sound_Sq2_MainSequencePointer
                LDA     #$FE
                STA     Sound_Sq2_MainSequencePointer+1
                LDA     #$D4
                STA     Sound_Tri_MainSequencePointer
                LDA     #$FE
                STA     Sound_Tri_MainSequencePointer+1
                LDA     #$04
                STA     Sound_Noi_MainSequencePointer
                LDA     #$FF
                STA     Sound_Noi_MainSequencePointer+1
                JSR     Sound_PlayMainSequence_Sq1
                JSR     Sound_PlayMainSequence_Sq2
                JSR     Sound_PlayMainSequence_Tri
                JMP     Sound_PlayMainSequence_Noi

SoundPlay_Ending:
                JSR     Sound_InitializeSounddriver
                LDA     #$05
                STA     Sound_Sq1_MainSequencePointer
                LDA     #$FD
                STA     Sound_Sq1_MainSequencePointer+1
                LDA     #$13
                STA     Sound_Sq2_MainSequencePointer
                LDA     #$FD
                STA     Sound_Sq2_MainSequencePointer+1
                LDA     #$42
                STA     Sound_Tri_MainSequencePointer
                LDA     #$FD
                STA     Sound_Tri_MainSequencePointer+1
                LDA     #$71
                STA     Sound_Noi_MainSequencePointer
                LDA     #$FD
                STA     Sound_Noi_MainSequencePointer+1
                JSR     Sound_PlayMainSequence_Sq1
                JSR     Sound_PlayMainSequence_Sq2
                JSR     Sound_PlayMainSequence_Tri
                JMP     Sound_PlayMainSequence_Noi

SoundPlay_Shrine:
                JSR     Sound_InitializeSounddriver
                LDA     #$D1
                STA     Sound_Sq1_MainSequencePointer
                LDA     #$FA
                STA     Sound_Sq1_MainSequencePointer+1
                LDA     #$FF
                STA     Sound_Tri_MainSequencePointer
                LDA     #$FA
                STA     Sound_Tri_MainSequencePointer+1
                JSR     Sound_PlayMainSequence_Sq1
                JMP     Sound_PlayMainSequence_Tri

SoundPlay_SE_Damage:
                LDA     #$F2
                STA     Sound_Noi_MainSequencePointer
                LDA     #$F4
                STA     Sound_Noi_MainSequencePointer+1
                JMP     Sound_PlayMainSequence_Noi

SoundPlay_SE_02:
                RTS

SoundPlay_SE_03:
                RTS

SoundPlay_SE_Kill:
                LDA     #$44
                STA     Sound_Noi_MainSequencePointer
                LDA     #$F5
                STA     Sound_Noi_MainSequencePointer+1
                JMP     Sound_PlayMainSequence_Noi

SoundPlay_SE_Jump:
                LDA     #$E5
                STA     Sound_Sq2_MainSequencePointer
                LDA     #$F4
                STA     Sound_Sq2_MainSequencePointer+1
                JMP     Sound_PlayMainSequence_Sq2

SoundPlay_SE_06:
                RTS

SoundPlay_SE_07:
                LDA     #$05
                STA     Sound_Noi_MainSequencePointer
                LDA     #$F5
                STA     Sound_Noi_MainSequencePointer+1
                JMP     Sound_PlayMainSequence_Noi

SoundPlay_SE_08:
                LDA     #$11
                STA     Sound_Noi_MainSequencePointer
                LDA     #$F5
                STA     Sound_Noi_MainSequencePointer+1
                JMP     Sound_PlayMainSequence_Noi

SoundPlay_SE_GetItem:
                LDA     #$1D
                STA     Sound_Sq2_MainSequencePointer
                LDA     #$F5
                STA     Sound_Sq2_MainSequencePointer+1
                JMP     Sound_PlayMainSequence_Sq2

SoundPlay_SE_10:
                LDA     #$32
                STA     Sound_Sq2_MainSequencePointer
                LDA     #$F5
                STA     Sound_Sq2_MainSequencePointer+1
                JMP     Sound_PlayMainSequence_Sq2

SoundPlay_SE_11:
                RTS

SoundPlay_SE_Attack:
                LDA     #$D9
                STA     Sound_Noi_MainSequencePointer
                LDA     #$F4
                STA     Sound_Noi_MainSequencePointer+1
                JMP     Sound_PlayMainSequence_Noi

SoundPlay_SE_13:
                RTS

SoundPlay_SE_14:
                LDA     #$76
                STA     Sound_Noi_MainSequencePointer
                LDA     #$F5
                STA     Sound_Noi_MainSequencePointer+1
                JMP     Sound_PlayMainSequence_Noi

SoundPlay_SE_15:
                LDA     #$00
                LDX     #Sound_Noi
@LoopMemoryClear:
                STA     $00,x                           ;zero clear $28-$2F (Noise channel)
                INX
                CPX     #Sound_Noi+8
                BNE     @LoopMemoryClear
                LDX     #$0C
@LoopApuClear:  STA     SQ1_VOL,x                       ;zero clear $400C-$400F (Noise channel)
                INX
                CPX     #$10
                BNE     @LoopApuClear
                RTS

SoundPlay_SE_16:
                LDA     #$08                            ;Play only noise channel
                JSR     ApuChannesSet
                LDA     #$6A
                STA     Sound_Noi_MainSequencePointer
                LDA     #$F5
                STA     Sound_Noi_MainSequencePointer+1
                JMP     Sound_PlayMainSequence_Noi

SoundPlay_SE_17:
                JSR     SoundPlay_SE_15
                JMP     Sound_ApuEnable

Sound_InitializeSounddriver:
                LDA     #$00
                LDX     #$10
@LoopMemory:    STA     $00,x
                INX
                CPX     #$30
                BNE     @LoopMemory
                LDX     #$00
@LoopRegister:  STA     SQ1_VOL,x
                INX
                CPX     #$14
                BNE     @LoopRegister
Sound_ApuEnable:
                LDA     #$0F
                STA     SND_CHN
                RTS

Sound_ApuDisable:
                LDA     #$00
ApuChannesSet:  STA     SND_CHN
                RTS

Sound_WaitLengthTable:
                .byte   $03
                .byte   $01
                .byte   $06
                .byte   $02
                .byte   $09
                .byte   $0C
                .byte   $04
                .byte   $12
                .byte   $18
                .byte   $08
                .byte   $24
                .byte   $30
                .byte   $10
                .byte   $48
                .byte   $3C
                .byte   $1E

; $10 - Channels memory (8bytes * 4ch)
; +$00 : ??    ; ???
; +$01 : SS SS ; Main sequence pointer
; +$03 : QQ QQ ; Sub sequence pointer
; +$05 : LL    ; Tick length
; +$06 : CC    ; Tick counter
; +$07 : WW    ; Wait counter
Sound_          .set    $00
Sound_MainSequencePointer .set $01
Sound_SubSequencePointer .set $03
Sound_TickLength .set   $05
Sound_TickCounter .set  $06
Sound_WaitCounter .set  $07
Sound_PlaySubSequence:
                NOP
@Sq1:           LDA     Sound_Sq1_                      ;Sq1
                BEQ     @Sq2
                LDX     #$10                            ;$10 + 8 * 0
                LDY     #$00                            ;4 * 0
                JSR     Sound_PlaySubSequenceChannel
@Sq2:           LDA     Sound_Sq2_                      ;Sq2
                BEQ     @Tri
                LDX     #$18                            ;$10 + 8 * 1
                LDY     #$04                            ;4 * 1
                JSR     Sound_PlaySubSequenceChannel
@Tri:           LDA     Sound_Tri_                      ;Tri
                BEQ     @Noi
                LDX     #$20                            ;$10 + 8 * 2
                LDY     #$08                            ;4 * 2
                JSR     Sound_PlaySubSequenceChannel
@Noi:           LDA     Sound_Noi_                      ;Noi
                BEQ     @Return
                LDX     #$28                            ;$10 + 8 * 3
                LDY     #$0C                            ;4 * 3
                JSR     Sound_PlaySubSequenceChannel
@Return:        RTS

Sound_PlaySubSequenceChannel:
                LDA     Sound_TickCounter,x             ;($06 + ($10 + Ch * 8))
                BEQ     @Update
                DEC     Sound_TickCounter,x
                BNE     @Return
                LDA     Sound_TickLength,x              ;to zero
                STA     Sound_TickCounter,x             ;Reload counter
                DEC     Sound_WaitCounter,x
                BNE     @Return                         ;Wait expired
@ReadSequence:  LDA     (Sound_SubSequencePointer,x)    ;Read sequence : low freq
                CMP     #$00
                BEQ     @PlayMainSequence               ;Subsequence end
                STA     SQ1_LO,y
                LDA     #$08                            ;Noise length counter (L=1)
                CPY     #$0C                            ;Noise
                BEQ     @SkipReadHighFreq
                JSR     IncrementSubSequencePointer
                LDA     (Sound_SubSequencePointer,x)    ;Read sequence : high freq
                AND     #$07                            ;%0000 1ttt
                ORA     #$08                            ;PSG length counter (L=1)
@SkipReadHighFreq:
                STA     SQ1_HI,y
                LDA     (Sound_SubSequencePointer,x)    ;Read sequence : length (reload)
                LSR     A                               ;Get high nibble
                LSR     A
                LSR     A
                LSR     A
                TAY
                LDA     Sound_WaitLengthTable,y
                STA     Sound_WaitCounter,x
                JSR     IncrementSubSequencePointer
@Return:        RTS

@Update:        LDA     Sound_TickLength,x              ;Reload counter
                STA     Sound_TickCounter,x
                JMP     @ReadSequence

; Main sequence : ...
;   00    : ?
;   XX YY : Jump sub sequence address (low, high)
                LDA     (Sound_SubSequencePointer,x)    ;(Maybe) unused code, write high freq raw value
                AND     #$0F
                STA     SQ1_LO,y
                LDA     #$08
@PlayMainSequence:
                JSR     IncrementMainSequencePointer
@ReadMainSequence:
                LDA     (Sound_MainSequencePointer,x)
                CMP     #$00
                BEQ     @LF426
                STA     Sound_SubSequencePointer,x      ;Jump sub sequence address
                JSR     IncrementMainSequencePointer
                LDA     (Sound_MainSequencePointer,x)
                STA     Sound_SubSequencePointer+1,x
                JMP     @ReadSequence                   ;Play jump destination sequence

; Main sequence : 00 ...
;   00          : Clear channel memory
;   00 FE       : Set tick length
;   00 FF XX YY : Jump main sequence address (low, high)
@LF426:         JSR     IncrementMainSequencePointer
                LDA     (Sound_MainSequencePointer,x)
                BEQ     ClearChannelData                ;Sequence : 00 00       ; Clear
                CMP     #$FF
                BEQ     @JumpMain                       ;Sequence : 00 FF       ; Jump main sequence address
                CMP     #$FE
                BEQ     @SetTick                        ;Sequence : 00 FE       ; Set tick length
                STA     SQ1_VOL,y                       ;Sequence : 00 ** XX YY ; Channel misc $4000, $4001
                JSR     IncrementMainSequencePointer
                LDA     (Sound_MainSequencePointer,x)
                STA     SQ1_SWEEP,y
                JMP     @PlayMainSequence

; Main sequence : 00 FE ; Set tick length
@SetTick:       JSR     IncrementMainSequencePointer
                LDA     (Sound_MainSequencePointer,x)
                STA     Sound_TickLength,x
                STA     Sound_TickCounter,x
                JMP     @PlayMainSequence

; Main sequence : 00 FF XX YY ; Jump main sequence address (low, high)
@JumpMain:      JSR     IncrementMainSequencePointer
                LDA     (Sound_MainSequencePointer,x)
                PHA
                JSR     IncrementMainSequencePointer
                LDA     (Sound_MainSequencePointer,x)
                STA     Sound_MainSequencePointer+1,x
                PLA
                STA     Sound_MainSequencePointer,x
                JMP     @ReadMainSequence

; Sequence : 00 00 ; Clear channel memory
ClearChannelData:
                LDA     #$00
                STA     SQ1_VOL,y
                STA     Sound_,x
                STA     Sound_TickLength,x
                STA     Sound_TickCounter,x
                RTS

IncrementMainSequencePointer:
                INC     Sound_MainSequencePointer,x
                BNE     @SkipHigh
                INC     Sound_MainSequencePointer+1,x
@SkipHigh:      RTS

IncrementSubSequencePointer:
                INC     Sound_SubSequencePointer,x
                BNE     @SkipHigh
                INC     Sound_SubSequencePointer+1,x
@SkipHigh:      RTS

Sound_PlayMainSequence_Sq1:
                LDX     #$10                            ;$10 + 8 * 0
                LDY     #$00                            ;4 * 0
                JMP     Sound_PlayMainSequence

Sound_PlayMainSequence_Sq2:
                LDX     #$18                            ;$10 + 8 * 1
                LDY     #$04                            ;4 * 1
                JMP     Sound_PlayMainSequence

Sound_PlayMainSequence_Tri:
                LDX     #$20                            ;$10 + 8 * 2
                LDY     #$08                            ;4 * 2
                JMP     Sound_PlayMainSequence

Sound_PlayMainSequence_Noi:
                LDX     #$28                            ;$10 + 8 * 3
                LDY     #$0C                            ;4 * 3
                JMP     Sound_PlayMainSequence

Sound_PlayMainSequence:
                LDA     #$00
                STA     Sound_,x
@LF49C:         LDA     (Sound_MainSequencePointer,x)
                CMP     #$00
                BEQ     @LF4B0
                STA     Sound_SubSequencePointer,x      ;Set sub sequence pointer
                JSR     IncrementMainSequencePointer
                LDA     (Sound_MainSequencePointer,x)
                STA     Sound_SubSequencePointer+1,x
                LDA     #$FF                            ;sub sequence address set flag?
                STA     Sound_,x
                RTS

; Main sequence : 00 ...
@LF4B0:         JSR     IncrementMainSequencePointer
                LDA     (Sound_MainSequencePointer,x)
                BEQ     ClearChannelData
                CMP     #$FE
                BEQ     @LF4CC
                STA     SQ1_VOL,y
                JSR     IncrementMainSequencePointer
                LDA     (Sound_MainSequencePointer,x)
                STA     SQ1_SWEEP,y
                JSR     IncrementMainSequencePointer
                JMP     @LF49C

@LF4CC:         JSR     IncrementMainSequencePointer
                LDA     (Sound_MainSequencePointer,x)
                STA     Sound_TickLength,x
                JSR     IncrementMainSequencePointer
                JMP     @LF49C

                .byte   $00
                .byte   $FE
                .byte   $02
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $E3
                .byte   $F4
                .byte   $00
                .byte   $00
                .byte   $29
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $02
                .byte   $00
                .byte   $C4
                .byte   $9C
                .byte   $EF
                .byte   $F4
                .byte   $00
                .byte   $00
                .byte   $6B
                .byte   $70
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $02
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $01
                .byte   $F5
                .byte   $00
                .byte   $04
                .byte   $00
                .byte   $03
                .byte   $F5
                .byte   $00
                .byte   $00
                .byte   $0B
                .byte   $00
                .byte   $0A
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $01
                .byte   $00
                .byte   $02
                .byte   $00
                .byte   $0F
                .byte   $F5
                .byte   $00
                .byte   $00
                .byte   $2F
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $01
                .byte   $00
                .byte   $02
                .byte   $00
                .byte   $1B
                .byte   $F5
                .byte   $00
                .byte   $00
                .byte   $04
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $02
                .byte   $00
                .byte   $84
                .byte   $00
                .byte   $27
                .byte   $F5
                .byte   $00
                .byte   $00
                .byte   $24
                .byte   $00
                .byte   $2A
                .byte   $00
                .byte   $35
                .byte   $00
                .byte   $2A
                .byte   $00
                .byte   $24
                .byte   $20
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $05
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $41
                .byte   $F5
                .byte   $00
                .byte   $CF
                .byte   $95
                .byte   $41
                .byte   $F5
                .byte   $00
                .byte   $00
                .byte   $59
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $02
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $62
                .byte   $F5
                .byte   $00
                .byte   $34
                .byte   $00
                .byte   $64
                .byte   $F5
                .byte   $00
                .byte   $3A
                .byte   $00
                .byte   $66
                .byte   $F5
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $68
                .byte   $F5
                .byte   $00
                .byte   $38
                .byte   $00
                .byte   $66
                .byte   $F5
                .byte   $00
                .byte   $00
                .byte   $0B
                .byte   $00
                .byte   $29
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $25
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $02
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   $74
                .byte   $F5
                .byte   $00
                .byte   $00
                .byte   $07
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $04
                .byte   $00
                .byte   $0F
                .byte   $00
                .byte   $80
                .byte   $F5
                .byte   $00
                .byte   $00
                .byte   "+,-.-,"
                .byte   $00
Music_01_Main_Sq1:
                .byte   $00
                .byte   $FE
                .byte   $02
                .byte   $00
                .byte   $46
                .byte   $00
                HiAscii ";uLuLu"
                .byte   $11
                .byte   $F6
                .byte   $CC
                .byte   $F5
                .byte   $27
                .byte   $F7
                .byte   $50
                .byte   $F6
                .byte   $8F
                .byte   $F6
                .byte   $00
                .byte   $FF
                .byte   $8F
                .byte   $F5
                .byte   $00
                .byte   $FE
                .byte   $02
                .byte   $00
                .byte   $48
                .byte   $00
                HiAscii ".v?v?v?v?v"
                .byte   $02
                .byte   $F7
                .byte   $02
                .byte   $F7
                .byte   $27
                .byte   $F7
                .byte   $00
                .byte   $FF
                .byte   $A9
                .byte   $F5
                .byte   $6B
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   "k ^ k ^"
                .byte   $90
                .byte   "Y@TP"
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $6B
                .byte   $20
                .byte   $7F
                .byte   " k@k"
                .byte   $00
                .byte   "^ T ^ k ^"
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $7F
                .byte   $50
                .byte   $8F
                .byte   $20
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $6B
                .byte   $20
                .byte   $7F
                .byte   " k@k"
                .byte   $00
                .byte   "^ T ^"
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $5E
                .byte   $A0
                .byte   $00
                .byte   "?pFP?"
                .byte   $00
                .byte   $3F
                .byte   $00
                .byte   "F T F"
                .byte   $00
                .byte   $46
                .byte   $00
                .byte   $46
                .byte   $00
                .byte   $46
                .byte   $00
                .byte   "T ^ T"
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   "TPFpTPF"
                .byte   $00
                .byte   $46
                .byte   $00
                .byte   "T ^ T"
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   "^ k ^P^P"
                .byte   $00
                .byte   "?PF F T"
                .byte   $00
                .byte   $46
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $54
                .byte   $20
                .byte   $54
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   "FPT T ^"
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $5E
                .byte   $50
                .byte   $7F
                .byte   $50
                .byte   $8F
                .byte   $20
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $7F
                .byte   $20
                .byte   $7F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $6B
                .byte   $50
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   $F0
                .byte   $00
                .byte   "F F ?P^PTPF F ?"
                .byte   $A0
                .byte   "F F ?"
                .byte   $A0
                .byte   "k k "
                .byte   $7F
                .byte   $50
                .byte   $8F
                .byte   $80
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   $20
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   $90
                .byte   "x@qP"
                .byte   $00
                .byte   $FE
                .byte   " k T O"
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $6B
                .byte   $20
                .byte   $AA
                .byte   $20
                .byte   $7F
                .byte   $20
                .byte   $AA
                .byte   $20
                .byte   $1D
                .byte   "!q ^"
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   "^ q "
                .byte   $8F
                .byte   $20
                .byte   $5E
                .byte   $20
                .byte   $8F
                .byte   $20
                .byte   $40
                .byte   $21
                .byte   $7F
                .byte   $20
                .byte   $6B
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $6B
                .byte   $20
                .byte   $A0
                .byte   $20
                .byte   $7F
                .byte   $20
                .byte   $6B
                .byte   $20
                .byte   $7F
                .byte   $20
                .byte   $BE
                .byte   $50
                .byte   $8F
                .byte   "PqP^"
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $8F
                .byte   $20
                .byte   $00
                .byte   "FPTP^PTPkP"
                .byte   $8F
                .byte   $50
                .byte   $7F
                .byte   $50
                .byte   $8F
                .byte   $50
                .byte   $6B
                .byte   $50
                .byte   $8F
                .byte   $50
                .byte   $7F
                .byte   $50
                .byte   $8F
                .byte   $50
                .byte   $AA
                .byte   $50
                .byte   $8F
                .byte   $70
                .byte   $7F
                .byte   $20
                .byte   $6B
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $8F
                .byte   $20
                .byte   $00
                .byte   "FPTP^PTPkP"
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   $50
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   $20
                .byte   $8F
                .byte   $20
                .byte   $AA
                .byte   $50
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   $50
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   $50
                .byte   $7F
                .byte   "Pk ^P"
                .byte   $8F
                .byte   $00
                .byte   $87
                .byte   $00
                .byte   $7F
                .byte   $20
                .byte   $6B
                .byte   $20
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $02
                .byte   $00
                .byte   $41
                .byte   $00
                .byte   $81
                .byte   $F8
                .byte   $81
                .byte   $F8
                .byte   $81
                .byte   $F8
                .byte   $81
                .byte   $F8
                .byte   $86
                .byte   $F8
                .byte   $86
                .byte   $F8
                .byte   $86
                .byte   $F8
                .byte   $86
                .byte   $F8
                .byte   $8B
                .byte   $F8
                .byte   $8B
                .byte   $F8
                .byte   $8B
                .byte   $F8
                .byte   $8B
                .byte   $F8
                .byte   $90
                .byte   $F8
                .byte   $90
                .byte   $F8
                .byte   $90
                .byte   $F8
                .byte   $90
                .byte   $F8
                .byte   $00
                .byte   $FE
                .byte   $03
                .byte   $00
                .byte   $7A
                .byte   $00
                .byte   $95
                .byte   $F8
                .byte   $95
                .byte   $F8
                .byte   $00
                .byte   $7B
                .byte   $00
                .byte   $B4
                .byte   $F8
                .byte   $00
                .byte   $46
                .byte   $00
                HiAscii "^xQx^xyx"
                .byte   $0C
                .byte   $F9
                .byte   $15
                .byte   $F9
                .byte   $0C
                .byte   $F9
                .byte   $1A
                .byte   $F9
                .byte   $0C
                .byte   $F9
                .byte   $1F
                .byte   $F9
                .byte   $00
                .byte   $FF
                .byte   $7D
                .byte   $F7
                .byte   $00
                .byte   $FE
                .byte   $02
                .byte   $23
                .byte   $FA
                .byte   $00
                .byte   $FE
                .byte   $03
                .byte   $00
                .byte   $58
                .byte   $00
                .byte   $49
                .byte   $FA
                .byte   $49
                .byte   $FA
                .byte   $49
                .byte   $FA
                .byte   $49
                .byte   $FA
                .byte   $52
                .byte   $FA
                .byte   $77
                .byte   $FA
                .byte   $49
                .byte   $FA
                .byte   $49
                .byte   $FA
                .byte   $49
                .byte   $FA
                .byte   $49
                .byte   $FA
                .byte   $52
                .byte   $FA
                .byte   $77
                .byte   $FA
                .byte   $00
                .byte   $40
                .byte   $00
                .byte   $84
                .byte   $FA
                .byte   $84
                .byte   $FA
                .byte   $49
                .byte   $FA
                .byte   $49
                .byte   $FA
                .byte   $8D
                .byte   $FA
                .byte   $49
                .byte   $FA
                .byte   $77
                .byte   $FA
                .byte   $00
                .byte   $22
                .byte   $00
                HiAscii "AyAyAyAy"
                .byte   $02
                .byte   $FA
                .byte   $02
                .byte   $FA
                .byte   $02
                .byte   $FA
                .byte   $28
                .byte   $FA
                .byte   $00
                .byte   $FF
                .byte   $AC
                .byte   $F7
                .byte   $00
                .byte   $FE
                .byte   $02
                .byte   $00
                .byte   $41
                .byte   $00
                .byte   $6D
                .byte   $F8
                .byte   $6D
                .byte   $F8
                .byte   $6D
                .byte   $F8
                .byte   $6D
                .byte   $F8
                .byte   $72
                .byte   $F8
                .byte   $72
                .byte   $F8
                .byte   $72
                .byte   $F8
                .byte   $72
                .byte   $F8
                .byte   $77
                .byte   $F8
                .byte   $77
                .byte   $F8
                .byte   $77
                .byte   $F8
                .byte   $77
                .byte   $F8
                .byte   $7C
                .byte   $F8
                .byte   $7C
                .byte   $F8
                .byte   $7C
                .byte   $F8
                .byte   $7C
                .byte   $F8
                .byte   $00
                .byte   $FE
                .byte   $03
                .byte   $00
                .byte   $B8
                .byte   $00
                .byte   $30
                .byte   $F9
                .byte   $30
                .byte   $F9
                .byte   $30
                .byte   $F9
                .byte   $4D
                .byte   $F9
                .byte   $6C
                .byte   $F9
                .byte   $87
                .byte   $F9
                .byte   $30
                .byte   $F9
                .byte   $30
                .byte   $F9
                .byte   $00
                .byte   $BA
                .byte   $00
                .byte   $30
                .byte   $F9
                .byte   $30
                .byte   $F9
                .byte   $30
                .byte   $F9
                .byte   $4D
                .byte   $F9
                .byte   $6C
                .byte   $F9
                .byte   $87
                .byte   $F9
                .byte   $30
                .byte   $F9
                .byte   $30
                .byte   $F9
                .byte   $30
                .byte   $F9
                .byte   $30
                .byte   $F9
                .byte   $30
                .byte   $F9
                .byte   $4D
                .byte   $F9
                .byte   $6C
                .byte   $F9
                .byte   $87
                .byte   $F9
                .byte   $30
                .byte   $F9
                .byte   $A4
                .byte   $F9
                .byte   $00
                .byte   $86
                .byte   $00
                HiAscii "Hz$z-z6z?z6z-z$z?z6z-z$z"
                .byte   $00
                .byte   $FF
                .byte   $18
                .byte   $F8
                .byte   $E3
                .byte   $00
                .byte   $40
                .byte   $01
                .byte   $00
                .byte   $BE
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $00
                .byte   $AA
                .byte   $00
                .byte   $E3
                .byte   $00
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $BE
                .byte   $00
                .byte   $00
                .byte   $AA
                .byte   $00
                .byte   $E3
                .byte   $00
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $BE
                .byte   $00
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $AA
                .byte   $00
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $00
                .byte   $7F
                .byte   $E0
                .byte   $6B
                .byte   $80
                .byte   $8F
                .byte   $50
                .byte   $7F
                .byte   $E0
                .byte   "kP^PF K"
                .byte   $00
                .byte   $4F
                .byte   $00
                .byte   $54
                .byte   $E0
                .byte   "kP^P"
                .byte   $8F
                .byte   $50
                .byte   $7F
                .byte   $D0
                .byte   $01
                .byte   $80
                .byte   $00
                .byte   $54
                .byte   $E0
                .byte   "FP?PFPT"
                .byte   $E0
                .byte   "FP?PkP^"
                .byte   $E0
                .byte   "^PTP"
                .byte   $8F
                .byte   $50
                .byte   $7F
                .byte   $D0
                .byte   $01
                .byte   $80
                .byte   $00
                .byte   "? FP"
                .byte   $01
                .byte   $F0
                .byte   "^ TP"
                .byte   $01
                .byte   $A0
                .byte   $00
                .byte   $46
                .byte   $20
                .byte   $46
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   "^ k "
                .byte   $7F
                .byte   $70
                .byte   $6B
                .byte   $20
                .byte   $7F
                .byte   $70
                .byte   $8F
                .byte   $00
                .byte   $87
                .byte   $00
                .byte   $7F
                .byte   " k ^ "
                .byte   $00
                .byte   "F TP"
                .byte   $01
                .byte   $F0
                .byte   "^ TP"
                .byte   $01
                .byte   $80
                .byte   $01
                .byte   $00
                .byte   $87
                .byte   $00
                .byte   $7F
                .byte   $20
                .byte   $00
                .byte   $54
                .byte   $40
                .byte   $7F
                .byte   $40
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   $70
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $00
                .byte   $87
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $AA
                .byte   $40
                .byte   $8F
                .byte   $40
                .byte   $7F
                .byte   $70
                .byte   $01
                .byte   $00
                .byte   $87
                .byte   $00
                .byte   $7F
                .byte   $20
                .byte   $00
                .byte   $1D
                .byte   $01
                .byte   $FE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $53
                .byte   $21
                .byte   $1D
                .byte   $01
                .byte   $FE
                .byte   $00
                .byte   $7D
                .byte   $21
                .byte   $1D
                .byte   $01
                .byte   $FE
                .byte   $00
                .byte   $1D
                .byte   $01
                .byte   $FE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $BE
                .byte   $00
                .byte   $1D
                .byte   $01
                .byte   $00
                .byte   $1D
                .byte   $01
                .byte   $FE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $53
                .byte   $21
                .byte   $1D
                .byte   $01
                .byte   $FE
                .byte   $00
                .byte   $1D
                .byte   $01
                .byte   $FE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $BE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $AA
                .byte   $00
                .byte   $BE
                .byte   $00
                .byte   $AA
                .byte   $00
                .byte   $00
                .byte   $1D
                .byte   $01
                .byte   $FE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $40
                .byte   $21
                .byte   $FE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $53
                .byte   $21
                .byte   $FE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $7D
                .byte   $21
                .byte   $FE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $7D
                .byte   $01
                .byte   $00
                .byte   $1D
                .byte   $01
                .byte   $FE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $40
                .byte   $21
                .byte   $FE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $53
                .byte   $21
                .byte   $FE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $1D
                .byte   $01
                .byte   $FE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $BE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $00
                .byte   $1D
                .byte   $01
                .byte   $FE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $53
                .byte   $21
                .byte   $1D
                .byte   $01
                .byte   $FE
                .byte   $00
                .byte   $7D
                .byte   $21
                .byte   $1D
                .byte   $01
                .byte   $FE
                .byte   $00
                .byte   $68
                .byte   $01
                .byte   $53
                .byte   $01
                .byte   $1D
                .byte   $01
                .byte   $FE
                .byte   $00
                .byte   $D6
                .byte   $00
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $46
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $46
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $46
                .byte   $00
                .byte   $54
                .byte   $00
                .byte   $00
                .byte   $BE
                .byte   $00
                .byte   $AA
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $00
                .byte   $01
                .byte   $B0
                .byte   $01
                .byte   $B0
                .byte   $00
                .byte   $BE
                .byte   $00
                .byte   $AA
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   $6B
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $87
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $50
                .byte   $AA
                .byte   $50
                .byte   $FE
                .byte   $50
                .byte   $AA
                .byte   $50
                .byte   $00
                .byte   $40
                .byte   $51
                .byte   $D6
                .byte   $20
                .byte   $7D
                .byte   $01
                .byte   $68
                .byte   $01
                .byte   $53
                .byte   $51
                .byte   $D6
                .byte   $50
                .byte   $7D
                .byte   $51
                .byte   $FE
                .byte   $20
                .byte   $7D
                .byte   $01
                .byte   $68
                .byte   $01
                .byte   $53
                .byte   $51
                .byte   $1D
                .byte   $51
                .byte   $FE
                .byte   $50
                .byte   $AA
                .byte   $50
                .byte   $FE
                .byte   $50
                .byte   $AA
                .byte   $20
                .byte   $1D
                .byte   $01
                .byte   $0D
                .byte   $01
                .byte   $00
                .byte   $FE
                .byte   $50
                .byte   $AA
                .byte   $20
                .byte   $7D
                .byte   $01
                .byte   $68
                .byte   $01
                .byte   $53
                .byte   $51
                .byte   $1D
                .byte   $51
                .byte   $00
                .byte   $D6
                .byte   $50
                .byte   $8F
                .byte   $50
                .byte   $D6
                .byte   $50
                .byte   $8F
                .byte   $50
                .byte   $00
                .byte   $40
                .byte   $51
                .byte   $D6
                .byte   $50
                .byte   $53
                .byte   $01
                .byte   $53
                .byte   $41
                .byte   $D6
                .byte   $50
                .byte   $7D
                .byte   $51
                .byte   $FE
                .byte   $20
                .byte   $7D
                .byte   $01
                .byte   $68
                .byte   $01
                .byte   $53
                .byte   $51
                .byte   $1D
                .byte   $51
                .byte   $00
                .byte   $A7
                .byte   $52
                .byte   $C5
                .byte   $51
                .byte   $A7
                .byte   $52
                .byte   $C5
                .byte   $51
                .byte   $00
                .byte   $81
                .byte   $52
                .byte   $AC
                .byte   $51
                .byte   $81
                .byte   $52
                .byte   $AC
                .byte   $51
                .byte   $00
                .byte   ";R}Q;R}Q"
                .byte   $00
                .byte   $FD
                .byte   $51
                .byte   $53
                .byte   $51
                .byte   $FD
                .byte   $51
                .byte   $53
                .byte   $51
                .byte   $00
                .byte   $AC
                .byte   $51
                .byte   $1D
                .byte   $51
                .byte   $AC
                .byte   $51
                .byte   $1D
                .byte   $51
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $04
                .byte   $00
                .byte   $BC
                .byte   $00
                .byte   $56
                .byte   $FB
                .byte   $56
                .byte   $FB
                .byte   $4D
                .byte   $FB
                .byte   $67
                .byte   $FB
                .byte   $56
                .byte   $FB
                .byte   $56
                .byte   $FB
                .byte   $4D
                .byte   $FB
                .byte   $67
                .byte   $FB
                .byte   $00
                .byte   $FE
                .byte   $02
                .byte   $00
                .byte   $17
                .byte   $00
                .byte   $E1
                .byte   $FB
                .byte   $00
                .byte   $FE
                .byte   $04
                .byte   $00
                .byte   $BC
                .byte   $00
                .byte   $78
                .byte   $FB
                .byte   $56
                .byte   $FB
                .byte   $7F
                .byte   $FB
                .byte   $00
                .byte   $FF
                .byte   $D7
                .byte   $FA
                .byte   $00
                .byte   $FE
                .byte   $02
                .byte   $00
                .byte   $30
                .byte   $00
                HiAscii "F{F{F{F{F{F{F{"
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $E8
                .byte   $FC
                .byte   $00
                .byte   $30
                .byte   $00
                HiAscii "F{F{F{F{F{F{F{"
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $E8
                .byte   $FC
                .byte   $00
                .byte   $1C
                .byte   $00
                .byte   $E1
                .byte   $FB
                .byte   $46
                .byte   $FC
                .byte   $00
                .byte   $30
                .byte   $00
                HiAscii "F{F{F{F{"
                .byte   $4D
                .byte   $FC
                .byte   $4D
                .byte   $FC
                .byte   $00
                .byte   $7F
                .byte   $00
                .byte   $88
                .byte   $FC
                .byte   $00
                .byte   $FF
                .byte   $FF
                .byte   $FA
                .byte   $AA
                .byte   $70
                .byte   $BE
                .byte   $20
                .byte   $FE
                .byte   $80
                .byte   $E3
                .byte   $B0
                .byte   $00
                .byte   $FE
                .byte   $70
                .byte   $E3
                .byte   $20
                .byte   $1D
                .byte   $51
                .byte   $53
                .byte   $51
                .byte   $FE
                .byte   $40
                .byte   $FE
                .byte   $40
                .byte   $E3
                .byte   $20
                .byte   $1D
                .byte   $81
                .byte   $00
                .byte   $AA
                .byte   $70
                .byte   $BE
                .byte   $20
                .byte   $FE
                .byte   $40
                .byte   $FE
                .byte   $40
                .byte   $BE
                .byte   $20
                .byte   $E3
                .byte   $80
                .byte   $AA
                .byte   $50
                .byte   $7F
                .byte   $50
                .byte   $00
                .byte   "}aSa"
                .byte   $1D
                .byte   $61
                .byte   $00
                .byte   $FE
                .byte   $70
                .byte   $E3
                .byte   $20
                .byte   $1D
                .byte   $51
                .byte   $53
                .byte   $51
                .byte   $FE
                .byte   $40
                .byte   $FE
                .byte   $40
                .byte   $E3
                .byte   $20
                .byte   $1D
                .byte   $51
                .byte   $BE
                .byte   $50
                .byte   $AA
                .byte   $70
                .byte   $BE
                .byte   $20
                .byte   $AA
                .byte   $50
                .byte   $8F
                .byte   $50
                .byte   $BE
                .byte   $80
                .byte   $AA
                .byte   $80
                .byte   $AA
                .byte   $70
                .byte   $BE
                .byte   $20
                .byte   $AA
                .byte   $50
                .byte   $8F
                .byte   $50
                .byte   $BE
                .byte   $80
                .byte   $AA
                .byte   $50
                .byte   $8F
                .byte   $50
                .byte   $71
                .byte   $40
                .byte   $7F
                .byte   $40
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   $70
                .byte   $5E
                .byte   $20
                .byte   $7F
                .byte   $80
                .byte   $71
                .byte   $80
                .byte   $71
                .byte   $40
                .byte   $7F
                .byte   $40
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   "p^ q"
                .byte   $B0
                .byte   $00
                .byte   "}!q "
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   $50
                .byte   $71
                .byte   $20
                .byte   $8F
                .byte   " }!S!q "
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   $50
                .byte   $71
                .byte   $20
                .byte   $8F
                .byte   $50
                .byte   $00
                .byte   "T q ^ TPq ^ T "
                .byte   $7F
                .byte   $20
                .byte   $7F
                .byte   $20
                .byte   $7F
                .byte   " q ^ "
                .byte   $AA
                .byte   $50
                .byte   $7F
                .byte   $00
                .byte   $71
                .byte   $00
                .byte   "T q ^ TP"
                .byte   $7F
                .byte   $50
                .byte   $7F
                .byte   $50
                .byte   $7F
                .byte   $20
                .byte   $7F
                .byte   $20
                .byte   $71
                .byte   $50
                .byte   $AA
                .byte   $50
                .byte   $71
                .byte   $00
                .byte   $5E
                .byte   $00
                .byte   "T q ^ TPq ^ T "
                .byte   $7F
                .byte   $20
                .byte   $7F
                .byte   $20
                .byte   $7F
                .byte   " qP^P^"
                .byte   $00
                .byte   $59
                .byte   $00
                .byte   "T q ^ TP"
                .byte   $7F
                .byte   $50
                .byte   $7F
                .byte   $50
                .byte   $7F
                .byte   $20
                .byte   $7F
                .byte   $20
                .byte   $71
                .byte   $20
                .byte   $00
                .byte   $01
                .byte   $20
                .byte   $AA
                .byte   $50
                .byte   $B4
                .byte   $20
                .byte   $00
                .byte   $D6
                .byte   " q T "
                .byte   $7F
                .byte   "Pq T "
                .byte   $D6
                .byte   $20
                .byte   $E3
                .byte   " q ^ "
                .byte   $7F
                .byte   "Pq ^ "
                .byte   $E3
                .byte   $20
                .byte   $FE
                .byte   " k ^ "
                .byte   $8F
                .byte   "Pk ^ "
                .byte   $FE
                .byte   $20
                .byte   $1D
                .byte   "!q ^ "
                .byte   $AA
                .byte   $20
                .byte   $8F
                .byte   $20
                .byte   $7F
                .byte   " q ^ "
                .byte   $00
                .byte   $D6
                .byte   " q T "
                .byte   $7F
                .byte   $20
                .byte   $D6
                .byte   " q T "
                .byte   $D6
                .byte   $20
                .byte   $CA
                .byte   " q T "
                .byte   $7F
                .byte   $20
                .byte   $CA
                .byte   " q T "
                .byte   $CA
                .byte   $20
                .byte   $BE
                .byte   " ^ T q "
                .byte   $BE
                .byte   " ^ T "
                .byte   $BE
                .byte   $20
                .byte   $AA
                .byte   " ^ T q "
                .byte   $AA
                .byte   " ^ T "
                .byte   $AA
                .byte   $20
                .byte   $D6
                .byte   " q T "
                .byte   $7F
                .byte   $20
                .byte   $D6
                .byte   " q T "
                .byte   $D6
                .byte   $20
                .byte   $E3
                .byte   " q ^ "
                .byte   $7F
                .byte   $20
                .byte   $E3
                .byte   " q ^ "
                .byte   $E3
                .byte   $20
                .byte   $2E
                .byte   $21
                .byte   $7F
                .byte   " q T"
                .byte   $80
                .byte   $7F
                .byte   $00
                .byte   $8F
                .byte   $00
                .byte   $AA
                .byte   " }!S!"
                .byte   $1D
                .byte   $21
                .byte   $FE
                .byte   $20
                .byte   $E3
                .byte   $20
                .byte   $BE
                .byte   $20
                .byte   $AA
                .byte   $20
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $07
                .byte   $00
                .byte   $BC
                .byte   $00
                .byte   $93
                .byte   $FD
                .byte   $96
                .byte   $FD
                .byte   $00
                .byte   $FF
                .byte   $0D
                .byte   $FD
                .byte   $00
                .byte   $FE
                .byte   $07
                .byte   $00
                .byte   $84
                .byte   $00
                .byte   $1D
                .byte   $FE
                .byte   $00
                .byte   $02
                .byte   $00
                .byte   $50
                .byte   $FE
                .byte   $2E
                .byte   $FE
                .byte   $50
                .byte   $FE
                .byte   $3F
                .byte   $FE
                .byte   $50
                .byte   $FE
                .byte   $3F
                .byte   $FE
                .byte   $50
                .byte   $FE
                .byte   $2E
                .byte   $FE
                .byte   $5F
                .byte   $FE
                .byte   $5F
                .byte   $FE
                .byte   $5F
                .byte   $FE
                .byte   $5F
                .byte   $FE
                .byte   $50
                .byte   $FE
                .byte   $3F
                .byte   $FE
                .byte   $50
                .byte   $FE
                .byte   $2E
                .byte   $FE
                .byte   $00
                .byte   $FF
                .byte   $1E
                .byte   $FD
                .byte   $00
                .byte   $FE
                .byte   $07
                .byte   $00
                .byte   $0A
                .byte   $00
                .byte   $1D
                .byte   $FE
                .byte   $00
                .byte   $50
                .byte   $00
                .byte   $72
                .byte   $FE
                .byte   $72
                .byte   $FE
                .byte   $72
                .byte   $FE
                .byte   $7B
                .byte   $FE
                .byte   $84
                .byte   $FE
                .byte   $72
                .byte   $FE
                .byte   $8D
                .byte   $FE
                .byte   $98
                .byte   $FE
                .byte   $7B
                .byte   $FE
                .byte   $84
                .byte   $FE
                .byte   $7B
                .byte   $FE
                .byte   $84
                .byte   $FE
                .byte   $98
                .byte   $FE
                .byte   $72
                .byte   $FE
                .byte   $72
                .byte   $FE
                .byte   $98
                .byte   $FE
                .byte   $00
                .byte   $FF
                .byte   $4D
                .byte   $FD
                .byte   $00
                .byte   $FE
                .byte   $07
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $F9
                .byte   $FD
                .byte   $03
                .byte   $FE
                .byte   $03
                .byte   $FE
                .byte   $03
                .byte   $FE
                .byte   $0D
                .byte   $FE
                .byte   $F9
                .byte   $FD
                .byte   $13
                .byte   $FE
                .byte   $13
                .byte   $FE
                .byte   $13
                .byte   $FE
                .byte   $13
                .byte   $FE
                .byte   $03
                .byte   $FE
                .byte   $03
                .byte   $FE
                .byte   $00
                .byte   $FF
                .byte   $79
                .byte   $FD
                .byte   $01
                .byte   $C0
                .byte   $00
                .byte   $1D
                .byte   $91
                .byte   $FE
                .byte   $20
                .byte   $D6
                .byte   $30
                .byte   $1D
                .byte   $C1
                .byte   $FE
                .byte   $90
                .byte   $1D
                .byte   $21
                .byte   $53
                .byte   $11
                .byte   $1D
                .byte   $11
                .byte   $7D
                .byte   $C1
                .byte   $53
                .byte   $91
                .byte   $7D
                .byte   $21
                .byte   $53
                .byte   $11
                .byte   $1D
                .byte   $11
                .byte   $FE
                .byte   $90
                .byte   $1D
                .byte   $91
                .byte   $53
                .byte   $21
                .byte   $1D
                .byte   "1}a}"
                .byte   $11
                .byte   $53
                .byte   $11
                .byte   $7D
                .byte   $11
                .byte   $53
                .byte   $11
                .byte   $AC
                .byte   $C1
                .byte   "}!}1}!"
                .byte   $AC
                .byte   $11
                .byte   $7D
                .byte   $11
                .byte   $53
                .byte   $C1
                .byte   $BE
                .byte   $20
                .byte   $BE
                .byte   $30
                .byte   $BE
                .byte   $20
                .byte   $D6
                .byte   $10
                .byte   $BE
                .byte   $10
                .byte   $AA
                .byte   $C0
                .byte   $8F
                .byte   $20
                .byte   $8F
                .byte   $30
                .byte   $AA
                .byte   $20
                .byte   $BE
                .byte   $10
                .byte   $D6
                .byte   $10
                .byte   $FE
                .byte   $C0
                .byte   $1D
                .byte   $21
                .byte   $1D
                .byte   $31
                .byte   $FE
                .byte   $60
                .byte   $1D
                .byte   $11
                .byte   $FE
                .byte   $10
                .byte   $1D
                .byte   $11
                .byte   $FE
                .byte   $10
                .byte   $D6
                .byte   $C0
                .byte   $00
                .byte   $11
                .byte   $11
                .byte   $11
                .byte   $11
                .byte   "11aa1"
                .byte   $00
                .byte   "acacac"
                .byte   $01
                .byte   $11
                .byte   $63
                .byte   $00
                .byte   $61
                .byte   $61
                .byte   $01
                .byte   $11
                .byte   $33
                .byte   $00
                .byte   $11
                .byte   $31
                .byte   $11
                .byte   $31
                .byte   $11
                .byte   $31
                .byte   $11
                .byte   $31
                .byte   $63
                .byte   $00
                .byte   $D6
                .byte   $10
                .byte   $D6
                .byte   $10
                .byte   $D6
                .byte   $10
                .byte   $D6
                .byte   $10
                .byte   $D6
                .byte   $30
                .byte   $D6
                .byte   $30
                .byte   $D6
                .byte   $60
                .byte   $D6
                .byte   $60
                .byte   $00
                .byte   "k0k0"
                .byte   $8F
                .byte   $30
                .byte   $8F
                .byte   $30
                .byte   $7F
                .byte   $10
                .byte   $7F
                .byte   $10
                .byte   $7F
                .byte   $30
                .byte   $8F
                .byte   $60
                .byte   $00
                .byte   $7F
                .byte   $30
                .byte   $7F
                .byte   $30
                .byte   $8F
                .byte   $30
                .byte   $8F
                .byte   $30
                .byte   $7F
                .byte   $10
                .byte   $7F
                .byte   $10
                .byte   $7F
                .byte   $30
                .byte   $8F
                .byte   $60
                .byte   $00
                .byte   $7F
                .byte   $30
                .byte   $7F
                .byte   $30
                .byte   $8F
                .byte   $60
                .byte   $7F
                .byte   $10
                .byte   $7F
                .byte   $10
                .byte   $7F
                .byte   $30
                .byte   $8F
                .byte   $60
                .byte   $00
                .byte   $7F
                .byte   $30
                .byte   $7F
                .byte   $30
                .byte   $7F
                .byte   $30
                .byte   $8F
                .byte   $10
                .byte   $7F
                .byte   $30
                .byte   $7F
                .byte   $30
                .byte   $8F
                .byte   $10
                .byte   $7F
                .byte   $30
                .byte   $8F
                .byte   $30
                .byte   $00
                .byte   $FE
                .byte   $60
                .byte   $1D
                .byte   $61
                .byte   $FE
                .byte   $60
                .byte   $1D
                .byte   $61
                .byte   $00
                .byte   $E3
                .byte   $60
                .byte   $1D
                .byte   $61
                .byte   $E3
                .byte   $60
                .byte   $1D
                .byte   $61
                .byte   $00
                .byte   $D6
                .byte   $60
                .byte   $1D
                .byte   $61
                .byte   $D6
                .byte   $60
                .byte   $1D
                .byte   $61
                .byte   $00
                .byte   $D6
                .byte   $60
                .byte   $1D
                .byte   $61
                .byte   $E3
                .byte   $60
                .byte   $1D
                .byte   $31
                .byte   $FE
                .byte   $30
                .byte   $00
                .byte   $AA
                .byte   $60
                .byte   $1D
                .byte   $61
                .byte   $AA
                .byte   $60
                .byte   $1D
                .byte   $61
                .byte   $00
                .byte   $00
                .byte   $FE
                .byte   $08
                .byte   $00
                .byte   $7C
                .byte   $00
                .byte   $32
                .byte   $FF
                .byte   $32
                .byte   $FF
                .byte   $32
                .byte   $FF
                .byte   $39
                .byte   $FF
                .byte   $32
                .byte   $FF
                .byte   $32
                .byte   $FF
                .byte   $32
                .byte   $FF
                .byte   $39
                .byte   $FF
                .byte   $00
                .byte   $4F
                .byte   $00
                .byte   $32
                .byte   $FF
                .byte   $EC
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $A4
                .byte   $FE
                .byte   $00
                .byte   $FE
                .byte   $08
                .byte   $00
                .byte   $4F
                .byte   $00
                .byte   $4E
                .byte   $FF
                .byte   $4E
                .byte   $FF
                .byte   $6F
                .byte   $FF
                .byte   $EC
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $C5
                .byte   $FE
                .byte   $00
                .byte   $FE
                .byte   $08
                .byte   $00
                .byte   $70
                .byte   $00
                .byte   $C9
                .byte   $FF
                .byte   $74
                .byte   $FF
                .byte   $74
                .byte   $FF
                .byte   $74
                .byte   $FF
                .byte   $74
                .byte   $FF
                .byte   $87
                .byte   $FF
                .byte   $9A
                .byte   $FF
                .byte   $AD
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $74
                .byte   $FF
                .byte   $74
                .byte   $FF
                .byte   $74
                .byte   $FF
                .byte   $74
                .byte   $FF
                .byte   $87
                .byte   $FF
                .byte   $9A
                .byte   $FF
                .byte   $AD
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $C7
                .byte   $FF
                .byte   $EC
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $D7
                .byte   $FE
                .byte   $00
                .byte   $FE
                .byte   $08
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $CC
                .byte   $FF
                .byte   $CE
                .byte   $FF
                .byte   $D7
                .byte   $FF
                .byte   $CE
                .byte   $FF
                .byte   $D7
                .byte   $FF
                .byte   $CE
                .byte   $FF
                .byte   $D7
                .byte   $FF
                .byte   $CE
                .byte   $FF
                .byte   $E3
                .byte   $FF
                .byte   $CE
                .byte   $FF
                .byte   $D7
                .byte   $FF
                .byte   $CE
                .byte   $FF
                .byte   $D7
                .byte   $FF
                .byte   $CE
                .byte   $FF
                .byte   $D7
                .byte   $FF
                .byte   $CE
                .byte   $FF
                .byte   $E3
                .byte   $FF
                .byte   $EF
                .byte   $FF
                .byte   $00
                .byte   $FF
                .byte   $07
                .byte   $FF
                .byte   $1D
                .byte   $61
                .byte   $FE
                .byte   $60
                .byte   $AA
                .byte   $80
                .byte   $00
                .byte   $8F
                .byte   $60
                .byte   $97
                .byte   $60
                .byte   $A0
                .byte   $90
                .byte   $A0
                .byte   $30
                .byte   $AA
                .byte   $30
                .byte   $A0
                .byte   $30
                .byte   $BE
                .byte   $30
                .byte   $01
                .byte   $30
                .byte   $BE
                .byte   $30
                .byte   $01
                .byte   $60
                .byte   $00
                .byte   $01
                .byte   $90
                .byte   "T q "
                .byte   $8F
                .byte   $60
                .byte   $54
                .byte   $C0
                .byte   "T k "
                .byte   $7F
                .byte   $60
                .byte   $54
                .byte   $C0
                .byte   "q T F`e"
                .byte   $C0
                .byte   $5E
                .byte   $C0
                .byte   $01
                .byte   $30
                .byte   $46
                .byte   $20
                .byte   $00
                .byte   $01
                .byte   $90
                .byte   $6B
                .byte   $80
                .byte   $00
                .byte   $D6
                .byte   $30
                .byte   $01
                .byte   $10
                .byte   $D6
                .byte   $10
                .byte   $01
                .byte   $30
                .byte   $D6
                .byte   $30
                .byte   $01
                .byte   $00
                .byte   $D6
                .byte   $10
                .byte   $1D
                .byte   $31
                .byte   $FE
                .byte   $30
                .byte   $00
                .byte   $E3
                .byte   $30
                .byte   $01
                .byte   $10
                .byte   $E3
                .byte   $10
                .byte   $01
                .byte   $30
                .byte   $E3
                .byte   $30
                .byte   $01
                .byte   $00
                .byte   $E3
                .byte   $10
                .byte   $1D
                .byte   $31
                .byte   $53
                .byte   $31
                .byte   $00
                .byte   $FE
                .byte   $30
                .byte   $01
                .byte   $10
                .byte   $FE
                .byte   $10
                .byte   $01
                .byte   $30
                .byte   $FE
                .byte   $30
                .byte   $01
                .byte   $00
                .byte   $FE
                .byte   $10
                .byte   $53
                .byte   $31
                .byte   $FE
                .byte   $30
                .byte   $00
                .byte   $BE
                .byte   $30
                .byte   $01
                .byte   $10
                .byte   $BE
                .byte   $10
                .byte   $01
                .byte   $30
                .byte   $BE
                .byte   $30
                .byte   $01
                .byte   $00
                .byte   $BE
                .byte   $10
                .byte   $FE
                .byte   $30
                .byte   $F0
                .byte   $30
                .byte   $00
                .byte   $01
                .byte   $30
                .byte   $1D
                .byte   $31
                .byte   $01
                .byte   $50
                .byte   $00
                .byte   $1D
                .byte   $C1
                .byte   $01
                .byte   $90
                .byte   $00
                .byte   $90
                .byte   $00
                .byte   $02
                .byte   $12
                .byte   "422424"
                .byte   $00
                .byte   $12
                .byte   $12
                .byte   $32
                .byte   $34
                .byte   $32
                .byte   $14
                .byte   $14
                .byte   $12
                .byte   $14
                .byte   $34
                .byte   $34
                .byte   $00
                .byte   $32
                .byte   $22
                .byte   $14
                .byte   $14
                .byte   $14
                .byte   $14
                .byte   $34
                .byte   $34
                .byte   $00
                .byte   $01
                .byte   $D0
                .byte   $00
                .byte   $D1
IRQ:            .byte   $81
                .byte   $00
                .byte   $FF
                .byte   $00
LFFF4:          .byte   $30
                .byte   $31
                .byte   $32
LFFF7:          .byte   $33
                .byte   $00
                .byte   $00
;*******************************************************************************
;* Vector                                                                      *
;*******************************************************************************
                .word   NMI
                .word   RST
                .word   IRQ                             ;unused
;*******************************************************************************
;* CHR                                                                         *
;*******************************************************************************
                ; snip
