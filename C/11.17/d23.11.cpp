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
/*
int main()
{
	//a[1][2]
	int a;
	int arrsize = 5;
	int ** arr = new int * [arrsize];


	bool flag=true;
	for (int i = 0; i < 5; i++)
	{
		if (flag)
		{
			arr[i] = new int[6];
			flag = false;
		}
		else
		{
			cout << "Daxil et\n";
			cin >> a;
			arr[i] = new int[a];
			flag = true;
		}
	}
	int d;
	arrsize;
	cout << sizeof(arr) << '\n';
	for (int i = 0; i < arrsize; i++)
	{
		d = sizeof(arr[i]);

		for (int j = 0; j < d; j++)
		{
			arr[i][j] = rand() % 10;
		}

	}
	for (int i = 0; i < arrsize; i++)
	{
		d = sizeof(arr[i]);

		for (int j = 0; j < d; j++)
		{
			cout << arr[i][j] << ' ';
		}
		cout << '\n';
	}


	system("pause");
	return 0;
}
*/

/*
typedef void(*ptr)(int* , int);

void func1(int * arr, int size)
{
	for (int i = 0; i < size; i++)
	{
		arr[i] += 5;
	}
}

void  func(int **arr, ptr d, int size)
{

	for (int i = 0; i < 5; i++)
		d(arr[i] ,5);

}



int main()
{
	int size = 5;
	int ** arr = new int *[5];
	for (int i = 0; i < 5; i++)
	{
		arr[i] = new int[5];
	}

	for (int i = 0; i < 5; i++)
	{
		for (int j = 0; j < 5; j++)
		{
			arr[i][j] = rand() % 10;
		}
	}
	for (int i = 0; i < 5; i++)
	{
		for (int j = 0; j < 5; j++)
		{
			cout << arr[i][j] << " ";
		}
		cout << "\n";
	}

		func(arr, func1, size);
	for (int i = 0; i < 5; i++)
	{
		for (int j = 0; j < 5; j++)
		{
			cout << arr[i][j] << " ";
		}
		cout << "\n";
	}
	system("pause");
}
*/
/*
int **  func(int ** arr, int a, int b , int size)
{
	int c = 0;
	int d = 0;
	cout << "\n\n";
	int ** tmp = new int *[size];
	for (int i = 0; i < size; i++)

	for (int i = 0; i < size; i++  , d++)
	{

		for (int j = a; j < a + b; j++)
			c++;
		tmp[i] = new int[c];
		c = 0;

	}
	for (int i = 0; i < size; i++, d++)
	{

		for (int j = a; j < a + b; j++, c++)
			tmp[i][c] = arr[i][j];
		c = 0;
	}
	return tmp;
}

int main()
{

	int size = 10;

	int ** arr = new int *[size];
	for (int i = 0; i < size; i++)
	{
		arr[i] = new int[size];
	}

	for (int i = 0; i < size; i++)
	{
		for (int j = 0; j < size; j++)
		{
			arr[i][j] = rand() % 10;
		}
	}
	for (int i = 0; i < size; i++)
	{
		for (int j = 0; j < size; j++)
		{
			cout << arr[i][j] << " ";
		}
		cout << "\n";
	}
	int ** tmp = 0;
	tmp = func(arr, 3, 6 ,size);
	for (int i = 0; i < size; i++)
	{
		for (int j = 0; j < 6; j++)
		{
			cout << tmp[i][j] << " ";
		}
		cout << "\n";
	}


	system("pause");
}
*/


/*
int main()
{
	int size = 10;
	int ** arr = new int *[size];
	int a;
	int b, c;

	for (int i = 0; i < size; i++)
		arr[i] = new int[size];

	time_t t;
	srand((unsigned)time(&t));

	for (int i = 0; i < size; i++)
		for (int j = 0; j < size; j++)
			arr[i][j] = rand() % 100;
	for (int i = 0; i < size; i++)
	{
		for (int j = 0; j < size; j++)
			cout << arr[i][j] << "\t";
		cout << '\n';
	}
	cout << "\n\n";
	int min = arr[0][0];
	int line = 0;
	for (int i = 0; i < size; i++)
	{
		for (int j = 0; j < size; j++)
		{
			if (min > arr[i][j])
			{
				min = arr[i][j];
				line = i;
			}
		}
	}


	int tmp;
	for (int i = 0; i < size; i++)
	{
		tmp = arr[line][i];
		arr[line][i] = arr[size - 1][i];
		arr[size - 1][i] = tmp;

	}





	for (int i = 0; i < size; i++)
	{
		for (int j = 0; j < size; j++)
			cout << arr[i][j] << "\t";
		cout << '\n';
	}
	system("pause");
	return 0;
}

*/


/*

int main()
{
	int size = 10;
	int ** arr = new int *[size];
	int a;
	int b, c;

	for (int i = 0; i < size; i++)
		arr[i] = new int[size];

	time_t t;
	srand((unsigned)time(&t));

	for (int i = 0; i < size; i++)
		for (int j = 0; j < size; j++)
			arr[i][j] = rand() % 10;
	int min = arr[0][0];
	int max = 0;
	float  sum = 0;
	for (int i = 0; i < size; i++)
	{
		for (int j = 0; j < size; j++)
		{
			sum += arr[i][j];
			if (min > arr[i][j])
				min = arr[i][j];
			if (max < arr[i][j])
				max = arr[i][j];
		}
		sum -= min + max;
		sum /= size - 2;

		for (int j = 0; j < size; j++)
			cout << arr[i][j] << "\t";
		cout << '\t' << "--" << sum << "\n";
		cout << '\n';
	}



	system("pause");
	return 0;
}
*/

void game(bool flag)
{

	int arr[3][3];
	char scr[3][3];

	for (int i = 0; i < 3; i++)
		for (int j = 0; j < 3; j++)
			scr[i][j] = ' ';

	if (flag); 
	else;



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
				cout << "\n\n\t\t";
				cout << "X";
				cout << "\t\t";
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
			else if (key == KB_ENTER) game(flag1);
			else if (key == KB_ESCAPE)return;
		}
	}


}