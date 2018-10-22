#include <iostream>
#include <cstring>
 #pragma warning(disable : 4996)  
using namespace std;

/*
struct Book
{
	char* name;
	char* author;
	char* date;
	char* page;
} book[5];

int main()
{

	book[0].name = new char[10]{ "book12" };
	book[0].author = new char[10]{ "author12" };
	book[0].date = new char[15]{ "12.12.12" };
	book[0].page = new char[4]{ "123" };

	book[1].name = new char[10]{ "book13" };
	book[1].author = new char[10]{ "author13" };
	book[1].date = new char[15]{ "11.11.11" };
	book[1].page = new char[4]{ "234" };

	book[2].name = new char[10]{ "book14" };
	book[2].author = new char[10]{ "author14" };
	book[2].date = new char[15]{ "10.10.10" };
	book[2].page = new char[4]{ "345" };

	for (int i = 0; i < 3; i++)
	{
		cout << book[i].name << '\n';
		cout << book[i].author << '\n';
		cout << book[i].date << '\n';
		cout << book[i].page << '\n';
		cout << '\n';
	}
	system("pause");
	return 0;
}
*/

/*
struct Student
{
	char*name;
	char*speciality;
	int  point;
}student[3];

int main()
{
	student[0].name = new char[10];
	student[0].speciality = new char[10];
	student[1].name = new char[10];
	student[1].speciality = new char[10];
	student[2].name = new char[10];
	student[2].speciality = new char[10];

	cout << "Birinci telebe : Ad Ixtisas orta bal\n";
	cin >> student[0].name;
	cin >> student[0].speciality;
	cin >> student[0].point;

	cout << "Ikinci telebe : Ad Ixtisas orta bal\n";
	cin >> student[1].name;
	cin >> student[1].speciality;
	cin >> student[1].point;

	cout << "Ucuncu telebe : Ad Ixtisas orta bal\n";
	cin >> student[2].name;
	cin >> student[2].speciality;
	cin >> student[2].point;
	char* tmp = new char[10];
	int tmp1=0;
	for (int i = 0; i < (3 - 1); i++)
	{
		for (int j = 0; j < 3 - i - 1; j++)
		{
			if (student[j].point < student[j + 1].point)
			{
				strcpy(tmp, student[j].name);
				strcpy(student[j].name, student[j + 1].name);
				strcpy(student[j + 1].name, tmp);

				strcpy(tmp, student[j].speciality);
				strcpy(student[j].speciality, student[j + 1].speciality);
				strcpy(student[j + 1].speciality, tmp);

				tmp1 = student[j].point;
				student[j].point = student[j + 1].point;
				student[j + 1].point = tmp1;
			}
		}
	}


	cout << student[0].name << '\n';
	cout << student[0].speciality << '\n';
	cout << student[0].point << "\n\n";

	cout << student[1].name << '\n';
	cout << student[1].speciality << '\n';
	cout << student[1].point << "\n\n";

	cout << student[2].name << '\n';
	cout << student[2].speciality << '\n';
	cout << student[2].point << "\n\n";

	system("pause");
	return 0;
}
*/