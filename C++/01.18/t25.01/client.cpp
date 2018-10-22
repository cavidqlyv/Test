#include "cashier.cpp"

class Client
{
	int money = 500;
	Ticket * ticket[3];
	int	count = 0;
public:
	void addTicket(Ticket * cTicket)
	{
		ticket[count++] = cTicket;
	}
	void changeMoney(int price)
	{
		money -= price;
	}
};