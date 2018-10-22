#include <iostream>
using namespace std;



float cem(float a , float b) {

	return a + b;
}


float ferq(float a, float b) {

	return a - b;

}


float hasil(float a, float b) {

	return a*b;
}


float bolme(float a, float b) {

	return a / b;
}


float operation(float  num , char a , float num1) {
	if (a == '+')
	{
		return cem(num, num1);
	}
	else if (a == '-')
	{
		return ferq(num, num1);
	}
	else if (a == '*')
	{
		return hasil(num, num1);
	}
	else if (a == '/')
	{
		return bolme(num, num1);
	}
	
}


float calculator() {

	float a = 0;
	float b = 0;
	char c;
	
		cout << "1 ci ededi daxil edin\n\n";
		cin >> a;
		cout << "\nemeliyati daxil edin\n\n";
		cin >> c;
		cout << "\n2 ci ededi daxil edin\n\n";
		cin >> b;

		cout << "\nCavab = " << operation(a, c, b) << "\n\n";
	
	return 0;

}

void fayl(char file[5][10], char file1[5][200] , int a = 0 ) {

	
	int file2 = 1;
	int  b = 0;


	while (file2 != 0)
	{

		cout << "\nTeze fayl yaratmaq ucun 1 daxil edin\n";
		cout << "Fayllara baxmaq ucun 2 daxil edin\n";
		cout << "Redakte etmek ucun 3 daxil edin\n";
		cout << "Silmek ucun 4 daxil edin\n";
		cout << "Faylin adini deyismek ucun 5 daxil edin\n";
		cout << "Geri qayitmaq ucun 0 daxil edin\n";
		cin >> file2;
		if (file2 == 1 && a<5)
		{
			cout << "Faylin adini daxil edin\n";
			cin >> file[a];
			cout << "melumati daxil edin\n";
			cin >> file1[a];
			a++;
			
		}
		else if (file2 == 1 && a >= 5)
		{
			cout << "Artiq faly yarada bilmezsiniz\n";
		}
		else if (file2 == 2 && a == 0)
		{
			cout << "Hec bir fayl yoxdur\n";
		}
		else if (file2 == 3 && a == 0)
		{
			cout << "Hec bir fayl yoxdur\n";
		}
		else if (file2 == 4 && a == 0)
		{
			cout << "Hec bir fayl yoxdur\n";
		}
		else if (file2 == 2 && a != 0)
		{
			cout << "fayllar : \n";
			for (int i = 0; i < a; i++)
			{
				cout << file[i] << "\n";
			}
			cout << "Baxmaq istediyiniz faylin nomresini daxil edin\n";
			cin >> b;
			if (file[b-1][0] == '\0')
			{
				cout << "Bele fayl yoxdur\n";
			}
			else
			{
				cout << "Fayl : " << file[b-1] << "\n";
				cout << "\n\n" << file1[b-1] << "\n";
			}


		}
		else if (file2 == 3 && a != 0)
		{
			cout << "Redakte etmek istediyiniz faylin nomresini daxil edin\n";
			cin >> b;
			if (file[b-1][0] == '\0')
			{
				cout << "Bele fayl yoxdur\n";
			}
			else
			{
				cout << "Faylin adini daxil edin\n";
				cin >> file[b-1];
				cout << "Melumati daxil edin\n";
				cin >> file1[b-1];
				cout << "Fayl deyisdirildi\n";
			}
		}
		else if (file2 == 4 && a != 0)
		{
			cout << "Silmek istediyiniz faylin nomresini daxil edin\n";
			cin >> b;
			if (file[b-1][0] == '\0')
			{
				cout << "Bele fayl yoxdur\n";
			}
			else
			{
				file[b-1][0] = '\0';
				cout << "fayl silindi\n";
			}
		}
		else if (file2 == 5 && a == 0)
		{
			cout << "Hec bir fayl yoxdur\n";
		}
		else if (file2 == 5 && a != 0)
		{
			cout << "Adini deyismek istediyiniz faylin nomresini daxil edin\n";
			cin >> b;
			if (file[b - 1][0] == '\0')
			{
				cout << "Bele fayl yoxdur\n";
			}
			else
			{
				cout << "Faylin teze adini daxil edin\n";
				cin >> file[b - 1];
				cout << "Faylin adini deyisdiz\n";
			}
		}



	}
	


}
int pas(int a) {

	int b = 1234;
	//cin >> a;
	if (a== b)
	{
		return 1;
	}
	else
	{
		return 0;
	}

}


void prog5(){
	int prog1 = 1;
	int  a = 0;
	char file[5][10];
	char file1[5][200];
	//cout << "a\n";
	for (int i = 0; i < 5; i++)
	{

		file[i][0] = '\0';


	}
	prog1 = 1;
	while (prog1 != 0)
	{
		cout << "Kalkulyator ucun 1 daxil et\n";
		cout << "File manager ucun 2 daxil et\n";
		cout << "Baglamaq ucun 0 daxil edin\n";
		cin >> prog1;

		if (prog1 == 1)
		{
			calculator();
		}
		else if (prog1 == 2)
		{
			fayl(file, file1, a = 0);
		}
		else if (prog1!=1 && prog1 !=2 && prog1 !=0 )
		{
			cout << "Duzgun daxil et\n";
		}
	}
}



int main() {

	int prog = 1 , pas1 =0;
	
	
	while (prog != 0)
	{
		cout << "Sifreni daxil edin\n";
		cin >> pas1;
		if (pas(pas1) == 0)
		{
			cout << "Yalnisdir tekrar daxil et\n";
		}
		else
		{
			prog5();
		}
		
		
		
	}
	
}

