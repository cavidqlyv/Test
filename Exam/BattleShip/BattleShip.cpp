#include <iostream>
#include <windows.h>
#include <conio.h>
#include <cctype>
#include <time.h>

using namespace std;
//#define _CRT_SECURE_NO_WARNINGS
#pragma warning(disable : 4996)
#define KB_UP 72
#define KB_DOWN 80
#define KB_LEFT 75
#define KB_RIGHT 77
#define KB_ESCAPE 27
#define KB_ENTER 13
#define KB_SPACE 32
#define KB_A 65
#define KB_a 97
#define KB_R 82
#define KB_r 114

void automapgenerator1(int[10][10], int, int, int, int&);
void automapgenerator(int[10][10], int, int, int);
void start(int[10][10]);
void func_print(int[10][10], int[10][10], int, int);
void game(int[10][10], bool);
bool pc_Win(int[10][10]);
bool Win(int[10][10]);
void func(int[10][10], int, int);
void func1(int[10][10], int);
void stats(int[10][10], int[10][10]);
void Win_Scr(int[10][10], int[10][10]);
void PC_Win_Scr(int[10][10], int[10][10]);


void main()
{
	bool flag = true;

	int key;
	unsigned char frame[] = { 201,205,205,205,205,205,205,205,205,205,205 , 187 , '\0' };
	unsigned char frame1 = 186;
	unsigned char frame2[] = { 200,205,205,205,205,205,205,205,205,205,205 , 188 , '\0' };
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	int  menu1 = 2;
	int scr[10][10];
	FILE *f = fopen("save.bin", "rb");
	if (f)
	{
		fread(scr, sizeof(int), 100, f);
		fclose(f);
		flag = false;
	}

	while (1)
	{
		system("cls");
		SetConsoleTextAttribute(hConsole, 7);
		cout << "\t\t\t      ____        _   _   _         _____ _     _       \n";
		cout << "\t\t\t     |  _ \\      | | | | | |       / ____| |   (_)      \n";
		cout << "\t\t\t     | |_) | __ _| |_| |_| | ___  | (___ | |__  _ _ __  \n";
		cout << "\t\t\t     |  _ < / _` | __| __| |/ _ \\  \\___ \\| '_ \\| | '_ \\ \n";
		cout << "\t\t\t     | |_) | (_| | |_| |_| |  __/  ____) | | | | | |_) |\n";
		cout << "\t\t\t     |____/ \\__,_|\\__|\\__|_|\\___| |_____/|_| |_|_| .__/ \n";
		cout << "\t\t\t                                                 | |    \n";
		cout << "\t\t\t                                                 |_|    \n";
		if (flag)
		{
			if (menu1 == 2) menu1 = 0;
			else if (menu1 == -1) menu1 = 1;
		}
		else
		{
			if (menu1 == 3) menu1 = 0;
			else if (menu1 == -1) menu1 = 2;
		}
		if (flag)
		{
			if (menu1 == 0)
			{
				cout << "\n\n\t\t\t\t\t    ";
				cout << frame << "\n";
				cout << "\t\t\t\t\t    " << frame1;
				SetConsoleTextAttribute(hConsole, 112);
				cout << " New Game ";
				SetConsoleTextAttribute(hConsole, 7);
				cout << frame1;
				cout << "\n\t\t\t\t\t    " << frame1 << "   Exit   " << frame1 << "\n";
				cout << "\t\t\t\t\t    " << frame2 << "\n";
			}
			else if (menu1 == 1)
			{
				cout << "\n\n\t\t\t\t\t    ";
				cout << frame << "\n";
				cout << "\t\t\t\t\t    " << frame1 << " New Game " << frame1;
				cout << "\n\t\t\t\t\t    " << frame1;
				SetConsoleTextAttribute(hConsole, 112);
				cout << "   Exit   ";
				SetConsoleTextAttribute(hConsole, 7);
				cout << frame1;
				cout << "\n\t\t\t\t\t    " << frame2 << "\n";
			}

		}
		else
		{
			if (menu1 == 0)
			{
				cout << "\n\n\n\n\t\t\t\t\t";
				cout << frame << "\n";
				cout << "\t\t\t\t\t" << frame1;
				SetConsoleTextAttribute(hConsole, 112);
				cout << " Continue ";
				SetConsoleTextAttribute(hConsole, 7);
				cout << frame1;
				cout << "\n\t\t\t\t\t" << frame1 << " New Game " << frame1;
				cout << "\n\t\t\t\t\t" << frame1 << "   Exit   " << frame1 << "\n";
				cout << "\t\t\t\t\t" << frame2 << "\n";
			}
			else if (menu1 == 1)
			{
				cout << "\n\n\n\n\t\t\t\t\t";
				cout << frame << "\n";
				cout << "\t\t\t\t\t" << frame1;
				cout << " Continue ";
				cout << frame1;
				cout << "\n\t\t\t\t\t" << frame1;
				SetConsoleTextAttribute(hConsole, 112);
				cout << " New Game ";
				SetConsoleTextAttribute(hConsole, 7);
				cout << frame1;
				cout << "\n\t\t\t\t\t" << frame1 << "   Exit   " << frame1 << "\n";
				cout << "\t\t\t\t\t" << frame2 << "\n";

			}
			else if (menu1 == 2)
			{
				cout << "\n\n\n\n\t\t\t\t\t" << frame << "\n";
				cout << "\t\t\t\t\t" << frame1 << " Continue ";
				cout << frame1 << "\n\t\t\t\t\t" << frame1;
				cout << " New Game " << frame1;
				cout << "\n\t\t\t\t\t" << frame1;
				SetConsoleTextAttribute(hConsole, 112);
				cout << "   Exit   ";
				SetConsoleTextAttribute(hConsole, 7);
				cout << frame1 << "\n\t\t\t\t\t" << frame2 << "\n";
			}
		}
		key = _getch();
		if (key == KB_UP) menu1--;
		else if (key == KB_DOWN) menu1++;
		else if (key == KB_ENTER)
		{
			if (flag)
			{
				if (menu1 == 0)
				{
					for (int i = 0; i < 10; i++)
						for (int j = 0; j < 10; j++)
							scr[i][j] = 0;
					start(scr);
				}
				else if (menu1 == 1)return;
			}
			else
			{
				if (menu1 == 0)game(scr, true);
				else if (menu1 == 1)
				{
					for (int i = 0; i < 10; i++)
						for (int j = 0; j < 10; j++)
							scr[i][j] = 0;
					start(scr);
				}
				else if (menu1 == 2)return;
			}
		}
	}
	system("pause");
}

