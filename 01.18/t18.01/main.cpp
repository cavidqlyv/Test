#include <iostream>
#include "site.cpp"

#pragma warning(disable : 4996) 
int main()
{
	Site site;
	//std::cout << "1\n";
	char *uName = new char[10]{ "aaa" };
	char *uEmail = new char[20]{ "aaa@gmail.com" };
	char *uName1 = new char[10]{ "aaa" };
	char *uEmail1 = new char[20]{ "aba@gmail.com" };
	char *uName2 = new char[10]{ "ccc" };
	char *uEmail2 = new char[20]{ "ccc@gmail.com" };
	//std::cout << "2\n";

	site.addUser(uName, uEmail);
	site.addUser(uName1, uEmail1);
	site.addUser(uName2, uEmail2);
	//std::cout << "3\n";

	//site.changeUserStat(false, 1);
	//std::cout << "4\n";

	char * nTitle = new char[10]{ "Hello" };
	char * nText = new char[100]{ "gsakjhgdsljfhsahjd;jashjsa" };
	//std::cout << "5\n";

	News *tmp = new News(nTitle, nText);
	site.addNews(tmp);
	//std::cout << "6\n";

	delete[] uName;
	delete[] uName1;
	delete[] uName2;
	delete[] uEmail;
	delete[] uEmail1;
	delete[] uEmail2;
	delete[] nTitle;
	delete[] nText;
	delete tmp;

	system("pause");
	return 0;
}