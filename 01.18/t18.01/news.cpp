#include <iostream>


class News
{
	char * title;
	char * text;
	
public:
	News(char * nTitle, char * nText)
	{
		setTitle(nTitle);
		setText(nText);
	}
	
	void setTitle(char * nTitle)
	{
		title = nTitle;
	}
	void setText(char * nText)
	{
		text = nText;
	}
	char * getTitle()
	{
		return title;
	}
	char *getText()
	{
		return text;
	}


};