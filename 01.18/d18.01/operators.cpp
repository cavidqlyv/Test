class Opr
{
	int num;
public:
	Opr(int n) :num(n){}
	Opr operator +(const Opr & oOpr)
	{
		return Opr(num + oOpr.num);
	}
	Opr operator -(const Opr & oOpr)
	{
		return Opr(num - oOpr.num);
	}
	Opr operator *(const Opr & oOpr)
	{
		return Opr(num * oOpr.num);
	}
	Opr operator /(const Opr & oOpr)
	{
		return Opr(num / oOpr.num);
	}
	Opr& operator +=(Opr & oOpr)
	{
		num += oOpr.num;
		return *this;
	}
	Opr& operator -=(Opr & oOpr)
	{
		num -= oOpr.num;
		return *this;
	}
	Opr& operator ++()
	{
		++num;
		return *this;
	}
	Opr& operator ++(int)
	{
		Opr tmp = *this; 
		++num;
		return tmp;
	}
	Opr& operator --(int)
	{
		Opr tmp = *this;
		--num;
		return tmp;
	}
	Opr& operator --()
	{
		--num;
		return *this;
	}
	bool operator >=(Opr & oOpr)
	{
		return num >= oOpr.num;
	}
	bool operator <=(Opr & oOpr)
	{
		return num <= oOpr.num;
	}
	bool operator >(Opr & oOpr)
	{
		return num > oOpr.num;
	}
	bool operator <(Opr & oOpr)
	{
		return num < oOpr.num;
	}
	bool operator !=(Opr & oOpr)
	{
		return num != oOpr.num;
	}
	bool operator ==(Opr & oOpr)
	{
		return num == oOpr.num;
	}
	int getNum() const
	{
		return num;
	}
	operator bool()
	{
		return num != 0;
	}
};