void automapgenerator1(int scr[10][10], int size, int shipsize, int shipcount, int &count)
{
	int posx, posy;
	int pos;
	int countship = 0;
	srand(time(0));
	while (countship < shipcount)
	{
		posx = rand() % size;
		posy = rand() % size;
		int tempx = posx;
		int tempy = posy;
		int yerlesme = 1;
		pos = rand() % 4;
		for (int i = 0; i < shipsize; i++)
		{
			if (posx < 0 || posx >= size || posy < 0 || posy >= size)
			{
				yerlesme = 0;
			}
			if ((scr[posx][posy] == 20 || scr[posx][posy + 1] == 20 || scr[posx][posy - 1] == 20 ||
				scr[posx + 1][posy] == 20 || scr[posx + 1][posy + 1] == 20 || scr[posx + 1][posy - 1] == 20 ||
				scr[posx - 1][posy] == 20 || scr[posx - 1][posy + 1] == 20 || scr[posx - 1][posy - 1] == 20)
				||
				(scr[posx][posy] == 21 || scr[posx][posy + 1] == 21 || scr[posx][posy - 1] == 21 ||
					scr[posx + 1][posy] == 21 || scr[posx + 1][posy + 1] == 21 || scr[posx + 1][posy - 1] == 21 ||
					scr[posx - 1][posy] == 21 || scr[posx - 1][posy + 1] == 21 || scr[posx - 1][posy - 1] == 21)
				||
				(scr[posx][posy] == 22 || scr[posx][posy + 1] == 22 || scr[posx][posy - 1] == 22 ||
					scr[posx + 1][posy] == 22 || scr[posx + 1][posy + 1] == 22 || scr[posx + 1][posy - 1] == 22 ||
					scr[posx - 1][posy] == 22 || scr[posx - 1][posy + 1] == 22 || scr[posx - 1][posy - 1] == 22)
				||
				(scr[posx][posy] == 23 || scr[posx][posy + 1] == 23 || scr[posx][posy - 1] == 23 ||
					scr[posx + 1][posy] == 23 || scr[posx + 1][posy + 1] == 23 || scr[posx + 1][posy - 1] == 23 ||
					scr[posx - 1][posy] == 23 || scr[posx - 1][posy + 1] == 23 || scr[posx - 1][posy - 1] == 23)
				||
				(scr[posx][posy] == 24 || scr[posx][posy + 1] == 24 || scr[posx][posy - 1] == 24 ||
					scr[posx + 1][posy] == 24 || scr[posx + 1][posy + 1] == 24 || scr[posx + 1][posy - 1] == 24 ||
					scr[posx - 1][posy] == 24 || scr[posx - 1][posy + 1] == 24 || scr[posx - 1][posy - 1] == 24)
				||
				(scr[posx][posy] == 25 || scr[posx][posy + 1] == 25 || scr[posx][posy - 1] == 25 ||
					scr[posx + 1][posy] == 25 || scr[posx + 1][posy + 1] == 25 || scr[posx + 1][posy - 1] == 25 ||
					scr[posx - 1][posy] == 25 || scr[posx - 1][posy + 1] == 25 || scr[posx - 1][posy - 1] == 25)
				||
				(scr[posx][posy] == 26 || scr[posx][posy + 1] == 2 || scr[posx][posy - 1] == 2 ||
					scr[posx + 1][posy] == 26 || scr[posx + 1][posy + 1] == 26 || scr[posx + 1][posy - 1] == 26 ||
					scr[posx - 1][posy] == 26 || scr[posx - 1][posy + 1] == 26 || scr[posx - 1][posy - 1] == 26)
				||
				(scr[posx][posy] == 27 || scr[posx][posy + 1] == 27 || scr[posx][posy - 1] == 27 ||
					scr[posx + 1][posy] == 27 || scr[posx + 1][posy + 1] == 27 || scr[posx + 1][posy - 1] == 27 ||
					scr[posx - 1][posy] == 27 || scr[posx - 1][posy + 1] == 27 || scr[posx - 1][posy - 1] == 27)
				||
				(scr[posx][posy] == 28 || scr[posx][posy + 1] == 28 || scr[posx][posy - 1] == 28 ||
					scr[posx + 1][posy] == 28 || scr[posx + 1][posy + 1] == 28 || scr[posx + 1][posy - 1] == 28 ||
					scr[posx - 1][posy] == 28 || scr[posx - 1][posy + 1] == 28 || scr[posx - 1][posy - 1] == 28)
				||
				(scr[posx][posy] == 29 || scr[posx][posy + 1] == 29 || scr[posx][posy - 1] == 29 ||
					scr[posx + 1][posy] == 29 || scr[posx + 1][posy + 1] == 29 || scr[posx + 1][posy - 1] == 29 ||
					scr[posx - 1][posy] == 29 || scr[posx - 1][posy + 1] == 29 || scr[posx - 1][posy - 1] == 29))
			{
				yerlesme = 0;
			}
			if (pos == 0)
			{
				posx++;
			}
			else if (pos == 1)
			{
				posx--;
			}
			else if (pos == 2)
			{
				posy++;
			}
			else if (pos == 3)
			{
				posy--;
			}
		}
		if (yerlesme == 1)
		{
			posx = tempx;
			posy = tempy;
			for (int i = 0; i < shipsize; i++)
			{
				scr[posx][posy] = count;
				if (pos == 0)
				{
					posx++;
				}
				else if (pos == 1)
				{
					posx--;
				}
				else if (pos == 2)
				{
					posy++;
				}
				else if (pos == 3)
				{
					posy--;
				}
			}
			count++;
			countship++;
		}
	}
}

