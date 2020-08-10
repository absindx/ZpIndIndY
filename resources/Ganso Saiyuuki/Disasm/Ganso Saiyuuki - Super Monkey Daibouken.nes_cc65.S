; Target assembler: cc65 v2.18.0 [--target none -C Ganso Saiyuuki - Super Monkey Daibouken.nes_cc65.cfg]
;*******************************************************************************
;* Ganso Saiyuuki - Super Monkey Daibouken Disassembly                         *
;*******************************************************************************
                .setcpu "6502"
VmMem_Pointer   =       $32
VmMem_Temp      =       $34
VmMem_SecondStack =     $36
ProcessStateCounter =   $3D
ProcessedStateCounter = $3F
PpuControlBuffer =      $41                             ;$41=Base nametable, $42=Base nametable, $43=Increment direction, $44=SP Address, $45=BG Address, $46=Sprite size, $47=PPU master/slave, $48=NMI enable
PpuMaskBuffer   =       $49                             ;$49=Greyscale, $4A=BG left, $4B=SP left, $4C=BG enable, $4D=SP enable, $4E=Emphasize R, $4F=Emphasize G, $50=Emphasize B
ScreenX         =       $57
ScreenY         =       $59
FieldPageY      =       $BC
FieldPageX      =       $BE
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
PadBuffer_Prev  =       $0328                           ;ABsS^v<>
PadBuffer_Trigger =     $0330                           ;ABsS^v<>
PartyLifes      =       $03C8                           ;Goku, Sanzo, Horse, Sagojo, Chohakkai
PartyIn_Chohakkai =     $047E
PartyIn_Sagojo  =       $047F
VmStack_Low     =       $0600
VmStack_High    =       $0680
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
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $40
                .byte   $00
                .byte   $20
                .byte   $00
                .byte   $10
                .byte   $00
                .byte   $08
                .byte   $00
                .byte   $04
                .byte   $00
                .byte   $02
                .byte   $00
                .byte   $01
                .byte   $80
                .byte   $00
                .byte   $40
                .byte   $00
                .byte   $20
                .byte   $00
                .byte   $10
                .byte   $00
                .byte   $08
                .byte   $00
                .byte   $04
                .byte   $00
                .byte   $02
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $01
                .byte   $00
                .byte   $05
                .byte   $00
                .byte   $80
                .byte   $00
                .byte   $C0
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $FC
                .byte   $00
                .byte   $FF
                .byte   $80
                .byte   $FF
                .byte   $00
                .byte   $FE
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $F8
                .byte   $00
                .byte   $F0
                .byte   $00
                .byte   $E0
                .byte   $00
                .byte   $80
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
                .byte   $00
                .byte   $05
                .res    15,$FF
                .byte   $CF,$FE,$CF,$FC,$87
                .byte   $3C
                .byte   $03
                .byte   $3C
                .byte   $00
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
                .byte   $00
                .byte   $05
                .byte   $00
                .byte   $FF
                .byte   $18
                .byte   $FC
                .byte   $78
.macro          HiAscii Arg
                .repeat .strlen(Arg), I
                .byte   .strat(Arg, I) | $80
                .endrep
.endmacro
                HiAscii "`x@pap"
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $01
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
                .byte   $00
                .byte   $00
                .byte   $00
                .byte   $05
L8374:          .byte   $08
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
                .byte   $03
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
                .byte   $03
                .byte   $05
                .byte   $0D
                .res    12,$00
                .byte   $80
                .res    11,$00
                .byte   $03
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
                .byte   $03
                .byte   $05
                .byte   $0F
                .res    12,$00
                .byte   $80
                .res    11,$00
                .byte   $06
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
                .byte   $06
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
                .byte   $06
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
                .byte   $05
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
                .byte   $05
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
                .byte   $01
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
                .byte   $05
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
                .byte   $05
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
                .byte   $05
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
                .byte   $05
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
                .byte   $05
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
                .byte   $05
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
                .byte   $00
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
                .byte   $02
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
                .byte   $02
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
                .byte   $06
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
                .byte   $07
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
                .byte   $04
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
                .byte   $07
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
                .byte   $06
                .byte   $05
                .byte   $0A
                .byte   $00
                .byte   $80
                .byte   $00
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
                .byte   $06
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
                .byte   $05
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
                .byte   $08
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
                .byte   $03
                .byte   $03
                .byte   $0B
                .res    18,$00
                .byte   $E0
                .res    5,$FF
                .byte   $03
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
                .byte   $03
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
                .byte   $07
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
                .byte   $06
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
                .byte   $07
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
                .byte   $08
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
                .byte   $02
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
                .byte   $03
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
                .byte   $02
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
                .byte   $07
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
                .byte   $07
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
                .byte   $04
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
                .byte   $06
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
                .byte   $03
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
                .byte   $01
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
                .byte   $07
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
                .byte   $07
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
                .byte   $05
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
                .byte   $06
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
                .byte   $09
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
                .byte   $04
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
                .byte   $05
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
                .byte   $06
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
                .byte   $06
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
                .byte   $09
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
                .byte   $08
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
                .byte   $06
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
                .byte   $01
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
                .byte   $04
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
                .byte   $05
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
                .byte   $06
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
                .byte   $06
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
                .byte   $06
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
                .byte   $06
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
                .byte   $07
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
                .byte   $06
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
                .byte   $09
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
                .byte   $04
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
                .byte   $08
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
                .byte   $08
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
                .byte   $08
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
                .byte   $08
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
                .byte   $08
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
                .byte   $06
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
                .byte   $06
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
                .byte   $06
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
                .byte   $05
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
                .byte   $05
                .byte   $0B
                .res    12,$FF
                .byte   $00
                .byte   $FF
                .byte   $C0
                .byte   $FF
                .byte   $F8
                .res    7,$FF
                .byte   $03
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
                .byte   $03
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
                .byte   $00
                .byte   $0B
                .byte   $00
                .byte   $0C
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
                .byte   $03
                .byte   $0B
                .res    12,$FF
                .byte   $1C
                .byte   $7E
                .byte   $00
                .byte   $18
                .res    8,$00
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
                .byte   $05
                .byte   $0B
                .byte   $FF
                .byte   $FF
                .byte   $F0
                .byte   $FF
                .byte   $00
                .byte   $1C
                .res    18,$00
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
                .byte   $05
                .byte   $0B
                .res    15,$00
                .byte   $F0
                .byte   $00
                .byte   $FF
                .byte   $FE
                .res    5,$FF
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
                .byte   $05
                .byte   $0C
                .res    14,$FF
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
                .byte   $05
                .byte   $0B
                .res    10,$00
                .byte   $F0
                .byte   $0F
                .res    12,$FF
                .byte   $03
                .byte   $05
                .byte   $0B
                .res    18,$00
                .byte   $04
                .byte   $60
                .byte   $0F
                .byte   $F8
                .byte   $0F
                .byte   $FC
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                .byte   $03
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
                JSR     VmOp_Add_AB                     ;Stack[1] = Mem[Stack[0] + stack[1]]
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
                LDA     $0780,y
                ADC     #$01
                STA     $07C0,y
                RTS

                LDY     VmMem_SecondStack
                LDA     $0780,y
                CMP     $07C0,y
                BEQ     L9631
                CLC
                RTS

L9601:          DEC     VmMem_SecondStack
                LDY     VmMem_SecondStack
                LDA     VmStack_Low,x
                STA     $0780,y
                LDA     VmStack_High,x
                STA     $07A0,y
                INX
                LDA     VmStack_Low,x
                STA     $07C0,y
                LDA     VmStack_High,x
                STA     $07E0,y
                INX
                RTS

L9620:          LDY     VmMem_SecondStack
                SEC
                LDA     $0780,y
                SBC     $07C0,y
                LDA     $07A0,y
                SBC     $07E0,y
                BCC     L9635
L9631:          INC     VmMem_SecondStack
                SEC
                RTS

L9635:          TXA
                PHA
                TYA
                TAX
                INC     $0780,x
                BNE     @L9641
                INC     $07A0,x
@L9641:         PLA
                TAX
                CLC
                RTS

L9645:          LDY     VmMem_SecondStack
                SEC
                LDA     $0780,y
                SBC     $07C0,y
                LDA     $07A0,y
                SBC     $07E0,y
                PHP
                CLC
                LDA     VmStack_Low,x
                ADC     $0780,y
                STA     $0780,y
                LDA     VmStack_High,x
                ADC     $07A0,y
                STA     $07A0,y
                SEC
                LDA     $0780,y
                SBC     $07C0,y
                LDA     $07A0,y
                SBC     $07E0,y
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
                LDA     $07C0,y
                STA     $0780,y
                LDA     $07E0,y
                STA     $07A0,y
                RTS

L9695:          LDY     VmMem_SecondStack
@L9697:         DEX
                LDA     $0780,y
                STA     VmStack_Low,x
                LDA     $07A0,y
                STA     VmStack_High,x
                RTS

                LDY     VmMem_SecondStack
                INY
                JMP     @L9697

VmOp_PopRegister:
                LDY     VmStack_Low,x
                LDA     VmStack_High,x
                INX
                RTS

VmOp_ReadTempMemAddr:
                JSR     VmOp_PushMemory
                JSR     VmOp_ReadAddressWord
VmOp_PopMemory: JSR     VmOp_PopRegister
                STY     VmMem_Temp
                STA     VmMem_Temp+1
                RTS

