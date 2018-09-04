#include <iostream>
#include "news.h"


#pragma warning(disable : 4996) 
int main()
{
	News news;
	char *uName = new char[10]{ "aaa" };
	char *uEmail = new char[20]{ "aaa@gmail.com" };
	char *uName1 = new char[10]{ "aaa" };
	char *uEmail1 = new char[20]{ "aaa@gmail.com" };
	char *uName2 = new char[10]{ "ccc" };
	char *uEmail2 = new char[20]{ "ccc@gmail.com" };
	news.addUser(uName, uEmail);
	news.addUser(uName1, uEmail1);
	news.addUser(uName2, uEmail2);

	news.changeUserStat(false, 2);

	char * nTitle = new char[10]{ "Hello" };
	char * nText = new char[100]{ "gsakjhgdsljfhsahjd;jashjsa" };
	news.addNews(nTitle, nText);

	delete[] uName;
	delete[] uName1;
	delete[] uName2;
	delete[] uEmail;
	delete[] uEmail1;
	delete[] uEmail2;
	delete[] nTitle;
	delete[] nText;

	system("pause");
	return 0;
}