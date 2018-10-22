#include <iostream>
#include <conio.h>
using namespace std;

struct Users
{
	char * username;
	char * password;

}users[20];

int main()
{
	int count = 0;
	for (int i = 0; i < 20; i++)
	{
		users[i].username = new char[20];
		users[i].password = new char[20];
	}

	int a = 0;
	
	while (1)
	{
		cout << "For sign up press 1\n";
		cout << "For sign in press 2\n";
		//a = _getch();
		cin >> a;
		if (a == 1)
		{
			while (1)
			{
				bool flag = true;
				cout << "Enter username\n";
				cin >> users[count].username;
				for (int i = 0; i < 20; i++)
					if (strcmp(users[count].username, users[i].username) == 0 && i != count)
						flag = false;
				if (flag)
				break;
			}
			while (1)
			{
				cout << "Enter password\n";
				cin >> users[count].password;
				if (strlen(users[count].password) <= 6)
					continue;
				break;
			}
			count++;
		}
		char tmp_username[20];
		

		if (a == 2)
		{
			while (1)
			{
				bool flag = true;
				cout << "Enter username\n";
				cin >> tmp_username;
				for (int i = 0; i < 20; i++)
					if (strcmp(tmp_username, users[i].username) == 0)
					{
						flag = true;
						break;
					}
					else flag = false;
				cout << "Enter password\n";
				cin >> tmp_username;
				for (int i = 0; i < 20; i++)
					if (strcmp(tmp_username, users[i].password) == 0)
					{
						flag = true;
						break;
					}
					else flag = false;

				if (flag)
				{
					cout << "Welcome\n";
					break;
				}
				else 
				{ 
					cout << "Wrong username or password\n";
					continue;
				}


			}
		}
	}
	system("pause");
	return 0;
}