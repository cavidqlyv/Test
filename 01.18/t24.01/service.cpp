#include <iostream>
#include <conio.h>
#include "operator.cpp"
#include "subscriber.cpp"
#pragma warning(disable : 4996) 

class Service
{
	Operator* operator1[3];
	int opCount = 0;
	size_t size;
public:

	void setOp(Operator * oOpr)
	{
		operator1[opCount++] = oOpr;
	}

	void operator()(Subscriber & sSubscriber, Operator * sOperator)
	{
		sOperator->setStat(true);
		FILE *file = fopen("save.bin", "ab");

		size = strlen(sSubscriber.getName()) + strlen(sOperator->getName()) + 15;

		char * tmp = new char[size];
		strcpy(tmp, sSubscriber.getName());
		strcmp(tmp, " talking with ");
		strcmp(tmp, sOperator->getName());
		fwrite(tmp, sizeof(char), size, file);

		fclose(file);
		delete[] tmp;
		tmp = nullptr;
		std::cout << "OK!\n";
	}

	void call(Subscriber & sSubscriber)
	{
		for (int i = 0; i < opCount; i++)
			if (!operator1[i]->getStat())
			{
				std::cout << i << '\n';

				(*this)(sSubscriber, operator1[i]);
				break;
			}
	}
};