void automapgenerator(int scr[10][10], int size, int shipsize, int shipcount)
{
	int posx, posy;
	int pos;
	int countship = 0;
	srand(time(0));
	while (countship < shipcount)
	{
		posx = rand() % size;
		posy = rand() % size;
		int tempx = posx;
		int tempy = posy;
		int yerlesme = 1;
		pos = rand() % 4;
		for (int i = 0; i < shipsize; i++)
		{
			if (posx < 0 || posx >= size || posy < 0 || posy >= size)
			{
				yerlesme = 0;
			}
			if (scr[posx][posy] == 2 || scr[posx][posy + 1] == 2 || scr[posx][posy - 1] == 2 ||
				scr[posx + 1][posy] == 2 || scr[posx + 1][posy + 1] == 2 || scr[posx + 1][posy - 1] == 2 ||
				scr[posx - 1][posy] == 2 || scr[posx - 1][posy + 1] == 2 || scr[posx - 1][posy - 1] == 2)
			{
				yerlesme = 0;
			}
			if (pos == 0)
			{
				posx++;
			}
			else if (pos == 1)
			{
				posx--;
			}
			else if (pos == 2)
			{
				posy++;
			}
			else if (pos == 3)
			{
				posy--;
			}
		}
		if (yerlesme == 1)
		{
			posx = tempx;
			posy = tempy;
			for (int i = 0; i < shipsize; i++)
			{
				scr[posx][posy] = 2;
				if (pos == 0)
				{
					posx++;
				}
				else if (pos == 1)
				{
					posx--;
				}
				else if (pos == 2)
				{
					posy++;
				}
				else if (pos == 3)
				{
					posy--;
				}
			}
			countship++;
		}
	}
}

