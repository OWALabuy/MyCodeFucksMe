#include "stdio.h"
#include "string.h"
/*#include "subpro.c"
#include "subpro1.c"*/
char ch,string1[10];
extern FILE *fp;

void identify()
{int c1,idd;
while (letter()==1||digit()==1)
{cons();ch=fgetc(fp);}
fseek(fp,-1,1);
c1=reserv();
if(c1!=0) out1(c1,0);
else{idd=idcentry();out1(1,idd);}
}

void numble()
{int intd;
cons();ch=fgetc(fp);
while (digit()==1)
{cons();ch=fgetc(fp);}
fseek(fp,-1,1);
intd=centry();
out1(2,intd);
}

void dictionary(){
ch=fgetc(fp);
getnonb();
//���ݴʷ������̰��У�ʶ��һ�����ʵĳ����������ͼ���ڸ�λ��֮�¸�����Ӧ�ĳ������

}
/*printf("this is error program\n");*/
}//��������
