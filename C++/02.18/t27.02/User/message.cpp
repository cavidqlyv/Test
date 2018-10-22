#include "node.cpp"
#include <string>

#pragma warning (disable :4996)

class Message
{
	char name[10];
	char content[10];
	bool stat;
public:
	void setName(std::string mName)
	{
		strcpy(name, mName.c_str());
	}
	void setContent(std::string mContent)
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