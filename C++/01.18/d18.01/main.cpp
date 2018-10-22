#include <iostream>
#include "operators.cpp"

std::ostream& operator<<(std::ostream& os, const Opr& opr1)
{
	os << opr1.getNum();
	return os;
}

int main()
{
	Opr opr(10);
	Opr opr1(5);


	std::cout << "opr + opr1 : " << opr + opr1 << "\n";
	std::cout << "opr - opr1 : " << opr - opr1 << "\n";
	std::cout << "opr * opr1 : " << opr * opr1 << "\n";
	std::cout << "opr / opr1 : " << opr / opr1 << "\n";
	std::cout << "opr += opr1 : " << (opr += opr1) << "\n";
	std::cout << "opr -= opr1 : " << (opr -= opr1) << "\n";
	std::cout << "opr++ : " << (opr++) << "\n";
	std::cout << "++opr : " << (++opr) << "\n";
	std::cout << "opr-- : " << (opr--) << "\n";
	std::cout << "--opr : " << (--opr) << "\n";
	std::cout << "opr >= opr1 : " << (opr >= opr1) << "\n";
	std::cout << "opr <= opr1 : " << (opr <= opr1) << "\n";
	std::cout << "opr > opr1 : " << (opr > opr1) << "\n";
	std::cout << "opr < opr1 : " << (opr < opr1) << "\n";
	std::cout << "opr != opr1 : " << (opr != opr1) << "\n";
	std::cout << "opr == opr1 : " << (opr == opr1) << "\n";
	if (opr)
	{
		std::cout << "true\n";
	}
	else
	{
		std::cout << "true\n";
	}



	system("pause");
	return 0;
}