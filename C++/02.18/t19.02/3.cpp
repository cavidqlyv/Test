#include <iostream>
#include <string>

struct Code1 : std::exception
{
	Code1(const char * reason) : std::exception(reason) {}

};
struct Code2 : std::exception
{
	Code2(const char * reason) : std::exception(reason) {}

};

class File
{
	std::string name;
	std::string content;
public:
	void setName(std::string fName)
	{
		name = fName;
	}
	void setContent(std::string fContent)
	{
		content = fContent;
	}
	std::string getName()
	{
		return name;
	}
	std::string getContent()
	{
		return content;
	}
};

class HardDisk
{
	int size = 2;
	File ** file;
	int count = 0;
public:
	HardDisk()
	{
		file = new File*[size];
	}
	void createFile(std::string fName)
	{
		if (count < size)
		{
			file[count] = new File;
			file[count++]->setName(fName);
		}
		else
		{
			throw Code2("No more space in hard disk");
		}
	}
	void writeFile(std::string fName, std::string fContent)
	{
		for (int i = 0; i < count; i++)
		{
			if (fName == file[i]->getName())
			{
				file[i]->setContent(fContent);
				return;
			}
		}
		throw Code1("No File");
	}
	void printList()
	{
		for (int i = 0; i < count; i++)
		{
			std::cout << "Name : " << file[i]->getName() << "\n";
			std::cout << "Content : " << file[i]->getContent() << '\n';
		}
	}
};

int main()
{
	HardDisk hardDisk;

	hardDisk.createFile("aaa");

	try
	{
		hardDisk.writeFile("aaaa", "bbbb");
		std::cout << "OK!" << '\n';
	}
	catch (Code1 e)
	{
		std::cout << e.what() << '\n';
	}

	hardDisk.createFile("aaabb");

	try
	{
		hardDisk.createFile("aaabbcc");
		std::cout << "OK!" << '\n';
	}
	catch (Code2 e)
	{
		std::cout << e.what() << '\n';
	}

	hardDisk.printList();

	system("pause");
	return 0;
}