//#include <iostream>
//class Filter
//{
//public:
//	bool operator()(int num)
//	{
//		return num > 5;
//	}
//};
////
////class PointerWrapper
////{
////	int *buf = nullptr;
////public:
////	PointerWrapper(int *b)
////	{
////		buf = b;
////	}
////	PointerWrapper(PointerWrapper && pw)
////	{
////		buf = pw.buf;
////		pw.buf = nullptr;
////	}
////	~PointerWrapper()
////	{
////		if (buf)
////			delete[] buf;
////	}
////};
//
//class Result
//{
//	int *arr = nullptr;
//	size_t size;
//	int count = 0;
//public:
//	~Result()
//	{
//		if (arr)
//			delete[] arr;
//	}
//	void setArr(int rNum)
//	{
//		if (!arr)
//		arr = new int[size];
//		arr[count++] = rNum;
//	}
//	void setSize(size_t rSize)
//	{
//		size = rSize;
//	}
//	int *getArr()
//	{
//		return arr;
//	}
//	void print()
//	{
//		for (int i = 0; i < size; i++)
//			std::cout << arr[i] << '\n';
//	}
//};
//
//
//template <typename TCallback>
//Result* arrayFilter(int* arr, size_t size, TCallback callback)
//{
//	int tmpSize = 0;
//	int tmpIndex = 0;
//	Result * result = new Result;
//	for (int i = 0; i < size; i++)
//		if (callback(arr[i]))
//			tmpSize++;
//	result->setSize(tmpSize);
//
//	for (int i = 0; i < size; i++)
//		if (callback(arr[i]))
//			result->setArr(arr[i]);
//
//	return result;
//}
//
//int main()
//{
//	int * arr =new int [5]{3,4,5,6,7};
//	Filter filter; 
//
//	Result * tmp= arrayFilter(arr, 5, filter);
//
//	tmp->print();
//
//	delete tmp;
//
//	system("pause");
//	return 0;
//}



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


	Operator operator1;
	operator1.setName(opName1);

	Operator operator2;

	operator1.setName(opName2);

	service(subscriber1, operator1);

	delete[] subName1;
	delete[] subName2;
	delete[] subName3;
	delete[] subName4;

	delete[] opName1;
	delete[] opName2;



	system("pause");
	return 0;
}