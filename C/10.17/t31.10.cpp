#include <iostream>
using namespace std;


void main()
{
	
	char name[2][10];
	int key;

	cout << "Birinci istfadecinin adini daxil et\n";
	cin >> name[0];
	cout << "IKinci istifadecinin adini daxil et\n";
	cin >> name[1];
	int h[100];
	int k = 0;
	char  b [100][20];
	char c[100][20];
	int  a=0, e=0;
	for (int i = 0; i < 100; i++)
	{
		h[i] = 0;
	}
	while (1)
	{
		cout << "\n\nYazmaq ucun 1\n";
		cout << "Baxmaq ucun 2\n";
		cout << "Baglamaq ucun 3\n";
		cin >> key;
		if (key == 1)
		{
			while (1)
			{
				cout << "\n\n" << name[0] << " Ucun 1\n";
				cout << name[1] << " Ucun 2\n";
				cout << "Geri qayitmaq ucun 0\n";
				cin >> key;
				if (key == 1)
				{
					h[k] = 1;
					k++;
					cout << "Mesaji daxil et :\n";
					cin >>  c[a];
					a++;
				}
				else if (key == 2)
				{
					h[k] = 2;
					k++;
					cout << "Mesaji daxil et :\n";

					cin >> b[e];
					e++;
				}
				else if (key == 0)
				{
					key = 1;
					break;
				}
				else
				{
					cout << "Duzgun daxil et\n";
				}
			}
		}
		else if (key == 2)
		{
			int y = 0;
			int u = 0;
			for (int i = 0; i < k; i++)
			{
				if (h[i] == 1)
				{
					cout << name[0] << " :" << c[y] << "\n";
					y++;
				}
				else if (h[i] == 2)
				{
					cout << name[1] << " :" << b[u] << "\n";
					u++;
				}
			}
		}
	}
	system("pause");
}