#include <iostream>
#pragma warning (disable: 4996)
#include <cstdio>

using namespace std;

template<typename T>
void toBin(T data)
{
	unsigned int stop = 0 - 1;
	for (unsigned int i = (sizeof(T) * 8) - 1; i != stop; i--)
	{

		cout << (data & ((T)1 << i) ? 1 : 0);
	}

	//00000001
	//(1 << 6) 01000000

	/*
	00000001
	&
	10000000
	*/
}

int main()
{
	/*
	Ev tapshirigi:
	1. proqramda 3 option olmalidir
	2. options-lari saxlayan deyishen yaradin (uint8_t)
	3. her option-i yandirib sondurmek imkani olmalidir
	4. optionlari cap eden funksiya yaradin
	*/

	/*
	Encrypting example (DO NOT USE IN PRODUCTION)
	char name[] = "Mike";
	char key = 'z';

	for (int i = 0; i < 4; i++) {
	name[i] ^= key;
	}

	cout << name << '\n';

	for (int i = 0; i < 4; i++) {
	name[i] ^= key;
	}

	cout << name << '\n';
	*/
	/*
	1
	00000001
	<< to left
	>> to right

	uint8_t n = 1;//00000001
	n = n << 1; //00000010
	n = n >> 1; //00000001

	uint8_t n1 = 1;
	uint8_t n2 = 1;
	uint8_t n3 = n1 & n2;

	00010001
	00000001 & (bitwise and)
	00000001 <- result

	00010001
	00000001 | (bitwise or)
	00010001 <- result

	00010001
	00000001 ^ (xor)
	00010000 <- result

	00000001 ~ (bit inversion)
	11111110 <- result

	01110110
	*/
	int a;
	uint8_t opt1 = 255;//00000001
	int tmp=0;

	uint8_t flags = 0;//00000000

					  //flags |= opt1 | opt2; //(opt1 | opt2 == 00000011)

					  /*
					  flags == 00000011
					  opt1  == 00000001
					  &	  == 00000001
					  */
	toBin(opt1);
	//cout << '\n';
	//while (1)
	//{
	//	if (opt1 == 1)
	//		break;
	//	 opt1 >>= 1;
	//	//cout << opt1<<'\n';
	//	
	//}
	//opt1 >>= 3;
	//opt1 <<= 2;
	tmp = ~opt1;


	opt1 = opt1 ^ tmp;
	opt1 <<= 1;
	cout << '\n';
	toBin(opt1);

	/*bool flag1 = true;
	bool flag2 = true;
	bool flag3 = true;
	while (1)
	{
		system("cls");
		cout << "1 ci ucun 1\n";
		cout << "2 ci ucun 2\n";
		cout << "3 ci ucun 3\n";
		cout << "baxmaq ucun 4\n";
		cin >> a;
		if (a == 1 && flag1)
		{
			flags |= opt1;
			flag1 = false;
		}
		else if (a == 1 && !flag1)
		{
			flags &= ~opt1;
			flag1 = true;
		}
		else if (a == 2 && flag2)
		{
			flags |= opt2;
			flag2 = false;
		}
		else if (a == 2 && !flag2)
		{
			flags &= ~opt1;
			flag2 = true;
		}
		else if (a == 3 && flag3)
		{
			flags |= opt3;
			flag3 = false;
		}
		else if (a == 3 && !flag3)
		{
			flags &= ~opt1;
			flag3 = true;
		}

		if (a == 4)
		{
			if (flags & opt1)
			{
				cout << "opt1 is enabled\n";
			}
			else
			{
				cout << "opt1 is disabled\n";
			}
			if (flags & opt2)
			{
				cout << "opt2 is enabled\n";
			}
			else
			{
				cout << "opt2 is disabled\n";
			}
			if (flags & opt3)
			{
				cout << "opt3 is enabled\n";
			}
			else
			{
				cout << "opt3 is disabled\n";
			}*/
			//flags &= ~opt1;

	/*
	flags == 00000011
	~opt1 == 11111110 (previously opt1 value 00000001)
	&	  == 00000010
	*/

	system("pause");
	return 0;
}