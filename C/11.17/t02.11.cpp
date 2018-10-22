#include <iostream>
using namespace std;


typedef int(*ptr)(char[20][10]);



int list1 = 0;
int add(char list[20][10])
{
	cout << "Qonaqin adini daxil et\n";
	cin >> list[list1];
	list1++;

	return 0;
}
int view(char list[20][10])
{
	for (int i = 0; i < list1; i++)
	{
		cout <<i+1 << ". " << list[i] << "\n";
	}
	return 0;
}
int del(char  list[20][10])
{
	for (int i = 0; i < 20; i++)
	{
		list[i][0] = '\0';
	}
	list1 = 0;
	return 0;
}


int main()
{
	int a;
	char list[20][10];
	
	ptr arr1[3];

	arr1[0] = add;
	arr1[1] = view;
	arr1[2] = del;

	while (1)
	{
		cout << "Qonaq siyahisina elave etmek ucun 1\n";
		cout << "Siyahini cap etmek unun 2\n";
		cout << "Siyahini legv etmek funksiyasi ucun 3\n";
		cout << "baglamaq ucun 0\n";
		cin >> a;
		if (a == 1)
		{
			arr1[0](list);
		}
		else if (a == 2)
		{
			arr1[1](list);
		}
		else if (a == 3)
		{
			arr1[2](list);
		}
		else if (a == 0)
		{
			break;
		}
		else
		{
			cout << "Duzgun daxil et\n";
		}

	}


	system("pause");
	return 0;
}

