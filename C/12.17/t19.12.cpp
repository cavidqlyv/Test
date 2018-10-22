#include <iostream>
#include <Windows.h>
#include <stdio.h>
#include <conio.h>
using namespace std;
#pragma warning(disable : 4996) 

int fileSize(FILE* f)
{
	fseek(f, 0, SEEK_END);
	int size = ftell(f);
	fseek(f, 0, SEEK_SET);
	return size;
}

int main()
{
	char a;
	FILE * f;
	char name[10] = { "test.txt" };
	while (1)
	{
		system("cls");
		cout << "New File\n";
		cout << "Delete File 2\n";
		cout << "Rename File 3\n";
		cout << "Fayla melumat yazmaq 4 \n";
		cout << "Faylin terkibini oxumaq 5\n";
		cout << "Faylin icini bosaldamq 6\n";
		cout << "Elave etmek 7\n";

		a = _getch();

		if (a == '1')
		{
			f = fopen(name, "w");
			fclose(f);

		}
		else if (a == '2')
		{
			fclose(f);
			remove(name);
		}
		else if (a == '3')
		{
			char b[10];

			cout << "Indiki ad\n";
			cin >> b;
			cout << "Teze ad\n";
			cin >> name;
			rename(b, name);
			strcpy(b, name);
		}
		else if (a == '4')
		{
			char b;
			f = fopen(name, "w");
			cout << "---\n";
			while (1)
			{
				b = _getch();
				cout << b;
				if (b != 13)
				{
					//fwrite(&b, 1, 1, f);

					putc(b, f);
				}
				else break;
			}
			fclose(f);
		}
		else if (a == '5')
		{
			f = fopen(name, "r");
			/*
			if (f && fileSize(f) > 0)
			{
				while (!feof(f))
				{
					char d[20];
					fgets(d, 20, f);
					cout << d;
				}


				cout << '\n';
				fclose(f);
				system("pause");
			}
			*/
			char d[200];
			d[0] = '\0';
			fgets(d, 200, f);
			if (d[0] == '\0')
				cout << "Fayl bosdur\n";
			else
				cout << d;
			cout << '\n';
			fclose(f);
			system("pause");

		}
		else if (a == '6')
		{
			fclose(f);
			remove(name);
			f = fopen(name, "w");
		}
		else if (a == '7')
		{
			char b;
			f = fopen(name, "a");
			cout << "---\n";
			while (1)
			{
				b = _getch();
				cout << b;
				if (b != 13)
				{
					//fwrite(&b, 1, 1, f);

					putc(b, f);
				}
				else break;
			}
			fclose(f);


		}

		//fclose(f);


	}
	system("pause");
	return 0;
}