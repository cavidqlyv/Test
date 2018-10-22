#include <iostream>

using namespace std;

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

void addstudent(int size[], int gr, Student * tmp)
{


	for (int i = 0; i < size[gr] + 1; i++)
		tmp[i].name = new char[20];

	for (int i = 0; i < size[gr]; i++)
		tmp[i] = group[gr].student[i];

	cout << "Telebenin adini daxil et\n";
	tmp[size[gr]].name = new char[15];
	cin >> tmp[size[gr]].name;
	cout << "Telebenin balini daxil et\n";
	cin >> tmp[size[gr]].point;

	size[gr]++;

}

void delete_(int size[], int gr)
{
	cout << "aaaaaaaaaaaaaaaaaaaaaaaaaaaaa\n";
	for (int i = 0; i < 3; i++)
		delete[] group[i].student;
	cout << "bbbbbbbbbbbbbbbbbbbbbbbbbbbb\n";
}

void print(int size[])
{
	cout << "\n\n";

	cout << "Qrup 1 :\n";
	for (int i = 0; i < size[0]; i++)
		cout << i + 1 << "  " << group[0].student[i].name << "  Bali : " << group[1].student[i].point << "\n";

	cout << "\n\n";
	cout << "Qrup 1 :\n";

	for (int i = 0; i < size[1]; i++)
		cout << i + 1 << "  " << group[1].student[i].name << "  Bali : " << group[1].student[i].point << "\n";
	cout << "\n\n";
	cout << "Qrup 1 :\n";

	for (int i = 0; i < size[2]; i++)
		cout << i + 1 << "  " << group[2].student[i].name << "  Bali : " << group[1].student[i].point << "\n";
	cout << "\n\n";


}

void delete_student(int size[], int gr, Student * tmp)
{
	int b, c;

	for (int i = 0; i < size[gr] + 1; i++)
		tmp[i].name = new char[20];

	for (int i = 0; i < size[gr]; i++)
		tmp[i] = group[gr].student[i];
	cout << "Qrupu daxil edin \n";
	cin >> b;
	cout << "Telebenin adini daxil edin\n";
	cin >> c;


}



int main()
{
	group[0].name = new char[10]{ "Qurp1" };
	group[1].name = new char[10]{ "Qurp2" };
	group[2].name = new char[10]{ "Qurp3" };

	int size[3] = { 0,0,0 };

	int a;

	while (1)
	{
		system("cls");
		cout << "Qrupa telebe elave etmek ucun 1\n";
		cout << "Qrupdan telebe silmek ucun 2\n";
		cout << "Qrupun siyahisina baxmnaq ucun 3\n";
		cin >> a;

		if (a == 1)
		{
			system("cls");

			cout << "1 ci qrup ucun 1\n";
			cout << "2 ci qrup ucun 2\n";
			cout << "3 ci qrup ucun 3\n";
			cin >> a;

			Student * tmp = new Student[size[a - 1]];

			addstudent(size, a - 1, tmp);

			delete_(size, a - 1);
			group[a - 1].student = tmp;

		}

		else if (a == 2)
		{
			system("cls");
			print(size);





		}
		else if (a == 3)
		{
			system("cls");
			print(size);

		}
	}



	system("pause");
	return 0;
}


/*
#include <iostream>

using namespace std;

void print(char** messages, int size)
{
	cout << "\n========MESSAGES========\n";
	for (int i = 0; i < size; i++) {
		cout << messages[i] << '\n';
	}
	cout << "========================\n\n";
}

void cpy(char** dest, char** source, int size)
{
	for (int i = 0; i < size; i++) {
		dest[i] = new char[10];
		strcpy(dest[i], source[i]);
	}
}

void memfree(char** messages, int size)
{
	if (!messages) return;

	for (int i = 0; i < size; i++) {
		delete[] messages[i];
	}
	delete[] messages;
}

int main()
{
	int index = 0;
	char** messages = 0;

	while (1)
	{
		cout << "Enter a message\n";
		char* msg = new char[10];
		cin >> msg;

		char** tmp = new char*[index + 1];
		cpy(tmp, messages , index);
		tmp[index++] = msg;

		memfree(messages, index - 1);
		messages = tmp;
		print(messages, index);
	}

	return 0;
}
*/
