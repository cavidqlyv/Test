#include <iostream>
#include "service.cpp"

int main()
{
	Service service;

	char *subName1 = new char[5]{ "aaaa" };
	char* subName2 = new char[5]{ "bbbb" };
	char *subName3 = new char[5]{ "cccc" };
	char *subName4 = new char[5]{ "dddd" };

	int subNum1 = 123;
	int subNum2 = 456;
	int subNum3 = 789;
	int subNum4 = 147;

	char *opName1 = new char[5]{ "eeee" };
	char *opName2 = new char[5]{ "ffff" };

	Subscriber subscriber1;
	subscriber1.setName(subName1);
	subscriber1.setNumber(subNum1);

	Subscriber subscriber2;
	subscriber2.setName(subName2);
	subscriber2.setNumber(subNum2);

	Subscriber subscriber3;
	subscriber3.setName(subName3);
	subscriber3.setNumber(subNum3);

	Subscriber subscriber4;
	subscriber4.setName(subName4);
	subscriber4.setNumber(subNum4);

	Operator *operator1 = new Operator;
	operator1->setName(opName1);

	Operator* operator2 = new Operator;

	operator2->setName(opName2);
	service.setOp(operator1);
	service.setOp(operator2);

	service.call(subscriber1);
	service.call(subscriber2);
	service.call(subscriber3);

	delete[] subName1;
	delete[] subName2;
	delete[] subName3;
	delete[] subName4;

	delete[] opName1;
	delete[] opName2;

	delete operator1;
	delete operator2;

	system("pause");
	return 0;
}