void start(int scr[10][10])
{
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	char frame[] = { 201,205,205,205,203,205,205,205,203,205,205,205,203,205,205,205,203,205,205,205,203,205,205,205,203,205,205,205,203,205,205,205,203,205,205,205,203,205,205,205,187,'\0' };
	char frame1 = 186;
	char frame2[] = { 204,205,205,205,206,205,205,205,206,205,205,205,206,205,205,205,206,205,205,205,206,205,205,205,206,205,205,205,206,205,205,205,206,205,205,205,206,205,205,205,185,'\0' };
	char frame3[] = { 200,205,205,205,202,205,205,205,202,205,205,205,202,205,205,205,202,205,205,205,202,205,205,205,202,205,205,205,202,205,205,205,202,205,205,205,202,205,205,205,188,'\0', };
	int a = 3;
	int b = 1;
	int key;
	int menu = 0;
	int num = 0;
	int num1 = 0;
	bool flag = true;
	bool flag1 = true;
	bool flag2 = true;

	bool game_flag = false;
	bool ship_flag = true;
	bool rotate = false;
	int size;
	int ship[4] = { 1,2,3,4 };
	int t = 0;

	system("cls");

	while (1)
	{
		//system("cls");
		SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), { 0,0 });

		for (int i = 0; i < 4; i++)
		{
			if (ship[i] == 0) game_flag = true;
			else
			{
				game_flag = false;
				break;
			}
		}
		if (game_flag) system("cls");

		SetConsoleTextAttribute(hConsole, 3);
		cout << frame << "\n";
		if (flag)
			func(scr, 2, 1);
		for (int j = 0; j < 9; j++)
		{
			a = 3;
			b = 1;
			t = 0;
			for (int i = 0; i < 41; i++)
			{
				if (i == 0)
					cout << frame1;

				if (i == a)
				{
					cout << frame1;
					a += 4;
				}
				else if (i == b)
				{
					if (scr[j][t] == 0 || scr[j][t] == 1)
						cout << " ";

					else if (scr[j][t] == 2)
					{
						SetConsoleTextAttribute(hConsole, 10);
						cout << "x";
						SetConsoleTextAttribute(hConsole, 3);
					}
					else if (scr[j][t] == 6)
					{
						SetConsoleTextAttribute(hConsole, 10);
						cout << "x";
						SetConsoleTextAttribute(hConsole, 3);
					}
					else if (scr[j][t] == 7)
					{
						SetConsoleTextAttribute(hConsole, 12);
						cout << "x";
						SetConsoleTextAttribute(hConsole, 3);
					}
					else if (scr[j][t] == 8)
					{
						SetConsoleTextAttribute(hConsole, 12);
						cout << "x";
						SetConsoleTextAttribute(hConsole, 3);
					}
					b += 4;
					t++;
				}
				else cout << ' ';
			}
			cout << "\n";
			cout << frame2 << "\n";
			t = 0;
		}
		a = 3;
		b = 1;
		t = 0;
		for (int i = 0; i < 41; i++)
		{
			if (i == 0)
				cout << frame1;

			if (i == a)
			{
				cout << frame1;
				a += 4;
			}
			else if (i == b)
			{
				if (scr[9][t] == 0 || scr[9][t] == 1)
					cout << " ";

				else if (scr[9][t] == 2)
				{
					SetConsoleTextAttribute(hConsole, 10);
					cout << "x";
					SetConsoleTextAttribute(hConsole, 3);
				}
				else if (scr[9][t] == 6)
				{
					SetConsoleTextAttribute(hConsole, 10);
					cout << "x";
					SetConsoleTextAttribute(hConsole, 3);
				}
				else if (scr[9][t] == 7)
				{
					SetConsoleTextAttribute(hConsole, 12);
					cout << "x";
					SetConsoleTextAttribute(hConsole, 3);
				}
				else if (scr[9][t] == 8)
				{
					SetConsoleTextAttribute(hConsole, 12);
					cout << "x";
					SetConsoleTextAttribute(hConsole, 3);
				}
				b += 4;
				t++;
			}
			else cout << ' ';
		}
		cout << '\n' << frame3 << "\n";

		if (menu == -1) menu = 3;
		else if (menu == 4)menu = 0;

		if (ship[0] == 0 && menu == 0)menu = 1;
		if (ship[1] == 0 && menu == 1)menu = 2;
		if (ship[2] == 0 && menu == 2)menu = 3;
		if (ship[3] == 0 && menu == 3)menu = 0;

		cout << "\n";
		SetConsoleTextAttribute(hConsole, 7);

		if (menu == 0)
		{
			if (ship[0] != 0)
			{
				SetConsoleTextAttribute(hConsole, 112);
				cout << "Aircraft carrier\t" << ship[0];
				SetConsoleTextAttribute(hConsole, 7);
			}
			if (ship[1] != 0)
				cout << "\nCruiser\t\t\t" << ship[1] << "\n";
			if (ship[2] != 0)
				cout << "Submarine\t\t" << ship[2] << "\n";
			if (ship[3] != 0)
				cout << "Destroyer\t\t" << ship[3] << "\n";
		}
		else if (menu == 1)
		{
			if (ship[0] != 0)
				cout << "Aircraft carrier\t" << ship[0] << "\n";
			if (ship[1] != 0)
			{
				SetConsoleTextAttribute(hConsole, 112);
				cout << "Cruiser\t\t\t" << ship[1];
				SetConsoleTextAttribute(hConsole, 7);
			}
			if (ship[2] != 0)
				cout << "\nSubmarine\t\t" << ship[2] << "\n";
			if (ship[3] != 0)
				cout << "Destroyer\t\t" << ship[3] << "\n";
		}
		else if (menu == 2)
		{
			if (ship[0] != 0)
				cout << "Aircraft carrier\t" << ship[0] << "\n";
			if (ship[1] != 0)
				cout << "Cruiser\t\t\t" << ship[1] << "\n";
			if (ship[2] != 0)
			{
				SetConsoleTextAttribute(hConsole, 112);
				cout << "Submarine\t\t" << ship[2];
				SetConsoleTextAttribute(hConsole, 7);
			}
			if (ship[3] != 0)
				cout << "\nDestroyer\t\t" << ship[3] << "\n";
		}
		else if (menu == 3)
		{
			if (ship[0] != 0)
				cout << "Aircraft carrier\t" << ship[0] << "\n";
			if (ship[1] != 0)
				cout << "Cruiser\t\t\t" << ship[1] << "\n";
			if (ship[2] != 0)
				cout << "Submarine\t\t" << ship[2] << "\n";
			if (ship[3] != 0)
			{
				SetConsoleTextAttribute(hConsole, 112);
				cout << "Destroyer\t\t" << ship[3];
				SetConsoleTextAttribute(hConsole, 7);
				cout << "\n";
			}
			cout << "\nPress < A > for auto\n";
			cout << "\nPress < R > for reset\n";
		}

		if (game_flag)
		{
			//cout << "Start\n";
			SetConsoleTextAttribute(hConsole, 3);

			cout << "\t   _____ _             _   \n";
			cout << "\t  / ____| |           | |  \n";
			cout << "\t | (___ | |_ __ _ _ __| |_ \n";
			cout << "\t  \\___ \\| __/ _` | '__| __|\n";
			cout << "\t  ____) | || (_| | |  | |_ \n";
			cout << "\t |_____/ \\__\\__,_|_|   \\__|\n";
			SetConsoleTextAttribute(hConsole, 7);

			key = _getch();
			if (key == KB_ENTER)
			{
				game(scr, false);
			}
			if (key == KB_R || key == KB_r)
			{
				for (int i = 0; i < 10; i++)
					for (int j = 0; j < 10; j++)
						scr[i][j] = 0;
				for (int i = 0; i < 4; i++)
					ship[i] = i + 1;
				system("cls");
				continue;
			}
		}
		if (flag)
		{
			key = _getch();
			if (key == KB_DOWN) menu++;
			else if (key == KB_UP) menu--;
			else if (key == KB_ESCAPE) return;
			if (key == KB_R || key == KB_r)
			{
				for (int i = 0; i < 10; i++)
					for (int j = 0; j < 10; j++)
						scr[i][j] = 0;

				for (int i = 0; i < 4; i++)
					ship[i] = i + 1;
				system("cls");
			}
			else if (key == KB_A || key == KB_a)
			{
				automapgenerator(scr, 10, 4, 1);
				automapgenerator(scr, 10, 3, 2);
				automapgenerator(scr, 10, 2, 3);
				automapgenerator(scr, 10, 1, 4);
				for (int i = 0; i < 4; i++)
				{
					ship[i] = 0;
				}
			}
			else if (key == KB_ENTER)
			{
				flag = false;
				rotate = false;
			}
		}
		else
		{
			if (flag1)
			{
				if (menu == 0) size = 4;
				else if (menu == 1)size = 3;
				else if (menu == 2)size = 2;
				else if (menu == 3)size = 1;
				num = 0;
				num1 = 0;

				for (int i = num; i < num + size; i++)
				{
					if (scr[i][num1] == 0)
						scr[i][num1] = 6;
					if (scr[i][num1] == 1)
						scr[i][num1] = 7;
					if (scr[i][num1] == 2)
						scr[i][num1] = 8;
				}
				flag1 = false;
			}
			else
			{
				key = _getch();
				if (key == KB_RIGHT)
				{
					if (!rotate&& num1 < 9) // duz
					{
						num1++;
						for (int i = num; i < size + num; i++)
						{
							scr[i][num1] += 6;
							scr[i][num1 - 1] -= 6;
						}
					}
					else if (rotate && num1 + size < 10)  // eyri
					{
						if (scr[num][num1] == 6)
							scr[num][num1] = 0;
						if (scr[num][num1] == 7)
							scr[num][num1] = 1;
						if (scr[num][num1] == 8)
							scr[num][num1] = 2;

						num1++;
						for (int i = num1; i < size + num1; i++)
						{
							if (scr[num][i] == 0)
								scr[num][i] = 6;
							if (scr[num][i] == 1)
								scr[num][i] = 7;
							if (scr[num][i] == 2)
								scr[num][i] = 8;
						}
					}
				}
				else if (key == KB_LEFT && num1 > 0)
				{
					if (!rotate)
					{
						num1--;
						for (int i = num; i < size + num; i++)
						{
							scr[i][num1] += 6;
							scr[i][num1 + 1] -= 6;
						}
					}
					else if (rotate)
					{
						if (scr[num][num1 + size - 1] == 6)
							scr[num][num1 + size - 1] = 0;
						if (scr[num][num1 + size - 1] == 7)
							scr[num][num1 + size - 1] = 1;
						if (scr[num][num1 + size - 1] == 8)
							scr[num][num1 + size - 1] = 2;
						num1--;
						for (int i = num1; i < size + num1; i++)
						{

							if (scr[num][i] == 0)
								scr[num][i] = 6;
							if (scr[num][i] == 1)
								scr[num][i] = 7;
							if (scr[num][i] == 2)
								scr[num][i] = 8;
						}
					}
				}
				else if (key == KB_ESCAPE) return;
				else if (key == KB_DOWN)
				{
					if (!rotate&& num + size - 1 < 9)
					{
						if (scr[num][num1] == 6)
							scr[num][num1] = 0;
						if (scr[num][num1] == 7)
							scr[num][num1] = 1;
						if (scr[num][num1] == 8)
							scr[num][num1] = 2;

						num++;
						for (int i = num; i < size + num; i++)
						{
							if (scr[i][num1] == 0)
								scr[i][num1] = 6;
							if (scr[i][num1] == 1)
								scr[i][num1] = 7;
							if (scr[i][num1] == 2)
								scr[i][num1] = 8;
						}
					}
					else if (rotate&& num < 9)
					{
						num++;
						for (int i = num1; i < size + num1; i++)
						{
							scr[num][i] += 6;
							scr[num - 1][i] -= 6;
						}
					}
				}
				else if (key == KB_UP && num > 0)
				{
					if (!rotate)
					{
						if (scr[num + size - 1][num1] == 6)
							scr[num + size - 1][num1] = 0;
						if (scr[num + size - 1][num1] == 7)
							scr[num + size - 1][num1] = 1;
						if (scr[num + size - 1][num1] == 8)
							scr[num + size - 1][num1] = 2;
						num--;
						for (int i = num; i < size + num; i++)
						{
							if (scr[i][num1] == 0)
								scr[i][num1] = 6;
							if (scr[i][num1] == 1)
								scr[i][num1] = 7;
							if (scr[i][num1] == 2)
								scr[i][num1] = 8;
						}
					}
					else if (rotate)
					{
						num--;
						for (int i = num1; i < size + num1; i++)
						{
							scr[num][i] += 6;
							scr[num + 1][i] -= 6;
						}
					}
				}
				else if (key == KB_SPACE)
				{

					if (!rotate && num1 + size < 11)
					{
						for (int i = num, j = num1; i < num + size; i++, j++)
						{
							scr[i][num1] -= 6;
							scr[num][j] += 6;
							rotate = true;
						}
					}
					else if (rotate && num + size < 11)
					{
						for (int i = num, j = num1; i < num + size; i++, j++)
						{
							scr[i][num1] += 6;
							scr[num][j] -= 6;
							rotate = false;
						}
					}
				}
				else if (key == KB_ENTER)
				{
					ship_flag = true;
					for (int i = 0; i < 10; i++)
						for (int j = 0; j < 10; j++)
						{
							if (scr[i][j] == 7 || scr[i][j] == 8)
								ship_flag = false;
						}
					if (ship_flag)
					{
						flag1 = true;
						flag = true;
						if (menu == 0) ship[0]--;
						else if (menu == 1)ship[1]--;
						else if (menu == 2)ship[2]--;
						else if (menu == 3)ship[3]--;
						for (int i = 0; i < 10; i++)
							for (int j = 0; j < 10; j++)
								if (scr[i][j] == 6) scr[i][j] = 2;
					}
					system("cls");
				}
			}
		}
	}
}

