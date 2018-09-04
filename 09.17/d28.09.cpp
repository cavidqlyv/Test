#include <iostream>
using namespace std;


/*
void log() {
	char a[50];
	cout << "Ad daxil et\n";
	cin >> a;
	cout << a << "\n";


}


int main() {
	
	

	log();


	return 0;
}
*/
/*
bool num(int a)
{
	if (a < 0)
	{
		return false;
	}
	else 
	{
		return true;
	}
}
	int main() {

		int a;
		cin >> a;
		cout << num(a) << "\n";

		return 0;

	}

	*/

/*
int num( int a, int b)
{
	int c=0;
	if (a < b) 
	{
		while (a != b-1)
		{
			a++;
			c = c + a;
			
		}
	}
	else if (a > b)
	{
		while (a != b-1)
		{
			b++;
			c = c + b;
			
		}

	}
	return c;
}

int main()
{
	int a, b;
	cout << "Birinci reqem\n";
	cin >> a;
	cout << "Ikinci reqem\n";
	cin >> b;
	cout << num(a, b) << "\n";

}
*/


int num(int a[5])
{
	int b=0;
	for (int i = 0; i < 5; i++)
	{
		if (a[i] < 0)
		{
			b++;
		}
		else if (a[i] > 0)
		{
			b++;
		}
	}
	return b;

}
int main() {
	int a[5];
	cout << "Reqemleri daxil et\n";
	for (int i = 0; i < 5; i++)
	{
		cin >> a[i];
	}
	cout<<"\n" << num(a) << "\n";


	return 0;

}

