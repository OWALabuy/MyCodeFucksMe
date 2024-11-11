#include "stdio.h"
#include "string.h"
FILE *fp;
extern char ch,string1[10];
struct key
{char word[10];
int value;};
struct key resel[16]={{"main",4},{"while",5},{"if",6},{"int",7},{";",8},
{"{",9},{"}",10},{",",11},{"(",12},{"}",13},{"+",14},{"*",15},{"=",16},{"<=",17},
{"<",18},{"\0",0}};

void  getnonb()
{if (ch==EOF) return(0);
else
while((ch==' ')||(ch==10))
{ch=fgetc(fp);
if(ch==EOF) return(0);}
}

void cons()
{char str[2];
str[0]=ch;
str[1]='\0';
strcat(string1,str);}

int letter()
{if((ch>=0x61)&&(ch<=0x7a)) return(1);
else return(0);}

int digit()
{if((ch>=0x30)&&(ch<=0x39)) return(1);
else return(0);}

int reserv()
{ struct key *point;
  int i1;
  i1=1;
point=resel;
while (point->word[0]!='\0')
{if (strcmp(point->word,string1)==0)
return(i1+3);
i1=i1+1;
point=point++;}
return(0);
}
