#include <string>
#include <iostream>

class News
{
	std::string title;
	std::string text;

public:
	News() = default;
	News(std::string nTitle, std::string nText)
	{
		setTitle(nTitle);
		setText(nText);
	}
	void setTitle(std::string nTitle)
	{
		title = nTitle;
	}
	void setText(std::string nText)
	{
		text = nText;
	}
	std::string getTitle()
	{
		return title;
	}
	std::string getText()
	{
		return text;
	}
};