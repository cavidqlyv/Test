#include <iostream>
#include <windows.h>
#include <conio.h>
#include <cctype>
#include <time.h>
using namespace std;

#define KB_UP 72
#define KB_DOWN 80
#define KB_LEFT 75
#define KB_RIGHT 77
#define KB_ESCAPE 27
#define KB_ENTER 13

void game(int * size, int difficulty)

{
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	int move[2] = { 0,0 };
	bool flag = true;
	int key;
	int count = 0;
	int ** scr = new int *[size[0]];
	char ** scrw = new char *[size[0]];
	for (int i = 0; i < size[0]; i++)
	{
		scrw[i] = new char[size[1]];
		scr[i] = new int[size[1]];
	}
	for (int i = 0; i < size[0]; i++)
	{
		for (int j = 0; j < size[1]; j++)
		{
			scr[i][j] = 0;
			scrw[i][j] = 254;
		}
	}
	int difficulty1;
	int win = 0;
	if (difficulty == 1) difficulty1 = size[0] * size[1] / 6;
	else if (difficulty == 2) difficulty1 = size[0] * size[1] / 5;
	else if (difficulty == 3) difficulty1 = size[0] * size[1] / 4;
	{
		int a, b;
		int n;
		time_t t;

		n = 5;
		srand((unsigned)time(&t));
		for (int i = 0; i < difficulty1; i++)
		{
			a = rand() % size[0];
			b = rand() % size[1];
			if (scr[a][b] == 0) scr[a][b] = 1;
			else i--;
		}
	}
	int a = 0, b = 0;
	char s = 254;
	while (1)
	{
		system("cls");

		for (int i = 0; i < size[0]; i++)
		{
			cout << "\t\t";
			for (int j = 0; j < size[1]; j++)
			{
				if (i == move[0] && j == move[1])
				{
					SetConsoleTextAttribute(hConsole, 12);
					cout << s;
					SetConsoleTextAttribute(hConsole, 7);
					cout << " ";
				}
				else cout << scrw[i][j] << " ";
			}
			cout << "\n";
		}
		if (!flag)
		{
			SetConsoleTextAttribute(hConsole, 12);
			cout << "YOU LOSE\n";
			SetConsoleTextAttribute(hConsole, 7);
			system("pause");
			return;
		}
		if (win == size[0] * size[1] - difficulty1)
		{
			SetConsoleTextAttribute(hConsole, 12);
			cout << "YOU WIN\n";
			SetConsoleTextAttribute(hConsole, 7);
			system("pause");
			return;
		}
		key = _getch();
		count = 0;
		if (key == KB_DOWN)
		{
			move[0]++;
		}
		else if (key == KB_UP) move[0]--;
		else if (key == KB_LEFT) move[1]--;
		else if (key == KB_RIGHT) move[1]++;
		else if (key == KB_ENTER)
		{
			int c = move[0];
			int e = move[1];
			if (scr[c][e] == 1)
			{
				flag = false;
				for (int i = 0; i < size[0]; i++)
				{
					for (int j = 0; j < size[1]; j++)
					{
						if (scr[i][j] == 1)
							scrw[i][j] = 42;
					}
				}
			}
			else
			{
				if (c != 0)
				{
					if (scr[c - 1][e] == 1) count++;
					if (scr[c - 1][e - 1] == 1) count++;
					if (scr[c - 1][e + 1] == 1) count++;
				}
				if (scr[c][e - 1] == 1 && e != 0) count++;
				if (scr[c][e + 1] == 1 && e != size[1] - 1) count++;
				if (c != size[0] - 1)
				{
					if (scr[c + 1][e] == 1) count++;
					if (scr[c + 1][e - 1] == 1) count++;
					if (scr[c + 1][e + 1] == 1) count++;
				}
				win++;
				scrw[move[0]][move[1]] = count + 48;
			}
		}
	}
}

