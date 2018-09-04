#include <iostream>
#include <conio.h>

using namespace std;



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
		passanger[i].name = new char[10];

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
			aa = 0;
		}
	}
	system("pause");
	return 0;
}



/*
struct Cinema
{
	char * name;
	char* janr;
	int  rating;
}cinema[3];


void print()
{
	system("cls");
	for (int i = 0; i < 3; i++)
	{
		cout << i + 1 << " ci kino\n";
		cout << "Adi : \t\t" << cinema[i].name << "\n";
		cout << "Janr : \t\t" << cinema[i].janr << "\n";
		cout << "Reyting : \t" << cinema[i].rating << "\n\n";
	}

	system("pause");

}


void find()
{
	system("cls");

	int a;

	cout << "Istediyiniz janri secin\n";
	cout << "eeeee ucun 1\n";
	cout << "fffff ucun 2\n";

	cin >> a;

	system("cls");

	for (int i = 0; i < 3; i++)
	{
		if (a == 1)
		{
			if (strcmp("eeeee", cinema[i].janr) == 0)
				cout << cinema[i].name << "\n";
		}
		if (a == 2)
		{
			if (strcmp("fffff", cinema[i].janr) == 0)
				cout << cinema[i].name << "\n";
		}
	}
	system("pause");

}

void change_r()
{
	system("cls");
	print();

	int a;
	cout << "Deyismey istediyiniz filmin nmresini daxil edin\n";
	cin >> a;

	cout << "Reytinqi daxil edin\n";
	cin >> cinema[a - 1].rating;

	system("pause");

}

void sort()
{
	int a;
	Cinema tmp;
	cout << "Boyukden balacaya 1\n";
	cout << "Balacadan boyuye 2\n";
	cin >> a;
	for (int i = 0; i < 3 - 1; i++)
		for (int j = 0; j < 3-i-1; j++)
		{
			if (a == 2)
			{
				if (cinema[j].rating > cinema[j + 1].rating)
				{
					tmp = cinema[j];
					cinema[j] = cinema[j + 1];
					cinema[j + 1] = tmp;
				}
			}
			else if (a == 1)
			{
				if (cinema[j].rating < cinema[j + 1].rating)
				{
					tmp = cinema[j];
					cinema[j] = cinema[j + 1];
					cinema[j + 1] = tmp;
				}
			}
		}


}


int main()
{
	int a;

	for (int i = 0; i < 3; i++)
	{
		cinema[i].name = new char[15];
		cinema[i].janr = new char[15];
	}

	cinema[0].name = "aaaaa";
	cinema[1].name = "bbbbb";
	cinema[2].name = "ccccc";

	cinema[0].janr = "eeeee";
	cinema[1].janr = "eeeee";
	cinema[2].janr = "fffff";

	cinema[0].rating = 5;
	cinema[1].rating = 6;
	cinema[2].rating = 7;
	while (true)
	{
		system("cls");
		cout << "Siyahiya baxmaq ucun 1\n";
		cout << "Janra gore axtaris ucun 2\n";
		cout << "Reytinqleri deysmek ucun 3\n";
		cout << "Siralamaq ucun 4\n";

		cin >> a;

		if (a == 1) print();
		else if (a == 2) find();
		else if (a == 3) change_r();
		else if (a == 4)sort();

	}
	system("pause");
	return 0;
}

*/