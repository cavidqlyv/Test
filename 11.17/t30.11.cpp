#include <iostream>
using namespace std;

struct worker
{
	char * name;
	int age;
	char * specialty;
	int salary;
};

struct factory
{
	char * name;
	char * address;
	int average_age;
	int average_salary;
	worker workers[2];
}factorys[3];

int main()
{
	for (int i = 0; i < 3; i++)
	{
		factorys[i].name = new char[15];
		factorys[i].address = new char[15];
	}
	factorys[0].name = "Beton zavod";
	factorys[0].address = "Sumqayit";
	factorys[1].name = "Sement zavod";
	factorys[1].address = "Gence";
	factorys[2].name = "Kerpic zavod";
	factorys[2].address = "Baki";

	int a = 0;
	for (int i = 0; i < 3; i++)
	{
		cout << factorys[i].name << "\n";
		cout << "------------------------------------------------------------------------------------------------------------\n\n";
		for (int j = 0; j < 2; j++)
		{
			factorys[i].workers[j].name = new char[20];
			factorys[i].workers[j].specialty = new char[20];
			cout << "\nIscinin adini daxil et\n";
			cin >> factorys[i].workers[j].name;
			cout << "\nIscinin yasini daxil edin\n";
			cin >> factorys[i].workers[j].age;
			cout << "\nIxtisas  : Muhendis ucun 1 daxil et \n";
			cout << "\t   Fehle ucun 2 daxil et\n";
			cout << "\t   Surucu ucun 3 daxil et\n";
			cin >> a;
			if (a == 1) factorys[i].workers[j].specialty = "muhendis";
			if (a == 2) factorys[i].workers[j].specialty = "fehle";
			if (a == 3) factorys[i].workers[j].specialty = "surucu";
			cout << "Emek haqqini daxil et\n";
			cin >> factorys[i].workers[j].salary;
		}
	}
	cout << "\n\n------------------------------------------------------------------------------------------------------------\n\n";
	int count_salary = 0;
	int cout_age = 0;
	int sum_age = 0;
	int sum_salary = 0;

	for (int i = 0; i < 3; i++)
	{
		cout << "\n\n\n------------------------------------------------------------------------------------------------------------\n";
		cout << factorys[i].name << "\t";
		cout << factorys[i].address << "\n";

		for (int j = 0; j < 2; j++)
		{
			if (strcmp(factorys[i].workers[j].specialty, "muhendis") == 0)
			{
				sum_salary += factorys[i].workers[j].salary;
				sum_age += factorys[i].workers[j].age;
				count_salary++;
				cout_age++;
			}
		}
		cout << "Muhendisler : ";
		if (sum_salary != 0)
		{
			cout << "Orta emek haqqi - " << sum_salary / count_salary << '\n';
			cout << "Orta yas - " << sum_age / cout_age << '\n';
		}
		else
			cout << "Muhendis yoxdur\n";
		count_salary = 0;
		cout_age = 0;
		sum_age = 0;
		sum_salary = 0;
		for (int j = 0; j < 2; j++)
		{
			if (strcmp(factorys[i].workers[j].specialty, "fehle") == 0)
			{
				sum_salary += factorys[i].workers[j].salary;
				sum_age += factorys[i].workers[j].age;
				count_salary++;
				cout_age++;
			}
		}

		cout << "Fehleler  : ";
		if (sum_salary != 0)
		{
			cout << "Orta emek haqqi - " << sum_salary / count_salary << '\n';
			cout << "Orta yas - " << sum_age / cout_age << '\n';
		}
		else
			cout << "Fehle yoxdur\n";

		count_salary = 0;
		cout_age = 0;
		sum_age = 0;
		sum_salary = 0;

		for (int j = 0; j < 2; j++)
		{
			if (strcmp(factorys[i].workers[j].specialty, "surucu") == 0)
			{
				sum_salary += factorys[i].workers[j].salary;
				sum_age += factorys[i].workers[j].age;
				count_salary++;
				cout_age++;
			}
		}

		cout << "Suruculer  : ";
		if (sum_salary != 0)
		{
			cout << "Orta emek haqqi - " << sum_salary / count_salary << '\n';
			cout << "Orta yas - " << sum_age / cout_age << '\n';
		}
		else
			cout << "Surucu yoxdur\n";
	}

	system("pause");
	return 0;
}