#include <iostream>
#include <conio.h>

using namespace std;
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
		delete[] group[gr].student;
	cout << "bbbbbbbbbbbbbbbbbbbbbbbbbbbb\n";
}

void print(int size[])
{
	cout << "\n\n";

	cout << "Qrup 1 :\n";
	for (int i = 0; i < size[0]; i++)
		cout << i + 1 << "  " << group[0].student[i].name << "  Bali : " << group[1].student[i].point << "\n";

	cout << "\n\n";
	cout << "Qrup 2 :\n";

	for (int i = 0; i < size[1]; i++)
		cout << i + 1 << "  " << group[1].student[i].name << "  Bali : " << group[1].student[i].point << "\n";
	cout << "\n\n";
	cout << "Qrup 3 :\n";

	for (int i = 0; i < size[2]; i++)
		cout << i + 1 << "  " << group[2].student[i].name << "  Bali : " << group[1].student[i].point << "\n";
	cout << "\n\n";

	system("pause");
}

void delete_student(int size[],  Student * tmp)
{
	int b, c;


	cout << "Qrupu daxil edin \n";
	cin >> b;
	cout << "Telebenin adini daxil edin\n";
	cin >> c;

	for (int i = 0; i < size[b] + 1; i++)
		tmp[i].name = new char[20];

	for (int i = 0; i < size[b]; i++)
		tmp[i] = group[b].student[i];

	int d = 0;
	for (int i = 0; i < size[b]; i++)
	{
		if (c == i)
		{
			continue;
		}
		else
		{
			tmp[d] = group[b].student[i];
			d++;
		}
	}
	delete_(size, b);
	group[b].student = tmp;
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

			Student * tmp = new Student[size[a - 1]+1];



			addstudent(size, a - 1, tmp);
			delete_(size, a - 1);
			//for (int i = 0; i < size[a - 1]; i++)
			//{

				group[a - 1].student = tmp;
			//}
			//delete[] tmp;
		}
		else if (a == 2)
		{
			system("cls");
			print(size);
			Student * tmp = new Student[size[a - 1]];
			delete_student(size, tmp);
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
*/
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


/*
#include <iostream>
#include <iomanip>
#include <ctime>
#include <conio.h>
using namespace std;

#pragma warning(disable : 4996)

struct Contact
{
	char name[20];
	char surname[20];
	char phone[20];
};


void printcontacts(Contact contacts[], int &count)
{
	system("cls");
	if (count == 0)
	{
		cout << "Phonebook is empty! " << endl;
	}
	else if (count>0)
	{

		cout << setw(5) << left << "#";
		cout << setw(20) << left << "Name: ";
		cout << setw(20) << left << "Surname: ";
		cout << setw(20) << left << "Phone: " << "\n\n";
		for (int i = 0; i < count; i++)
		{
			cout << setw(5) << left << i + 1;
			cout << setw(20) << left << contacts[i].name;
			cout << setw(20) << left << contacts[i].surname;
			cout << setw(20) << left << contacts[i].phone << endl;

		}
	}
	system("pause");
}
void addcontact(Contact contacts[], int &count)
{
	system("cls");
	Contact c;

	cout << "Enter name:" << "\t";
	cin.getline(c.name, 20);
	cout << "Enter surname:" << "\t";
	cin.getline(c.surname, 20);
	cout << "Enter phone:" << "\t";
	cin.getline(c.phone, 20);
	contacts[count] = c;
	count++;

	system("pause");

}
void removecontact(Contact contacts[], int &count)
{
	system("cls");


	if (count == 0)
	{
		system("cls");
		cout << "Phonebook is empty! " << endl;
		system("pause");
	}
	else if (count > 0)
	{
		Contact c;
		system("cls");
		int index;
		cout << setw(5) << left << "#";
		cout << setw(20) << left << "Name: ";
		cout << setw(20) << left << "Surname: ";
		cout << setw(20) << left << "Phone: " << "\n\n";
		for (int i = 0; i < count; i++)
		{
			cout << setw(5) << left << i + 1;
			cout << setw(20) << left << contacts[i].name;
			cout << setw(20) << left << contacts[i].surname;
			cout << setw(20) << left << contacts[i].phone << endl;

		}
		cout << "Enter remove contact index:";
		cin >> index;
		cin.get();
		if (index > 0 && index <= count)

		{
			for (int i = 0; i < index - 1; i++)
			{
				c = contacts[i];
				contacts[i] = c;
			}
			for (int i = index - 1; i < count - 1; i++)
			{
				c = contacts[i + 1];
				contacts[i] = c;
			}
			count--;
			system("cls");
			cout << setw(5) << left << "#";
			cout << setw(20) << left << "Name: ";
			cout << setw(20) << left << "Surname: ";
			cout << setw(20) << left << "Phone: " << "\n\n";
			for (int i = 0; i < count; i++)
			{
				cout << setw(5) << left << i + 1;
				cout << setw(20) << left << contacts[i].name;
				cout << setw(20) << left << contacts[i].surname;
				cout << setw(20) << left << contacts[i].phone << endl;

			}
		}
		else
		{
			cout << "index no find" << endl;
		}
		system("pause");
	}
}
void editcontact(Contact contacts[], int &count)
{
	system("cls");

	if (count == 0)
	{
		system("cls");
		cout << "Phonebook is empty! " << endl;
		system("pause");
	}
	else if (count > 0)
	{
		Contact c;

		cout << setw(5) << left << "#";
		cout << setw(20) << left << "Name: ";
		cout << setw(20) << left << "Surname: ";
		cout << setw(20) << left << "Phone: " << "\n\n";
		for (int i = 0; i < count; i++)
		{
			cout << setw(5) << left << i + 1;
			cout << setw(20) << left << contacts[i].name;
			cout << setw(20) << left << contacts[i].surname;
			cout << setw(20) << left << contacts[i].phone << endl;

		}

		cout << "Enter edit contact index:";
		int index;
		cin >> index;
		cin.get();
		if (index > 0 && index <= count)
		{
			cout << "Name:" << "  " << contacts[index - 1].name << endl;
			cout << "Surname:" << "  " << contacts[index - 1].surname << endl;
			cout << "Phone:" << "  " << contacts[index - 1].phone << endl;


			cout << "1.Edit by name" << endl;
			cout << "2.Edit by surname:" << endl;
			cout << "3.Edit by phone:" << endl;

			char key;
			key = getch();
			if (key == '1')
			{
				cout << "enter new name:" << endl;
				cin.getline(c.name, 20);
				strcpy(contacts[index - 1].name, c.name);
				strcpy(c.surname, contacts[index - 1].surname);
				strcpy(c.phone, contacts[index - 1].phone);
			}
			else if (key == '2')
			{
				cout << "enter new surname:" << endl;
				cin.getline(c.surname, 20);
				strcpy(contacts[index - 1].surname, c.surname);
				strcpy(c.name, contacts[index - 1].name);
				strcpy(c.phone, contacts[index - 1].phone);
			}
			else if (key == '3')
			{
				cout << "enter new phone:" << endl;
				cin.getline(c.phone, 20);
				strcpy(contacts[index - 1].phone, c.phone);
				strcpy(c.name, contacts[index - 1].name);
				strcpy(c.surname, contacts[index - 1].surname);
			}

			cout << setw(20) << left << c.name;
			cout << setw(20) << left << c.surname;
			cout << setw(20) << left << c.phone << endl;
		}
		else
		{
			cout << "Index no find!" << endl;
		}
		system("pause");
	}
}
void sortcontact(Contact contacts[], int &count)
{
	system("cls");
	Contact c;
	if (count == 0)
	{
		system("cls");
		cout << "Phonebook is empty! " << endl;
		system("pause");
	}
	else if (count > 0)
	{
		for (int i = 0; i < count; i++)
		{
			c = contacts[i];
			for (int j = 0; j < count - i; j++)
			{
				if (strcmp(contacts[i].name, contacts[count - 1 - j].name) == 1)
				{
					contacts[i] = contacts[count - 1 - j];
					contacts[count - 1 - j] = c;
					c = contacts[i];
				}
			}


			cout << setw(20) << left << c.name;
			cout << setw(20) << left << c.surname;
			cout << setw(20) << left << c.phone << endl;
		}
		system("pause");
	}
}
void searchcontact(Contact contacts[], int &count)
{
	system("cls");
	Contact c;
	if (count == 0)
	{
		system("cls");
		cout << "Phonebook is empty! " << endl;
		system("pause");
	}
	else if (count > 0)
	{
		cout << "1.Search by name!" << endl;
		cout << "2.Search by surname!" << endl;
		cout << "3.Search by phone!" << endl;

		char search;
		int say = 0;
		search = getch();

		if (search == '1')
		{
			cout << "Search name:" << "\t";
			cin.getline(c.name, 20);
			for (int i = 0; i < count; i++)
			{
				if (strcmp(contacts[i].name, c.name) == 0)
				{
					say++;
					cout << setw(20) << left << contacts[i].name;
					cout << setw(20) << left << contacts[i].surname;
					cout << setw(20) << left << contacts[i].phone << endl;
				}
			}
			if (say > 0)
			{
				cout << "Find to  " << say << "  contact" << endl;
			}
			else
			{
				cout << "No find contact" << endl;
			}
		}
		else if (search == '2')
		{
			cout << "Search surname:" << "\t";
			cin.getline(c.surname, 20);
			for (int i = 0; i < count; i++)
			{
				if (strcmp(contacts[i].surname, c.surname) == 0)
				{
					say++;
					cout << setw(20) << left << contacts[i].name;
					cout << setw(20) << left << contacts[i].surname;
					cout << setw(20) << left << contacts[i].phone << endl;
				}
			}
			if (say > 0)
			{
				cout << "Find to  " << say << "  contact" << endl;
			}
			else
			{
				cout << "No find contact" << endl;
			}
		}
		else if (search == '3')
		{
			cout << "Search phone number:" << "\t";
			cin.getline(c.phone, 20);
			for (int i = 0; i < count; i++)
			{
				if (strcmp(contacts[i].phone, c.phone) == 0)
				{
					say++;
					cout << setw(20) << left << contacts[i].name;
					cout << setw(20) << left << contacts[i].surname;
					cout << setw(20) << left << contacts[i].phone << endl;
				}
			}
			if (say > 0)
			{
				cout << "Find to  " << say << "  contact" << endl;
			}
			else
			{
				cout << "No find contact" << endl;
			}
		}
		system("pause");
	}

}

void main()
{
	Contact contacts[100];
	int count = 0;
	Contact c;
	char step;

	while (1)
	{
		system("cls");
		cout << "1. Print" << endl;
		cout << "2. Add" << endl;
		cout << "3. Remove" << endl;
		cout << "4. Edit" << endl;
		cout << "5. Sort" << endl;
		cout << "6. Search" << endl;
		cout << "0. Exit" << endl;

		step = getch();
		if (step == '1')
		{

			printcontacts(contacts, count);

		}
		else if (step == '2')
		{
			addcontact(contacts, count);
		}
		else if (step == '3')
		{
			removecontact(contacts, count);
		}
		else if (step == '4')
		{
			editcontact(contacts, count);
		}
		else if (step == '5')
		{
			sortcontact(contacts, count);
		}
		else if (step == '6')
		{
			searchcontact(contacts, count);

		}
		else if (step == '0')
		{
			exit(0);
		}

	}

}

*/
struct Item
{
	char item_name[20];
	int weight;

};
struct Baggage
{
	int item_count;

	Item * item;



};



struct Passanger
{
	char* name;
	int ticket_number;
	Baggage baggage;

}passanger[3];


void add_item()
{

	passanger[0].baggage.item = new Item[passanger[0].baggage.item_count];
	passanger[1].baggage.item = new Item[passanger[1].baggage.item_count];
	passanger[2].baggage.item = new Item[passanger[2].baggage.item_count];
	cout << "\n\n";
	for (int i = 0; i < 3; i++)
	{
		for (int j = 0; j < passanger[i].baggage.item_count; j++)
		{
			cout << i + 1 << " ci sernisinin " << j + 1 << " ci esyasinin adini daxil edin\n";
			cin >> passanger[i].baggage.item[j].item_name;
			cout << i + 1 << " ci sernisinin " << j + 1 << " ci esyasinin cekisini daxil edin\n";
			cin >> passanger[i].baggage.item[j].weight;
			cout << "\n\n";
		}
	}
}


void print()
{

	for (int i = 0; i < 3; i++)
	{
		cout << passanger[i].name << " Bagaji : \n";
		for (int j = 0; j < passanger[i].baggage.item_count; j++)
		{
			cout << "Adi : " << passanger[i].baggage.item[j].item_name << "  Cekisi  : " << passanger[i].baggage.item[j].weight << "\n";
		}
		cout << "\n\n";
	}

}


int main()
{

	for (int i = 0; i < 3; i++)
		passanger[i].name = new char;

	passanger[0].name = "Alim";
	passanger[1].name = "Elvin";
	passanger[2].name = "Xeyyam";

	passanger[0].ticket_number = 123;
	passanger[1].ticket_number = 456;
	passanger[2].ticket_number = 789;

	passanger[0].baggage.item_count = 3;
	passanger[1].baggage.item_count = 4;
	passanger[2].baggage.item_count = 4;

	add_item();
	print();




	int index = 0;
	int count = 0;
	int a = 0;

	for (int i = 0; i < 3 - 1; i++)
		for (int j = 0; j < 3; j++)
			if (passanger[i].baggage.item_count > passanger[j].baggage.item_count)
				index = passanger[i].baggage.item_count;

	for (int i = 0; i < 3; i++)
		if (index == passanger[i].baggage.item_count)
			count++;

	if (count == 1)
	{
		for (int i = 0; i < 3; i++)
			if (index == passanger[i].baggage.item_count)
			{
				cout << passanger[i].name << " Size lazim olan sernisin budur\n";
			}
	}
	else
	{
		int * arr = new int[count];
		for (int i = 0; i < count; i++)
			arr[i] = 0;

		for (int i = 0; i < 3; i++)
		{
			if (index == passanger[i].baggage.item_count)
			{
				for (int j = 0; j < passanger[i].baggage.item_count; j++)
				{
					arr[a] += passanger[i].baggage.item[j].weight;
				}
				a++;
			}
		}

		for (int i = 0; i < count - 1; i++)
		{
			for (int j = 0; j < count - 1 - i; j++)
			{
				if (arr[j] < arr[j + 1])
					index = arr[j];
			}
		}
	}
	int aa = 0;
	for (int i = 0; i < 3; i++)
	{
		for (int j = 0; j < passanger[i].baggage.item_count; j++)
		{
			aa += passanger[i].baggage.item[j].weight;
		}
		if (index == aa)
		{
			cout << passanger[i].name << " Size lazim olan sernisin \n";
			break;
		}
	}

	system("pause");
	return 0;
}