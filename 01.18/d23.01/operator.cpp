class Operator
{
	char * name;
	bool stat =false;
public:
	void setName(char * oName)
	{
		name = oName;
	}
	void setStat(bool oStat)
	{
		stat = oStat;
	}
	char * getName()
	{
		return name;
	}
	bool getStat()
	{
		return stat;
	}
};