void func_print(int scr[10][10], int scr_pc[10][10], int num, int num1)
{

	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

	int b = 1, t = 0;
	int a = 3;

	char frame[] = { 201,205,205,205,203,205,205,205,203,205,205,205,203,205,205,205,203,205,205,205,203,205,205,205,203,205,205,205,203,205,205,205,203,205,205,205,203,205,205,205,187,'\0' };
	char frame1 = 186;
	char frame2[] = { 204,205,205,205,206,205,205,205,206,205,205,205,206,205,205,205,206,205,205,205,206,205,205,205,206,205,205,205,206,205,205,205,206,205,205,205,206,205,205,205,185,'\0' };
	char frame3[] = { 200,205,205,205,202,205,205,205,202,205,205,205,202,205,205,205,202,205,205,205,202,205,205,205,202,205,205,205,202,205,205,205,202,205,205,205,202,205,205,205,188,'\0' };

	//system("cls");
	SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), { 0,0 });
	SetConsoleTextAttribute(hConsole, 3);

	cout << frame << "\t\t" << frame << "\n";
	for (int j = 0; j < 9; j++)
	{
		a = 3;
		b = 1;
		t = 0;
		for (int i = 0; i < 41; i++)
		{

			if (i == 0)
				cout << frame1;

			if (i == a)
			{
				cout << frame1;
				a += 4;
			}
			else if (i == b)
			{
				if (scr[j][t] == 0 || scr[j][t] == 1)
				{
					cout << " ";
				}
				else if (scr[j][t] == 2)
				{
					SetConsoleTextAttribute(hConsole, 10);
					cout << "x";
					SetConsoleTextAttribute(hConsole, 3);
				}
				else if (scr[j][t] == 10)
				{
					SetConsoleTextAttribute(hConsole, 4);
					cout << "*";
					SetConsoleTextAttribute(hConsole, 3);
				}
				else if (scr[j][t] == 15)
				{
					SetConsoleTextAttribute(hConsole, 6);
					cout << "o";
					SetConsoleTextAttribute(hConsole, 3);
				}
				t++;
				b += 4;
			}
			else cout << " ";

		}
		cout << "\t\t";
		a = 3;
		b = 1;
		t = 0;

		for (int i = 0; i < 41; i++)
		{
			if (i == 0)
				cout << frame1;

			if (i == a)
			{
				cout << frame1;
				a += 4;
			}
			else if (i == b)
			{
				if (scr_pc[j][t] == 0 || scr_pc[j][t] == 1)
				{
					if (num == j && num1 == t)
					{
						SetConsoleTextAttribute(hConsole, 112);
						cout << " ";
						SetConsoleTextAttribute(hConsole, 3);
					}
					else cout << " ";
				}
				else if (scr_pc[j][t] == 20 || scr_pc[j][t] == 21 || scr_pc[j][t] == 22 || scr_pc[j][t] == 23 || scr_pc[j][t] == 24 || scr_pc[j][t] == 25 || scr_pc[j][t] == 26 || scr_pc[j][t] == 27 || scr_pc[j][t] == 28 || scr_pc[j][t] == 29)
				{
					if (num == j && num1 == t)
					{
						SetConsoleTextAttribute(hConsole, 112);
						cout << " ";
						SetConsoleTextAttribute(hConsole, 3);
					}

					else
					{
						cout << " ";
					}
				}
				else if (scr_pc[j][t] == 30 || scr_pc[j][t] == 31 || scr_pc[j][t] == 32 || scr_pc[j][t] == 33 || scr_pc[j][t] == 34 || scr_pc[j][t] == 35 || scr_pc[j][t] == 36 || scr_pc[j][t] == 37 || scr_pc[j][t] == 38 || scr_pc[j][t] == 39)

				{
					if (num == j && num1 == t)
					{
						SetConsoleTextAttribute(hConsole, 112);
						cout << "*";
						SetConsoleTextAttribute(hConsole, 3);
					}

					else
					{
						SetConsoleTextAttribute(hConsole, 4);

						cout << "*";
						SetConsoleTextAttribute(hConsole, 3);

					}
				}
				else if (scr_pc[j][t] == 15)
				{
					if (num == j && num1 == t)
					{
						SetConsoleTextAttribute(hConsole, 112);
						cout << "o";
						SetConsoleTextAttribute(hConsole, 3);
					}

					else
					{
						SetConsoleTextAttribute(hConsole, 6);
						cout << "o";
						SetConsoleTextAttribute(hConsole, 3);
					}
				}

				//cout << scr_pc[j][t];
				t++;
				b += 4;
			}
			else cout << " ";
		}
		cout << "\n";
		cout << frame2 << "\t\t" << frame2 << "\n";
	}
	a = 3;
	b = 1;
	t = 0;
	for (int i = 0; i < 41; i++)
	{
		if (i == 0)
			cout << frame1;

		if (i == a)
		{
			cout << frame1;
			a += 4;
		}
		else if (i == b)
		{
			if (scr[9][t] == 0 || scr[9][t] == 1)
			{
				cout << " ";
			}
			else if (scr[9][t] == 2)
			{
				SetConsoleTextAttribute(hConsole, 10);
				cout << "x";
				SetConsoleTextAttribute(hConsole, 3);
			}
			else if (scr[9][t] == 10)
			{
				SetConsoleTextAttribute(hConsole, 12);
				cout << "*";
				SetConsoleTextAttribute(hConsole, 3);
			}
			else if (scr[9][t] == 15)
			{
				SetConsoleTextAttribute(hConsole, 6);
				cout << "o";
				SetConsoleTextAttribute(hConsole, 3);

			}
			t++;
			b += 4;
		}
		else cout << " ";
	}
	cout << "\t\t";
	a = 3;
	b = 1;
	t = 0;
	for (int i = 0; i < 41; i++)
	{
		if (i == 0)
			cout << frame1;

		if (i == a)
		{
			cout << frame1;
			a += 4;
		}
		else if (i == b)
		{
			if (scr_pc[9][t] == 0 || scr_pc[9][t] == 1)
			{
				if (num == 9 && num1 == t)
				{
					SetConsoleTextAttribute(hConsole, 112);
					cout << " ";
					SetConsoleTextAttribute(hConsole, 3);
				}
				else cout << " ";
			}
			else if (scr_pc[9][t] == 20 || scr_pc[9][t] == 21 || scr_pc[9][t] == 22 || scr_pc[9][t] == 23 || scr_pc[9][t] == 24 || scr_pc[9][t] == 25 || scr_pc[9][t] == 26 || scr_pc[9][t] == 27 || scr_pc[9][t] == 28 || scr_pc[9][t] == 29)
			{
				if (num == 9 && num1 == t)
				{
					SetConsoleTextAttribute(hConsole, 112);
					cout << " ";
					SetConsoleTextAttribute(hConsole, 3);
				}
				else
				{
					cout << " ";
				}
			}
			else if (scr_pc[9][t] == 30 || scr_pc[9][t] == 31 || scr_pc[9][t] == 32 || scr_pc[9][t] == 33 || scr_pc[9][t] == 34 || scr_pc[9][t] == 35 || scr_pc[9][t] == 36 || scr_pc[9][t] == 37 || scr_pc[9][t] == 38 || scr_pc[9][t] == 39)

			{
				if (num == 9 && num1 == t)
				{
					SetConsoleTextAttribute(hConsole, 112);
					cout << "*";
					SetConsoleTextAttribute(hConsole, 3);
				}
				else
				{
					SetConsoleTextAttribute(hConsole, 4);
					cout << "*";
					SetConsoleTextAttribute(hConsole, 3);
				}
			}
			else if (scr_pc[9][t] == 15)
			{
				if (num == 9 && num1 == t)
				{
					SetConsoleTextAttribute(hConsole, 112);
					cout << "o";
					SetConsoleTextAttribute(hConsole, 3);
				}
				else
				{
					SetConsoleTextAttribute(hConsole, 6);
					cout << "o";
					SetConsoleTextAttribute(hConsole, 3);
				}
			}
			t++;
			b += 4;
		}
		else cout << " ";
	}
	cout << '\n' << frame3 << "\t\t" << frame3 << "\n";
}