void start()
{
	int key;
	int keyarr[6];
	int size[2] = { 5,5 };
	int difficulty = 2;
	for (int i = 1; i < 6; i++)
	{
		keyarr[i] = 0;
	}
	keyarr[0] = 1;
	while (1)
	{
		system("cls");
		HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

		// keyarr[0] Size
		// keyarr[1] difficulty
		// keyarr[2] Size 1
		// keyarr[3] Size 2
		// keyarr[4] difficulty 1

		if (keyarr[0] == 1) // Size
		{
			cout << "\n\n\n\t\t\t";
			SetConsoleTextAttribute(hConsole, 112);
			cout << "Size";
			SetConsoleTextAttribute(hConsole, 7);
			cout << "\t\t\t\t" << size[0] << " x " << size[1] << "\n";
			cout << "\n\t\t\tDifficulty\t\t\t";
			if (difficulty == 1) cout << "Easy\n";
			else if (difficulty == 2) cout << "Normal\n";
			else cout << "Hard\n";
			cout << "\n\n\n\t\t\t\t     ";
			cout << "Start\n";
			key = _getch();
			if (key == KB_DOWN)
			{
				keyarr[0] = 0;
				keyarr[1] = 1;
			}
			else if (key == KB_RIGHT)
			{
				keyarr[0] = 0;
				keyarr[2] = 1;
			}
			else if (key == KB_ESCAPE) return;
		}
		else if (keyarr[1] == 1) // difficulty
		{
			cout << "\n\n\n\t\t\t";
			cout << "Size";
			cout << "\t\t\t\t" << size[0] << " x " << size[1] << "\n";
			SetConsoleTextAttribute(hConsole, 112);
			cout << "\n\t\t\tDifficulty\t\t\t";
			SetConsoleTextAttribute(hConsole, 7);

			if (difficulty == 1) cout << "Easy\n";
			else if (difficulty == 2) cout << "Normal\n";
			else cout << "Hard\n";
			cout << "\n\n\n\t\t\t\t     ";
			cout << "Start\n";

			key = _getch();
			if (key == KB_RIGHT)
			{
				keyarr[1] = 0;
				keyarr[4] = 1;
			}
			else if (key == KB_UP)
			{
				keyarr[1] = 0;
				keyarr[0] = 1;
			}
			else if (key == KB_DOWN)
			{
				keyarr[1] = 0;
				keyarr[5] = 1;
			}
			else if (key == KB_ESCAPE) return;
		}
		else if (keyarr[2] == 1)
		{
			cout << "\n\n\n\t\t\t";
			cout << "Size";
			cout << "\t\t\t\t";
			SetConsoleTextAttribute(hConsole, 112);
			cout << size[0];
			SetConsoleTextAttribute(hConsole, 7);
			cout << " x " << size[1] << "\n";
			cout << "\n\t\t\tDifficulty\t\t\t";
			if (difficulty == 1) cout << "Easy\n";
			else if (difficulty == 2) cout << "Normal\n";
			else cout << "Hard\n";
			cout << "\n\n\n\t\t\t\t     ";
			cout << "Start\n";

			key = _getch();
			if (key == KB_RIGHT)
			{
				keyarr[2] = 0;
				keyarr[3] = 1;
			}
			else if (key == KB_LEFT)
			{
				keyarr[2] = 0;
				keyarr[0] = 1;
			}
			else if (key == KB_ENTER)
			{
				while (1)
				{
					system("cls");
					cout << "\n\n\n\t\t\t";
					cout << "Size";
					cout << "\t\t\t\t";
					SetConsoleTextAttribute(hConsole, 112);
					cout << size[0];
					SetConsoleTextAttribute(hConsole, 7);
					cout << " x " << size[1] << "\n";
					cout << "\n\t\t\tDifficulty\t\t\t";

					if (difficulty == 1) cout << "Easy\n";
					else if (difficulty == 2) cout << "Normal\n";
					else cout << "Hard\n";
					cout << "\n\n\n\t\t\t\t     ";
					cout << "Start\n";

					key = _getch();
					if (key == KB_UP && size[0] < 20) size[0]++;
					else if (key == KB_DOWN && size[0] > 5) size[0]--;
					else if (key == KB_ENTER) break;
				}
			}
			else if (key == KB_ESCAPE) return;
		}
		else if (keyarr[3] == 1)
		{
			cout << "\n\n\n\t\t\t";
			cout << "Size";
			cout << "\t\t\t\t" << size[0] << " x ";
			SetConsoleTextAttribute(hConsole, 112);
			cout << size[1];
			SetConsoleTextAttribute(hConsole, 7);
			cout << "\n";
			cout << "\n\t\t\tDifficulty\t\t\t";
			if (difficulty == 1) cout << "Easy\n";
			else if (difficulty == 2) cout << "Normal\n";
			else cout << "Hard\n";
			cout << "\n\n\n\t\t\t\t     ";
			cout << "Start\n";

			key = _getch();
			if (key == KB_LEFT)
			{
				keyarr[3] = 0;
				keyarr[2] = 1;
			}
			else if (key == KB_ENTER)
			{
				while (1)
				{
					system("cls");
					cout << "\n\n\n\t\t\t";
					cout << "Size";
					cout << "\t\t\t\t" << size[0] << " x ";
					SetConsoleTextAttribute(hConsole, 112);
					cout << size[1];
					SetConsoleTextAttribute(hConsole, 7);
					cout << "\n";
					cout << "\n\t\t\tDifficulty\t\t\t";
					if (difficulty == 1) cout << "Easy\n";
					else if (difficulty == 2) cout << "Normal\n";
					else cout << "Hard\n";
					cout << "\n\n\n\t\t\t\t     ";
					cout << "Start\n";

					key = _getch();
					if (key == KB_UP && size[1] < 20) size[1]++;
					else if (key == KB_DOWN && size[1] > 5) size[1]--;
					else if (key == KB_ENTER) break;
				}
			}
			else if (key == KB_ESCAPE) return;
		}
		else if (keyarr[4] == 1)
		{
			cout << "\n\n\n\t\t\t";
			cout << "Size";
			cout << "\t\t\t\t" << size[0] << " x " << size[1] << "\n";
			cout << "\n\t\t\tDifficulty\t\t\t";
			SetConsoleTextAttribute(hConsole, 112);
			if (difficulty == 1) cout << "Easy\n";
			else if (difficulty == 2) cout << "Normal\n";
			else cout << "Hard\n";
			SetConsoleTextAttribute(hConsole, 7);
			cout << "\n\n\n\t\t\t\t     ";
			cout << "Start\n";

			key = _getch();
			if (key == KB_LEFT)
			{
				keyarr[4] = 0;
				keyarr[1] = 1;
			}
			else if (key == KB_ENTER)
			{
				while (1)
				{
					system("cls");
					cout << "\n\n\n\t\t\t";
					cout << "Size";
					cout << "\t\t\t\t" << size[0] << " x " << size[1] << "\n";
					cout << "\n\t\t\tDifficulty\t\t\t";
					SetConsoleTextAttribute(hConsole, 112);
					if (difficulty == 1) cout << "Easy\n";
					else if (difficulty == 2) cout << "Normal\n";
					else cout << "Hard\n";
					SetConsoleTextAttribute(hConsole, 7);
					cout << "\n\n\n\t\t\t\t     ";
					cout << "Start\n";

					key = _getch();
					if (key == KB_UP && difficulty > 1)difficulty--;
					else if (key == KB_DOWN && difficulty < 3)difficulty++;
					else if (key == KB_ENTER) break;
				}
			}

			else if (key == KB_ESCAPE) return;
		}
		else if (keyarr[5] == 1)
		{
			cout << "\n\n\n\t\t\t";
			cout << "Size";
			cout << "\t\t\t\t";
			cout << size[0];
			cout << " x " << size[1] << "\n";
			cout << "\n\t\t\tDifficulty\t\t\t";

			if (difficulty == 1) cout << "Easy\n";
			else if (difficulty == 2) cout << "Normal\n";
			else cout << "Hard\n";

			cout << "\n\n\n\t\t\t\t     ";
			SetConsoleTextAttribute(hConsole, 112);
			cout << "Start";
			SetConsoleTextAttribute(hConsole, 7);
			cout << '\n';
			key = _getch();

			if (key == KB_ENTER) game(size, difficulty);
			else if (key == KB_ESCAPE) return;
			else if (key == KB_UP)
			{
				keyarr[5] = 0;
				keyarr[1] = 1;
			}
		}
	}
}

