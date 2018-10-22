#include<iostream>
using namespace std;

/*
struct Student
{
	char * name;
	int math;
	int art;
	int programming;
}student[5];

void func_2()
{
	for (int i = 0; i < 5; i++)
	{
		if (student[i].math == 2) cout << student[i].name << " Riyaziyyatdan 2 alib\n\n";
		if (student[i].art == 2) cout << student[i].name << " Resmden 2 alib\n\n";
		if (student[i].programming == 2) cout << student[i].name << " Programlastirmadan 2 alib\n\n";
	}
}


void func_avg(int *arr)
{
	bool flag = true;
	for (int i = 0; i < 5; i++)
	{
		if (student[i].math > arr[0] && student[i].art > arr[1] && student[i].programming > arr[2])
		{
			cout << student[i].name << " Telebe yaxsi oxuyur\n\n";
			flag = false;
		}
	}
	if (flag) cout << "\nTelebelerin hec biri oxumur\n\n";


}


int main()
{
	for (int i = 0; i < 5; i++)
	{
		student[i].name = new char[15];

		cout << "Adi daxil et\n";
		cin >> student[i].name;
		cout << "Riyaziyyatdan bali daxil et\n";
		cin >> student[i].math;
		cout << "Resmden orta bali daxil et\n";
		cin >> student[i].art;
		cout << "Programlastirmadan orta baxli daxil et\n";
		cin >> student[i].programming;
		cout << "\n\n------------------------------------------------------------------------------------------\n\n";

	}
	int sum = 0;
	int arr[3];
	for (int i = 0; i < 3; i++)
	{
		for (int j = 0; j < 5; j++)
		{
			if (i == 0)sum += student[j].math;
			else if (i == 1) sum += student[j].art;
			else if (i == 2)sum += student[j].programming;
		}
		if (i == 0)
		{
			arr[0] = sum / 5;
			cout << "Riyaziyyatdan orta bal :" << arr[0] << "\n";
		}
		else if (i == 1)
		{
			arr[1] = sum / 5;
			cout << "Resmden orta bal :" << arr[1] << "\n";
		}
		else if (i == 2)
		{
			arr[2] = sum / 5;
			cout << "Programlastirmadan orta bal :" << arr[2] << "\n";
		}
		sum = 0;
	}

	func_2();
	func_avg(arr);
	system("pause");
	return 0;
}
*/

/*

struct Student
{
	char * name;
	int point;


};

struct Group
{

	char * name;

	Student  *student;
}group[3];


int main()
{
	group[0].name = new char[10]{ "Qurp1" };
	group[1].name = new char[10]{ "Qurp2" };
	group[2].name = new char[10]{ "Qurp3" };

	int size[3] = {0,0,0};

	int a;
	while(1)
	{
		cout << "Qrupa telebe elave etmek ucun 1\n";
		cout << "Qrupdan telebe silmek ucun 2\n";
		cout << "Qrupun siyahisina baxmnaq ucun 3\n";
		cin >> a;

		if (a == 1)
		{
			for (int i = 0; i < 3; i++)
			{
				cout << i + 1 << " ci qrup ucun 1\n";
				cout << i + 1 << " ci qrup ucun 2\n";
				cout << i + 1 << " ci qrup ucun 3\n";
				cin >> a;
				if (a == 1)
				{
					Student * tmp = new Student[1];
					tmp
					cout << "Telebenin adini daxil edin\n";
					
					group[size[0]].student = new Student[size[0] + 1];
				}

			}
		}
	}



	system("pause");
	return;
}

*/
