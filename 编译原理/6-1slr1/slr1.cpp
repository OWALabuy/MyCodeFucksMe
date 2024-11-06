#include<stdio.h>
#include<stdlib.h>
#include<string.h>
//#define Actionrow 12
#define Actioncol 6//action矩阵的列值
#define GoTOcol 3//goto矩阵的列值
#define GramNum 7//产生式个数
#define VTNum 6//文法终极符个数
#define VNNum 3//文法非终极符个数
#define StateNum 12//分析表状态数
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
int VNum[GramNum];//存放每一条产生式的长度值
int i=0;//当前输入流指针
char Input[20];//存放待分析的符号串

typedef struct{
	char *base;
	char *top;
}SymbolStack;//符号栈类型定义

typedef struct{
	int *base;
	int *top;
}StateStack;//状态栈类型定义

StateStack state;//定义状态栈
SymbolStack symbol;//定义符号栈


int vNumCount()
//计算每条产生式的长度（产生式中文法符号个数），存放到VNum数组的对应的元素里
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
	//初始化状态栈，栈顶初值为0状态
	state.base=(int *)malloc(100*sizeof(int));
	if(!state.base)exit(1);
	state.top=state.base;
	*state.top=0;
	//初始化符号栈，栈顶初始值为“#”
	symbol.base=(char *)malloc(100*sizeof(char));
	if(!symbol.base)exit(1);
	symbol.top=symbol.base;
	*symbol.top='#';
}

int Judge(int stateTop,char inputChar)
//用状态栈顶和当前输入流字符，确定ACTIONG矩阵元素的值返回
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
//用状态栈顶和当前归约的非终极符（A），确定GOTO矩阵元素的值返回
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
//输出每一步分析格局，count为分析步骤，i为输入流指针，Iput为输入流数组
//sing为分析动作标号变量，action为动作矩阵的动作编号，gt为GOTO矩阵的产生式编号
{
	
	int *p=state.base,stateNum;//*p为状态栈底指针的值
	int j,jj;
	char *q=symbol.base,symbolNum;//*p为符号栈底指针的值
	printf("%d\t",count);//输出步骤值
	j=0;
	while(p!=state.top+1)//输出状态栈的值
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
	while(q!=symbol.top+1)////输出符号栈的值
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
	while(Input[j]!='\0')//输出输入流后端的值
	{
		printf("%c",Input[j]);
		j++;
	}
	return 1;
}

int Pop(int action)
//归约时，状态栈的出入栈操作和符号栈出入栈操作
//参数action为归约产生式编号，函数返回值为0，或GOTO矩阵的元素值
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
//SLR1分析函数
{
	int count=1;
	int ssValue,action;
	int stateTop,gt;
	//int sign=-1;//移进1，规约2，接受3
	printf("输入一个以“#”号结束的，以i为变量的加乘表达式：\n");
	scanf("%s",&Input);
    i=0;
	printf("步骤\t状态栈\t\t符号栈\t\t输入串\t\tACTION\tGOTO\n");
	print(count);
	while(Input[i]!='\0')
	{
		stateTop=*state.top;
		ssValue=Judge(stateTop,Input[i]);//取出ACTION矩阵的元素值
		if(ssValue==0)
		{
			printf("\t\t规约出错！\n");
			return 0;
		}
		if(ssValue==-2)
		{
			printf("\t\t句子中存在非法字符\n");
			return 0;
		}
		if(ssValue==-1)
		{
			//sign=3;
			printf("\t\tACC！\n");
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
		printf("\t\t句子末尾没有#号\n");
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
