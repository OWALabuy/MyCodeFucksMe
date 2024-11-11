//词法分析.c
//在终端编译运行 在命令行参数中加上待分析的文件名
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LEN1 sizeof(struct digit)
#define LEN2 sizeof(struct id)
#define LEN3 sizeof(struct token)

char ch, string1[10];
FILE *fp;

struct key {
    char word[10];
    int value;
};

struct digit {
    int num;
    struct digit *next;
} *inthead, *intp1, *intp2;

struct id {
    char name[10];
    struct id *next;
} *idhead, *idp1, *idp2;

struct token {
    int class;
    int value;
    struct token *next;
} *head, *p1, *p2;

struct key resel[16] = {{"main", 4}, {"while", 5}, {"if", 6}, {"int", 7},
                        {";", 8},    {"{", 9},     {"}", 10}, {",", 11},
                        {"(", 12},   {"}", 13},    {"+", 14}, {"*", 15},
                        {"=", 16},   {"<=", 17},   {"<", 18}, {"\0", 0}};

int idn = 0, intn = 0, tn = 0;

int centry() {
    int i, a;
    i = 0;
    a = 0;
    while (string1[i] != '\0') {
        a = a * 10 + (~((~0) << 4) & string1[i]);
        i = i + 1;
    }
    intp1 = (struct digit *)malloc(LEN1);
    intp1->num = a;
    intn = intn + 1;
    if (intn == 1)
        inthead = intp1;
    else
        intp2->next = intp1;
    intp2 = intp1;
    intp2->next = NULL;
    return (intn);
}

int idcentry() {
    idp1 = (struct id *)malloc(LEN2);
    strcpy(idp1->name, string1);
    idn = idn + 1;
    if (idn == 1)
        idhead = idp1;
    else
        idp2->next = idp1;
    idp2 = idp1;
    idp2->next = NULL;
    return (idn);
}

void out1(int c, int v)
{
    p1 = (struct token *)malloc(LEN3);
    p1->class = c;
    p1->value = v;
    tn = tn + 1;
    if (tn == 1)
        head = p1;
    else
        p2->next = p1;
    p2 = p1;
    p2->next = NULL;
}
void printtoken() {
    struct token *pi;
    pi = head;
    printf("token list is:\n");
    while (pi != NULL) {
        printf("%4d %4d\n", pi->class, pi->value);
        pi = pi->next;
    }
}

void printid() {
    struct id *pi;
    pi = idhead;
    printf("identify list is:\n");
    while (pi != NULL) {
        printf("%s\n", pi->name);
        pi = pi->next;
    }
}

void printnum() {
    struct digit *pi;
    pi = inthead;
    printf("numble list is:\n");
    while (pi != NULL) {
        printf("%d \n", pi->num);
        pi = pi->next;
    }
}
/*
int getnonb() {
    if (ch == EOF)
        return 0;
    else
        while ((ch == ' ') || (ch == 10)) {
            ch = fgetc(fp);
            if (ch == EOF) return 0;
        }
}
*/

int getnonb() {
    // 持续读取字符直到非空字符或者 EOF
    while (ch == ' ' || ch == '\n' || ch == '\t' || ch == 13) {
        ch = fgetc(fp);
        if (ch == EOF) return 0;
    }
    return 1;  // 表示成功读取到非空字符
}


void cons() {
    char str[2];
    str[0] = ch;
    str[1] = '\0';
    strcat(string1, str);
}

int letter() {
    if ((ch >= 0x61) && (ch <= 0x7a))
        return 1;
    else
        return 0;
}

int digit() {
    if ((ch >= 0x30) && (ch <= 0x39))
        return 1;
    else
        return 0;
}

int reserv() {
    struct key *point;
    int i1;
    i1 = 1;
    point = resel;
    while (point->word[0] != '\0') {
        if (strcmp(point->word, string1) == 0) return i1 + 3;
        i1 = i1 + 1;
        //point = point++;
        //谁写的未定义行为
        point++;
    }
    return 0;
}

void identify() {
    int c1, idd;
    while (letter() == 1 || digit() == 1) {
        cons();
        ch = fgetc(fp);
    }

    fseek(fp, -1, 1);

    c1 = reserv();

    if (c1 != 0)
        out1(c1, 0);
    else {
        idd = idcentry();
        out1(1, idd);
    }
}

void numble() {
    int intd;
    cons();
    ch = fgetc(fp);
    while (digit() == 1) {
        cons();
        ch = fgetc(fp);
    }

    fseek(fp, -1, 1);
    intd = centry();
    out1(2, intd);
}

void dictionary() {
    ch = fgetc(fp);
    getnonb();
    if (ch >= 'a' && ch <= 'z') {
        identify();
    } else if (ch >= '0' && ch <= '9') {
        numble();
    } else {
        switch (ch) {
            case ';':
                out1(8, 0);
                printf("%c", ch);
                break;
            case '{':
                out1(9, 0);
                printf("%c", ch);
                break;
            case '}':
                out1(10, 0);
                printf("%c", ch);
                break;
            case ',':
                out1(11, 0);
                printf("%c", ch);
                break;
            case '(':
                out1(12, 0);
                printf("%c", ch);
                break;
            case ')':
                out1(13, 0);
                printf("%c", ch);
                break;
            case '+':
                out1(14, 0);
                printf("%c", ch);
                break;
            case '*':
                out1(15, 0);
                printf("%c", ch);
                break;
            case '=':
                out1(16, 0);
                printf("%c", ch);
                break;
            case '<': {
                ch = fgetc(fp);
                if (ch == '=') {
                    out1(17, 0);
                    printf("%c", ch);
                } else {
                    fseek(fp, -1, 1);
                    out1(18, 0);
                    printf("<=");
                }
            } break;
            default:
                if (ch != EOF) {
                    printf("can't identify this char");
                    exit(0);
                }
        }
    }
}

/*原先老师写的主函数 上古时期用dos系统写的代码 留作纪念
int main() {
    if ((fp = fopen("file", "r")) == NULL) {
        printf("file canot open\n");
        exit(0);
    }
    //初始化全局变量string1
    memset(string1, 0, sizeof(string1));

li:
    dictionary();
    printf("%s   \n", string1);
    string1[0] = '\0';

    if (ch == EOF) goto li1;
    goto li;
li1:
    //printf("%o",idhead);
    printtoken();
    printid();
    printnum();

    //关闭文件指针避免资源内存泄露问题
    fclose(fp);
    return 0;
}
*/
int main(int argc, char *argv[]) {
    // 检查是否提供了文件名作为参数
    if (argc != 2) {  // argc 应该等于2 表示程序名 + 文件名
        printf("Usage: %s <filename>\n", argv[0]);
        exit(1);  // 退出并返回错误状态
    }

    // 打开用户提供的文件
    fp = fopen(argv[1], "r");
    if (fp == NULL) {  // 检查文件是否成功打开
        printf("Error: Cannot open file %s\n", argv[1]);
        exit(1);  // 退出并返回错误状态
    }

    printf("File %s opened successfully.\n", argv[1]);

    // 词法分析的主循环
    while (1) {
        dictionary();  // 调用词法分析函数
        printf("%s\n", string1);
        string1[0] = '\0';  // 清空 string1 数组 准备分析下一个词法单元

        if (ch == EOF)  // 如果到达文件末尾 则退出循环
            break;
    }

    // 输出 token 标识符 数字
    printtoken();
    printid();
    printnum();

    // 关闭文件
    fclose(fp);

    return 0;
}

