#include<iostream>
#include "Cinema.cpp"
#pragma warning(disable : 4996) 


int main()
{

	Cinema cinema;
	char * tmpName = new char[10]{ "aaa" };

	cinema.setName(tmpName);
	cinema.setDuration(150);
	cinema.setYear(2013);
	char ** tmpStaffName = new char *[5];
	char ** tmpStaffJob = new char *[5];
	Staff ** tmp = new Staff *[5];
	for (int i = 0; i < 5; i++)
	{
		tmpStaffName[i] = new char[10];
		tmpStaffJob[i] = new char[10];
		std::cout << "Enter Staff Name\n";
		std::cin >> tmpStaffName[i];
		std::cout << "Enter Staff Job\n";
		std::cin >> tmpStaffJob[i];
		tmp[i] = new Staff(tmpStaffName[i], tmpStaffJob[i]);
		cinema.addStaff(tmp[i]);
	}

	cinema.print();

	for (int i = 0; i < 5; i++)
	{
		delete[] tmpStaffName[i];
		delete[] tmpStaffJob[i];
		delete[] tmp[i];
	}
	delete tmpStaffName;
	delete tmpStaffJob;
	delete tmp;

	system("pause");
	return 0;
}