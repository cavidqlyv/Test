#include <iostream>
#include <time.h>

using namespace std;

/*
int main()
{

	int ** arr = new int *[5];

	for (int i = 0; i < 5; i++)
		arr[i] = new int[5];

	time_t t;
	srand((unsigned)time(&t));

	for (int i = 0; i < 5; i++)
		for (int j = 0; j < 5; j++)
			arr[i][j] = rand() % 20;

	for (int i = 0; i < 5; i++)
	{
		for (int j = 0; j < 5; j++)
			cout << arr[i][j] << " ";
		cout << '\n';
	}

	int b = 0;
	int s = arr[0][0];
	int q = 0;
	int w = 0;
	int sum = 0;
	for (int i = 0; i < 5; i++)
	{
		w = 0;
		q = 0;
		s = arr[0][0];
		b = 0;
		sum = 0;
		for (int j = 0; j < 5; j++)
		{
			if (arr[i][j] > b)
			{
				b = arr[i][j];
				q = j;
			}
			if (arr[i][j] < s)
			{
				s = arr[i][j];
				w = j;
			}
		}
		if (q > w)
		{
			for (int j = w + 1; j < q; j++) sum += arr[i][j];
		}
		else if (q < w)
		{
			for (int j = q + 1; j < w; j++) sum += arr[i][j];
		}
		cout << i << " massiv =" << sum << "\n";

	}
	system("pause");
	return 0;
}
*/
/*
int main()
{

	int ** arr = new int *[5];
	int a;
	int b, c;
	for (int i = 0; i < 5; i++)
		arr[i] = new int[5];

	time_t t;
	srand((unsigned)time(&t));

	for (int i = 0; i < 5; i++)
		for (int j = 0; j < 5; j++)
			arr[i][j] = rand() % 20;
	while (1)
	{
		//system("cls");
		for (int i = 0; i < 5; i++)
		{
			for (int j = 0; j < 5; j++)
				cout << arr[i][j] << "\t";
			cout << '\n';
		}

		cout << "\n\nSetr ucun 1\n";
		cout << "Sutun ucun 2\n";
		cin >> a;
		int tmp;
		if (a == 1)
		{
			cout << "1 ci setri daxil edin\n\n";
			cin >> b;
			cout << "2 ci setri daxil edin\n\n";
			cin >> c;
			for (int i = 0; i < 5; i++)
			{
				tmp = arr[b - 1][i];
				arr[b - 1][i] = arr[c - 1][i];
				arr[c - 1][i] = tmp;
			}
		}
		else if (a == 2)
		{
			cout << "1 ci sutun daxil edin\n\n";
			cin >> b;
			cout << "2 ci sutun daxil edin\n\n";
			cin >> c;
			for (int i = 0; i < 5; i++)
			{
				tmp = arr[i][b - 1];
				arr[i][b - 1] = arr[i][c - 1];
				arr[i][c - 1] = tmp;
			}
		}
	}
	system("pause");
	return 0;
}
*/
/*
int main()
{
	int ** arr = new int *[5];
	int a;
	int b, c;

	for (int i = 0; i < 5; i++)
		arr[i] = new int[5];

	time_t t;
	srand((unsigned)time(&t));

	for (int i = 0; i < 5; i++)
		for (int j = 0; j < 5; j++)
			arr[i][j] = rand() % 3;
	for (int i = 0; i < 5; i++)
	{
		for (int j = 0; j < 5; j++)
			cout << arr[i][j] << "\t";
		cout << '\n';
	}
	cout << "\n\n";
	int tmp;
	int sum = 0,sum1 = 0;
	int aa = 0, bb = 1;
	for (int o = 0; o < 5; o++)
	{
		aa = 0;
		bb = 1;
		for (int j = 0; j < 5; j++)
		{
			sum = 0;
			sum1 = 0;
			for (int i = 0; i < 5; i++)
			{
				sum += arr[i][aa];
				sum1 += arr[i][bb];
			}
			for (int i = 0; i < 5; i++)
			{
				if (sum1 > sum)
				{
					tmp = arr[i][aa];
					arr[i][aa] = arr[i][bb];
					arr[i][bb] = tmp;
				}
			}
			aa++;
			bb++;
		}
	}



	for (int i = 0; i < 5; i++)
	{
		for (int j = 0; j < 5; j++)
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
	int ** arr = new int *[6];
	int a;
	int b, c;

	for (int i = 0; i < 6; i++)
		arr[i] = new int[6];

	time_t t;
	srand((unsigned)time(&t));

	for (int i = 0; i < 6; i++)
		for (int j = 0; j < 6; j++)
			arr[i][j] = rand() % 20;
	for (int i = 0; i < 6; i++)
	{
		for (int j = 0; j < 6; j++)
			cout << arr[i][j] << "\t";
		cout << '\n';
	}
	cout << "\n\n";
	int tmp;

	int aa = 0;
	int bb = 1;
	for (int j=0 ; j<3 ; j++)
	{ 
		for (int i = 0; i < 6; i++)
		{
			tmp = arr[aa][i];
			arr[aa][i] = arr[bb][i];
			arr[bb][i] = tmp;
		}
		aa += 2;
		bb += 2;
	}
	for (int i = 0; i < 6; i++)
	{
		for (int j = 0; j < 6; j++)
			cout << arr[i][j] << "\t";
		cout << '\n';
	}

	system("pause");
	return 0;
}
*/

