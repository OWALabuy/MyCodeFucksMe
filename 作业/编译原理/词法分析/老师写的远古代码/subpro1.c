#include "stdio.h"
#include "string.h"
#define LEN1 sizeof(struct digit)
#define LEN2 sizeof(struct id)
#define  LEN3 sizeof(struct token)
struct digit
{int num;
struct digit *next;} *inthead=NULL,*intp1,*intp2;

struct id
{char name[10];
struct id *next;} *idhead=NULL,*idp1,*idp2;

struct token
{int class;
int value;
struct token *next;} *head=NULL,*p1,*p2;

extern char string1[10];
int idn=0,intn=0,tn=0;

int centry()
{int i,a;
i=0;a=0;
while(string1[i]!='\0')
{a=a*10+(~((~0)<<4)&string1[i]);
i=i+1;}
intp1=(struct digit *)malloc(LEN1);
intp1->num=a;
intn=intn+1;
if(intn==1) inthead=intp1;
else intp2->next=intp1;
intp2=intp1;
intp2->next=NULL;
return(intn);}

int idcentry()
{idp1=(struct id *)malloc(LEN2);
strcpy(idp1->name,string1);
idn=idn+1;
if(idn==1)  idhead=idp1;
else idp2->next=idp1;
idp2=idp1;
idp2->next=NULL;
return(idn);}

void out1(c,v)
int c,v;
{p1=(struct token *)malloc(LEN3);
p1->class=c;
p1->value=v;
tn=tn+1;
if(tn==1) head=p1;
else p2->next=p1;
p2=p1;
p2->next=NULL;
}
void printtoken()
{struct token *pi;
pi=head;
printf("token list is:\n");
while (pi!=NULL)
{printf("%4d %4d\n",pi->class,pi->value);
pi=pi->next;}
}

void printid()
{struct id *pi;
pi=idhead;
printf("identify list is:\n");
while (pi!=NULL)
{printf("%s\n",pi->name);
pi=pi->next;}
}

void printnum()
{struct digit *pi;
pi=inthead;
printf("numble list is:\n");
while (pi!=NULL)
{printf("%d \n",pi->num);
pi=pi->next;}
}
