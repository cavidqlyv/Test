#include <iostream>
#include <time.h>
#include <windows.h>
#include <conio.h>
using namespace std;

#define KB_UP 72
#define KB_DOWN 80
#define KB_LEFT 75
#define KB_RIGHT 77
#define KB_ESCAPE 27
#define KB_ENTER 13

void game(bool &flag, bool& flag1)
{
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	char p1, p2;
	int key;
	char scr[3][3];
	int move[2] = { 0,0 };
	for (int i = 0; i < 3; i++)
		for (int j = 0; j < 3; j++)
			scr[i][j] = '*';
	int game = 0;
	if (flag1)
	{
		p1 = 'X';
		p2 = 'O';
	}
	else
	{
		p2 = 'X';
		p1 = 'O';
	}
	while (1)
	{
		system("cls");
		for (int i = 0; i < 3; i++)
		{
			for (int j = 0; j < 3; j++)
			{
				if (move[0] == i && move[1] == j)
				{
					SetConsoleTextAttribute(hConsole, 12);

					cout << scr[i][j];
					SetConsoleTextAttribute(hConsole, 7);
					cout << " | ";
				}
				else cout << scr[i][j] << " | ";
			}
			cout << "\b\b \n";
		}
		int a;
		int b;
		time_t t;
		srand((unsigned)time(&t));
		if (flag)
		{
			while (1)
			{
				key = _getch();
				if (key == KB_RIGHT && move[1] < 2) move[1]++;
				else if (key == KB_LEFT && move[1] > 0)  move[1]--;
				else if (key == KB_UP && move[0] > 0) move[0]--;
				else if (key == KB_DOWN && move[0] < 2) move[0]++;
				else if (key == KB_ENTER && scr[move[0]][move[1]] == '*')
				{
					scr[move[0]][move[1]] = p1;
					game++;
					break;
				}
				else if (key == KB_ESCAPE)return;
				flag = false;
				system("cls");
				for (int i = 0; i < 3; i++)
				{
					for (int j = 0; j < 3; j++)
					{
						if (move[0] == i && move[1] == j)
						{
							SetConsoleTextAttribute(hConsole, 12);

							cout << scr[i][j];
							SetConsoleTextAttribute(hConsole, 7);
							cout << " | ";
						}
						else cout << scr[i][j] << " | ";
					}
					cout << "\b\b \n";
				}
			}
		}
		else
		{
			while (1)
			{
				a = rand() % 3;
				b = rand() % 3;
				if (scr[a][b] == '*')
				{
					scr[a][b] = p2;
					game++;
					break;
				}

			}
			flag = true;
		}
		if (
			(scr[0][0] == p1&&scr[0][1] == p1&& scr[0][2] == p1) ||
			(scr[1][0] == p1&&scr[1][1] == p1&& scr[1][2] == p1) ||
			(scr[2][0] == p1&&scr[2][1] == p1&& scr[2][2] == p1) ||
			(scr[0][0] == p1&&scr[1][0] == p1&& scr[2][0] == p1) ||
			(scr[0][1] == p1&&scr[1][1] == p1&& scr[2][1] == p1) ||
			(scr[0][2] == p1&&scr[1][2] == p1&& scr[2][2] == p1) ||
			(scr[0][0] == p1&&scr[1][1] == p1&& scr[2][2] == p1) ||
			(scr[0][2] == p1&&scr[1][1] == p1&& scr[2][0] == p1)
			)
		{
			SetConsoleTextAttribute(hConsole, 12);
			cout << "YOU WIN" << '\n';
			SetConsoleTextAttribute(hConsole, 7);
			system("pause");
			return;
		}
		else if
			((scr[0][0] == p2&&scr[0][1] == p2&& scr[0][2] == p2) ||
			(scr[1][0] == p2&&scr[1][1] == p2&& scr[1][2] == p2) ||
				(scr[2][0] == p2&&scr[2][1] == p2&& scr[2][2] == p2) ||
				(scr[0][0] == p2&&scr[1][0] == p2&& scr[2][0] == p2) ||
				(scr[0][1] == p2&&scr[1][1] == p2&& scr[2][1] == p2) ||
				(scr[0][2] == p2&&scr[1][2] == p2&& scr[2][2] == p2) ||
				(scr[0][0] == p2&&scr[1][1] == p2&& scr[2][2] == p2) ||
				(scr[0][2] == p2&&scr[1][1] == p2&& scr[2][0] == p2))
		{
			SetConsoleTextAttribute(hConsole, 12);
			cout << "YOU LOSE" << '\n';
			SetConsoleTextAttribute(hConsole, 7);
			system("pause");
			return;
		}
		if (game == 9)
		{
			system("pause");
			return;
		}
	}
}

void main()
{
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	cout << "\n\n\n\t\t\t";
	SetConsoleTextAttribute(hConsole, 112);
	cout << "Select\n";
	SetConsoleTextAttribute(hConsole, 7);

	bool flag = true;
	bool flag1 = true;
	int key;
	while (1)
	{
		while (1)
		{
			system("cls");
			if (flag == true)
			{
				cout << "\n\n\t\t";
				SetConsoleTextAttribute(hConsole, 12);
				cout << "X";
				SetConsoleTextAttribute(hConsole, 7);
				cout << "\t\tO\n";
			}
			else if (flag == false)
			{
				cout << "\n\n\t\tX\t\t";
				SetConsoleTextAttribute(hConsole, 12);
				cout << 'O';
				SetConsoleTextAttribute(hConsole, 7);
				cout << "\n";
			}
			key = _getch();
			if (key == KB_RIGHT) flag = false;
			else if (key == KB_LEFT) flag = true;
			else if (key == KB_ENTER) break;
			else if (key == KB_ESCAPE)return;
		}
		while (1)
		{
			system("cls");
			if (flag == true)
			{
				cout << "\n\n\t\t";
				SetConsoleTextAttribute(hConsole, 12);
				cout << "X";
				SetConsoleTextAttribute(hConsole, 7);
				cout << "\t\tO\n";
			}
			else if (flag == false)
			{
				cout << "\n\n\t\tX\t\t";
				SetConsoleTextAttribute(hConsole, 12);
				cout << 'O';
				SetConsoleTextAttribute(hConsole, 7);
				cout << "\n";
			}
			if (flag1 == true)
			{
				cout << "\n\n\t\t";
				SetConsoleTextAttribute(hConsole, 12);
				cout << "Player";
				SetConsoleTextAttribute(hConsole, 7);
				cout << "\t\tPC\n";
			}
			else if (flag1 == false)
			{
				cout << "\n\n\t\t";
				cout << "Player";
				cout << "\t\t";
				SetConsoleTextAttribute(hConsole, 12);
				cout << "PC";
				SetConsoleTextAttribute(hConsole, 7);
				cout << "\n";
			}
			key = _getch();
			if (key == KB_RIGHT) flag1 = false;
			else if (key == KB_LEFT) flag1 = true;
			else if (key == KB_ENTER) game(flag1, flag);
			else if (key == KB_ESCAPE)return;
		}
	}
}