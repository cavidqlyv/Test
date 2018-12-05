#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;

enum fieldMode
{
	MODE_ALL,
	MODE_WITHOUT_MINES
};

void printMineField(char **field, fieldMode mode, int rows, int cols)
{
	cout << "*  ";
	for (int i = 0; i < cols; i++)
	{
		cout << i << "  ";
	}
	cout << '\n';
	for (int i = 0; i < rows; i++)
	{
		cout << i << ' ';
		for (int j = 0; j < cols; j++)
		{
			if (mode == MODE_ALL)
			{
				cout << "[" << field[i][j] << "]";
			}
			else if (mode == MODE_WITHOUT_MINES)
			{
				if (field[i][j] == '*')
				{
					cout << "[ ]";
				}
				else
				{
					cout << "[" << field[i][j] << "]";
				}
			}
		}
		cout << '\n';
	}
}

int main()
{
	int rows;
	int cols;
	cout << "Enter rows count\n";
	cin >> rows;
	cout << "Enter columns count\n";
	cin >> cols;

	char **minesField = new char *[rows];
	for (int i = 0; i < rows; i++)
	{
		minesField[i] = new char[cols];
	}

	int winCount = rows * cols;

	srand(time(NULL));
	for (int i = 0; i < rows; i++)
	{
		for (int j = 0; j < cols; j++)
		{
			if (rand() % 2 == 0)
			{
				minesField[i][j] = '*';
				--winCount;
			}
			else
			{
				minesField[i][j] = ' ';
			}
		}
	}
	system("cls");
	printMineField(minesField, MODE_WITHOUT_MINES, rows, cols);

	int row;
	int col;

	int successCounter = 0;

	while (1)
	{
		cout << "Enter row number\n";
		cin >> row;
		while (row < 0 || row > rows - 1)
		{
			cout << "Wrong position\n";
			cin >> row;
		}

		cout << "Enter column number\n";
		cin >> col;
		while (col < 0 || col > cols - 1)
		{
			cout << "Wrong position\n";
			cin >> col;
		}

		system("cls");
		if (minesField[row][col] != '*')
		{
			minesField[row][col] = 'O';
			++successCounter;

			if (successCounter == winCount)
			{
				printMineField(minesField, MODE_ALL, rows, cols);
				cout << "You are win\n";
				break;
			}
			else
			{
				printMineField(minesField, MODE_WITHOUT_MINES, rows, cols);
			}
		}
		else
		{
			minesField[row][col] = 'X';
			printMineField(minesField, MODE_ALL, rows, cols);
			cout << "You are loss\n";
			break;
		}
	}
	return 0;
}