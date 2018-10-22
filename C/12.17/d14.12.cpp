#include <iostream>
#include <Windows.h>
#include <stdio.h>
#include <conio.h>
using namespace std;
#pragma warning(disable : 4996) 



int main()
{
	char a;
	FILE * f ;
	char name[10];
	while (1)
	{
		system("cls");
		cout << "Fayl yaratmaq ucun 1\n";
		cout << "Silmek ucun 2\n";
		cout << "Faylin adini deyismek ucun 3\n";
		cout << "Fayla melumat yazmaq 4 \n";
		cout << "Faylin terkibini oxumaq\n";
		cout << "Faylin icini bosaldamq\n";

		a = _getch();

		if (a == '1')
		{
			f = fopen("test.txt", "w");

		}
		else if (a == '2')
		{
			remove("text.txt");
		}
		else if (a == '3')
		{
			char b[10];

			cout << "Indiki ad\n";
			cin >> b;
			cout << "Teze ad\n";
			cin >> name;
			rename(b, name);
		}
		else if (a == '4')
		{
			char b;
			f = fopen(name, "w");
			while (1)
			{
				b = _getch();
				if (a != 13)
				{
					//fwrite(&b, 1, 1, f);

					putc(b, f);
				}
				else break;
			}
		}
		else if (a == '5')
		{
			f = fopen(name, "w");
			char d[20];
			fgets(d, 20, f);
			cout << d;

			cout << '\n';
		}

		//fclose(f);

		
	}
	system("pause");
		return 0;
}