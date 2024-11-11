#include "stdio.h"
#include "string.h"
/*#include "subpro2.c"*/
FILE *fp;
extern char ch,string1[10];
extern int idn,intn,tn;
main()
{if((fp=fopen("file.c","r"))==NULL)
{printf("file canot open\n");
exit(0); }
li:
dictionary();
printf("%s   \n",string1);
string1[0]='\0';
if(ch==EOF) goto li1;
goto li;
li1:
/*printf("%o",idhead); */
printtoken();
printid();
printnum();
}
