#define LEN sizeof(struct LNode)
#include <stdlib.h>
#include <string.h>
#include "stdio.h"
#define LL1row 5     // LL1矩阵的行值
#define LL1col 6     // LL1矩阵的列值
#define GramNum 8    // 产生式个数
#define VTNum 6      // 文法终极符个数
#define VNNum 5      // 文法非终极符个数
#define StateNum 12  // 分析表状态数
char grammar[GramNum][5] = {"ETB",  "B+TB", "B",    "TFY",
                            "Y*FY", "Y",    "F(E)", "Fi"};
int LL1[LL1row][LL1col] = {{1, 0, 0, 1, 0, 0},
                           {0, 2, 0, 0, 3, 3},
                           {4, 0, 0, 4, 0, 0},
                           {0, 6, 5, 0, 6, 6},
                           {8, 0, 0, 7, 0, 0}};
char vt[VTNum] = {'i', '+', '*', '(', ')', '#'};
char vn[VNNum] = {'E', 'B', 'T', 'Y', 'F'};

int findvt(char ch) {
    int i;
    for (i = 0; i < VTNum; i++)
        if (vt[i] == ch) return i + 1;
    return 0;
}
int findvn(char ch) {
    int i;
    for (i = 0; i < VNNum; i++)
        if (vn[i] == ch) return i + 1;
    return 0;
}

void main() {
    int vnrow, vtcol;
    char x;
    int i, j, k, l, n, c, length;
    char s[20], s1[20];
    for (i = 0; i < GramNum; i++) {
        if (grammar[i][1] != '\n')
            printf("%c->%s\n", grammar[i][0], &grammar[i][1]);
        else
            printf("%c->$\n", grammar[i][0]);
    }

    /*begin the main*/
    s[0] = '#';
    s[1] = 'E';
    i = 1;
    j = 0;  // i为分析栈指针 j为输入流指针
    printf("请输入一个仅包含变量i的以#号结束的带有括号结构的加与乘的表达式");
    scanf("%s", s1);
    printf("分析栈\t\t     输入流字符串\t动作\n");
    for (n = 0; n <= i; n++) printf("%c", s[n]);
    for (n = 0; n < 20 - i - 1; n++) printf(" ");
    printf(" %s", &s1[j]);
    while (1) {
        x = s[i];
        if (findvt(x) != 0) {
            if (x == '#') {
                if (x == s1[j]) {
                    printf("\n no syntax error\n");
                    exit(0);
                } else {
                    printf("syntax error\n");
                    exit(0);
                }
            } else {
                if (x == s1[j]) {
                    length = strlen(&s1[j]);
                    for (n = 0; n <= 20 - length; n++) printf(" ");
                    printf("匹配\n");
                    j = j + 1;
                    for (n = 0; n < i; n++) printf("%c", s[n]);
                    for (n = 0; n < 20 - i; n++) printf(" ");
                    printf(" %s", &s1[j]);
                    i = i - 1;
                } else {
                    printf("\n syntax error\n");
                    exit(0);
                }
            }
        } else {
            vnrow = findvn(x);
            vtcol = findvt(s1[j]);
            if (vnrow && vtcol) {
                k = LL1[vnrow - 1][vtcol - 1];
                if (k != 0) {
                    length = strlen(&s1[j]);
                    for (n = 0; n <= 20 - length; n++) printf(" ");
                    if (grammar[k - 1][1] != '\n')
                        printf("%c->%s\n", grammar[k - 1][0],
                               &grammar[k - 1][1]);
                    else
                        printf("%c->$\n", grammar[k - 1][0]);
                    c = 1;
                    while (grammar[k - 1][c] != '\0') c++;
                    for (c = c - 1; c >= 1; c--) s[i++] = grammar[k - 1][c];
                    for (n = 0; n < i; n++) printf("%c", s[n]);
                    for (n = 0; n < 20 - i; n++) printf(" ");
                    printf(" %s", &s1[j]);
                    // for(n=0;n<30-i;n++)
                    //  printf(" ");
                    i = i - 1;
                } else {
                    printf("syntax error\n");
                    exit(0);
                }
            } else {
                printf("syntax error\n");
                exit(0);
            }
        }
    } /*end while*/
} /*end main */