void main()
{
	int key;
	unsigned char frame[] = { 201,205,205,205,205,205,205,205,205,205,205 , 187 , '\0' };
	unsigned char frame1[] = { 186,'\0' };
	unsigned char frame2[] = { 200,205,205,205,205,205,205,205,205,205,205 , 188 , '\0' };
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	bool menu1 = true;
	while (1)
	{
		if (menu1 == true)
		{
			cout << "\n\n\n\n\t\t\t\t\t";
			cout << frame << "\n";
			cout << "\t\t\t\t\t" << frame1;
			SetConsoleTextAttribute(hConsole, 112);
			cout << " New Game ";
			SetConsoleTextAttribute(hConsole, 7);
			cout << frame1;
			cout << "\n\t\t\t\t\t" << frame1 << "   Exit   " << frame1 << "\n";
			cout << "\t\t\t\t\t" << frame2 << "\n";
		}
		else
		{
			cout << "\n\n\n\n\t\t\t\t\t";
			cout << frame << "\n";
			cout << "\t\t\t\t\t" << frame1 << " New Game " << frame1;
			cout << "\n\t\t\t\t\t" << frame1;
			SetConsoleTextAttribute(hConsole, 112);
			cout << "   Exit   ";
			SetConsoleTextAttribute(hConsole, 7);
			cout << frame1;
			cout << "\n\t\t\t\t\t" << frame2 << "\n";
		}
		key = _getch();
		switch (key)
		{
		case KB_UP:
			if (menu1 == true) menu1 = false;
			else menu1 = true;
			break;
		case KB_DOWN:
			if (menu1 == true) menu1 = false;
			else menu1 = true;
			break;
		case KB_ENTER:
			if (menu1 == false) return;
			else start();
			break;

		default:
			cout << "\a";
			break;
		}
		system("cls");
	}
}
