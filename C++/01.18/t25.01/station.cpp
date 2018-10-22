#include "client.cpp"
#include <conio.h>

class Station
{
	Ticket *ticket[5];
	Cashier * cashier[2];
	Cash * cash;
	int tCount = 0;
	int cCount = 0;
public:
	void printAll()
	{
		for (int i = 0; i < tCount; i++)
		{
			std::cout << "Number : " << ticket[i]->getNumber() << "\tPrice : " << ticket[i]->getPrice() << '\n';
			std::cout << "Stat : ";
			if (ticket[i]->getStat())
				std::cout << "not sold\n";
			else
			{
				std::cout << "sold out by :  ";
				std::cout << ticket[i]->getSName() << '\n';
			}
			std::cout << "Added by : " << ticket[i]->getName() << "\n\n";
		}
	}
	void printTickets()
	{
		for (int i = 0; i < tCount; i++)
			if (ticket[i]->getStat())
				std::cout << "Number : " << ticket[i]->getNumber() << "\tPrice : " << ticket[i]->getPrice() << '\n';
	}
	void addTicket(Ticket * sTicket)
	{
		ticket[tCount++] = sTicket;
	}
	void printCashier()
	{
		for (int i = 0; i < cCount; i++)
			std::cout << i + 1 << ". " << cashier[i]->getName() << '\n';
	}
	int getEarnings()
	{
		return cash->earnings();
	}
	int getCashierEarnings(int index)
	{
		int sum = 0;
		for (int i = 0; i < tCount; i++)
			if (strcmp(ticket[i]->getSName(), cashier[index - 1]->getName()) == 0)
				sum += ticket[i]->getPrice();
		return sum;
	}
	void addCashier(Cashier * sCashier)
	{
		cashier[cCount++] = sCashier;
	}
	void buyTicket(int index, Client * client)
	{
		int cindex = rand() % 2;
		ticket[index - 1]->setStat(false);
		ticket[index - 1]->setSName(cashier[cindex]->getName());
		client->addTicket(ticket[index - 1]);
		client->changeMoney(ticket[index - 1]->getPrice());
		cash->addMoney(ticket[index - 1]->getPrice());
		cash->addTicket(ticket[index - 1]);
	}
	void addCash(Cash * sCash)
	{
		cash = sCash;
	}
};