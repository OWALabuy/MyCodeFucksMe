#include<stdio.h>
#include<stdlib.h>
#include<string.h>
//#define Actionrow 12
#define Actioncol 6//action�������ֵ
#define GoTOcol 3//goto�������ֵ
#define GramNum 7//����ʽ����
#define VTNum 6//�ķ��ռ�������
#define VNNum 3//�ķ����ռ�������
#define StateNum 12//������״̬��
int Action[StateNum][Actioncol]=
{
105,0,0,104,0,0,
0,106,0,0,0,-1,
0,52,107,0,52,52,
0,54,54,0,54,54,
105,0,0,104,0,0,
0,56,56,0,56,56,
105,0,0,104,0,0,
105,0,0,104,0,0,
0,106,0,0,111,0,
0,51,107,0,51,51,
0,53,53,0,53,53,
0,55,55,0,55,55};
int Goto[StateNum][GoTOcol]=
{
	1,2,3,
	0,0,0,
	0,0,0,
	0,0,0,
	8,2,3,
	0,0,0,
	0,9,3,
	0,0,10,
	0,0,0,
	0,0,0,
	0,0,0,
	0,0,0
};
char Grammar[GramNum][10]={"SE","EE+T","ET","TT*F","TF","F(E)","Fi"};
char AVT[VTNum]={'i','+','*','(',')','#'};
char GVN[VNNum]={'E','T','F'};
int VNum[GramNum];//���ÿһ������ʽ�ĳ���ֵ
int i=0;//��ǰ������ָ��
char Input[20];//��Ŵ������ķ��Ŵ�

typedef struct{
	char *base;
	char *top;
}SymbolStack;//����ջ���Ͷ���

typedef struct{
	int *base;
	int *top;
}StateStack;//״̬ջ���Ͷ���

StateStack state;//����״̬ջ
SymbolStack symbol;//�������ջ


int vNumCount()
//����ÿ������ʽ�ĳ��ȣ�����ʽ���ķ����Ÿ���������ŵ�VNum����Ķ�Ӧ��Ԫ����
{
	int i,j;
	for(i=0;i<GramNum;i++)
	{
		j=1;
		while(Grammar[i][j]!='\0')
		{
			j++;
		}
		VNum[i]=j;
	}
	printf("\n");
	return 0;
}

void InitStack()
{
	//��ʼ��״̬ջ��ջ����ֵΪ0״̬
	state.base=(int *)malloc(100*sizeof(int));
	if(!state.base)exit(1);
	state.top=state.base;
	*state.top=0;
	//��ʼ������ջ��ջ����ʼֵΪ��#��
	symbol.base=(char *)malloc(100*sizeof(char));
	if(!symbol.base)exit(1);
	symbol.top=symbol.base;
	*symbol.top='#';
}

int Judge(int stateTop,char inputChar)
//��״̬ջ���͵�ǰ�������ַ���ȷ��ACTIONG����Ԫ�ص�ֵ����
{
	int i,j;
	for(i=0;i<StateNum;i++)
	{
		if(stateTop==i)break;
	}
	for(j=0;j<VTNum;j++)
	{
		if(inputChar==AVT[j])break;
	}
	if(i>=StateNum||j>=VTNum)
		return -2;
	else
		return Action[i][j];
}
int GetGoto(int stateTop,char inputChar)
//��״̬ջ���͵�ǰ��Լ�ķ��ռ�����A����ȷ��GOTO����Ԫ�ص�ֵ����
{
	int i,j;
	for(i=0;i<StateNum;i++)
	{
		if(stateTop==i)break;
	}
	for(j=0;j<VNNum;j++)
	{
		if(inputChar==GVN[j])break;
	}
	return Goto[i][j];
}

int print(int count)
//���ÿһ��������֣�countΪ�������裬iΪ������ָ�룬IputΪ����������
//singΪ����������ű�����actionΪ��������Ķ�����ţ�gtΪGOTO����Ĳ���ʽ���
{
	
	int *p=state.base,stateNum;//*pΪ״̬ջ��ָ���ֵ
	int j,jj;
	char *q=symbol.base,symbolNum;//*pΪ����ջ��ָ���ֵ
	printf("%d\t",count);//�������ֵ
	j=0;
	while(p!=state.top+1)//���״̬ջ��ֵ
	{
		stateNum=*p;
		printf("%d",stateNum);
		p++;j++;
	}
	//printf("\t");
    if(j<8)
		printf("\t\t");
	else
		printf("\t");
	j=0;
	while(q!=symbol.top+1)////�������ջ��ֵ
	{
		symbolNum=*q;
		printf("%c",symbolNum);
		q++;j++;
	}
	//printf("\t");
	if(j<8)
		printf("\t\t");
	else
		printf("\t");
	j=i;
	jj=0;
	while(jj<j)
	{
		printf(" ");
		jj++;
	}
	while(Input[j]!='\0')//�����������˵�ֵ
	{
		printf("%c",Input[j]);
		j++;
	}
	return 1;
}

int Pop(int action)
//��Լʱ��״̬ջ�ĳ���ջ�����ͷ���ջ����ջ����
//����actionΪ��Լ����ʽ��ţ���������ֵΪ0����GOTO�����Ԫ��ֵ
{
	int stateNum,ssValue,i;
	i=VNum[action]-1;
	while(i>0)
	{
		symbol.top--;
		state.top--;
		i--;
	}
	symbol.top++;
    stateNum=*state.top;
	*symbol.top=Grammar[action][0];
	ssValue=GetGoto(stateNum,Grammar[action][0]);
	if(ssValue==0)return ssValue;
	state.top++;
	*state.top=ssValue;
	return ssValue;
}
int Reduction()
//SLR1��������
{
	int count=1;
	int ssValue,action;
	int stateTop,gt;
	//int sign=-1;//�ƽ�1����Լ2������3
	printf("����һ���ԡ�#���Ž����ģ���iΪ�����ļӳ˱��ʽ��\n");
	scanf("%s",&Input);
    i=0;
	printf("����\t״̬ջ\t\t����ջ\t\t���봮\t\tACTION\tGOTO\n");
	print(count);
	while(Input[i]!='\0')
	{
		stateTop=*state.top;
		ssValue=Judge(stateTop,Input[i]);//ȡ��ACTION�����Ԫ��ֵ
		if(ssValue==0)
		{
			printf("\t\t��Լ����\n");
			return 0;
		}
		if(ssValue==-2)
		{
			printf("\t\t�����д��ڷǷ��ַ�\n");
			return 0;
		}
		if(ssValue==-1)
		{
			//sign=3;
			printf("\t\tACC��\n");
			return 1;
		}
		if(ssValue>=100)
		{
			//sign=1;
			action=ssValue-100;
			state.top++;
			*state.top=action;
			symbol.top++;
			*symbol.top=Input[i];
			i++;
			printf("\t\tS%d\t%d\n",action,0);
			count++;
			print(count);
		}
		if(ssValue>=50&&ssValue<100)
		{
			//sign=2;
			action=ssValue-50;
			printf("\t\tR%d",action);
			gt=Pop(action);
			printf("\t%d\n",gt);
			count++;
			print(count);
		}
	}
	if(Input[i]=='\0')
		printf("\t\t����ĩβû��#��\n");
	return 0;
}

int main()
{
	int i;
	for(i=0;i<GramNum;i++)
		if(Grammar[i][1]!='\n')
			printf("%c->%s\n",Grammar[i][0],&Grammar[i][1]);
		else
			printf("%c->$\n",Grammar[i][0]);
	vNumCount();
	InitStack();
	Reduction();
	return 0;
}
