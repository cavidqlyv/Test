#include<iostream>
#include "time.cpp"
#include <conio.h>

#define KB_UP 72
#define KB_DOWN 80

std::ostream& operator << (std::ostream& os, const Time& time)
{
	os << time.getMinute() << ":" << time.getSecond();
	return os;
}

int main()
{
	int key;
	Time time;
	while (1)
	{
		system("cls");
		std::cout << time << "\n";
		key = _getch();
		if (key == KB_UP)
			(++time);
		else if (key == KB_DOWN)
			(--time);
		time.func();
	}
	system("pause");
	return 0;
}