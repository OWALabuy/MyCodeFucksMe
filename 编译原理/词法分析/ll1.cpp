#define LEN sizeof(struct LNode)
#include "stdio.h"
#include <stdlib.h>
#include <string.h>
#define LL1row 5//LL1矩阵的行值
#define LL1col 6//LL1矩阵的列值
#define GramNum 8//产生式个数
#define VTNum 6//文法终极符个数
#define VNNum 5//文法非终极符个数
#define StateNum 12//分析表状态数
char grammar[GramNum][5]={"ETB","B+TB","B","TFY","Y*FY","Y","F(E)","Fi"};
int LL1[ LL1row][LL1col]={ {1,0,0,1,0,0},
{0,2,0,0,3,3},
{4,0,0,4,0,0},
{0,6,5,0,6,6},
{8,0,0,7,0,0}};
char vt[VTNum]={'i','+','*','(',')','#'};
char vn[VNNum]={'E','B','T','Y','F'};

int findvt(char ch)
{
	int i;
    for (i=0;i<VTNum;i++)
		if(vt[i]==ch) return i+1;
	return 0;
}
int findvn(char ch)
{
	int i;
    for (i=0;i<VNNum;i++)
		if(vn[i]==ch) return i+1;
	return 0;
}

void main()
{
	int vnrow,vtcol;
	char x;
    int i,j,k,l,n,c,length;
    char s[20],s1[20];
    for(i=0;i<GramNum;i++){
		if(grammar[i][1]!='\n')
			printf("%c->%s\n",grammar[i][0],&grammar[i][1]);
		else
			printf("%c->$\n",grammar[i][0]);
	}

/*begin the main*/
	s[0]='#';
	s[1]='E';
