#include <iostream>
#include <iomanip>
#include "bank.cpp"

int main()
{
	std::string user1Name = "aaaa";
	std::string user2Name = "bbbb";
	std::string user3Name = "cccc";
	std::string user4Name = "dddd";
	std::string user5Name = "eeee";

	User user1(user1Name);
	User user2(user2Name);
	User user3(user3Name);
	User user4(user4Name);
	User user5(user5Name);

	Bank * bank = new Bank;

	bank->addCash(user1, 1);
	bank->addCash(user1, 2);
	bank->addCash(user1, 3);

	//bank->print();

	system("pause");
	return 0;
}