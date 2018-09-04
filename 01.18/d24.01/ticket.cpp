class Ticket
{
	int number;
	int price;
	bool stat = true;
	char * name;
	char * Sname;
public:
	void setNumber(int tNumber)
	{
		number = tNumber;
	}
	void setPrice(int tPrice)
	{
		price = tPrice;
	}
	int getPrice()
	{
		return price;
	}
	int getNumber()
	{
		return number;
	}
	void setStat(bool tStat)
	{
		stat = tStat;
	}
	bool getStat()
	{
		return stat;
	}
	void setName(char * cName)
	{
		name = cName;
	}
	char * getName()
	{
		return name;
	}
	void setSName(char * cName)
	{
		name = cName;
	}
	char * getSName()
	{
		return name;
	}
};