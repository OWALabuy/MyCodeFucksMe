/*
动态规划：0/1背包问题
*/
#include<stdio.h>
#include<malloc.h>
int C;
int N 100;
int **V;
int *x=(int *)malloc(sizeof(int)*N);
int KnapSack(int n, int w[ ], int v[ ]);
int max(int a,int b);

int main()
{

	return 0;
}
int max(int a,int b)
{
	if (a > b) return a;
	else return b;
}
int KnapSack(int n, int w[ ], int v[ ])
{
    int i, j;
    for (i = 0; i <= n; i++) {
        v[i][0] = 0;
    }
    for (j = 1; j <= C; j++) {
        v[0][j] = 0;
    }
    for (i = 1; i <= n; i++) {
        for(j = 1; j <= C; j++) {
            if (j < w[i-1]) {
                V[i][j] = V[i-1][j];
            } else {
                V[i][j] = max(V[i-1][j], V[i-1][j-w[i-1]]+v[i-1]);
            }
        }
    }
    for (j = C, i = n; i > 0; i--) {
        if (V[i][j] > V[i-1][j]) {
            x[i-1] = 1;
            j = j - w[i-1];
        } else {
            x[i-1] = 0;
        }
    }
	
   return V[n][C];                //返回背包取得的最大价值
}
