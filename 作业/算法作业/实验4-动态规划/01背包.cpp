/*
动态规划：0/1背包问题
*/
#include <stdio.h>
#include <stdlib.h>

int **V;  // 用于存储动态规划表
int *x;   // 用于存储选择了哪些物品

int max(int a, int b);
int KnapSack(int n, int w[], int v[], int C);

int main() {
    int C;  // 背包容量
    int m;  // 物品数量

    // 读取输入
    scanf("%d", &C);
    scanf("%d", &m);

    int *weights = (int *)malloc(sizeof(int) * m);
    int *values = (int *)malloc(sizeof(int) * m);

    // 读取物品重量
    for (int i = 0; i < m; i++) {
        scanf("%d", &weights[i]);
    }

    // 读取物品价值
    for (int i = 0; i < m; i++) {
        scanf("%d", &values[i]);
    }

    // 为动态规划表分配内存
    V = (int **)malloc((m + 1) * sizeof(int *));
    for (int i = 0; i <= m; i++) {
        V[i] = (int *)malloc((C + 1) * sizeof(int));
    }

    // 用于标记装入了哪些物品
    x = (int *)malloc(sizeof(int) * m);

    // 调用 0/1 背包函数
    int maxValue = KnapSack(m, weights, values, C);

    // 输出最大价值
    printf("%d\n", maxValue);

    // 输出装入的物品
    int first = 1;
    for (int i = 0; i < m; i++) {
        if (x[i] == 1) {
            if (!first) {
                printf(" ");
            }
            printf("%d", i + 1);
            first = 0;
        }
    }
    printf("\n");

    // 释放内存
    for (int i = 0; i <= m; i++) {
        free(V[i]);
    }
    free(V);
    free(x);
    free(weights);
    free(values);

    return 0;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int KnapSack(int n, int w[], int v[], int C) {
    // 初始化动态规划表
    for (int i = 0; i <= n; i++) {
        V[i][0] = 0;
    }
    for (int j = 0; j <= C; j++) {
        V[0][j] = 0;
    }

    // 动态规划计算
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= C; j++) {
            if (j < w[i - 1]) {
                V[i][j] = V[i - 1][j];  // 不选第 i 个物品
            } else {
                V[i][j] = max(V[i - 1][j], V[i - 1][j - w[i - 1]] + v[i - 1]);  // 选或不选第 i 个物品
            }
        }
    }

    // 回溯找到装入背包的物品
    for (int j = C, i = n; i > 0; i--) {
        if (V[i][j] > V[i - 1][j]) {  // 如果选择了第 i 个物品
            x[i - 1] = 1;
            j -= w[i - 1];
        } else {
            x[i - 1] = 0;
        }
    }

    return V[n][C];  // 返回最大价值
}