void game(int scr[10][10], bool save = false)
{
	int key;
	int count = 20;
	int right = 0, left = 0, up = 0, down = 0;
	bool flag = true;
	bool pc_flag = true;
	bool win = false;
	bool pc_win = false;
	int num = 0, num1 = 0;
	int tmpnum, tmpnum1;
	int rotate = 0;
	int pc_num = 0, pc_num1 = 0;
	system("cls");
	int scr_pc[10][10];
	if (!save)
	{
		for (int i = 0; i < 10; i++)
			for (int j = 0; j < 10; j++)
				scr_pc[i][j] = 0;
		automapgenerator1(scr_pc, 10, 2, 3, count);
		automapgenerator1(scr_pc, 10, 1, 4, count);
		automapgenerator1(scr_pc, 10, 4, 1, count);
		automapgenerator1(scr_pc, 10, 3, 2, count);
	}
	else
	{
		FILE *f = fopen("save1.bin", "rb");
		if (f)
		{
			fread(scr_pc, sizeof(int), 100, f);
			fclose(f);
		}
	}



	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

	while (1)
	{
		func_print(scr, scr_pc, num, num1);

		if (flag)
		{
			//Sleep(500);
			//cout << "Your turn\n";
			key = _getch();
			if (key == KB_DOWN && num < 9) num++;
			else if (key == KB_UP && num > 0) num--;
			else if (key == KB_RIGHT && num1 < 9) num1++;
			else if (key == KB_LEFT && num1 > 0) num1--;
			else if (key == KB_ENTER && flag)
			{
				if (scr_pc[num][num1] == 20 || scr_pc[num][num1] == 21 || scr_pc[num][num1] == 22 || scr_pc[num][num1] == 23 || scr_pc[num][num1] == 24
					|| scr_pc[num][num1] == 25 || scr_pc[num][num1] == 26 || scr_pc[num][num1] == 27 || scr_pc[num][num1] == 28 || scr_pc[num][num1] == 29)
				{
					scr_pc[num][num1] += 10;
					func1(scr_pc, scr_pc[num][num1]);
				}
				else if (scr_pc[num][num1] == 0)
				{
					scr_pc[num][num1] = 15;
					flag = false;
				}
				else if (scr_pc[num][num1] == 15 || scr_pc[num][num1] == 10)
				{
					continue;
				}
			}
			else if (key == KB_ESCAPE)
			{
				FILE *file = fopen("save.bin", "wb");
				fwrite(scr, sizeof(int), 100, file);
				fclose(file);
				FILE *file1 = fopen("save1.bin", "wb");
				fwrite(scr_pc, sizeof(int), 100, file1);
				fclose(file1);
				main();
			}
		}
		else
		{
			//Sleep(500);
			cout << "PC turn\n";

			srand(time(0));
			if (pc_flag)
			{
				pc_num = rand() % 10;
				pc_num1 = rand() % 10;

				if (scr[pc_num][pc_num1] == 2)
				{
					scr[pc_num][pc_num1] = 10;
					down = 0;
					up = 0;
					left = 0;
					right = 0;
					rotate = 0;
					tmpnum = pc_num;
					tmpnum1 = pc_num1;
					while (1)
					{
						if (scr[tmpnum][tmpnum1 + 1] == 2 && tmpnum1 < 10)
						{
							right++;
							tmpnum1++;
						}
						else break;
					}
					tmpnum = pc_num;
					tmpnum1 = pc_num1;
					while (1)
					{
						if (scr[tmpnum][tmpnum1 - 1] == 2 && tmpnum1 > -1)
						{
							left++;
							tmpnum1--;
						}
						else break;
					}
					tmpnum = pc_num;
					tmpnum1 = pc_num1;
					while (1)
					{
						if (scr[tmpnum + 1][tmpnum1] == 2 && tmpnum < 10)
						{
							down++;
							tmpnum++;
						}
						else break;
					}
					tmpnum = pc_num;
					tmpnum1 = pc_num1;
					while (1)
					{
						if (scr[tmpnum - 1][tmpnum1] == 2 && tmpnum > -1)
						{
							up++;
							tmpnum--;
						}
						else break;
					}
					tmpnum = pc_num;
					tmpnum1 = pc_num1;
					pc_flag = false; // vurub qurtarannan sora
					continue;
				}
				else if (scr[pc_num][pc_num1] == 1 || scr[pc_num][pc_num1] == 0)
				{
					scr[pc_num][pc_num1] = 15;
					flag = true;
					continue;
				}
				else if (scr[pc_num][pc_num1] == 15 || scr[pc_num][pc_num1] == 10)
				{
					continue;
				}
			}
			else
			{
				if (down <= 0 && up <= 0 && left <= 0 && right <= 0)
				{
					func(scr, 10, 15);
					pc_flag = true;
					flag = true;
					continue;
				}
				if (up > -1 && scr[tmpnum - 1][tmpnum1] == 2 && (rotate == 1 || rotate == 0))
				{
					up--;
					scr[tmpnum - 1][tmpnum1] = 10;
					rotate = 1;
					tmpnum--;
					if (down <= 0 && up <= 0 && left <= 0 && right <= 0)
					{
						func(scr, 10, 15);
						pc_flag = true;
						flag = true;
						continue;
					}
				}
				else if (up > -1 && (scr[tmpnum - 1][tmpnum1] == 0 || scr[tmpnum - 1][tmpnum1] == 1) && (rotate == 1 || rotate == 0))
				{
					up--;
					scr[tmpnum - 1][tmpnum1] = 15;
					flag = true;
					tmpnum = pc_num;
					continue;
				}
				else if (up > -1 && (scr[tmpnum - 1][tmpnum1] == 15) && (rotate == 1 || rotate == 0))
				{
					up--;
					tmpnum = pc_num;
					continue;
				}
				if (left > -1 && scr[tmpnum][tmpnum1 - 1] == 2 && (rotate == 0 || rotate == 2))
				{
					left--;
					scr[tmpnum][tmpnum1 - 1] = 10;
					rotate = 2;
					tmpnum1--;
					if (down <= 0 && up <= 0 && left <= 0 && right <= 0)
					{
						func(scr, 10, 15);
						pc_flag = true;
						flag = true;
						continue;
					}
				}
				else if (left > -1 && (scr[tmpnum][tmpnum1 - 1] == 0 || scr[tmpnum][tmpnum1 - 1] == 1) && (rotate == 0 || rotate == 2))
				{
					left--;
					scr[tmpnum][tmpnum1 - 1] = 15;
					flag = true;
					tmpnum = pc_num;
					tmpnum1 = pc_num1;
					continue;
				}
				else if (left > -1 && scr[tmpnum][tmpnum1 - 1] == 15 && (rotate == 0 || rotate == 2))
				{
					left--;
					tmpnum = pc_num;
					tmpnum1 = pc_num1;
					continue;
				}
				if (right > -1 && scr[tmpnum][tmpnum1 + 1] == 2 && (rotate == 0 || rotate == 2))
				{
					right--;
					scr[tmpnum][tmpnum1 + 1] = 10;
					rotate = 2;
					tmpnum1++;
					if (down <= 0 && up <= 0 && left <= 0 && right <= 0)
					{
						func(scr, 10, 15);
						pc_flag = true;
						flag = true;
						continue;
					}
				}
				else if (right > -1 && (scr[tmpnum][tmpnum1 + 1] == 0 || scr[tmpnum][tmpnum1 + 1] == 1) && (rotate == 0 || rotate == 2))
				{
					right--;
					scr[tmpnum][tmpnum1 + 1] = 15;
					flag = true;
					tmpnum = pc_num;
					tmpnum1 = pc_num1;
					continue;
				}
				else if (right > -1 && (scr[tmpnum][tmpnum1 + 1] == 15) && (rotate == 0 || rotate == 2))
				{
					right--;
					tmpnum = pc_num;
					tmpnum1 = pc_num1;
					continue;
				}
				if (down > -1 && scr[tmpnum + 1][tmpnum1] == 2 && (rotate == 0 || rotate == 1))
				{
					down--;
					scr[tmpnum + 1][tmpnum1] = 10;
					rotate = 1;
					tmpnum++;
					if (down <= 0 && up <= 0 && left <= 0 && right <= 0)
					{
						func(scr, 10, 15);
						pc_flag = true;
						flag = true;
						continue;
					}
				}
				else if (down > -1 && (scr[tmpnum + 1][tmpnum1] == 0 || scr[tmpnum + 1][tmpnum1] == 1) && (rotate == 0 || rotate == 1))
				{
					down--;
					scr[tmpnum + 1][tmpnum1] = 15;
					flag = true;
					tmpnum = pc_num;
					tmpnum1 = pc_num1;
					continue;
				}
				else if (down > -1 && (scr[tmpnum + 1][tmpnum1] == 15) && (rotate == 0 || rotate == 1))
				{
					down--;
					tmpnum = pc_num;
					tmpnum1 = pc_num1;
					continue;
				}
				if (down <= 0 && up <= 0 && left <= 0 && right <= 0)
				{
					func(scr, 10, 15);
					pc_flag = true;
					flag = true;
					continue;
				}
			}
		}
		win = Win(scr_pc);
		pc_win = pc_Win(scr);
		if (win)Win_Scr(scr, scr_pc);
		if (pc_win) PC_Win_Scr(scr, scr_pc);
	}
}

