module generate;

import std.stdio;
import std.string;
import std.random;
import std.conv;
import std.math;
import std.array;

// [stone]の数だけ石があり,
// [zk]の数だけ敷地があり,
// 石のブロック数の総和が[zk]に等しい問題をランダムに生成し(全敷地を敷き詰められる保証はない),
// 標準出力に出力する
public void gen(int stone, int zk) {
	string[] output;

	output ~= genField(zk);
	output ~= "";
	output ~= stone.to!string;
	for (int i; i < stone; i++) {
		if (i == 0) output ~= genStone(zk / stone + zk % stone);
		else output ~= genStone(zk / stone);
		output ~= "";
	}
	output.popBack();
	foreach (string s; output) {
		s.writeln;
	}

}

// [zk]の数だけ敷き詰め可能な領域を持つ敷地をひとつ生成する。
// 形状はランダム。
private string[] genField(int zk) {
	int [32][32] field = 1;
	int zk_rtceil = (cast(float)zk).sqrt.ceil.to!int;
	for (int i; i < zk_rtceil; i++) {
		for (int j; j < zk_rtceil; j++) {
			field[i][j] = 0;
		}
	}
	int obstNum = zk_rtceil * zk_rtceil - zk;
	int x, y;
	for (int i; i < obstNum; i++) {
		while (1) {
			x = uniform(0, zk_rtceil);
			y = uniform(0, zk_rtceil);
			if (field[x][y] == 1) continue;
			break;
		}
		field[x][y] = 1;
	}

	string[] output;
	for (int i; i < 32; i++) {
		output ~= "";
		for (int j; j < 32; j++) {
			output.back ~= (field[j][i] == 1) ? '1' : '0';
		}
	}
	return output;
}

// [block]の数だけブロックを含む石をひとつ生成する。
// 形状はランダム。
private string[] genStone(int block) {
	assert(block >= 0 && block<=64);
	int[8][8] stone;

	stone[uniform(0, 8)][uniform(0, 8)] = 1;
	int x, y;
	for (int i; i < block - 1; i++) {
		while (1) {
			x = uniform(0, 8);
			y = uniform(0, 8);
			if (stone[x][y] == 1) continue;
			if ((x != 0) && (stone[x-1][y] == 1)) break;
			if ((y != 0) && (stone[x][y-1] == 1)) break;
			if ((x != 7) && (stone[x+1][y] == 1)) break;
			if ((y != 7) && (stone[x][y+1] == 1)) break;
		}
		stone[x][y] = 1;
	}

	string[] output;
	for (int i; i < 8; i++) {
		output ~= "";
		for (int j; j < 8; j++) {
			output.back ~= (stone[j][i] == 1) ? '1' : '0';
		}
	}
	return output;
}
