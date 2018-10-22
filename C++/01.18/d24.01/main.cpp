#include <iostream>
#include "station.cpp"



int main()
{
	char* cashierName1 = new char[10]{ "aaaa" };
	char* cashierName2 = new char[10]{ "bbbb" };

	Station station;

	Cashier* cashier1 = new Cashier;
	Cashier *cashier2 = new Cashier;
	cashier1->setName(cashierName1);
	cashier2->setName(cashierName2);

	station.addCashier(cashier1);
	station.addCashier(cashier2);

	Client *client = new Client;

	Cash * cash = new Cash;
	station.addCash(cash);

	int num;
	int tmp;
	int tmp2;
	while (1)
	{
		std::cout << "Cashier 1\n";
		std::cout << "Client 2\n";
		std::cin >> num;
		if (num == 1)
		{
			std::cout << "Show all tickets 1\n";
			std::cout << "Show earnings 2\n";
			std::cout << "Show cashier eranings 3\n";
			std::cout << "Add ticket 4\n";
			std::cin >> num;
			if (num == 1)
			{
				station.printAll();
			}
			else if (num == 2)
			{
				std::cout << "Earnings : " << station.getEarnings() << '\n';
			}
			else if (num == 3)
			{
				station.printCashier();
				std::cout << "Enter cashier number\n";
				std::cin >> tmp2;
				std::cout << station.getCashierEarnings(tmp2) << " manat \n";
			}
			else if (num == 4)
			{
				std::cout << "Enter number\n";
				std::cin >> num;
				std::cout << "Enter price\n";
				std::cin >> tmp;
				station.printCashier();
				std::cout << "Enter cashier number\n";
				std::cin >> tmp2;
				station.addTicket(num, tmp, tmp2);
			}
		}
		else
		{
			station.printTickets();
			std::cout << "Add ticket number\n";
			std::cin >> num;
			if (num != 0)
				station.buyTicket(num, client);
		}
	}
	delete[] cashierName1;
	delete[] cashierName2;

	delete cashier1;
	delete cashier2;

	delete cash;
	delete client;

	system("pause");
	return 0;
}