#include <iostream>
#include <conio.h>
#include "operator.cpp"
#include "subscriber.cpp"
#pragma warning(disable : 4996) 


class Service
{
	/*Operator* operator1[2];
	Subscriber * subscriber[5];
	int opCount = 0;
	int subCount = 0;*/
public:
	//~Service()
	//{
	//	for (int i = 0; i < opCount; i++)
	//		delete operator1[i];
	//	for (int i = 0; i < subCount; i++)
	//		delete subscriber[i];
	//}

	//void setOp(char * oName)
	//{
	//	operator1[opCount] = new Operator;
	//	operator1[opCount++]->setName(oName);
	//}
	//void setSub(char * sName, int sNum)
	//{
	//	subscriber[subCount] = new Subscriber;
	//	subscriber[subCount]->setName(sName);
	//	subscriber[subCount++]->setNumber(sNum);
	//}

	void operator()(Subscriber & sSubscriber , Operator & sOperator)
	{
		if (!sOperator.getStat())
		{
			sOperator.setStat(true);
			FILE *file = fopen("save.txt", "w");
			size_t size = strlen(sSubscriber.getName()) + strlen(sOperator.getName()) + 14;
			char * tmp = new char[size];
			strcpy(tmp, sSubscriber.getName());
			strcmp(tmp, " talking with ");
			strcmp(tmp, sOperator.getName());
			fwrite(tmp, sizeof(char), size, file);
			fclose(file);
		}
	}

};