#include <iostream>
using namespace std;



int main()
{
	char a[10];


	bool flag=true;
	int b = 0;
	int c = 3;
	char **arr = new  char *[c];

	for (int j=0 ; j<5 ; j++)
	{
		cin >> a;

		

		arr[b] = new char[strlen(a) + 1];
		arr[b][strlen(a) ] = '\0';
		for (int i = 0; i < strlen(a); i++)
		{
			arr[b][i] = a[i];
		}
		
		for (int i = 0; i <= b; i++)
			cout << arr[i] << " ";
		cout << "\n";
		b++;
		
	}

	system("pause");
	return 0;
}