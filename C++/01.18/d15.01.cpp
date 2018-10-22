#include<iostream>
#pragma warning(disable : 4996) 




class Book
{
	char * name = nullptr;
	char * author = nullptr;
	int year;

public:
	~Book()
	{
		if (name)
			delete[] name;
		if (author)
			delete[] author;
	}
	Book(char * bName, char * bAuthor, int bYear)
	{
		setName(bName);
		setAuthor(bAuthor);
		setYear(bYear);
	}
	//Book(const Book& book)
	//{
	//	year = book.year;
	//}
	void setName(char * bName)
	{
		name = bName;
	}
	void setAuthor(char * bAuthor)
	{
		author = bAuthor;
	}
	void setYear(int bYear)
	{
		year = bYear;
	}
	char * getName()
	{
		return name;
	}
	char * getAuthor()
	{
		return author;
	}
	int getYear()
	{
		return year;
	}

};

class searchResult
{
	int count;
	int* result;
	int tmpCount = 0;
public:
	void setResult(int num)
	{
		result[tmpCount++] = num;
	}
	void setCount(int bCount)
	{
		count = bCount;
		result = new int[count];

	}
	int getCount()
	{
		return count;
	}
	int* getResult()
	{
		return result;
	}
};

class BookCase
{
	Book* book[10];
	int count = 0;

public:


	~BookCase()
	{
		for (int i = 0; i < count; i++)
		{
			delete book[i];
		}
	}
	void addBook(Book * uBook)
	{
		book[count++] = uBook;
	}
	searchResult  *findByYear(int bYear)
	{
		searchResult* tmp = new searchResult;
		int count1 = 0;
		for (int i = 0; i < count; i++)
		{
			if (bYear == book[i]->getYear())
			{
				count1++;
			}
		}
		tmp->setCount(count1);

		for (int i = 0; i < count; i++)
		{
			if (bYear == book[i]->getYear())
			{
				tmp->setResult(i);
			}
		}
		return tmp;
	}
	searchResult  *findByName(char *bName)
	{
		searchResult* tmp = new searchResult;
		int count1 = 0;

		for (int i = 0; i < count; i++)
		{
			if (strcmp(bName, book[i]->getName()) == 0)
			{
				count1++;
			}
		}
		tmp->setCount(count1);
		for (int i = 0; i < count; i++)
		{
			if (strcmp(bName, book[i]->getName()) == 0)
			{
				tmp->setResult(i);
			}
		}
		return tmp;
	}
	searchResult* findByAuthor(char *bAuthor)
	{
		searchResult* tmp = new searchResult;

		int count1 = 0;
		for (int i = 0; i < count; i++)
		{
			if (strcmp(bAuthor, book[i]->getAuthor()) == 0)
			{
				count1++;
			}
		}
		tmp->setCount(count1);
		for (int i = 0; i < count; i++)
		{
			if (strcmp(bAuthor, book[i]->getAuthor()) == 0)
			{
				tmp->setResult(i);
			}
		}
		return tmp;
	}
	void printBook(searchResult * tmp)
	{
		int * arr = tmp->getResult();
		int  count = tmp->getCount();
		for (int i = 0; i < count; i++)
		{
			std::cout << "\n==============================================================================================\n\n";
			std::cout << "Name : " << book[arr[i]]->getName() << "\n";
			std::cout << "Author : " << book[arr[i]]->getAuthor() << "\n";
			std::cout << "Year : " << book[arr[i]]->getYear() << "\n";
		}
	}

};

int main()
{
	BookCase bookCase;
	int a;
	char b[10];
	bookCase.addBook(new Book(new char[10]{ "aaaa" }, new char[10]{ "bbbbb" }, 2015));
	bookCase.addBook(new Book(new char[10]{ "aaaa" }, new char[10]{ "ccccc" }, 2014));
	bookCase.addBook(new Book(new char[10]{ "aaaa" }, new char[10]{ "ddddd" }, 2013));
	bookCase.addBook(new Book(new char[10]{ "aaaa" }, new char[10]{ "eeeee" }, 2012));
	bookCase.addBook(new Book(new char[10]{ "ffff" }, new char[10]{ "hhhhh" }, 2011));
	bookCase.addBook(new Book(new char[10]{ "ffff" }, new char[10]{ "ggggg" }, 2010));
	bookCase.addBook(new Book(new char[10]{ "ffff" }, new char[10]{ "ttttt" }, 2009));
	bookCase.addBook(new Book(new char[10]{ "jjjj" }, new char[10]{ "ooooo" }, 2008));

	while (1)
	{
		std::cout << "Find by name 1\n";
		std::cout << "Find by author 2\n";
		std::cout << "Find by year 3\n";
		std::cin >> a;
		if (a == 1)
		{
			std::cout << "Enter name\n";
			std::cin >> b;
			bookCase.printBook(bookCase.findByName(b));

		}
		if (a == 2)
		{
			std::cout << "Enter author\n";
			std::cin >> b;
			bookCase.printBook(bookCase.findByAuthor(b));

		}
		if (a == 3)
		{
			std::cout << "Enter year\n";
			std::cin >> a;
			bookCase.printBook( bookCase.findByYear(a));

		}
	}


	system("pause");
	return 0;
}