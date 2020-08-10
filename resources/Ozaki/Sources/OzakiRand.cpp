//--------------------------------------------------
// 「ジャンボ尾崎のホールインワン・プロフェッショナル」方式の乱数再現
//--------------------------------------------------

#include	<stdio.h>
#include	<stdint.h>

uint16_t	RandBuffer	= 0;

//--------------------------------------------------
// 逆アセンブル内容をそのまま書き下し
//--------------------------------------------------

// ROL命令 8bit左ローテート
// +------------------+
// |                  v
// +-<- 76543210 <- carry
void	RotateLeft(uint8_t *a, bool *carry){
	bool	newCarry	= (*a & 0x80) != 0;
	*a	= (*a << 1) | ((*carry)? 1 : 0);
	*carry	= newCarry;
}

uint8_t	OzakiRand_Original(uint8_t x){
	for(int i=0; i<11; i++){
		// High : $33, Low : $32
		bool	carry	= (RandBuffer & 0x8000) != 0;
		RandBuffer	= RandBuffer << 1;	// ASL $32 : ROL $33
		RotateLeft(&x, &carry);			// ROL A
		RotateLeft(&x, &carry);			// ROL A
		x	= x ^ (RandBuffer & 0xFF);	// EOR $32
		RotateLeft(&x, &carry);			// ROL A
		x	= x ^ (RandBuffer & 0xFF);	// EOR $32
		x	= x >> 2;			// LSR A : LSR A
		x	= 1 - (x & 1);			// EOR #$FF : AND #$01
		RandBuffer	= RandBuffer | x;	// ORA $32 : STA $32
		x	= RandBuffer & 0xFF;
	}
	return x;
}

//--------------------------------------------------
// 最適化版
//--------------------------------------------------

// フィボナッチLFSR（線形帰還シフトレジスタ）亜種
// タップ位置は [16, 2, 1, 0]
uint8_t	OzakiRand(){
	uint16_t	t;
	for(int i=0; i<11; i++){
		t	= (RandBuffer >> 15) ^ (RandBuffer >> 1) ^ (RandBuffer);
		RandBuffer	= (RandBuffer << 1) | !(t & 1);
	}
	return RandBuffer & 0xFF;
}

//--------------------------------------------------
// 乱数検定
//--------------------------------------------------

int	main(int argc, char *argv[]){
	uint16_t	randStart	= 0x0000;	// 乱数初期値
	uint8_t		randOutput	= 0;		// 出力乱数
	int		count		= 0;		// 1周期生成回数
	int		randGenerated[0x10000];		// 各数値生成カウント

	RandBuffer			= randStart;	// 乱数初期化

	// カウント初期化
	for(int i=0; i<0x10000; i++){
		randGenerated[i]	= 0;
	}

	// 乱数生成
	printf("Output :\n");
	do{
		// 先頭10回は試しに出力
		if(count <= 10){
			printf("  [%5d] 0x%02X %3d (%04X)\n", count, randOutput, randOutput, RandBuffer);
		}

		// 乱数を回す
		randOutput	= OzakiRand();

		// 乱数を回した回数をカウントアップ
		count++;

		// 生成した値をマーク
		randGenerated[RandBuffer]++;
	}while(RandBuffer != randStart);		// 初期値に戻るまで実行

	// 終了値
	printf("  [ ... ]\n");
	printf("  [%5d] 0x%02X %3d (%04X)\n", count, randOutput, randOutput, RandBuffer);

	// 未使用値を列挙
	printf("Unused :\n");
	printf("  ");
	for(int i=0; i<0x10000; i++){
		if(randGenerated[i] == 0){
			printf("%04X ", i);
		}
	}
	printf("\n");

	return 0;
}

/* 出力
Output :
  [    0] 0x00   0 (0000)
  [    1] 0x92 146 (0492)
  [    2] 0x79 121 (9279)
  [    3] 0x3D  61 (CF3D)
  [    4] 0xDE 222 (ECDE)
  [    5] 0x17  23 (F617)
  [    6] 0x09   9 (BB09)
  [    7] 0xE9 233 (4EE9)
  [    8] 0x0D  13 (4A0D)
  [    9] 0x3F  63 (6A3F)
  [   10] 0x53  83 (FD53)
  [ ... ]
  [65534] 0x00   0 (0000)
Unused :
  5555 AAAA
*/
