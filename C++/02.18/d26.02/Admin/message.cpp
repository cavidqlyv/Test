#include <string>

#pragma warning (disable : 4996)

class Message
{
	char name[10];
	char content[10];
	bool stat = true;
public:
	Message(std::string mName, std::string mContent)
	{
		strcpy(name, mName.c_str());
		strcpy(content, mContent.c_str());
	}
	void setName(std::string mName)
	{
		strcpy(name, mName.c_str());
	}
	void steContent(std::string mContent)
	{
		strcpy(content, mContent.c_str());
	}
	void setStat(bool mStat)
	{
		stat = mStat;
	}
	std::string getName()
	{
		return name;
	}
	std::string getContent()
	{
		return content;
	}
	bool getStat()
	{
		return stat;
	}
};