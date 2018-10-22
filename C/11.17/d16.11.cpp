#include<stdio.h>
#include <iostream>
#include <cstring>
#include<conio.h>

#pragma warning(disable : 4430)
#pragma warning(disable : 4996)


using namespace std;

/*
char ** func(char **arr, char*a, int &b)
{
	arr[b] = new char[strlen(a) + 1];
	arr[b][strlen(a)] = '\0';
	for (int i = 0; i < strlen(a); i++)
	{
		arr[b][i] = a[i];
	}
	b++;

	return arr;
}

int main()
{
	char a[10];

	bool flag = true;
	bool flag1 = false;
	int b = 0;
	int c = 2;
	char **arr2;
	char **arr = new  char *[c];

	
	for (int j = 0; j<5; j++)
	{

		if (b % 2 == 0 && flag1)
		{
			if (flag)
			{
				arr2 = new  char *[b + 2];

				for (int i = 0; i < b; i++)
				{
					arr2[i] = arr[i];
					cout << arr2[i] << "---\n";
				}
				for (int i = 0; i < b; i++)
					delete[] arr[i];
				delete[] arr;
				
				flag = false;
			}
			else
			{
				char **arr = new  char *[b + 2];

				for (int i = 0; i < b; i++)
				{
					cout << "123\n";
					arr[i] = arr2[i];
					for (int i = 0; i < b; i++)
						delete[] arr2[i];
					delete[] arr2;
				}
				flag = true;
			}
		}
		flag1 = true;
		cin >> a;

		if (flag == true)
		{
			//char **arr1 = 
				func(arr, a, b);
			for (int i = 0; i < b; i++)
				cout << arr[i] << " ";
			cout << "\n";
		}
		else if (flag == false)
		{
			//char **arr1 = 
			func(arr2, a, b);
			for (int i = 0; i < b; i++)
				cout << arr2[i] << " ";
			cout << "\n";
		}
	}
	for (int i = 0; i < b; i++)
		delete[] arr[i];
	delete[] arr;

	system("pause");
	return 0;
}

*/


/*
void print(char** messages, int size)
{
	cout << "\n========MESSAGES========\n";
	for (int i = 0; i < size; i++) {
		cout << messages[i] << '\n';
	}
	cout << "========================\n\n";
}

void cpy(char** dest, char** source, int size)
{
	for (int i = 0; i < size; i++) {
		dest[i] = new char[10];
		strcpy(dest[i], source[i]);
	}
}

void memfree(char** messages, int size)
{
	if (!messages) return;

	for (int i = 0; i < size; i++) {
		delete[] messages[i];
	}
	delete[] messages;
}

int main()
{
	int index = 0;
	char** messages = 0;

	while (1)
	{
		cout << "Enter a message\n";
		char* msg = new char[10];
		cin >> msg;

		char** tmp = new char*[index + 1];
		cpy(tmp, messages, index);
		tmp[index++] = msg;

		memfree(messages, index - 1);
		messages = tmp;
		print(messages, index);
	}

	return 0;
}
*/
/*
int ** func(int *arr, int size , int num)
{
	int a = 0;
	int b = 0;
	if (size % num != 0) a = size / num + 1;
	else a = size / num;
	int** res = new int *[a];

	if (size % num != 0)
	{
		int i;
		for ( i = 0; i < size / num; i++)
			res[i] = new int[num];
		res[i] = new int[size%num];
	}
	else
	{
		for (int i = 0; i< a; i++)
			res[i] = new int[num];
	}

	for (int i = 0; i < a; i++)
	{
		
		res[i] = new int[num];
		for (int j = 0; j < num; j++)
		{
			res[i][j] = arr[b];
			b++;
		}
	}
	return res;
}

int main()
{
	int size;
	int num;
	int a;
	cout << "Massivin olcusunu daxil et\n";
	cin >> size;

	int * arr = new int[size];


	for (int i = 0; i < size; i++)
	{

		arr[i] =i;

	}
	cout << "Ededi daxil et\n";
	cin >> num;

	int **tmp = func(arr, size, num);

	if (size % num != 0) a = size / num + 1;
	else a = size / num;
	
	if (size % num != 0)
	{
		int i=0;
		for ( i = 0; i < a-1; i++)
		{
			
			for (int j = 0; j < num; j++)
			{
				cout << tmp[i][j] << "\t";
			}
			
			cout << "\n";

		}
		
			for (int j = 0; j < size % num; j++)
			{
				cout << tmp[i][j] << "\t";

			}
			cout << "\n";
		

	}
	else
	{
		for (int i = 0; i < a; i++)
		{
			for (int j = 0; j < num; j++)
			{
				cout << tmp[i][j] << "\t";
			}
			cout << "\n";
		}
	}
	system("pause");
	return 0;
}

*/
char** func(char **str, int num)
{
	int a = 0;
	bool flag1 = false;
	for (int i = 0; i < num; i++)
	{
		for (int j = i; j < num; j++)
		{
			if (strcmp(str[i], str[j]) == 0)
			{
				//if (flag1)
				a++;
				flag1 = true;
			}
		}
		flag1 = false;
	}
	cout << a<<'\n';
	char ** res = new char *[num-(a/2)];
	bool flag = true;
	for (int i = 0; i < num; i++)
	{
		for (int j = 0; j < num; j++)
		{
			if (strcmp(str[i], str[j]) == 0)
			{
				flag = false;
			}
		}
		if (flag)
		{
			res[i] = new char[strlen(str[i])+1];
			res[i] = str[i];
			res[i][strlen(str[i])] = '\0';
			flag = true;
		}
	}
	return res;
}


int main()
{
	int num;
	cout << "Soz sayini daxil edin\n";
	cin >> num;

	char ** str = new char *[num];

	for (int i = 0; i < num; i++)
	{
		str[i] = new char[10];

		cin >> str[i];
	}

	char ** tmp = func(str, num);

	for (int i = 0; i < num; i++)
	{
		cout << tmp[i];
		delete[] tmp[i];
	}
	delete[] tmp;

	system("pause");
	return 0;
}