; [VmMem_Temp - (A + 2)] = [VmMem_Temp]
; Argument: A = Offset
; Example:
;   VmMem_Temp = #$0780, A = #$06
;   => VmMem_Temp = $0778, $0778 = #$0780
VmHelper_SaveMemTemp:
                JSR     VmOp_PushByte                   ;[0] arg
                JSR     VmOp_AddConst_02                ;[0] arg + #2
                JSR     VmOp_Duplicate                  ;[0] arg + #2, [1] arg + #2
                JSR     VmOp_PushMemory                 ;[0] VmMem_Temp, [1] arg + #2, [2] arg + #2
                JSR     VmOp_Swap                       ;[0] arg + #2, [1] VmMem_Temp, [2] arg + #2
                JSR     VmOp_Sub_BA                     ;[0] VmMem_Temp - (arg + #2), [1] arg + #2
                JSR     VmOp_PopMemory                  ;Update VmMem_Temp
                JSR     VmOp_PushMemory                 ;[0] VmMem_Temp - (arg + #2), [1] arg + #2
                JSR     VmOp_Add_AB                     ;[0] VmMem_Temp
                JSR     VmOp_PushMemory                 ;[0] VmMem_Temp - (arg + #2), [1] VmMem_Temp
                JMP     VmOp_WriteWord

VmHelper_SaveMemTemp_02:
                LDA     #$02
                BNE     VmHelper_SaveMemTemp

VmHelper_SaveMemTemp_04:
                LDA     #$04
                BNE     VmHelper_SaveMemTemp

VmHelper_SaveMemTemp_06:
                LDA     #$06
                BNE     VmHelper_SaveMemTemp

VmHelper_SaveMemTemp_08:
                LDA     #$08
                BNE     VmHelper_SaveMemTemp

VmHelper_SaveMemTemp_0A:
                LDA     #$0A
                BNE     VmHelper_SaveMemTemp

VmHelper_SaveMemTemp_0C:
                LDA     #$0C
                BNE     VmHelper_SaveMemTemp

VmHelper_SaveMemTemp_0E:
                LDA     #$0E
                BNE     VmHelper_SaveMemTemp

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
VmOp_WriteTempAddressWord:
                LDA     VmStack_Low,x
                STA     (VmMem_Temp),y
                INY
                LDA     VmStack_High,x
                STA     (VmMem_Temp),y
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
                LDA     (VmMem_Temp),y
                STA     VmStack_Low,x
                INY
                LDA     (VmMem_Temp),y
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

VmOp_IndirectJump:
                LDA     #$4C                            ;#$4C = JMP
                STA     $3A
                LDA     VmStack_Low,x
                STA     $3B
                LDA     VmStack_High,x
                STA     $3C
                INX
                JMP     $003A                           ;Same as : JMP ($003B)

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

VmOp_PushMemory:
                LDY     VmMem_Temp
                LDA     VmMem_Temp+1
; High = A, Low = Y
VmOp_PushRegister:
                DEX
                STA     VmStack_High,x
                TYA
                STA     VmStack_Low,x
                RTS

                .byte   $DD
                .byte   $90
                .byte   $AE
                .byte   $8B
                .byte   $AE
                .byte   $8B
                .byte   $AE
                .byte   $8B
                .byte   $AE
                .byte   $8B
                .byte   $AE
                .byte   $8B
                .byte   $AE
                .byte   $8B
                .byte   $C9
                .byte   $8B
                .byte   $E4
                .byte   $8B
                .byte   $FF
                .byte   $8B
                .byte   $FF
                .byte   $8B
                .byte   $FF
                .byte   $8B
                .byte   $1A
                .byte   $8C
                .byte   $35
                .byte   $8C
                .byte   $62
                .byte   $8D
                .byte   $62
                .byte   $8D
                .byte   $62
                .byte   $8D
                .byte   $62
                .byte   $8D
                .byte   $62
                .byte   $8D
                .byte   $62
                .byte   $8D
                .byte   $62
                .byte   $8D
                .byte   $62
                .byte   $8D
                .byte   $62
                .byte   $8D
                .byte   $62
                .byte   $8D
                .byte   $16
                .byte   $84
                .byte   $82
                .byte   $84
                .byte   $67
                .byte   $84
                .byte   $82
                .byte   $84
                .byte   $82
                .byte   $84
                .byte   $82
                .byte   $84
                .byte   $82
                .byte   $84
                .byte   $EE
                .byte   $84
                .byte   $14
                .byte   $93
                .byte   $C5
                .byte   $83
                .byte   $39
                .byte   $8C
                .byte   $54
                .byte   $8C
                .byte   $54
                .byte   $8C
                .byte   $6F
                .byte   $8C
                .byte   $C5
                .byte   $83
                .byte   $8A
                .byte   $8C
                .byte   $A5
                .byte   $8C
                .byte   $C0
                .byte   $8C
                .byte   $DB
                .byte   $8C
                .byte   $F6
                .byte   $8C
                .byte   $11
                .byte   $8D
                .byte   $2C
                .byte   $8D
                .byte   $47
                .byte   $8D
                .byte   $C5
                .byte   $83
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $C5
                .byte   $83
                .byte   $5A
                .byte   $85
                .byte   $D3
                .byte   $84
                .byte   $31
                .byte   $84
                .byte   $4C
                .byte   $84
                .byte   $09
                .byte   $85
                .byte   $24
                .byte   $85
                .byte   $B8
                .byte   $84
                .byte   $B8
                .byte   $84
                .byte   $B8
                .byte   $84
                .byte   $C5
                .byte   $83
                .byte   $3F
                .byte   $85
                .byte   $13
                .byte   $91
                .byte   $FB
                .byte   $83
                .byte   $37
                .byte   $8C
                .byte   $8A
                .byte   $8C
                .byte   $A5
                .byte   $8C
                .byte   $62
                .byte   $8D
                .byte   $62
                .byte   $8D
                .byte   $62
                .byte   $8D
                .byte   $5A
                .byte   $85
                .byte   $7D
                .byte   $8D
                .byte   $98
                .byte   $8D,$B3,$8D,$CE,$8D,$C5
                .byte   $83
                .byte   $E9
                .byte   $8D
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $75
                .byte   $85
                .byte   $90
                .byte   $85
                .byte   $D3
                .byte   $84
                .byte   $AB
                .byte   $85
                .byte   $C6
                .byte   $85
                .byte   $E1
                .byte   $85
                .byte   $FC
                .byte   $85
                .byte   $17
                .byte   $86
                .byte   $A9
                .byte   $80
                .byte   $B8
                .byte   $84
                .byte   $B8
                .byte   $84
                .byte   $3F
                .byte   $85
                .byte   $04
                .byte   $8E
                .byte   $AE
                .byte   $8B
                .byte   $1F
                .byte   $8E
                .byte   $3A
                .byte   $8E
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $62
                .byte   $8D
                .byte   $62
                .byte   $8D
                .byte   $55
                .byte   $8E
                .byte   $70
                .byte   $8E
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $83
                .byte   $86
                .byte   $75
                .byte   $85
                .byte   $90
                .byte   $85
                .byte   $32
                .byte   $86
                .byte   $4D
                .byte   $86
                .byte   $FC
                .byte   $85
                .byte   $17
                .byte   $86
                .byte   $D3
                .byte   $84
                .byte   $E0
                .byte   $83
                .byte   $A9
                .byte   $80
                .byte   $3C
                .byte   $82
                .byte   $A9
                .byte   $80
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $8B
                .byte   $8E
                .byte   $A6
                .byte   $8E
                .byte   $A6
                .byte   $8E
                .byte   $C1
                .byte   $8E
                .byte   $5A
                .byte   $85
                .byte   $5A
                .byte   $85
                .byte   $C5
                .byte   $83
                .byte   $75
                .byte   $85
                .byte   $35
                .byte   $8C
                .byte   $48
                .byte   $8F
                .byte   $AE
                .byte   $8B
                .byte   $AE
                .byte   $8B
                .byte   $AE
                .byte   $8B
                .byte   $DC
                .byte   $8E
                .byte   $F7
                .byte   $8E
                .byte   $83
                .byte   $86
                .byte   $83
                .byte   $86
                .byte   $5A
                .byte   $85
                .byte   $C5
                .byte   $83
                .byte   $9E
                .byte   $86
                .byte   $B9
                .byte   $86
                .byte   $D4
                .byte   $86
                .byte   $EF
                .byte   $86
                .byte   $0A
                .byte   $87
                .byte   $25
                .byte   $87
                .byte   $B8
                .byte   $84
                .byte   $06
                .byte   $82
                .byte   $70
                .byte   $83
                .byte   $57
                .byte   $82
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $8B
                .byte   $8E
                .byte   $12
                .byte   $8F
                .byte   $2D
                .byte   $8F
                .byte   $FF
                .byte   $8B
                .byte   $FF
                .byte   $8B
                .byte   $DB
                .byte   $00
                .byte   $75
                .byte   $85
                .byte   $35
                .byte   $8C
                .byte   $48
                .byte   $8F
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $C5
                .byte   $83
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $40
                .byte   $87
                .byte   $5B
                .byte   $87
                .byte   $90
                .byte   $85
                .byte   $76
                .byte   $87
                .byte   $91
                .byte   $87,$AC,$87,$C7,$87,$E2,$87,$FD,$87,$B8
                .byte   $84
                .byte   $FB
                .byte   $83
                .byte   $21
                .byte   $82
                .byte   $72
                .byte   $82
                .byte   $A8
                .byte   $82
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $63
                .byte   $8F
                .byte   $7E
                .byte   $8F
                .byte   $2C
                .byte   $8D
                .byte   $35
                .byte   $8C
                .byte   $99
                .byte   $8F
                .byte   $35
                .byte   $8C
                .byte   $48
                .byte   $8F
                .byte   $B4
                .byte   $8F
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $CF
                .byte   $8F
                .byte   $D3
                .byte   $84
                .byte   $C5
                .byte   $83
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $18
                .byte   $88
                .byte   $B8
                .byte   $84
                .byte   $C5
                .byte   $83
                .byte   $33
                .byte   $88
                .byte   $4E
                .byte   $88
                .byte   $69
                .byte   $88
                .byte   $84
                .byte   $88
                .byte   $9F
                .byte   $88
                .byte   $C5
                .byte   $83
                .byte   $B8
                .byte   $84
                .byte   $31
                .byte   $84
                .byte   $BA
                .byte   $88
                .byte   $7F
                .byte   $81
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $04
                .byte   $8E
                .byte   $EA
                .byte   $8F
                .byte   $05
                .byte   $90
                .byte   $20
                .byte   $90
                .byte   $3B
                .byte   $90
                .byte   $56
                .byte   $90
                .byte   $71
                .byte   $90
                .byte   $48
                .byte   $8F
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $A7
                .byte   $90
                .byte   $C2
                .byte   $90
                .byte   $DD
                .byte   $90
                .byte   $2E
                .byte   $91
                .byte   $54
                .byte   $8C
                .byte   $F8
                .byte   $90
                .byte   $D5
                .byte   $88
                .byte   $E0
                .byte   $83
                .byte   $F0
                .byte   $88
                .byte   $0B
                .byte   $89
                .byte   $26
                .byte   $89
                .byte   $41
                .byte   $89
                .byte   $5C
                .byte   $89
                .byte   $E0
                .byte   $83
                .byte   $B8
                .byte   $84
                .byte   $31
                .byte   $84
                .byte   $4C
                .byte   $84
                .byte   $B8
                .byte   $84
                .byte   $C4
                .byte   $80
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $13
                .byte   $91
                .byte   $EA
                .byte   $8F
                .byte   $2E
                .byte   $91
                .byte   $54
                .byte   $8C
                .byte   $54
                .byte   $8C
                .byte   $54
                .byte   $8C
                .byte   $2E
                .byte   $91
                .byte   $8C
                .byte   $90
                .byte   $8C
                .byte   $90
                .byte   $C5
                .byte   $83
                .byte   $49
                .byte   $91
                .byte   $37
                .byte   $8C
                .byte   $64
                .byte   $91
                .byte   $B8
                .byte   $84
                .byte   $B8
                .byte   $84
                .byte   $37
                .byte   $8C
                .byte   $77
                .byte   $89
                .byte   $25
                .byte   $87
                .byte   $AD
                .byte   $89
                .byte   $C8
                .byte   $89
                .byte   $25
                .byte   $87
                .byte   $E3
                .byte   $89
                .byte   $FE
                .byte   $89
                .byte   $19
                .byte   $8A
                .byte   $FE
                .byte   $89
                .byte   $4C
                .byte   $84
                .byte   $C5
                .byte   $83
                .byte   $B8
                .byte   $84
                .byte   $8D
                .byte   $82
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $37
                .byte   $8C
                .byte   $7F
                .byte   $91
                .byte   $9A
                .byte   $91
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $8C
                .byte   $90
                .byte   $8C
                .byte   $90
                .byte   $8C
                .byte   $90
                .byte   $B5
                .byte   $91
                .byte   $D0
                .byte   $91
                .byte   $DD
                .byte   $90
                .byte   $EB
                .byte   $91
                .byte   $06
                .byte   $92
                .byte   $C5
                .byte   $83
                .byte   $DB
                .byte   $00
                .byte   $9D
                .byte   $84
                .byte   $AA
                .byte   $83
                .byte   $AA
                .byte   $83
                .byte   $C5
                .byte   $83
                .byte   $18
                .byte   $88
                .byte   $34
                .byte   $8A
                .byte   $4F
                .byte   $8A
                .byte   $6A
                .byte   $8A
                .byte   $B8
                .byte   $84
                .byte   $B8
                .byte   $84
                .byte   $B8
                .byte   $84
                .byte   $B8
                .byte   $84
                .byte   $C5
                .byte   $83
                .byte   $B5
                .byte   $81
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $37
                .byte   $8C
                .byte   $37
                .byte   $8C
                .byte   $21
                .byte   $92
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $8C
                .byte   $90
                .byte   $8C
                .byte   $90
                .byte   $8C
                .byte   $90
                .byte   $8C
                .byte   $90
                .byte   $B5
                .byte   $91
                .byte   $C5
                .byte   $83
                .byte   $B8
                .byte   $84
                .byte   $B8
                .byte   $84
                .byte   $EB
                .byte   $91
                .byte   $06
                .byte   $92
                .byte   $37
                .byte   $8C
                .byte   $9D
                .byte   $84
                .byte   $AA
                .byte   $83
                .byte   $AA
                .byte   $83
                .byte   $AA
                .byte   $83
                .byte   $D5
                .byte   $88
                .byte   $85
                .byte   $8A
                .byte   $D3
                .byte   $84
                .byte   $9D
                .byte   $84
                .byte   $B8
                .byte   $84
                .byte   $FB
                .byte   $83
                .byte   $B8
                .byte   $84
                .byte   $31
                .byte   $84
                .byte   $FE
                .byte   $89
                .byte   $D0
                .byte   $81
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $DD
                .byte   $90
                .byte   $37
                .byte   $8C
                .byte   $57
                .byte   $92
                .byte   $72
                .byte   $92
                .byte   $8D
                .byte   $92
                .byte   $C5
                .byte   $83
                .byte   $8C
                .byte   $90
                .byte   $C5
                .byte   $83
                .byte   $72
                .byte   $83
                .byte   $A8
                .byte   $92
                .byte   $C3
                .byte   $92
                .byte   $C3
                .byte   $92
                .byte   $DE
                .byte   $92
                .byte   $C3
                .byte   $92
                .byte   $EB
                .byte   $91
                .byte   $F9
                .byte   $92
                .byte   $9D
                .byte   $84
                .byte   $9D
                .byte   $84
                .byte   $A0,$8A,$BB,$8A,$D6,$8A,$F1,$8A
                .byte   $0C
                .byte   $8B
                .byte   $31
                .byte   $84
                .byte   $19
                .byte   $8A
                .byte   $FE
                .byte   $89
                .byte   $FE
                .byte   $89
                .byte   $4C
                .byte   $84
                .byte   $C5
                .byte   $83
                .byte   $7F
                .byte   $81
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $14
                .byte   $93
                .byte   $2F
                .byte   $93
                .byte   $37
                .byte   $8C
                .byte   $57
                .byte   $92
                .byte   $72
                .byte   $92
                .byte   $8D
                .byte   $92
                .byte   $8D
                .byte   $92
                .byte   $8C
                .byte   $90
                .byte   $72
                .byte   $83
                .byte   $4A
                .byte   $93
                .byte   $35
                .byte   $8C
                .byte   $35
                .byte   $8C
                .byte   $65
                .byte   $93
                .byte   $35
                .byte   $8C
                .byte   $37
                .byte   $8C
                .byte   $3D
                .byte   $94
                .byte   $9D
                .byte   $84
                .byte   $9D
                .byte   $84
                .byte   $C5
                .byte   $83
                .byte   $FB
                .byte   $83
                .byte   $31
                .byte   $84
                .byte   $FE
                .byte   $89
                .byte   $FE
                .byte   $89
                .byte   $4C
                .byte   $84
                .byte   $AA
                .byte   $83
                .byte   $FB
                .byte   $83
                .byte   $AA
                .byte   $83
                .byte   $9D
                .byte   $84
                .byte   $9D
                .byte   $84
                .byte   $EB
                .byte   $81
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $65
                .byte   $93
                .byte   $80
                .byte   $93
                .byte   $1F
                .byte   $8E
                .byte   $2F
                .byte   $93
                .byte   $57
                .byte   $92
                .byte   $07
                .byte   $94
                .byte   $9B
                .byte   $93
                .byte   $8C
                .byte   $90
                .byte   $72
                .byte   $83
                .byte   $B6
                .byte   $93
                .byte   $48
                .byte   $8F
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $9D
                .byte   $84
                .byte   $B8
                .byte   $84
                .byte   $3D
                .byte   $94
                .byte   $B8
                .byte   $84
                .byte   $B8
                .byte   $84
                .byte   $31
                .byte   $84
                .byte   $19
                .byte   $8A
                .byte   $27
                .byte   $8B
                .byte   $9D
                .byte   $84
                .byte   $AA
                .byte   $83
                .byte   $42
                .byte   $8B
                .byte   $C5
                .byte   $83
                .byte   $AA
                .byte   $83
                .byte   $5D
                .byte   $8B
                .byte   $AA
                .byte   $83
                .byte   $18
                .byte   $88
                .byte   $9A
                .byte   $81
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $14
                .byte   $93
                .byte   $D1
                .byte   $93
                .byte   $EC
                .byte   $93
                .byte   $07
                .byte   $94
                .byte   $2F
                .byte   $93
                .byte   $37
                .byte   $8C
                .byte   $22
                .byte   $94
                .byte   $37
                .byte   $8C
                .byte   $13
                .byte   $91
                .byte   $D3
                .byte   $84
                .byte   $C5
                .byte   $83
                .byte   $B6
                .byte   $93
                .byte   $D3
                .byte   $84
                .byte   $C5
                .byte   $83
                .byte   $B8
                .byte   $84
                .byte   $3D
                .byte   $94
                .byte   $E0
                .byte   $83
                .byte   $B8
                .byte   $84
                .byte   $AB
                .byte   $85
                .byte   $FB
                .byte   $83
                .byte   $78
                .byte   $8B
                .byte   $9D
                .byte   $84
                .byte   $93
                .byte   $8B
                .byte   $AA
                .byte   $83
                .byte   $AA
                .byte   $83
                .byte   $AA
                .byte   $83
                .byte   $AA
                .byte   $83
                .byte   $C6
                .byte   $85
                .byte   $9F
                .byte   $88
                .byte   $C4
                .byte   $80
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $14
                .byte   $93
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $2C
                .byte   $8D
                .byte   $58
                .byte   $94
                .byte   $07
                .byte   $94
                .byte   $3C
                .byte   $92
                .byte   $37
                .byte   $8C
                .byte   $37
                .byte   $8C
                .byte   $13
                .byte   $91
                .byte   $68
                .byte   $86
                .byte   $37
                .byte   $8C
                .byte   $13
                .byte   $91
                .byte   $07
                .byte   $94
                .byte   $B6
                .byte   $93
                .byte   $73
                .byte   $94
                .byte   $FE
                .byte   $89
                .byte   $FE
                .byte   $89
                .byte   $BA
                .byte   $88
                .byte   $C5
                .byte   $83
                .byte   $78
                .byte   $8B
                .byte   $F0
                .byte   $88
                .byte   $6A
                .byte   $8A
                .byte   $AA
                .byte   $83
                .byte   $AA
                .byte   $83
                .byte   $F1
                .byte   $8A
                .byte   $0C
                .byte   $8B
                .byte   $C5
                .byte   $83
                .byte   $7F
                .byte   $81
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $14
                .byte   $93
                .byte   $9D
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $1F
                .byte   $8E
                .byte   $1F
                .byte   $8E
                .byte   $2F
                .byte   $93
                .byte   $37
                .byte   $8C
                .byte   $37
                .byte   $8C
                .byte   $37
                .byte   $8C
                .byte   $68
                .byte   $86
                .byte   $37
                .byte   $8C
                .byte   $37
                .byte   $8C
                .byte   $DD
                .byte   $90
                .byte   $1F
                .byte   $8E
                .byte   $18
                .byte   $88
                .byte   $0C
                .byte   $8B
                .byte   $E1
                .byte   $85
                .byte   $D5
                .byte   $88
                .byte   $32
                .byte   $86
                .byte   $78
                .byte   $8B
                .byte   $E2
                .byte   $87
                .byte   $4D
                .byte   $86
                .byte   $AA
                .byte   $83
                .byte   $AA
                .byte   $83
                .byte   $AA
                .byte   $83
                .byte   $AA
                .byte   $83
                .byte   $B8
                .byte   $84
                .byte   $9A
                .byte   $81
                .byte   $30
                .byte   $81
                .byte   $8D
                .byte   $82
                .byte   $70
                .byte   $83
                .byte   $8E
                .byte   $94
                .byte   $06
                .byte   $92
                .byte   $9D
                .byte   $84
                .byte   $9D
                .byte   $84
                .byte   $9D
                .byte   $84
                .byte   $C5
                .byte   $83
                .byte   $9D
                .byte   $84
                .byte   $2F
                .byte   $93
                .byte   $37
                .byte   $8C
                .byte   $37
                .byte   $8C
                .byte   $68
                .byte   $86
                .byte   $1F
                .byte   $8E
                .byte   $1F
                .byte   $8E
                .byte   $9D
                .byte   $84
                .byte   $33
                .byte   $88
                .byte   $4E
                .byte   $88
                .byte   $69
                .byte   $88
                .byte   $BB
                .byte   $8A
                .byte   $E1
                .byte   $85
                .byte   $D4
                .byte   $86
                .byte   $78
                .byte   $8B
                .byte   $AD
                .byte   $89
                .byte   $34
                .byte   $8A
                .byte   $4F
                .byte   $8A
                .byte   $AA
                .byte   $83
                .byte   $09
                .byte   $85
                .byte   $24
                .byte   $85
                .byte   $FB
                .byte   $83
                .byte   $C4
                .byte   $80
                .byte   $C3
                .byte   $82
                .byte   $DE
                .byte   $82
                .byte   $70
                .byte   $83
                .byte   $14
                .byte   $93
                .byte   $EB
                .byte   $91
                .byte   $FE
                .byte   $89
                .byte   $FE
                .byte   $89
                .byte   $19
                .byte   $8A
                .byte   $FE
                .byte   $89
                .byte   $06
                .byte   $92
                .byte   $9D
                .byte   $84
                .byte   $2F
                .byte   $93
                .byte   $DD
                .byte   $90
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $76
                .byte   $87
                .byte   $EF
                .byte   $86
                .byte   $E2,$87,$FD,$87
                .byte   $25
                .byte   $87
                .byte   $0A
                .byte   $87
                .byte   $78
                .byte   $8B
                .byte   $FB
                .byte   $83
                .byte   $85
                .byte   $8A
                .byte   $B8
                .byte   $84
                .byte   $B8
                .byte   $84
                .byte   $E1
                .byte   $85
                .byte   $FC
                .byte   $85
                .byte   $A9
                .byte   $80
                .byte   $70
                .byte   $83
                .byte   $C3
                .byte   $82
                .byte   $0C
                .byte   $8B
                .byte   $20
                .byte   $80
                .byte   $14
                .byte   $93
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $78
                .byte   $8B
                .byte   $FB
                .byte   $83
                .byte   $A9
                .byte   $80
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $91
                .byte   $87
                .byte   $AC
                .byte   $87
                .byte   $6A
                .byte   $8A
                .byte   $C8
                .byte   $89
                .byte   $4D
                .byte   $86
                .byte   $E2
                .byte   $87
                .byte   $78
                .byte   $8B
                .byte   $B8
                .byte   $84
                .byte   $B8
                .byte   $84
                .byte   $C5
                .byte   $83
                .byte   $64
                .byte   $81
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $8E
                .byte   $80
                .byte   $4B
                .byte   $81
                .byte   $70
                .byte   $83
                .byte   $14
                .byte   $93
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $A9
                .byte   $80
                .byte   $3D
                .byte   $80
                .byte   $58
                .byte   $80
                .byte   $70
                .byte   $83
                .byte   $73
                .byte   $80
                .byte   $E3
                .byte   $89
                .byte   $64
                .byte   $91
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $C5
                .byte   $83
                .byte   $9F
                .byte   $88
                .byte   $D3
                .byte   $84
                .byte   $D3
                .byte   $84
                .byte   $FC
                .byte   $85
                .byte   $B9
                .byte   $86
                .byte   $78
                .byte   $8B
                .byte   $DF
                .byte   $80
                .byte   $FA
                .byte   $80
                .byte   $DF
                .byte   $80
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $14
                .byte   $93
                .byte   $68
                .byte   $86
                .byte   $E0
                .byte   $83
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $20
                .byte   $80
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $8E
                .byte   $80
                .byte   $68
                .byte   $86
                .byte   $EB
                .byte   $91
                .byte   $06
                .byte   $92
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $FC
                .byte   $85
                .byte   $C4
                .byte   $80
                .byte   $70
                .byte   $83
                .byte   $15
                .byte   $81
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $14
                .byte   $93
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $A9
                .byte   $80
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $73
                .byte   $80
                .byte   $68
                .byte   $86
                .byte   $EB
                .byte   $91
                .byte   $FE
                .byte   $89
                .byte   $06
                .byte   $92
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $A9
                .byte   $80
                .byte   $70
                .byte   $83
                .byte   $30
                .byte   $81
                .byte   $8D
                .byte   $82
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $14
                .byte   $93
                .byte   $68
                .byte   $86
                .byte   $A9
                .byte   $80
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $8E
                .byte   $80
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $78
                .byte   $8B
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $68
                .byte   $86
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $8E
                .byte   $80
                .byte   $4B
                .byte   $81
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $13
                .byte   $91
                .byte   $C3
                .byte   $92
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $C3
                .byte   $92
                .byte   $C3
                .byte   $92
                .byte   $C3
                .byte   $92
                .byte   $37
                .byte   $8C
                .byte   $C3
                .byte   $92
                .byte   $C3
                .byte   $92
                .byte   $C3
                .byte   $92
                .byte   $C3
                .byte   $92
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
                .byte   $70
                .byte   $83
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
TAA3C:          .byte   $22,$3A,$3A,$4A,$20,$36,$45,$5D,$41,$4E,$33,$20,$43,$5E,$3D,$23 ;「ここは かなんちほう です」
                .byte   $2A
TAA4D:          .byte   $22,$3A,$3A,$4A,$20,$3A,$5E,$4B,$5E,$3B,$4A,$5E,$38,$20,$43,$5E ;「ここは ごびさばく です」
                .byte   $3D,$23,$2A
TAA60:          .byte   $22,$3A,$3A,$4A,$20,$40,$38,$57,$4F,$36,$5D,$3B,$4A,$5E,$38,$20 ;「ここは たくらまかんさばく です」
                .byte   $43,$5E,$3D,$23,$2A
TAA75:          .byte   $41,$2E,$33,$31,$5D,$49,$20,$50,$54,$3A,$40,$5E,$21,$2A ;ちょうあんの みやこだ！
TAA83:          .byte   $57,$38,$56,$33,$49,$20,$50,$54,$3A,$40,$5E,$21,$2A ;らくようの みやこだ！
TAA90:          .byte   $41,$2E,$33,$3C,$2D,$33,$49,$20,$50,$54,$3A,$40,$5E,$21,$2A ;ちょうしゅうの みやこだ！
TAA9F:          .byte   $41,$2E,$5D,$42,$33,$49,$20,$50,$54,$3A,$40,$5E,$21,$2A ;ちょんつうの みやこだ！
TAAAD:          .byte   $22,$45,$36,$4F,$26,$20,$31,$42,$52,$45,$3B,$32,$23,$2A ;「なかまを あつめなさい」
TAABB:          .byte   $22,$37,$40,$4D,$20,$3D,$3D,$52,$23,$2A ;「きたへ すすめ」
TAAC5:          .byte   $22,$44,$37,$49,$20,$53,$5D,$26,$20,$44,$35,$5A,$23,$2A ;「ときの もんを とおれ」
TAAD3:          .byte   $22,$56,$59,$4A,$20,$37,$39,$5D,$40,$5E,$23,$2A ;「よるは きけんだ」
TAADF:          .byte   $22,$46,$3C,$46,$20,$36,$34,$5D,$3B,$5E,$5D,$36,$5E,$20,$31,$58 ;「にしに かえんざんが あります」
                .byte   $4F,$3D,$23,$2A
TAAF3:          .byte   $22,$43,$5D,$3C,$5E,$38,$4A,$20,$36,$34,$5D,$3B,$5E,$5D,$49,$20 ;「てんじくは かえんざんの むこう」
                .byte   $51,$3A,$33,$23,$2A
TAB08:          .byte   $22,$57,$3E,$42,$3C,$5E,$2E,$26,$20,$40,$35,$3E,$4A,$5E,$36,$34 ;「らせつじょを たおせば かえんざんの・・」
                .byte   $5D,$3B,$5E,$5D,$49,$25,$25,$23,$2A
TAB21:          .byte   $22,$37,$5D,$36,$38,$4A,$20,$3B,$4A,$5E,$38,$49,$20,$4A,$43,$46 ;「きんかくは さばくの はてにいる」
                .byte   $32,$59,$23,$2A
TAB35:          .byte   $22,$4C,$3C,$41,$2E,$33,$20,$4E,$33,$35,$33,$26,$20,$3B,$36,$5E ;「ふしちょう ほうおうを さがせ」
                .byte   $3E,$23,$2A
TAB48:          .byte   $37,$5D,$36,$38,$40,$5E,$32,$35,$33,$20,$22,$37,$5E,$5D,$36,$38 ;きんかくだいおう 「ぎんかくのかたき！」
                .byte   $49,$36,$40,$37,$21,$23,$2A
TAB5F:          .byte   $37,$5E,$5D,$36,$38,$40,$5E,$32,$35,$33,$20,$22,$3A,$3A,$4A,$44 ;ぎんかくだいおう 「ここはとおさんぞ！」
                .byte   $35,$3B,$5D,$3F,$5E,$21,$23,$2A
TAB77:          .byte   $22,$5C,$40,$3C,$36,$5E,$20,$57,$3E,$42,$3C,$5E,$2E,$40,$5E,$21 ;「わたしが らせつじょだ！」
                .byte   $23,$2A
TAB89:          .byte   $22,$43,$5D,$3C,$5E,$38,$4A,$53,$33,$3D,$38,$5E,$43,$5E,$3D,$23 ;「てんじくはもうすぐです」
                .byte   $2A
TAB9A:          .byte   $45,$36,$5E,$32,$40,$4B,$5E,$36,$5E,$20,$4A,$3C,$5E,$4F,$59,$25 ;「ながいたびが はじまる・・」
                .byte   $25,$2A
TABAC:          .byte   $3A,$5D,$3E,$32,$4F,$35,$33,$20,$22,$56,$38,$3A,$3A,$4F,$43,$5E ;こんせいまおう 「よくここまできたな・・」
                .byte   $37,$40,$45,$25,$25,$23,$2A
TABC3:          .byte   $3A,$5E,$38,$33,$32,$2F,$3A,$33,$49,$2A ;ごくういっこうの
TABCD:          .byte   $45,$36,$5E,$32,$20,$45,$36,$5E,$32,$20,$40,$4B,$5E,$4A,$20,$35 ;ながい ながい たびは おわり
                .byte   $5C,$58,$2A
TABE0:          .byte   $3A,$5A,$36,$57,$41,$2D,$33,$3A,$5E,$38,$49,$20,$5A,$37,$3C,$36 ;これからちゅうごくの れきしが はじまる
                .byte   $5E,$20,$4A,$3C,$5E,$4F,$59,$2A
TABF8:          .byte   $35,$3C,$2C,$36,$3B,$4F,$56,$58,$2A ;おしゃかさまより
TAC01:          .byte   $31,$58,$36,$5E,$40,$32,$35,$37,$2E,$33,$26,$20,$32,$40,$40,$5E ;ありがたいおきょうを いただいて
                .byte   $32,$43,$2A
TAC14:          .byte   $4B,$44,$4B,$5E,$44,$46,$20,$35,$3C,$34,$26,$20,$42,$40,$34,$4F ;ひとびとに おしえを つたえましょう
                .byte   $3C,$2E,$33,$2A
TAC28:          .byte   $31,$31,$20,$3C,$5D,$3C,$5E,$2C,$2F,$40,$21,$2A ;ああ しんじゃった！
TAC34:          .byte   $35,$3C,$4F,$32,$2A             ;おしまい
TAC39:          .byte   $4A,$2F,$36,$32,$20,$22,$40,$5E,$5A,$36,$20,$40,$3D,$39,$43,$21 ;はっかい 「だれか たすけて！」
                .byte   $23,$2A
TAC4B:          .byte   $22,$3B,$4A,$5E,$38,$49,$20,$32,$58,$38,$5E,$41,$4A,$20,$4E,$38 ;「さばくの いりぐちは ほくせい」
                .byte   $3E,$32,$23,$2A
TAC5F:          .byte   $22,$36,$5E,$5D,$4A,$5E,$2F,$43,$38,$40,$5E,$3B,$32,$48,$23,$2A ;「がんばってくださいね」
TAC6F:          .byte   $3B,$3A,$5E,$3C,$5E,$2E,$33,$20,$22,$35,$44,$53,$3C,$4F,$3D,$21 ;さごじょう 「おともします！」
                .byte   $23,$2A
TAC81:          .byte   $22,$C1,$C2,$20,$C1,$C2,$23,$2A ;「AB AB」
TAC89:          .byte   $22,$C1,$C2,$20,$C1,$C2,$20,$C1,$C2,$23,$2A ;「AB AB AB」
TAC94:          .byte   $22,$C1,$C2,$20,$C1,$20,$C1,$20,$C1,$C2,$23,$2A ;「AB A A AB」
TACA0:          .byte   $22,$C1,$C2,$20,$C1,$20,$C1,$23,$2A ;「AB A A」
TACA9:          .byte   $22,$C1,$C2,$20,$C1,$20,$C1,$C2,$20,$C1,$C2,$23,$2A ;「AB A AB AB」

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
                LDA     PpuControlBuffer+2
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
                LDA     PpuControlBuffer+2
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
                STA     PpuControlBuffer+2
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
@LAE61:         JSR     SetDisplayScreenPosition        ;if over VBlank, raise "lag" frame
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

ReadJoypad:     TXA                                     ;save software stack pointer
                PHA
                LDA     #$01
                STA     JOY1
                LDA     #$00
                STA     JOY1
                TAX
@Loop:          LDA     JOY1
                AND     #$03
                STA     PadBuffer_Now,x                 ;1button, 1byte...
                INX
                CPX     #$08
                BNE     @Loop
                JSR     @CheckButtons
                PLA                                     ;restore software stack pointer
                TAX
                RTS

@CheckButtons:  LDX     #$00
@Loop1:         JSR     @CheckButton
                INX
                CPX     #$08
                BCC     @Loop1
                RTS

@CheckButton:   LDA     PadBuffer_Prev,x
                BNE     @LAEF6
                LDA     PadBuffer_Now,x
                BEQ     @LAEF6
                STA     PadBuffer_Prev,x
                LDA     #$01
                STA     PadBuffer_Trigger,x
                RTS

@LAEF6:         LDA     #$00
                STA     PadBuffer_Trigger,x
                LDA     PadBuffer_Now,x
                STA     PadBuffer_Prev,x
                RTS

LAF02:          LDY     #$07
                LDA     #$00
@LAF06:         STA     PpuControlBuffer,y
                DEY
                BPL     @LAF06
                RTS

LAF0D:          LDY     #$07
                LDA     #$00
@LAF11:         STA     PpuMaskBuffer,y
                DEY
                BPL     @LAF11
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
                STA     PpuControlBuffer                ;Base nametable
                LDA     ScreenY
                STA     PPUSCROLL
                LDA     ScreenY+1
                STA     PpuControlBuffer+1              ;Base nametable
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
                BEQ     @LAFAC

@Expand:        JSR     ExpandMixedRleData              ;Nametable
                JSR     ExpandRleData                   ;Attribute
@LAFAC:         JSR     @LAFC7
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
                JSR     LF0CD
                JSR     LAFD6
                LDA     $55
                CMP     #$0B
                BCC     @LAFF6
                JSR     LB04F
                INC     $53
                JSR     LF0CD
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

LB04F:          LDA     PpuControlBuffer
                PHA
                LDA     $51
                BEQ     @LB096
                JSR     LB034
                LDA     #$00
                STA     PpuControlBuffer
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
                JSR     LB77D
                LDA     $0473
                BNE     @LB091
                JSR     LDE68
@LB091:         LDY     #$00
                JSR     LEA45
@LB096:         PLA
                STA     PpuControlBuffer
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
                JSR     LF0CD
                JSR     LAFD6
                JSR     LB10E
                INC     $55
                RTS

LB13B:          JSR     LF0CD
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
                JSR     LF0CD
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

LB1D9:          LDA     $03D4
                JMP     VmOp_PushByte

LB1DF:          JSR     VmOp_PopRegister
                STY     $03D4
                RTS

LB1E6:          LDA     PartyLifes-1
                JMP     VmOp_PushByte

LB1EC:          JSR     VmOp_PopRegister
                STY     PartyLifes-1
                RTS

                .byte   $A9
                .byte   $68
                .byte   $4C
                .byte   $CC
                .byte   $98

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

LB2A0:          LDA     $03D5
                JMP     VmOp_PushByte

LB2A6:          JSR     VmOp_PopRegister
                STY     $03D5
                RTS

LB2AD:          JSR     LB1EC
                JSR     LB24E
                JSR     VmOp_ExitFalse
                JSR     LB24E
                JSR     VmOp_Decrement
                JMP     LB243

LB2BF:          JSR     LB1D9
                JSR     VmOp_ExitTrue
                JSR     LB2A0
                JSR     VmHelper_PushConst_0010
                JSR     VmOp_Compare_Equal
                JSR     LB2A0
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

LB38E:          JSR     LB1D9
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
@LB3B5:         JSR     L9695
                JSR     LB243
                JSR     LB04F
                JSR     LBA24
                JSR     L9620
                BCC     @LB3B5
                RTS

LB3C7:          JSR     L9695
                JSR     VmHelper_PushConst_0004
                JSR     VmOp_Compare_Equal
                LDA     PartyIn_Chohakkai
                JSR     VmOp_PushByte
                JSR     VmHelper_PushConst_0000
                JSR     VmOp_Compare_Equal
                JMP     VmOp_And

LB3DF:          JSR     L9695
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
                JSR     L9695
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

LB42A:          JSR     LB2A0
                JSR     VmOp_Increment
                LDA     #$3F
                JSR     VmOp_PushByte
                JSR     VmOp_And
                JSR     LB2A6
                JMP     LB5FF

LB43E:          JSR     LB2A0
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
                JSR     LB1D9
                JSR     VmOp_Increment
                JSR     LB1DF
                JSR     LB1D9
                JSR     VmHelper_PushConst_0020
                JSR     VmOp_Compare_BGeatherThanOrEqual
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0000
                JSR     LB1DF
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
                JSR     LB1D9
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

@LB500:         JSR     LB1D9
                JSR     VmHelper_PushConst_0003
                JSR     VmOp_And
                JSR     VmOp_ExitTrue
                JMP     LB75D

LB50F:          JSR     LB4C6
                JSR     VmOp_ExitFalse
                JSR     VmOp_PopDiscard
                JMP     LB4DB

LB51B:          JSR     LB2A0
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

LB540:          JSR     VmHelper_SaveMemTemp_06
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
                JSR     L9695
                JSR     VmOp_WriteByte
                JSR     VmHelper_PushConst_0004
                JSR     L9645
                BCC     @LB568
                JMP     VmOp_ReadTempMemAddr

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
                JMP     VmOp_ReadTempMemAddr

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

LB5CF:          JSR     LB2A0
                JSR     VmHelper_PushConst_0030
                JSR     VmOp_Compare_Equal
                JSR     VmOp_ExitFalse
                LDY     #$20
@LB5DD:         LDA     L838F,y
                STA     $00DB,y
                DEY
                BPL     @LB5DD
                RTS

LB5E7:          JSR     LB2A0
                JSR     VmHelper_PushConst_0010
                JSR     VmOp_Compare_Equal
                JSR     VmOp_ExitFalse
LB5F3:          LDY     #$20
@LB5F5:         LDA     L8374,y
                STA     $00DB,y
                DEY
                BPL     @LB5F5
                RTS

LB5FF:          JSR     LB5CF
                JMP     LB5E7

LB605:          JSR     L9695
                JMP     VmOp_Add_AB

LB60B:          JSR     L9695
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
                JSR     LF0CD
                RTS

PpuControl_EnableDirection:
                LDA     #$01
                STA     PpuControlBuffer+2
                JMP     SetPpuControl

PpuControl_DisableDirection:
                LDA     #$00
                STA     PpuControlBuffer+2
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

                .byte   $A5
                .byte   $55
                .byte   $4C
                .byte   $CC
                .byte   $98

LB6FC:          JSR     VmOp_PopRegister
                STY     $55
                RTS

                .byte   $20
                .byte   $1C
                .byte   $B6
                .byte   $20
                .byte   $0B
                .byte   $98
                .byte   $20
                .byte   $27
                .byte   $B6
                .byte   $20
                .byte   $29
                .byte   $98
                .byte   $20
                .byte   $4E
                .byte   $97
                .byte   $20
                .byte   $57
                .byte   $B6
                .byte   $20
                .byte   $4E
                .byte   $97
                .byte   $4C
                .byte   $7E
                .byte   $95

LB71A:          LDY     #$04
                LDA     #$F0
@LB71E:         STA     OamBuffer,y
                INY
                BNE     @LB71E
                RTS

LB725:          JSR     EnableApuChannel
                LDA     #$01
                BNE     LB76B

LB72C:          JSR     EnableApuChannel
                LDA     #$03
                BNE     LB76B

LB733:          JSR     EnableApuChannel
                LDA     #$04
                BNE     LB76B

LB73A:          JSR     EnableApuChannel
                LDA     #$05
                BNE     LB76B

LB741:          LDA     #$06
                BNE     LB76B

LB745:          LDA     #$09
                BNE     LB76B

LB749:          LDA     #$0A
                BNE     LB76B

LB74D:          LDA     #$0E
                BNE     LB76B

LB751:          LDA     #$0F
                BNE     LB76B

LB755:          LDA     #$11
                BNE     LB76B

                .byte   $A9
                .byte   $12
                .byte   $D0
                .byte   $0E

LB75D:          LDA     #$13
                BNE     LB76B

LB761:          LDA     #$15
                BNE     LB76B

LB765:          LDA     #$16
                BNE     LB76B

LB769:          LDA     #$00
LB76B:          TAY
                TXA
                PHA
                TYA
                JSR     LF1D0
                PLA
                TAX
                RTS

LB775:          TXA
                PHA
                JSR     LF1DC
                PLA
                TAX
                RTS

LB77D:          TXA
                PHA
                JSR     LF1D3
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

CheckPause:     LDA     PadBuffer_Trigger+2             ;Select
                BEQ     Return
                JSR     DisableApuChannel               ;Pausing
@CheckLoop:     JSR     VmProc_ProcessFieldFrame        ;Wait next frame
                JSR     ReadJoypad
                LDA     PadBuffer_Trigger+2
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
                JSR     LB98C
                JSR     CheckPause
                JSR     VmProc_ProcessFieldFrame        ;[1F] Wait frame
                JSR     SetFieldPartySprite
                JSR     VmProc_ProcessFieldFrame        ;[00] Wait frame
                LDA     #$00
                STA     $0484                           ;Message screen flag?
                JSR     VmProc_MoveFieldLeft
                JSR     VmProc_ProcessFieldFrame        ;[01] Wait frame
                JSR     LBF7A
                JSR     LBF98
                JSR     VmProc_ProcessFieldFrameWithMove ;[02] Wait frame
                JSR     LBF20
                JSR     LBF68
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

LB8C1:          JSR     VmOp_Duplicate
                JSR     VmHelper_PushConst_000E
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_000F
                JMP     VmOp_Sub_BA

LB8D3:          JSR     VmOp_Duplicate
                JSR     VmHelper_PushConst_000F
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0010
                JMP     VmOp_Sub_BA

LB8E5:          JSR     VmHelper_SaveMemTemp_06
                JSR     LC0E1
                JSR     VmOp_Add_AB
                JSR     LB8C1
                JSR     VmOp_Asl_04
                JSR     VmOp_Swap
                JSR     VmHelper_PushFieldChipX
                JSR     VmOp_Add_AB
                JSR     LB8D3
                JSR     VmOp_Add_AB
                JSR     VmHelper_PushConst_0500
                JSR     VmOp_ReadOffsetByte
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmHelper_PushConst_0000
                JSR     VmOp_Compare_Equal
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmHelper_PushConst_0001
                JSR     VmOp_Compare_Equal
                JSR     VmOp_Or
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmHelper_PushConst_0010
                JSR     VmOp_Compare_Equal
                JSR     VmOp_Or
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmHelper_PushConst_0006
                JSR     VmOp_Compare_BGeatherThanOrEqual
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     VmHelper_PushConst_000C
                JSR     VmOp_Compare_AGeatherThanOrEqual
                JSR     VmOp_And
                JSR     VmOp_Or
                JSR     VmOp_CheckNotZero
                BCC     @LB94D
                JSR     ClearJoypad
@LB94D:         JMP     VmOp_ReadTempMemAddr

LB950:          JSR     VmHelper_PushPad_Up
                JSR     VmOp_ExitFalse                  ;not press : Exit
                JSR     VmHelper_PushConst_0008         ;8+0
                JSR     VmHelper_PushConst_0005         ;6-1
                JMP     LB8E5

LB95F:          JSR     VmHelper_PushPad_Down
                JSR     VmOp_ExitFalse                  ;not press : Exit
                JSR     VmHelper_PushConst_0008         ;8+0
                JSR     VmHelper_PushConst_0007         ;6+1
                JMP     LB8E5

LB96E:          JSR     VmHelper_PushPad_Right
                JSR     VmOp_ExitFalse                  ;not press : Exit
                JSR     VmHelper_PushConst_0009         ;8+1
                JSR     VmHelper_PushConst_0006         ;6+0
                JMP     LB8E5

LB97D:          JSR     VmHelper_PushPad_Left
                JSR     VmOp_ExitFalse                  ;not press : Exit
                JSR     VmHelper_PushConst_0007         ;8-1
                JSR     VmHelper_PushConst_0006         ;6+0
                JMP     LB8E5

LB98C:          JSR     LB950
                JSR     LB95F
                JSR     LB96E
                JMP     LB97D

LB998:          LDA     #$C3
                LDY     #$EA
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

LB9B9:          JSR     VmHelper_PushFieldPageX
                JSR     VmHelper_PushConst_001F
                JSR     VmOp_Compare_AGeatherThanOrEqual
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushFieldPageY
                JSR     VmHelper_PushConst_0018
                JSR     VmOp_Compare_AGeatherThanOrEqual
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
                JSR     LB998
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

LBA24:          LDA     $3E
                CMP     $40
                BEQ     LBA24
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
                STA     PadBuffer_Now+4
Return1:        RTS

LBAD5:          JSR     VmHelper_PushPositions
                JSR     VmProc_IncrementFieldPageY
                JSR     LBEC9
                LDA     #$1F
                STA     ProcessStateCounter
                STA     ProcessedStateCounter
                JSR     LBAC6
                JSR     VmHelper_PushConst_000C
                JSR     VmHelper_PushConst_0000
                JSR     L9601
@LBAF0:         JSR     LBA24
                JSR     LBF7A
                JSR     LBA24
                JSR     LBF83
                JSR     LBA24
                LDA     FieldPageX
                STA     $04DC
                JSR     LC0FF
                JSR     LBA24
                JSR     LC11A
                JSR     LBA24
                JSR     L9620
                BCC     @LBAF0
                JSR     VmHelper_PopPositions
                JSR     SetFieldChrBank
                JSR     LB5BD
                JSR     SetOamDmaRequest
                JMP     LBA24

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
                JSR     LB77D                           ;sound...?
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

LBBE8:          JSR     DisableApuChannel
                JSR     LB761
                JSR     VmHelper_PopFieldPageX
                JSR     VmHelper_PopFieldPageY
                LDA     #$01
                STA     $04DA
                JSR     LE533
                JSR     LBAD5
                JSR     LBAD5
                LDA     FieldPageX
                AND     #$01
                STA     ScreenX+1
                STA     PpuControlBuffer
                JSR     SetPpuControl
                JSR     LB765
                JSR     EnableApuChannel
                JSR     VmProc_SetTargetPointScreenX
                JSR     VmProc_SetTargetPointScreenY
                JSR     LE537
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

LBC94:          JSR     VmOp_Asl_05
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

LBD1E:          JSR     VmHelper_SaveMemTemp_0E
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
@LBD45:         JSR     L9695
                JSR     VmHelper_PushFieldChipY
                JSR     LBCEC
                JSR     VmHelper_ReadTempAddressWord_08
                JSR     L9695
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
@LBD85:         JSR     L9695
                JSR     VmHelper_PushFieldChipY
                JSR     LBCEC
                JSR     VmHelper_ReadTempAddressWord_08
                JSR     L9695
                JSR     VmOp_Add_AB
                JSR     VmOp_WriteByte
                JSR     L9620
                BCC     @LBD85
@LBD9F:         JMP     VmOp_ReadTempMemAddr

LBDA2:          JSR     VmHelper_PushFieldPageX
                JSR     VmHelper_PushFieldPageY
                JSR     LBC94
                JSR     VmHelper_WriteTempAddressWord_02
                JMP     LBCBC

LBDB1:          JSR     VmHelper_PushFieldChipX
                JSR     L9695
                JSR     LBCEC
                JSR     L9695
                JSR     LC0C0
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
                JSR     VmHelper_SaveMemTemp_0E
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
                JSR     VmOp_ReadTempMemAddr
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
                JSR     VmOp_ReadTempMemAddr
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

LBE9F:          JSR     VmHelper_PushFieldChipY
                JSR     VmOp_Add_AB
                JSR     VmOp_Duplicate
                JSR     VmHelper_PopFieldChipY
                JSR     VmHelper_PushConst_000B
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushFieldChipY
                JSR     VmHelper_PushConst_000C
                JSR     VmOp_Sub_BA
                JSR     VmHelper_PopFieldChipY
                JSR     VmHelper_PushFieldPageY
                JSR     VmOp_Increment
                JMP     VmHelper_PopFieldPageY

LBEC9:          JSR     VmHelper_PushFieldPageY
                JSR     VmHelper_PushConst_0018
                JSR     VmOp_Compare_AGeatherThan
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_0001
                JMP     LBE9F

LBEDB:          JSR     VmHelper_PushFieldPageY
                JSR     VmHelper_PushFieldChipY
                JSR     VmOp_Or
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushFieldChipY
                JSR     VmOp_Decrement
                JSR     VmOp_Duplicate
                JSR     VmHelper_PopFieldChipY
                JSR     VmHelper_PushConst_000B
                JSR     VmOp_Compare_BGeatherThan
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_000B
                JSR     VmHelper_PopFieldChipY
                JSR     VmHelper_PushFieldPageY
                JSR     VmOp_Decrement
                JMP     VmHelper_PopFieldPageY

LBF0B:          JSR     VmHelper_PushPad_Right
                JSR     VmOp_ExitFalse
                JMP     LBE5D

LBF14:          JSR     VmHelper_PushFieldPageX
                JSR     VmOp_Duplicate
                JSR     VmOp_Increment
                JMP     VmHelper_PopFieldPageX

LBF20:          JSR     VmHelper_PushPad_Right
                JSR     VmOp_ExitFalse
                JSR     LBF14
                JSR     LBDF0
                JMP     VmHelper_PopFieldPageX

LBF2F:          JSR     VmHelper_PushPad_Right
                JSR     VmOp_ExitFalse
                JSR     LBF14
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

LBF68:          JSR     VmHelper_PushPad_Left
                JSR     VmOp_ExitFalse
                JMP     LBDF0

LBF71:          JSR     VmHelper_PushPad_Left
                JSR     VmOp_ExitFalse
                JMP     LBE0D

LBF7A:          JSR     VmHelper_PushPad_Up
                JSR     VmOp_ExitFalse
                JMP     LBEDB

LBF83:          JSR     VmHelper_PushPad_Up
                JSR     VmOp_ExitFalse
                JSR     LC0E1
                JMP     LBD1E

VmProc_SetTargetPointScreenY:
                JSR     LC0E1
                JSR     VmOp_Asl_04
                JMP     VmHelper_PopScreenY

LBF98:          JSR     VmHelper_PushPad_Down
                JSR     VmOp_ExitFalse
                JMP     LBEC9

LBFA1:          JSR     VmHelper_PushPad_Down
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushFieldPageY
                JSR     VmHelper_PushFieldPageY
                JSR     VmOp_Increment
                JSR     VmHelper_PopFieldPageY
                JSR     LC0E1
                JSR     LBD1E
                JMP     VmHelper_PopFieldPageY

LBFBC:          LDA     #$04
                LDY     #$01
                JMP     VmOp_PushRegister

LBFC3:          LDA     #$83
                LDY     #$1B
                JMP     VmOp_PushRegister

LBFCA:          JSR     VmHelper_SaveMemTemp_06
                JSR     VmOp_Asl_04
                JSR     VmHelper_PushConst_0500
                JSR     VmOp_Add_AB
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     VmHelper_PushConst_000F
                JSR     VmHelper_PushConst_0000
                JSR     L9601
@LBFE2:         JSR     VmHelper_ReadTempAddressWord_02
                JSR     L9695
                JSR     VmOp_Add_AB
                JSR     VmOp_ReadByte
                JSR     VmOp_Asl_02
                JSR     LBFC3
                JSR     VmOp_Add_AB
                JSR     VmHelper_WriteTempAddressWord_04
                JSR     LBFBC
                JSR     L9695
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
                JMP     VmOp_ReadTempMemAddr

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
TC09B:          .byte   $00,$0C,$09,$06,$03,$00,$0C,$09,$06,$03
                .byte   $00,$0C,$09,$06,$03,$00,$0C,$09,$06,$03
                .byte   $00,$0C,$09,$06,$03,$00,$0C,$09,$06,$03

VmHelper_PushConst_C09B:
                LDA     #>TC09B
                LDY     #<TC09B
                JMP     VmOp_PushRegister

; Argument: [0] ??? (FieldChipY or ???)
; Return: [0] ???
LC0C0:          JSR     VmHelper_PushConst_C09B         ;// arg = FieldPageY or ???
                JSR     VmHelper_PushFieldPageY         ;Stack[0] = TC09B[FieldPageY] + arg
                JSR     VmOp_Add_AB
                JSR     VmOp_ReadByte
                JSR     VmOp_Add_AB
                JSR     VmOp_Duplicate
                JSR     VmHelper_PushConst_000E         ;if(#$000F <= Stack[0]){ Stack[0] -= #$000F; }
                JSR     VmOp_Compare_BGeatherThan       ;  // #$000E < Stack[0]
                JSR     VmOp_ExitFalse
                JSR     VmHelper_PushConst_000F         ;  // Stack[0] -= #$000F
                JMP     VmOp_Sub_BA

LC0E1:          JSR     VmHelper_PushFieldChipY
                JMP     LC0C0

LC0E7:          JSR     LC0E1
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
                JSR     LC0E1
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
                JSR     L9695
                JSR     VmOp_Asl_04
                JSR     VmOp_Add_AB
                JSR     VmOp_ReadByte
                JSR     VmOp_Asl_02
                JSR     LBFC3
                JSR     VmOp_Add_AB
                JSR     VmHelper_WriteTempAddressWord_04
                JSR     LBFBC
                JSR     L9695
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

LC1EC:          JSR     VmHelper_SaveMemTemp_06
                JSR     VmHelper_PushFieldChipX
                JSR     VmHelper_PushConst_0500
                JSR     VmOp_Add_AB
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     L9601
@LC1FE:         JSR     LC186
                JSR     L9620
                BCC     @LC1FE
                JMP     VmOp_ReadTempMemAddr

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
                JSR     LC0E1
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
                LDA     PadBuffer_Now+6                 ;Left
                BEQ     @SkipLeft
                LDA     #$01
                STA     FieldPartyDirection
@SkipLeft:      LDA     PadBuffer_Now+7                 ;Right
                BEQ     @SkipRight
                LDA     #$00
                STA     FieldPartyDirection
@SkipRight:     JSR     SetOamBuffer_FieldPartySprite
                JSR     SetOamDmaRequest
                RTS

                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $FA
                .byte   $CA
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $54
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $54
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $91
                .byte   $CE
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $D7
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $B0
                .byte   $CB
                .byte   $75
                .byte   $CD
                .byte   $98
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $91
                .byte   $CE
                .byte   $75
                .byte   $CD
                .byte   $44
                .byte   $CE
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $CB
                .byte   $CB
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $54
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $49
                .byte   $CC
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $2A
                .byte   $CF
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $B0
                .byte   $CB
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $03
                .byte   $CB
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $98
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $98
                .byte   $D1
                .byte   $98
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $8B
                .byte   $CC
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $98
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $B3
                .byte   $CA
                .byte   $26
                .byte   $D1
                .byte   $42
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $50
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $33
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $B7
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $98
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $98
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $81
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $54
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $12
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $50
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $98
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $BE
                .byte   $CC
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $71
                .byte   $D1
                .byte   $6C
                .byte   $D0
                .byte   $71
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $58
                .byte   $CC
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $26
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $42
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $71
                .byte   $D1
                .byte   $6C
                .byte   $D0
                .byte   $C2
                .byte   $D1
                .byte   $71
                .byte   $D1
                .byte   $B0
                .byte   $CB
                .byte   $6C
                .byte   $D0
                .byte   $C2
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $AA
                .byte   $CA
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $50
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $6C
                .byte   $D0
                .byte   $71
                .byte   $D1
                .byte   $C2
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $CB
                .byte   $CB
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $42
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $67
                .byte   $CC
                .byte   $03
                .byte   $CE
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $3A
                .byte   $CC
                .byte   $42
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $6C
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $81
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $27
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $90
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $00
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                HiAscii "MOPBQ"
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $81
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $9A
                .byte   $CC
                .byte   $75
                .byte   $CD
                .byte   $90
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $71
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $90
                .byte   $D0
                .byte   $90
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $0B
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $98
                .byte   $CB
                .byte   $50
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $71
                .byte   $D1
                .byte   $C2
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $C2
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $C2
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $71
                .byte   $D1
                .byte   $76
                .byte   $CC
                .byte   $75
                .byte   $CD
                .byte   $90
                .byte   $D0
                .byte   $90
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $B0
                .byte   $CB
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $0B
                .byte   $D1
                .byte   $9F
                .byte   $CA
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $33
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $80
                .byte   $CB
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $91
                .byte   $CE
                .byte   $C2
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $71
                .byte   $D1
                .byte   $B0
                .byte   $CB
                .byte   $6C
                .byte   $D0
                .byte   $6C
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $0B
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $8D
                .byte   $CA
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $71
                .byte   $D1
                .byte   $A9
                .byte   $CC
                .byte   $75
                HiAscii "MbLBQ"
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $81
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $26
                .byte   $D1
                .byte   $90
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $E7
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $98
                .byte   $CB
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $C2
                .byte   $D1
                .byte   $33
                .byte   $CA
                .byte   $33
                .byte   $CA
                .byte   $33
                .byte   $CA
                .byte   $71
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $81
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $26
                .byte   $D1
                .byte   $90
                .byte   $D0
                .byte   $90
                HiAscii "PKKdJ"
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $F3
                .byte   $CE
                .byte   $96
                .byte   $CA
                .byte   $50
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $33
                .byte   $CA
                .byte   $33
                .byte   $CA
                .byte   $33
                .byte   $CA
                .byte   $C2
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $91
                .byte   $CE
                .byte   $90
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $33
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $1C
                .byte   $CC
                .byte   $75
                .byte   $CD
                .byte   $33
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $33
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $33
                .byte   $CA
                .byte   $AF
                .byte   $CE
                .byte   $33
                .byte   $CA
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $B0
                .byte   $CB
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $CB
                .byte   $CB
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $3C
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $EF
                .byte   $CA
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $50
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $0B
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $E7
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $F1
                .byte   $CC
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $50
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $0D
                .byte   $CC
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $0B
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $50
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $17
                .byte   $CB
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $D3
                .byte   $CC
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                HiAscii "MgPgP"
                .byte   $75
                .byte   $CD
                .byte   $50
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $D0
                .byte   $CA
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $91
                .byte   $CE
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $BC
                .byte   $CA
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $D9
                .byte   $CA
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $0C
                .byte   $CB
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $E7
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $2B
                .byte   $CC
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                HiAscii "MgPgP"
                .byte   $75
                .byte   $CD
                .byte   $B0
                .byte   $CB
                .byte   $75
                .byte   $CD
                .byte   $E7
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $4E
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $90
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $E7
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $50
                .byte   $D1
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $E7
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $E7
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $E7
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $E7
                .byte   $D0
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $C5
                .byte   $CA
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD
                .byte   $75
                .byte   $CD

@LCA2A:         JSR     LB2A0
                JSR     VmHelper_PushConst_0020
                JMP     VmOp_Compare_BGeatherThan

                LDA     $047A
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
@LCA5E:         JSR     L9695
                JSR     LB2AD
                JSR     L9620
                BCC     @LCA5E
@LCA69:         RTS

@LCA6A:         JSR     VmHelper_SaveMemTemp_06
                JSR     VmHelper_WriteTempAddressWord_02
                JSR     VmHelper_WriteTempAddressWord_04
                JSR     @LCD89
                JSR     VmOp_CheckNotZero
                BCS     @LCA8A
                JSR     @LCD89
                JSR     VmHelper_ReadTempAddressWord_04
                JSR     VmHelper_ReadTempAddressWord_02
                JSR     LBBE8
                JSR     @LCD9E
@LCA8A:         JMP     VmOp_ReadTempMemAddr

                JSR     VmHelper_PushConst_000C
                JSR     VmHelper_PushConst_0019
                JMP     @LCA6A

                JSR     VmHelper_PushConst_000A
                JSR     VmHelper_PushConst_0019
                JMP     @LCA6A

                JSR     VmHelper_PushConst_0008
                LDA     #$17
                JSR     VmOp_PushByte
                JMP     @LCA6A

                JSR     VmHelper_PushConst_0005
                JSR     VmHelper_PushConst_001C
                JMP     @LCA6A

                JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_0016
                JMP     @LCA6A

                JSR     VmHelper_PushConst_0016
                JSR     VmHelper_PushConst_0016
                JMP     @LCA6A

                JSR     VmHelper_PushConst_0012
                LDA     #$15
                JSR     VmOp_PushByte
                JMP     @LCA6A

                JSR     VmHelper_PushConst_0012
                JSR     VmHelper_PushConst_001E
                JMP     @LCA6A

                JSR     VmHelper_PushConst_0011
                LDA     #$1B
                JSR     VmOp_PushByte
                JMP     @LCA6A

                JSR     VmHelper_PushConst_000E
                LDA     #$13
                JSR     VmOp_PushByte
                JMP     @LCA6A

                JSR     VmHelper_PushConst_000C
                LDA     #$13
                JSR     VmOp_PushByte
                JMP     @LCA6A

                JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_0005
                JMP     @LCA6A

                JSR     VmHelper_PushConst_000A
                JSR     VmHelper_PushConst_0006
                JMP     @LCA6A

                LDA     #$13
                JSR     VmOp_PushByte
                JSR     VmHelper_PushConst_0005
                JMP     @LCA6A

                JSR     VmHelper_PushConst_0004
                JSR     VmHelper_PushConst_001C
                JMP     @LCA6A

@LCB20:         LDA     #$01
                STA     $0498
                RTS

@LCB26:         JSR     @LCB20
                JSR     LE41F
                JSR     LE431
                JSR     @LCBF5
                JSR     @LCDB6
                JSR     LB73A
                JSR     LE76A
                JMP     @LCBFB

@LCB3E:         JSR     @LCB20
                JSR     LE41F
                JSR     @LCBF5
                JSR     @LCDB6
                JSR     LB73A
                JSR     LE76A
                JMP     @LCBFB

@LCB53:         JSR     @LCB20
                JSR     LE41F
                JSR     LE431
                JSR     @LCC01
                JSR     @LCDB6
                JSR     LB73A
                JSR     LE76A
                JMP     @LCC07

@LCB6B:         JSR     @LCB20
                JSR     LE431
                JSR     @LCC01
                JSR     @LCDB6
                JSR     LB73A
                JSR     LE76A
                JMP     @LCC07

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     @LCB20
                JSR     LE431
                JSR     @LCDB6
                JSR     LB73A
                JSR     LE76A
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     @LCB20
                JSR     LE41F
                JSR     @LCDB6
                JSR     LB73A
                JSR     LE76A
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     @LCB20
                JSR     LE41F
                JSR     LE431
                JSR     @LCDB6
                JSR     LB73A
                JSR     LE76A
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     @LCDB6
                JSR     @LD018
                JSR     VmHelper_PushConst_0001
                JSR     LE37F
                JSR     @LCDAA
                JSR     @LD018
                JSR     VmHelper_PushConst_0002
                JSR     LE37F
                JSR     @LCDAA
                JSR     LB725
                JSR     LE76A
                JMP     @LCD9E

@LCBF5:         LDA     #$01
                STA     $0482
                RTS

@LCBFB:         LDA     #$00
                STA     $0482
                RTS

@LCC01:         LDA     #$01
                STA     $0483
                RTS

@LCC07:         LDA     #$00
                STA     $0483
                RTS

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     LD254
                JSR     @LCB26
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     LD248
                JSR     @LCB6B
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     LD258
                JSR     @LCB3E
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     LD274
                JSR     @LCB26
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     LD24C
                JSR     @LCB53
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     LD25C
                JSR     @LCB3E
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     LD264
                JSR     @LCB6B
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD32C
                JSR     LD260
                JSR     @LCB26
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     LD26C
                JSR     @LCB3E
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     LD270
                JSR     @LCB3E
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD33C
                JSR     LD268
                JSR     @LCB53
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD334
                JSR     LD250
                JSR     @LCB53
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     LD278
                JSR     @LCB53
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     LD27C
                JSR     @LCB26
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     LD280
                JSR     @LCB53
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD284
                JSR     @LCDC2
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD28C
                JSR     LD31C
                JSR     @LCDC2
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD294
                JSR     LD324
                JSR     @LCDC2
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD29C
                JSR     @LCDC2
                JMP     @LCD9E

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     LB733
                JSR     LD2CC
                JSR     LD2D4
                JSR     LD2DC
                JSR     LD2E4
                JSR     LD2EC
                JSR     LD2F4
                JSR     LD304
@LCD6C:         JSR     LBA24
                JSR     LB77D
                JMP     @LCD6C

                .byte   $EA
                .byte   $60

@LCD77:         JSR     VmHelper_PushConst_0001
                JMP     LE37F

@LCD7D:         JSR     VmHelper_PushConst_0002
                JMP     LE37F

@LCD83:         JSR     VmHelper_PushConst_0003
                JMP     LE37F

@LCD89:         JSR     VmHelper_PushConst_0000
                JSR     LB9A5
                JSR     VmHelper_PushConst_0000
                JSR     LB9B2
                JSR     VmHelper_PushFieldChipX
                JSR     VmHelper_PushFieldChipY
                JMP     VmOp_Or

@LCD9E:         JSR     VmHelper_PushFieldPageX
                JSR     LB9A5
                JSR     VmHelper_PushFieldPageY
                JMP     LB9B2

@LCDAA:         JSR     VmHelper_PushConst_0001
                JMP     LD944

@LCDB0:         JSR     VmHelper_PushConst_0001
                JMP     LD963

@LCDB6:         JSR     VmHelper_PushConst_000B
                JMP     LE362

@LCDBC:         JSR     VmHelper_PushConst_0006
                JMP     LE362

@LCDC2:         JSR     @LCDBC
                JSR     @LCF5B
                JSR     @LCD77
                JSR     LE171
                JSR     @LCDB0
                JSR     LB725
                JMP     LE76A

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                LDA     $047A
                BNE     @LCDF1
                JSR     DisableApuChannel
                JSR     LD2B4
                JSR     @LCF76
                JSR     @LCD77
                JSR     LE168
@LCDF1:         JSR     @LCDB6
                JSR     LB725
                JSR     LE76A
                JSR     @LCD9E
                LDA     #$01
                STA     $047A
                RTS

                LDA     $047B
                BNE     @LCE43
                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD2AC
                JSR     VmHelper_PushConst_0009
                JSR     LE362
                JSR     @LCF7F
                JSR     @LCD77
                JSR     @LCDB0
                JSR     @LCF7F
                JSR     @LCD7D
                JSR     @LCDB0
                JSR     @LCF7F
                JSR     @LCD83
                LDA     #$1F
                STA     $045D
                JSR     LB725
                JSR     LE76A
                JSR     @LCD9E
                INC     $047B
@LCE43:         RTS

                LDA     $047C
                BNE     @LCE90
                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD2A4
                JSR     VmHelper_PushConst_0007
                JSR     LE362
                JSR     @LCF64
                JSR     @LCD77
                JSR     LE171
                JSR     @LCDB0
                JSR     @LCF64
                JSR     @LCD7D
                JSR     LE171
                JSR     @LCDB0
                JSR     @LCF64
                JSR     @LCD83
                JSR     LE171
                JSR     @LCDB0
                LDA     #$1F
                STA     $045D
                JSR     LB725
                JSR     LE76A
                JSR     @LCD9E
                INC     $047C
@LCE90:         RTS

                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     VmHelper_PushConst_0003
                JSR     LE362
                JSR     LB409
                JSR     LB73A
                JSR     LE76A
                JMP     @LCD9E

@LCEA9:         JSR     LE168
                JMP     @LCDAA

                LDA     PartyIn_Chohakkai-1
                BNE     @LCEF2
                JSR     @LCD89
                JSR     VmOp_ExitTrue
                JSR     DisableApuChannel
                JSR     LD2C4
                JSR     @LCF88
                JSR     @LCD77
                JSR     @LCEA9
                JSR     @LCF91
                JSR     @LCD7D
                JSR     @LCEA9
                JSR     @LCF9A
                JSR     @LCD83
                JSR     @LCEA9
                JSR     VmHelper_PushConst_000C
                JSR     LE362
                LDA     #$1F
                STA     $045D
                JSR     LB725
                JSR     LE76A
                JSR     @LCD9E
                INC     PartyIn_Chohakkai-1
@LCEF2:         RTS

                LDA     PartyIn_Chohakkai
                BNE     @LCF29
                JSR     DisableApuChannel
                JSR     LD30C
                JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     @LCFA3
                JSR     @LCD7D
                JSR     @LCDB0
                JSR     @LCFA3
                JSR     @LCD83
                JSR     @LCDB0
                LDA     #$01
                STA     $0480
                JSR     LB725
                JSR     LE76A
                INC     PartyIn_Chohakkai
                LDA     #$00
                STA     $0480
@LCF29:         RTS

                LDA     PartyIn_Sagojo
                BNE     @LCF5A
                JSR     DisableApuChannel
                JSR     LD314
                JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     @LCF5B
                JSR     @LCD7D
                JSR     LE171
                JSR     @LCDB0
                LDA     #$01
                STA     $0481
                JSR     LB725
                JSR     LE76A
                INC     PartyIn_Sagojo
                LDA     #$00
                STA     $0481
@LCF5A:         RTS

@LCF5B:         JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_0006
                JMP     VmHelper_PushConst_000A

@LCF64:         JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PushConst_0008
                JMP     VmHelper_PushConst_000A

@LCF6D:         JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_000A
                JMP     VmHelper_PushConst_000A

@LCF76:         JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_000B
                JMP     VmHelper_PushConst_0007

@LCF7F:         JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PushConst_0008
                JMP     VmHelper_PushConst_0006

@LCF88:         JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_00E0
                JMP     VmHelper_PushConst_0008

@LCF91:         JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_00E0
                JMP     VmHelper_PushConst_0009

@LCF9A:         JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_00E0
                JMP     VmHelper_PushConst_000A

@LCFA3:         JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_0008
                JMP     VmHelper_PushConst_000B

@LCFAC:         JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_000B
                JMP     VmHelper_PushConst_000B

@LCFB5:         JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PushConst_0008
                JMP     VmHelper_PushConst_0009

@LCFBE:         JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PushConst_000A
                JMP     VmHelper_PushConst_000A

@LCFC7:         JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PushConst_0006
                JMP     VmHelper_PushConst_000B

@LCFD0:         JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_000A
                JMP     VmHelper_PushConst_000B

@LCFD9:         JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_000A
                JMP     VmHelper_PushConst_0007

@LCFE2:         JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_000E
                JMP     VmHelper_PushConst_0007

@LCFEB:         JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_0004
                JMP     VmHelper_PushConst_0009

@LCFF4:         JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_0018
                JMP     VmHelper_PushConst_0006

@LCFFD:         JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_000F
                JMP     VmHelper_PushConst_0008

@LD006:         JSR     VmHelper_PushConst_0001
                JSR     VmHelper_PushConst_0004
                JMP     VmHelper_PushConst_0007

@LD00F:         JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_000F
                JMP     VmHelper_PushConst_0008

@LD018:         JSR     VmHelper_PushConst_0002
                JSR     VmHelper_PushConst_0008
                JMP     VmHelper_PushConst_0006

@LD021:         JSR     @LCDB0
                JSR     LB725
                JMP     LE76A

@LD02A:         JSR     @LCDAA
@LD02D:         JSR     LB725
                JMP     LE76A

                JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     @LCFA3
                JSR     @LCD77
                JMP     @LD021

                JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     @LCF5B
                JSR     @LCD77
                JSR     LE171
                JMP     @LD021

                JSR     VmHelper_PushConst_0001
                JSR     LE362
                JSR     @LCFB5
                JSR     @LCD77
                JSR     @LCDB0
                JSR     @LCFB5
                JSR     @LCD7D
                JMP     @LD021

                JSR     VmHelper_PushConst_0002
                JSR     LE362
                JSR     @LCA2A
                JSR     VmOp_ExitFalse
                JSR     @LCFC7
                JSR     @LCD77
                JMP     @LD02A

                JSR     VmHelper_PushConst_0002
                JSR     LE362
                JSR     @LCFD9
                JSR     @LCD77
                JMP     @LD02D

                JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     @LCA2A
                JSR     VmOp_ExitFalse
                JSR     @LCFEB
                JSR     @LCD77
                JSR     @LCDAA
                JSR     @LCFEB
                JSR     @LCD7D
                JSR     @LCDAA
                JSR     @LCFEB
                JSR     @LCD83
                JMP     @LD02A

                JSR     VmHelper_PushConst_0002
                JSR     LE362
                JSR     @LCFD9
                JSR     @LCD77
                JSR     @LCFF4
                JSR     @LCD7D
                JSR     LE168
                JMP     @LD02D

                JSR     VmHelper_PushConst_0002
                JSR     LE362
                JSR     @LCFD9
                JSR     @LCD77
                JSR     @LCFFD
                JSR     @LCD7D
                JSR     LE168
                JMP     @LD02D

                JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     @LD006
                JSR     @LCD77
                JSR     @LCDB0
                JSR     @LD006
                JSR     @LCD7D
                JSR     @LCDB0
                JSR     @LD006
                JSR     @LCD83
                JSR     LE168
                JMP     @LD02D

                JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     @LCFA3
                JSR     @LCD77
                JSR     @LCDB0
                JSR     @LD00F
                JSR     @LCD83
                JSR     LE168
                JMP     @LD02D

                JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     @LCF5B
                JSR     @LCD77
                JSR     LE171
                JSR     @LCDB0
                JSR     @LCF5B
                JSR     @LCD7D
                JSR     LE171
                JSR     @LCDB0
                JSR     @LCF6D
                JSR     @LCD83
                JSR     LE171
                JMP     @LD021

                JSR     VmHelper_PushConst_0005
                JSR     LE362
                JSR     @LCFA3
                JSR     @LCD77
                JSR     @LCDB0
                JSR     @LCFA3
                JSR     @LCD7D
                JSR     @LCDB0
                JSR     @LCFAC
                JSR     @LCD83
                JMP     @LD021

                JSR     VmHelper_PushConst_0002
                JSR     LE362
                JSR     @LCA2A
                JSR     VmOp_ExitFalse
                JSR     @LCFC7
                JSR     @LCD77
                JSR     @LCDAA
                JSR     @LCFC7
                JSR     @LCD7D
                JSR     @LCDAA
                JSR     @LCFD0
                JSR     @LCD83
                JMP     @LD02A

                JSR     VmHelper_PushConst_0001
                JSR     LE362
                JSR     @LCFBE
                JSR     @LCD77
                JSR     LE168
                JSR     @LCDB0
                JSR     @LCFBE
                JSR     @LCD7D
                JSR     LE168
                JSR     @LCDB0
                JSR     @LCFBE
                JSR     @LCD83
                JSR     LE168
                JMP     @LD021

                JSR     VmHelper_PushConst_0002
                JSR     LE362
                JSR     @LCFD9
                JSR     @LCD77
                JSR     @LCDB0
                JSR     @LCFD9
                JSR     @LCD7D
                JSR     @LCDB0
                JSR     @LCFE2
                JSR     @LCD83
                JMP     @LD02D

LD1E3:          .byte   $00
LD1E4:          .byte   $00
                .word   TAA3C
                .word   TAA4D
                .word   TAA60
                .word   TAA75
                .word   TAA83
                .word   TAA90
                .word   TAA9F
                .word   TAAAD
                .word   TAABB
                .word   TAAC5
                .word   TAAD3
                .word   TAADF
                .word   TAAF3
                .word   TAB08
                .word   TAB21
                .word   TAB35
                .word   TAB48
                .word   TAB5F
                .word   TAB77
                .word   TAB89
                .word   TAB9A
                .word   TABAC
                .word   TABC3
                .word   TABCD
                .word   TABE0
                .word   TABF8
                .word   TAC01
                .word   TAC14
                .word   TAC28
                .word   TAC34
                .word   TAC39
                .byte   $00
                .byte   $00
                .word   TAC4B
                .word   TAC5F
                .byte   $00
                .byte   $00
                .word   TAC6F
                .word   TAC81
                .word   TAC89
                .word   TAC94
                .word   TACA0
                .word   TACA9

LD237:          ASL     A
                TAY
                LDA     LD1E4,y
                STA     $C1
                LDA     LD1E3,y
                STA     $C0
                LDA     #$01
                STA     $C2
                RTS

LD248:          LDA     #$01
                BNE     LD237

LD24C:          LDA     #$02
                BNE     LD237

LD250:          LDA     #$03
                BNE     LD237

LD254:          LDA     #$08
                BNE     LD237

LD258:          LDA     #$09
                BNE     LD237

LD25C:          LDA     #$0A
                BNE     LD237

LD260:          LDA     #$0B
                BNE     LD237

LD264:          LDA     #$0C
                BNE     LD237

LD268:          LDA     #$0D
                BNE     LD237

LD26C:          LDA     #$0E
                BNE     LD237

LD270:          LDA     #$0F
                BNE     LD237

LD274:          LDA     #$10
                BNE     LD237

LD278:          LDA     #$14
                BNE     LD237

LD27C:          LDA     #$21
                BNE     LD237

LD280:          LDA     #$22
                BNE     LD237

LD284:          LDA     #$04
                JSR     LD237
                JMP     LE856

LD28C:          LDA     #$05
                JSR     LD237
                JMP     LE856

LD294:          LDA     #$06
                JSR     LD237
                JMP     LE856

LD29C:          LDA     #$07
                JSR     LD237
                JMP     LE856

LD2A4:          LDA     #$11
                JSR     LD237
                JMP     LE856

LD2AC:          LDA     #$12
                JSR     LD237
                JMP     LE856

LD2B4:          LDA     #$13
                JSR     LD237
                JMP     LE856

LD2BC:          LDA     #$15
                JSR     LD237
                JMP     LE856

LD2C4:          LDA     #$16
                JSR     LD237
                JMP     LE856

LD2CC:          LDA     #$17
                JSR     LD237
                JMP     LE856

LD2D4:          LDA     #$18
                JSR     LD237
                JMP     LE851

LD2DC:          LDA     #$19
                JSR     LD237
                JMP     LE851

LD2E4:          LDA     #$1A
                JSR     LD237
                JMP     LE851

LD2EC:          LDA     #$1B
                JSR     LD237
                JMP     LE851

LD2F4:          LDA     #$1C
                JSR     LD237
                JMP     LE851

LD2FC:          LDA     #$1D
                JSR     LD237
                JMP     LE856

LD304:          LDA     #$1E
                JSR     LD237
                JMP     LE851

LD30C:          LDA     #$1F
                JSR     LD237
                JMP     LE856

LD314:          LDA     #$24
                JSR     LD237
                JMP     LE856

LD31C:          LDA     #$25
                JSR     LD237
                JMP     LE856

LD324:          LDA     #$26
                JSR     LD237
                JMP     LE856

LD32C:          LDA     #$27
                JSR     LD237
                JMP     LE856

LD334:          LDA     #$28
                JSR     LD237
                JMP     LE856

LD33C:          LDA     #$29
                JSR     LD237
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

                .byte   $20
                .byte   $33
                .byte   $97
                .byte   $20
                .byte   $D7
                .byte   $95
                .byte   $4C
                .byte   $C5
                .byte   $97

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
                LDA     PadBuffer_Now+4
                BEQ     @LD6AC
                JSR     LD678
@LD6AC:         LDA     PadBuffer_Now+5
                BEQ     @LD6B4
                JSR     LD682
@LD6B4:         LDA     PadBuffer_Now+6
                BEQ     @LD6BC
                JSR     LD646
@LD6BC:         LDA     PadBuffer_Now+7
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

LD77D:          JSR     VmHelper_SaveMemTemp_02
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
                JMP     VmOp_ReadTempMemAddr

LD7AD:          JSR     L9601
@LD7B0:         JSR     LE159
                JSR     L9695
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

@LD7E6:         JSR     L9695
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
                JSR     LB745
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
                JMP     LB755

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
                LDA     $0354
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

                .byte   $AC
                .byte   $5A
                .byte   $03
                .byte   $B9
                .byte   $AF
                .byte   $03
                .byte   $4C
                .byte   $CC
                .byte   $98

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
                JSR     LB749
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

LDB00:          LDA     PadBuffer_Now
                JMP     VmOp_PushByte

                .byte   $AD
                .byte   $21
                .byte   $03
                .byte   $4C
                .byte   $CC
                .byte   $98

LDB0C:          LDA     PadBuffer_Trigger
                JMP     VmOp_PushByte

LDB12:          LDA     PadBuffer_Trigger+1
                JMP     VmOp_PushByte

LDB18:          LDA     PadBuffer_Now+3
                JMP     VmOp_PushByte

VmHelper_PushPad_Left:
                LDA     PadBuffer_Now+6
                JMP     VmOp_PushByte

VmHelper_PushPad_Right:
                LDA     PadBuffer_Now+7
                JMP     VmOp_PushByte

VmHelper_PushPad_Up:
                LDA     PadBuffer_Now+4
                JMP     VmOp_PushByte

VmHelper_PushPad_Down:
                LDA     PadBuffer_Now+5
                JMP     VmOp_PushByte

LDB36:          LDA     PadBuffer_Trigger+3
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

                .byte   $AD
                .byte   $74
                .byte   $04
                .byte   $4C
                .byte   $CC
                .byte   $98
                .byte   $20
                .byte   $AB
                .byte   $96
                .byte   $8C
                .byte   $74
                .byte   $04
                .byte   $60

LDBB6:          JSR     LDB36
                JSR     VmOp_ExitFalse
                JSR     LE1F8
                JSR     VmHelper_PushConst_0005
                JSR     VmOp_Compare_Equal
                JSR     VmOp_CheckNotZero
                BCC     LDBEA
LDBCA:          LDA     #$00
                STA     $0354
                STA     $03B5
                LDY     $035A
                LDA     #$01
                STA     $0361
                JSR     LB745
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
                JMP     LB745

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
                JSR     VmHelper_SaveMemTemp_0E
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
                JMP     VmOp_ReadTempMemAddr

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

                .byte   $20
                .byte   $AB
                .byte   $96
                .byte   $98
                .byte   $AC
                .byte   $5A
                .byte   $03
                .byte   $99
                .byte   $EE
                .byte   $03
                .byte   $60

LDCFE:          LDY     $035A
                LDA     $03F4,y
                JMP     VmOp_PushByte

                .byte   $20
                .byte   $AB
                .byte   $96
                .byte   $98
                .byte   $AC
                .byte   $5A
                .byte   $03
                .byte   $99
                .byte   $F4
                .byte   $03
                .byte   $60

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

                .byte   $BD
                .byte   $24
                .byte   $02
                .byte   $C9
                .byte   $F0
                .byte   $F0
                .byte   $6A
                .byte   $B9
                .byte   $8B
                .byte   $03
                .byte   $D0
                .byte   $21
                .byte   $A9
                .byte   $F0
                .byte   $9D
                .byte   $24
                .byte   $02
                .byte   $4C
                .byte   $63
                .byte   $DE
                .byte   $BD
                .byte   $24
                .byte   $02
                .byte   $C9
                .byte   $F0
                .byte   $F0
                .byte   $56
                .byte   $B9
                .byte   $A9
                .byte   $03
                .byte   $F0
                .byte   $0D
                .byte   $18
                .byte   $BD
                .byte   $24
                .byte   $02
                .byte   $79
                .byte   $AF
                .byte   $03
                .byte   $9D
                .byte   $24
                .byte   $02
                .byte   $4C
                .byte   $45
                .byte   $DE
                .byte   $B9
                .byte   $8B
                .byte   $03
                .byte   $19
                .byte   $B5
                .byte   $03
                .byte   $F0
                .byte   $1E
                .byte   $B9
                .byte   $67
                .byte   $03
                .byte   $F0
                .byte   $0A
                .byte   $38
                .byte   $BD
                .byte   $24
                .byte   $02
                .byte   $F9
                .byte   $AA
                .byte   $DD
                .byte   $9D
                .byte   $24
                .byte   $02
                .byte   $B9
                .byte   $6D
                .byte   $03
                .byte   $F0
                .byte   $0A
                .byte   $18
                .byte   $BD
                .byte   $24
                .byte   $02
                .byte   $79
                .byte   $AA
                .byte   $DD
                .byte   $9D
                .byte   $24
                .byte   $02
                .byte   $B9
                .byte   $79
                .byte   $03
                .byte   $F0
                .byte   $0A
                .byte   $38
                .byte   $BD
                .byte   $27
                .byte   $02
                .byte   $F9
                .byte   $A0
                .byte   $DD
                .byte   $9D
                .byte   $27
                .byte   $02
                .byte   $B9
                .byte   $73
                .byte   $03
                .byte   $F0
                .byte   $0A
                .byte   $18
                .byte   $BD
                .byte   $27
                .byte   $02
                .byte   $79
                .byte   $A0
                .byte   $DD
                .byte   $9D
                .byte   $27
                .byte   $02
                HiAscii "hhhh"
                .byte   $60

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

LDEFD:          LDA     $03D3
                JMP     VmOp_PushByte

LDF03:          JSR     VmOp_PopRegister
                STY     $03D3
                RTS

LDF0A:          LDY     $035A
                LDA     $046A,y
                BEQ     @LDF1A
                LDA     #$00
                STA     $046A,y
                JMP     LDF2A

@LDF1A:         RTS

LDF1B:          JSR     LD74F
                LDA     $0355
                JSR     VmOp_PushByte
                JSR     VmOp_Or
                JSR     VmOp_ExitFalse
LDF2A:          JSR     VmHelper_ReadTempAddressWord_0A
                JSR     VmOp_ExitFalse
                JSR     LB741
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
                LDY     $0354
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
                LDA     $0355
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

                .byte   $A0
                .byte   $05
                .byte   $A9
                .byte   $00
                .byte   $99
                .byte   $61
                .byte   $03
                .byte   $88
                .byte   $10
                .byte   $FA
                .byte   $60

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
                LDA     $0354,y
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

                .byte   $20
                .byte   $AB
                .byte   $96
                .byte   $85
                .byte   $67
                .byte   $84
                .byte   $66
                .byte   $60

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

                .byte   $20
                .byte   $70
                .byte   $DD
                .byte   $20
                .byte   $6C
                .byte   $DF
                .byte   $20
                .byte   $B5
                .byte   $98
                .byte   $20
                .byte   $04
                .byte   $95
                .byte   $20
                .byte   $88
                .byte   $DD
                .byte   $20
                .byte   $6C
                .byte   $DF
                .byte   $20
                .byte   $B5
                .byte   $98
                .byte   $20
                .byte   $FD
                .byte   $94
                .byte   $4C
                .byte   $19
                .byte   $95

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
                LDA     $0354,y
                JMP     VmOp_PushByte

LE201:          JSR     VmOp_PopRegister
                TYA
                LDY     $035A
                STA     $0354,y
                RTS

LE20C:          LDY     #$05
                LDA     #$00
@LE210:         STA     $0354,y
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
                LDA     $0354,y
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
                JSR     VmHelper_SaveMemTemp_0C
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
                JMP     VmOp_ReadTempMemAddr

LE2DA:          LDA     $0496
                BNE     @LE2E0
                RTS

@LE2E0:         LDA     #$00
                STA     $0496
                JSR     LE0CE
                JSR     LE101
                JSR     VmHelper_SaveMemTemp_0C
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
                JMP     VmOp_ReadTempMemAddr

                .byte   $A9
                .byte   $31
                .byte   $4C
                .byte   $CC
                .byte   $98
                .byte   $A9
                .byte   $33
                .byte   $4C
                .byte   $CC
                .byte   $98

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

                .byte   $A5
                .byte   $C9
                .byte   $4C
                .byte   $CC
                .byte   $98

LE362:          JSR     VmOp_PopRegister
                STY     RleExpandIndex
                RTS

LE368:          LDY     #$05
@LE36A:         LDA     $03E2,y
                BNE     @LE375
                DEY
                BNE     @LE36A
@LE372:         JMP     VmHelper_PushConst_0001

@LE375:         LDA     $0354,y
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

                .byte   $A9
                .byte   $F0
                .byte   $8D
                .byte   $0C
                .byte   $02
                .byte   $8D
                .byte   $10
                .byte   $02
                .byte   $60

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
                RTS

                .byte   $AD
                .byte   $80
                .byte   $04
                .byte   $F0
                .byte   $06
                .byte   $20
                .byte   $55
                .byte   $98
                .byte   $4C
                .byte   $A9
                .byte   $B3
                .byte   $AD
                .byte   $81
                .byte   $04
                .byte   $F0
                .byte   $EF
                .byte   $20
                .byte   $51
                .byte   $98
                .byte   $4C
                .byte   $A9
                .byte   $B3

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
                JSR     LB74D
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
                JSR     LB74D
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

LE533:          LDA     #$00
                BEQ     LE539

LE537:          LDA     #$01
LE539:          STA     PpuMaskBuffer+3
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
                JSR     LB751
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
                JSR     VmHelper_SaveMemTemp_06
                JSR     LE61E
                JMP     VmOp_ReadTempMemAddr

LE677:          JSR     LE653
                JSR     LE551
                JMP     LE59C

LE680:          JSR     LAF7C
                JSR     SetOamDmaRequest
                JMP     LE644

LE689:          LDA     PadBuffer_Trigger+2
                JSR     VmOp_PushByte
                JSR     VmOp_ExitFalse
                JSR     LD60A
                LDA     #$01
                STA     $0473
                JSR     DisableApuChannel
@LE69D:         JSR     ReadJoypad
                JSR     LE7BE
                LDA     PadBuffer_Trigger+2
                BEQ     @LE69D
                LDA     #$00
                STA     $0473
                JMP     EnableApuChannel

LE6B0:          JSR     LE7BE
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
                BEQ     LE6B0
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
                JSR     LE533
                JSR     LB71A
                JSR     LB034
                LDY     #$04
                LDA     #$00
@LE785:         STA     $0475,y
                DEY
                BPL     @LE785
                JSR     SetOamDmaRequest
                JSR     LE74E
                JSR     LBA24
                JSR     LE0F6
                JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PopScreenY
                JSR     VmHelper_PushConst_0000
                JSR     VmHelper_PopScreenX
                JSR     VmHelper_PushConst_0000
                JSR     LE70E
                JSR     LAF9A
                JSR     LBA24
                JSR     LB13B
                JSR     LE537
                JSR     LE508
                JSR     EnableApuChannel
                JMP     LE6B0

LE7BE:          JSR     SetOamDmaRequest
                JSR     LB04F
                JSR     LF0CD
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
                JSR     LB71A
                JSR     LBA24
                JSR     LE856
                LDA     #$01
                STA     $0484
                JSR     LE533
                JSR     SetZeroSprite
                JSR     SetOamDmaRequest
                JSR     LBA24
                LDA     #$00
                STA     $0498
                STA     RleExpandIndex
                JSR     LBAD5
                JSR     LBAD5
                JSR     LBAD5
                JSR     LB014
                JSR     LBA24
                LDA     #$02
                JSR     LB76B
                JSR     LB1A8
                JSR     SetOamDmaRequest
                JSR     LBA24
                JSR     LD98D
                JSR     @LE841
                JSR     LEE0A
                JSR     LE537
                LDA     #$00
                STA     $04DA
                RTS

@LE841:         LDY     #$05
                LDA     #$00
@LE845:         STA     $03E2,y
                DEY
                BPL     @LE845
                LDA     #$00
                STA     $0354
                RTS

LE851:          TXA
                PHA
                JMP     LE879

LE856:          LDA     $C2
                BNE     @LE85B
                RTS

@LE85B:         TXA
                PHA
                LDA     #$01
                STA     $0484
                JSR     LB71A
                JSR     SetOamDmaRequest
                JSR     LBA24
                JSR     LB77D
                LDA     #$00
                STA     $C2
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
@LE887:         LDA     ($C0),y
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
                LDA     ($C0),y
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
                LDA     #$33
                STA     ChrBankRequest
                LDA     #$06
                STA     $55
                LDA     #$00
                STA     $54
                JSR     LB614
                LDA     #$00
                STA     $0484
                JSR     VmHelper_PushConst_00F0
                JSR     VmHelper_PushConst_0000
                JSR     L9601
@LE8DA:         JSR     LBA24
                JSR     LB77D
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
@LE8F1:         LDA     $0354,y
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
                STA     $045A
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
                LDA     $045A
                BEQ     @LE97E
                LDA     $03FA
                BEQ     @LE93C
@LE97E:         LDA     $03FB
                BEQ     @LE93C
                LDA     $0493
                BNE     @LE93C
                DEC     $045D
                LDA     #$06
                JSR     LB76B
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

@LE9BF:         LDA     $045A
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
                STA     $0354,y
                LDA     $045E,y
                STA     $03DC,y
@LE9E4:         DEY
                BNE     @LE9C6
@LE9E7:         RTS

LE9E8:          JSR     ReadJoypad
                LDA     PadBuffer_Now+3
                BNE     @LEA0C
                LDA     PadBuffer_Now
                CMP     $045A
                BEQ     @LEA0A
                STA     $045A
                LSR     A
                BCC     @LEA0A
                LDA     $0459
                ASL     A
                ADC     PadBuffer_Now+1
                AND     #$0F
                STA     $0459
@LEA0A:         CLC
                RTS

@LEA0C:         LDA     #$01
                STA     PartyIn_Chohakkai
                STA     PartyIn_Sagojo
                LDY     $0459
                LDA     @LEA31,y
                BNE     @LEA26
                STA     PartyIn_Chohakkai
                STA     PartyIn_Sagojo
                LDA     #$1E
                LDY     #$10
@LEA26:         PHA
                TYA
                JSR     VmOp_PushByte
                PLA
                JSR     VmOp_PushByte
                SEC
                RTS

@LEA31:         .byte   $00
                .byte   $14
                .byte   $00
                .byte   $1A
                .byte   $06
                .byte   $00
                .byte   $00
                .byte   $11
                .byte   $00
                .byte   $0E
                .byte   $1A
                .byte   $05
                .byte   $00
                .byte   $18
                .byte   $10
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
                STX     $045A
                STY     $045B
                JSR     LB76B
                LDX     $045A
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
                STX     $045A
                STY     $045B
                PLA
                TAX
                JSR     LDF45
                TXA
                PHA
                LDA     #$08
                JSR     LB76B
                LDX     $045A
                LDY     $045B
                JMP     @LEB8A

@LEB16:         LDA     $0355
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

@LEB41:         STX     $045A
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
                JSR     LB76B
                JSR     LEB9E
                BNE     @LEB81
@LEB7E:         DEX
                BNE     @LEB49
@LEB81:         LDX     $045A
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
                STA     $045A
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
                ADC     $045A
                STA     $045A
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
                ADC     $045A
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
                ADC     $045A
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
                STA     PpuMaskBuffer+1
                JSR     SetPpuMask
                PLA
                TAX
                RTS

LEE39:          LDA     #$01
                STA     PpuMaskBuffer+1
                JSR     SetPpuMask
                JMP     LB71A

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

LEE5C:          LDY     #$00
                LDA     PartyLifes
                BEQ     @LEE64
                INY
@LEE64:         LDA     PartyLifes+1
                BEQ     @LEE6A
                INY
@LEE6A:         LDA     PartyLifes+2
                BEQ     @LEE70
                INY
@LEE70:         LDA     PartyLifes+3
                BEQ     @LEE76
                INY
@LEE76:         LDA     PartyLifes+4
                BEQ     @LEE7C
                INY
@LEE7C:         TYA
                JMP     VmOp_PushByte

LEE80:          LDY     $0354
                LDA     PartyLifes,y
                JMP     VmOp_PushByte

LEE89:          JSR     LEEB7
                JSR     VmOp_ExitFalse
                LDA     $0354
                CMP     #$05
                BEQ     @LEE99
                JSR     LEEBD
@LEE99:         RTS

LEE9A:          JSR     LEE89
                JSR     VmHelper_SaveMemTemp_08
                JSR     LEE80
                JSR     VmOp_CheckNotZero
                BCC     @LEEAC
                JSR     LEF69
                SEC
@LEEAC:         BCS     @LEEB4
                JSR     LEEF4
                JSR     LEF69
@LEEB4:         JMP     VmOp_ReadTempMemAddr

LEEB7:          LDA     PartyLifes
                JMP     VmOp_PushByte

LEEBD:          LDA     #$00
                STA     $0354
                RTS

LEEC3:          LDA     $0354
                JMP     VmOp_PushByte

LEEC9:          LDA     $0355
                JMP     VmOp_PushByte

LEECF:          JSR     VmHelper_PushConst_0000
                JMP     LEED8

LEED5:          JSR     VmHelper_PushConst_0001
LEED8:          JSR     LE217
                JMP     LE201

LEEDE:          LDA     #$03
                LDY     #$C8
                JMP     VmOp_PushRegister

LEEE5:          LDA     $0355
                BEQ     @LEEEE
                CMP     #$06
                BCC     @LEEF1
@LEEEE:         JMP     VmHelper_PushConst_0000

@LEEF1:         JMP     VmHelper_PushConst_0001

LEEF4:          LDA     PartyLifes
                BEQ     @LEEFA
                RTS

@LEEFA:         JSR     LEE5C
                JSR     VmOp_ExitFalse
                JSR     LEE5C
                JSR     VmHelper_PushConst_0001
                JSR     VmOp_Compare_Equal
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
                LDY     $0355
                CPY     #$06
                BCS     @LEF61
                LDA     PartyLifes,y
                BNE     @LEF63
@LEF61:         LDA     #$00
@LEF63:         JSR     VmOp_PushByte
                JMP     VmOp_Or

LEF69:          LDA     $045D
                BNE     @LEFA3
                LDA     $0480
                ORA     $0481
                BNE     @LEFA4
                JSR     LEF4F
                JSR     VmOp_ExitTrue
                JSR     LEE5C
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
@LEFA3:         RTS

@LEFA4:         LDA     $0480
                BEQ     @LEFCE
                LDA     PartyIn_Chohakkai
                BNE     @LEFA3
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
                BNE     @LEFA3
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
                JSR     LF160
                LDA     #$1C
                STA     VmMem_SecondStack
                LDX     #$7C
                LDA     #$80
                STA     VmMem_Temp
                LDA     #$07
                STA     VmMem_Temp+1
                LDA     #$0A
                STA     FieldPageY
                LDA     #$19
                STA     FieldPageX
                CLI
                JSR     LAF02
                LDA     #$01
                STA     PpuControlBuffer+7
                STA     PpuControlBuffer+4
                STA     PpuControlBuffer+5
                JSR     SetPpuControl
                JSR     LAF0D
                LDA     #$01
                STA     PpuMaskBuffer+1
                STA     PpuMaskBuffer+2
                STA     PpuMaskBuffer+3
                STA     PpuMaskBuffer+4
                JSR     SetPpuMask
                LDA     #$38
                STA     $39
                JMP     LF0E2

LF0CD:          LDA     #$00
                STA     $56
@LF0D1:         LDA     $56
                BEQ     @LF0D1
                JSR     SetDisplayScreenPosition
                LDA     #$00
                STA     $56
                RTS

SetOamDmaRequest:
                LDA     #$01
                STA     OamDmaRequest
                RTS

LF0E2:          JSR     @LF14A
                LDA     #$30
                STA     LFFF4
                LDA     #$00
                STA     ScreenX
                STA     ScreenX+1
                STA     ScreenY
                STA     $045D
                STA     $0472
                JSR     VmHelper_PushConst_0001
                JSR     LEF41
                JSR     VmHelper_PushConst_0001
                JSR     LEF48
                JSR     @LF13F
                JSR     LBA24
                JSR     LE533
                LDA     #$0D
                STA     RleExpandIndex
                JSR     LAF9A
                JSR     LB775
                JSR     LE537
                LDA     #$00
                STA     $0484
                JSR     LB72C
@LF122:         JSR     @LF13F
                JSR     LB77D
                JSR     LBA24
                JSR     LE9E8
                LDA     LFFF4
                STA     LFFF4
                BCC     @LF122
                JSR     LB769
                JSR     LBA3D
                JMP     LF0E2

@LF13F:         LDA     #$F0
                STA     OamBuffer
                JSR     LB71A
                JMP     SetOamDmaRequest

@LF14A:         TXA
                PHA
                LDA     #$00
                STA     PPUCTRL
                STA     PPUMASK
                JSR     LF160
                JSR     SetPpuControl
                JSR     SetPpuMask
                PLA
                TAX
                RTS

LF160:          LDY     #$00
                STY     PPUMASK
                TXA
                PHA
                LDX     #$20
@LF169:         LDA     PPUSTATUS
                TXA
                STA     PPUADDR
                LDA     #$00
                STA     PPUADDR
@LF175:         STA     PPUDATA
                INY
                BNE     @LF175
                INX
                CPX     #$40
                BCC     @LF169
                LDA     #$3F
                STA     PPUADDR
                LDA     #$00
                STA     PPUADDR
                STA     PPUADDR
                STA     PPUADDR
                PLA
                TAX
                RTS

                .byte   "SR"                            ;Junk data
                .byte   $09                             ;Uncompiled source
                .byte   "TRUE_CASE",$0D,$0A             ;PC:0x40E8, ROM:$C0D8 (Maybe)
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

LF1D0:          JMP     LF1DF

LF1D3:          JMP     LF398

JumpDisableApuChannel:
                JMP     ApuDisable

JumpEnableApuChannel:
                JMP     ApuEnable

LF1DC:          JMP     LF367

; Argument: A = Process index
LF1DF:          CMP     #$17
                BCS     @Return                         ;if overflow song number, return
                ASL     A
                TAX
                LDA     SounddriverProcessPointerTable+1,x
                PHA
                LDA     SounddriverProcessPointerTable,x
                PHA
@Return:        RTS                                     ;Jump to process routine / Return caller

SounddriverProcessPointerTable:
                .word   TF21C-1
                .word   TF21F-1
                .word   TF238-1
                .word   TF25C-1
                .word   TF28B-1
                .word   TF2BA-1
                .word   TF2D3-1
                .word   TF2DE-1
                .word   TF2DF-1
                .word   TF2E0-1
                .word   TF2EB-1
                .word   TF2F6-1
                .word   TF2F7-1
                .word   TF302-1
                .word   TF30D-1
                .word   TF318-1
                .word   TF323-1
                .word   TF324-1
                .word   TF32F-1
                .word   TF330-1
                .word   TF33B-1
                .word   TF351-1
                .word   TF361-1

TF21C:          JMP     LF367

TF21F:          JSR     LF367
                LDA     #$87
                STA     $11
                LDA     #$F5
                STA     $12
                LDA     #$A1
                STA     $21
                LDA     #$F5
                STA     $22
                JSR     LF47C
                JMP     LF48A

TF238:          JSR     LF367
                LDA     #$54
                STA     $11
                LDA     #$F7
                STA     $12
                LDA     #$EF
                STA     $19
                LDA     #$F7
                STA     $1A
                LDA     #$A4
                STA     $21
                LDA     #$F7
                STA     $22
                JSR     LF47C
                JSR     LF483
                JMP     LF48A

TF25C:          JSR     LF367
                LDA     #$A1
                STA     $11
                LDA     #$FE
                STA     $12
                LDA     #$C2
                STA     $19
                LDA     #$FE
                STA     $1A
                LDA     #$D4
                STA     $21
                LDA     #$FE
                STA     $22
                LDA     #$04
                STA     $29
                LDA     #$FF
                STA     $2A
                JSR     LF47C
                JSR     LF483
                JSR     LF48A
                JMP     LF491

TF28B:          JSR     LF367
                LDA     #$05
                STA     $11
                LDA     #$FD
                STA     $12
                LDA     #$13
                STA     $19
                LDA     #$FD
                STA     $1A
                LDA     #$42
                STA     $21
                LDA     #$FD
                STA     $22
                LDA     #$71
                STA     $29
                LDA     #$FD
                STA     $2A
                JSR     LF47C
                JSR     LF483
                JSR     LF48A
                JMP     LF491

TF2BA:          JSR     LF367
                LDA     #$D1
                STA     $11
                LDA     #$FA
                STA     $12
                LDA     #$FF
                STA     $21
                LDA     #$FA
                STA     $22
                JSR     LF47C
                JMP     LF48A

TF2D3:          LDA     #$F2
                STA     $29
                LDA     #$F4
                STA     $2A
                JMP     LF491

TF2DE:          RTS

TF2DF:          RTS

TF2E0:          LDA     #$44
                STA     $29
                LDA     #$F5
                STA     $2A
                JMP     LF491

TF2EB:          LDA     #$E5
                STA     $19
                LDA     #$F4
                STA     $1A
                JMP     LF483

TF2F6:          RTS

TF2F7:          LDA     #$05
                STA     $29
                LDA     #$F5
                STA     $2A
                JMP     LF491

TF302:          LDA     #$11
                STA     $29
                LDA     #$F5
                STA     $2A
                JMP     LF491

TF30D:          LDA     #$1D
                STA     $19
                LDA     #$F5
                STA     $1A
                JMP     LF483

TF318:          LDA     #$32
                STA     $19
                LDA     #$F5
                STA     $1A
                JMP     LF483

TF323:          RTS

TF324:          LDA     #$D9
                STA     $29
                LDA     #$F4
                STA     $2A
                JMP     LF491

TF32F:          RTS

TF330:          LDA     #$76
                STA     $29
                LDA     #$F5
                STA     $2A
                JMP     LF491

TF33B:          LDA     #$00
                LDX     #$28
@LF33F:         STA     $00,x
                INX
                CPX     #$30
                BNE     @LF33F
                LDX     #$0C
@LF348:         STA     SQ1_VOL,x
                INX
                CPX     #$10
                BNE     @LF348
                RTS

TF351:          LDA     #$08
                JSR     ApuChannesSet
                LDA     #$6A
                STA     $29
                LDA     #$F5
                STA     $2A
                JMP     LF491

TF361:          JSR     TF33B
                JMP     ApuEnable

LF367:          LDA     #$00
                LDX     #$10
@LF36B:         STA     $00,x
                INX
                CPX     #$30
                BNE     @LF36B
                LDX     #$00
@LF374:         STA     SQ1_VOL,x
                INX
                CPX     #$14
                BNE     @LF374
ApuEnable:      LDA     #$0F
                STA     SND_CHN
                RTS

ApuDisable:     LDA     #$00
ApuChannesSet:  STA     SND_CHN
                RTS

LF388:          .byte   $03
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

LF398:          NOP
                LDA     $10                             ;Sq1
                BEQ     @LF3A4
                LDX     #$10
                LDY     #$00
                JSR     @LF3C6
@LF3A4:         LDA     $18                             ;Sq2
                BEQ     @LF3AF
                LDX     #$18
                LDY     #$04
                JSR     @LF3C6
@LF3AF:         LDA     $20                             ;Tri
                BEQ     @LF3BA
                LDX     #$20
                LDY     #$08
                JSR     @LF3C6
@LF3BA:         LDA     $28                             ;Noi
                BEQ     @Return
                LDX     #$28
                LDY     #$0C
                JSR     @LF3C6
@Return:        RTS

@LF3C6:         LDA     $06,x                           ;($06 + ($10 + Ch * 8))
                BEQ     @LF401
                DEC     $06,x
                BNE     @LF400
                LDA     $05,x
                STA     $06,x
                DEC     $07,x
                BNE     @LF400
@LF3D6:         LDA     ($03,x)
                CMP     #$00
                BEQ     @LF411
                STA     SQ1_LO,y
                LDA     #$08
                CPY     #$0C
                BEQ     @LF3EE
                JSR     LF475
                LDA     ($03,x)
                AND     #$07
                ORA     #$08
@LF3EE:         STA     SQ1_HI,y
                LDA     ($03,x)
                LSR     A
                LSR     A
                LSR     A
                LSR     A
                TAY
                LDA     LF388,y
                STA     $07,x
                JSR     LF475
@LF400:         RTS

@LF401:         LDA     $05,x
                STA     $06,x
                JMP     @LF3D6

                .byte   $A1
                .byte   $03
                .byte   $29
                .byte   $0F
                .byte   $99
                .byte   $02
                .byte   $40
                .byte   $A9
                .byte   $08

@LF411:         JSR     LF46E
@LF414:         LDA     ($01,x)
                CMP     #$00
                BEQ     @LF426
                STA     $03,x
                JSR     LF46E
                LDA     ($01,x)
                STA     $04,x
                JMP     @LF3D6

@LF426:         JSR     LF46E
                LDA     ($01,x)
                BEQ     LF462
                CMP     #$FF
                BEQ     @LF44F
                CMP     #$FE
                BEQ     @LF443
                STA     SQ1_VOL,y
                JSR     LF46E
                LDA     ($01,x)
                STA     SQ1_SWEEP,y
                JMP     @LF411

@LF443:         JSR     LF46E
                LDA     ($01,x)
                STA     $05,x
                STA     $06,x
                JMP     @LF411

@LF44F:         JSR     LF46E
                LDA     ($01,x)
                PHA
                JSR     LF46E
                LDA     ($01,x)
                STA     $02,x
                PLA
                STA     $01,x
                JMP     @LF414

LF462:          LDA     #$00
                STA     SQ1_VOL,y
                STA     $00,x
                STA     $05,x
                STA     $06,x
                RTS

LF46E:          INC     $01,x
                BNE     @LF474
                INC     $02,x
@LF474:         RTS

LF475:          INC     $03,x
                BNE     @LF47B
                INC     $04,x
@LF47B:         RTS

LF47C:          LDX     #$10
                LDY     #$00
                JMP     LF498

LF483:          LDX     #$18
                LDY     #$04
                JMP     LF498

LF48A:          LDX     #$20
                LDY     #$08
                JMP     LF498

LF491:          LDX     #$28
                LDY     #$0C
                JMP     LF498

LF498:          LDA     #$00
                STA     $00,x
@LF49C:         LDA     ($01,x)
                CMP     #$00
                BEQ     @LF4B0
                STA     $03,x
                JSR     LF46E
                LDA     ($01,x)
                STA     $04,x
                LDA     #$FF
                STA     $00,x
                RTS

@LF4B0:         JSR     LF46E
                LDA     ($01,x)
                BEQ     LF462
                CMP     #$FE
                BEQ     @LF4CC
                STA     SQ1_VOL,y
                JSR     LF46E
                LDA     ($01,x)
                STA     SQ1_SWEEP,y
                JSR     LF46E
                JMP     @LF49C

@LF4CC:         JSR     LF46E
                LDA     ($01,x)
                STA     $05,x
                JSR     LF46E
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
