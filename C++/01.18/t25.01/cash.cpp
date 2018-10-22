#include "ticket.cpp"

class Cash
{
	Ticket *ticket[5];
	int count = 0;
	int money = 0;
public:
	void addTicket(Ticket * cTicket)
	{
		ticket[count++] = cTicket;
	}
	int earnings()
	{
		int sum = 0;
		for (int i = 0; i < count; i++)
			sum += ticket[i]->getPrice();
		return sum;
	}
	void addMoney(int tPrice)
	{
		money += tPrice;
	}
};