bool pc_Win(int scr[10][10])
{
	for (int i = 0; i < 10; i++)
		for (int j = 0; j < 10; j++)
			if (scr[i][j] == 2) return false;
	return true;
}

bool Win(int scr[10][10])
{
	for (int i = 0; i < 10; i++)
		for (int j = 0; j < 10; j++)
			if (scr[i][j] == 20 || scr[i][j] == 21 || scr[i][j] == 22 || scr[i][j] == 23 || scr[i][j] == 24 || scr[i][j] == 25 || scr[i][j] == 26 || scr[i][j] == 27 || scr[i][j] == 28 || scr[i][j] == 29)
				return false;
	return true;
}

void func(int scr[10][10], int a, int b)
{
	for (int i = 0; i < 10; i++)
	{
		for (int j = 0; j < 10; j++)
		{
			if (scr[i][j] == 0 || scr[i][j] == 1)
			{
				if (scr[i][j - 1] == a && j - 1 > -1)
				{
					scr[i][j] = b;
					continue;
				}
				if (scr[i][j + 1] == a && j + 1 < 10)
				{
					scr[i][j] = b;
					continue;
				}
				if (scr[i - 1][j] == a && i - 1 > -1)
				{
					scr[i][j] = b;
					continue;
				}
				if (scr[i + 1][j] == a && i + 1 < 10)
				{
					scr[i][j] = b;
					continue;
				}
				if (scr[i + 1][j + 1] == a && i + 1 < 10 && j + 1 < 10)
				{
					scr[i][j] = b;
					continue;
				}
				if (scr[i - 1][j - 1] == a && i - 1 > -1 && j - 1 > -1)
				{
					scr[i][j] = b;
					continue;
				}
				if (scr[i + 1][j - 1] == a && i + 1 < 10 && j - 1 > -1)
				{
					scr[i][j] = b;
					continue;
				}
				if (scr[i - 1][j + 1] == a && i - 1 > -1 && j + 1 < 10)
				{
					scr[i][j] = b;
					continue;
				}
			}
		}
	}
}

