class Time
{
	int second = 30;
	int minute = 59;
public:
	int getSecond() const
	{
		return second;
	}
	int getMinute() const
	{
		return minute;
	}
	Time& operator ++ ()
	{
		++second;
		return *this;
	}
	Time& operator -- ()
	{
		--second;
		return *this;
	}
	void func()
	{
		if (second == 60&& minute <59)
		{
			second = 0;
			minute++;
		}
		else if (second == -1 && minute >1 )
		{
			second = 59;
			minute--;
		}
		else if (second == -1 && minute == 0)
		{
			second = 0;
			minute = 0;
		}
		else if (second == 60 && minute == 59)
		{
			second = 0;
			minute = 0;
		}
	}
};