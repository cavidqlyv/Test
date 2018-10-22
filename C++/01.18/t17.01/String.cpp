#include <iostream>
#pragma warning(disable : 4996) 
class String
{
	char *string = nullptr;
public:
	String()
	{
		string = new char('\0');
	}
	String(const char * arr)
	{
		string = new char[strlen(arr) + 1];
		strcpy(string, arr);
	}
	String(const String& sString)
	{
		int num = strlen (sString.string);
		string = new char[num + 1];
		strcpy(string, sString.string);
	}
	~String()
	{
		if (string)
			delete[] string;
	}
	int size()
	{
		int i = strlen(string);
		return i;
	}
	void deleteString()
	{
		string[0] = '\0';
	}
	bool stat()
	{
		if (string[0] == '\0')
			return false;
		else return true;
	}
	char * getString()
	{
		return string;
	}
	void print()
	{
		std::cout << "String : " << getString() << "\n";
		std::cout << "Size : " << size() << "\n";
		if (stat())
			std::cout << "Full\n";
		else
			std::cout << "Empty\n";
	}
	void pushBack(const char * sStirng)
	{
		int a = size();
		int b = strlen(sStirng);
		char * tmp = new char[a + strlen(sStirng) + 1];
		strcpy(tmp, string);
		strcat(tmp, sStirng);
		if (string)
		{
			delete[] string;
			string = nullptr;
		}
		string = tmp;
	}
};