void func1(int scr[10][10], int a)
{
	bool flag = true;
	for (int i = 0; i < 10; i++)
	{
		if (!flag) break;
		for (int j = 0; j < 10; j++)
		{
			if (scr[i][j] == a - 10)
			{
				flag = false;
				break;
			}
		}
	}
	if (flag)
	{
		func(scr, a, 15);
	}
}

void stats(int scr[10][10], int pc_scr[10][10])
{
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

	int key;
	int pc_ship = 0;
	int pc_free = 0;
	int ship = 0;
	int free = 0;
	for (int i = 0; i < 10; i++)
	{
		for (int j = 0; j < 10; j++)
		{

			if (scr[i][j] == 15)
				free++;
			else if (scr[i][j] == 10)
				ship++;

			if (pc_scr[i][j] == 15)
				pc_free++;
			else if (pc_scr[i][j] == 30 || pc_scr[i][j] == 31 || pc_scr[i][j] == 32 || pc_scr[i][j] == 33 ||
				pc_scr[i][j] == 34 || pc_scr[i][j] == 35 || pc_scr[i][j] == 36 || pc_scr[i][j] == 37 || pc_scr[i][j] == 38 || pc_scr[i][j] == 39)
				pc_ship++;
		}
	}
	SetConsoleTextAttribute(hConsole, 10);
	cout << "\n\n\t\tPlayer\t\tPc";
	cout << "\n*\t\t" << ship << "\t\t" << pc_ship;
	cout << "\no\t\t" << free << "\t\t" << pc_free;
	SetConsoleTextAttribute(hConsole, 7);
	cout << "\n\nPress any key to return main menu\n";
	key = _getch();
	main();

}

void Win_Scr(int scr[10][10], int pc_scr[10][10])
{
	system("cls");
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

	SetConsoleTextAttribute(hConsole, 10);
	cout << " __     __           __          ___       \n";
	cout << " \\ \\   / /           \\ \\        / (_)      \n";
	cout << "  \\ \\_/ /__  _   _    \\ \\  /\\  / / _ _ __  \n";
	cout << "   \\   / _ \\| | | |    \\ \\/  \\/ / | | '_ \\ \n";
	cout << "    | | (_) | |_| |     \\  /\\  /  | | | | |\n";
	cout << "    |_|\\___/ \\__,_|      \\/  \\/   |_|_| |_|\n";
	SetConsoleTextAttribute(hConsole, 7);
	stats(scr, pc_scr);

}

void PC_Win_Scr(int scr[10][10], int pc_scr[10][10])
{
	system("cls");

	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	SetConsoleTextAttribute(hConsole, 12);

	cout << " __     __            _                    \n";
	cout << " \\ \\   / /           | |                   \n";
	cout << "  \\ \\_/ /__  _   _   | |     ___  ___  ___ \n";
	cout << "   \\   / _ \\| | | |  | |    / _ \\/ __|/ _ \\\n";
	cout << "    | | (_) | |_| |  | |___| (_) \\__ \\  __/\n";
	cout << "    |_|\\___/ \\__,_|  |______\\___/|___/\\___|\n";

	SetConsoleTextAttribute(hConsole, 7);
	stats(scr, pc_scr);
}