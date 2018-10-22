#include <iostream>
#include <string>
#include <chrono>
#include <filesystem>
#include <conio.h>
#include <Windows.h>
#include <experimental\filesystem>

#define KB_LEFT 75
#define KB_UP 72
#define KB_DOWN 80
#define KB_RIGHT 77
#define KB_ESCAPE 27
#define KB_ENTER 13
#define KB_BACKSPACE 8

#pragma warning (disable:4996)

namespace fs = std::experimental::filesystem;

class Filesystem
{
	std::string base;
	std::string current;
	int count;
	int pos = 1;
public:
	Filesystem(std::string fBase)
	{
		base = fBase;
		current = base;
	}
	Filesystem()
	{
		base = "%appdata%\\";
		current = base;
	}
	void printDirectory()
	{
		HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

		system("cls");
		count = 0;
		for (auto p : fs::directory_iterator(current))
			count++;

		int i = 0;
		for (auto p : fs::directory_iterator(current))
		{
			i++;
			auto ftime = fs::last_write_time(p);
			std::time_t time = std::chrono::system_clock::to_time_t(ftime);

			//p.replace(10, 5, "red");

			//show only relative path
			std::cout << "Filename: ";
			if (i == pos)
			{
				SetConsoleTextAttribute(hConsole, 112);
				std::cout << p;
				SetConsoleTextAttribute(hConsole, 7);
			}
			else
				std::cout << p;
			std::cout << " : " << '\n';
			if (!fs::is_directory(p))
			{
				if (fs::file_size(p) >= 1048576)
					std::cout << "Size: " << fs::file_size(p) / 1048576 << " MB\n";
				else if (fs::file_size(p) >= 1024)
					std::cout << "Size: " << fs::file_size(p) / 1024 << " KB\n";
				else
					std::cout << "Size: " << fs::file_size(p) << '\n';
			}
			std::cout << "Last modified: " << std::asctime(std::localtime(&time)) << '\n';
		}
	}
	void createFolder(std::string fName)
	{
		fs::create_directories(current + fName);
	}
	void operator++(int)
	{
		pos++;
	}
	void  operator--(int)
	{
		pos--;
	}
	int getPos()
	{
		return pos;
	}
	void setPos(int fPos)
	{
		pos = fPos;
	}
};


int main()
{
	std::string base = "%appdata%\\";
	fs::create_directories(base + "New Folder");
	std::string current = base + "New Folder";
	//fs::path currentPath;

	Filesystem fileSystem;

	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

	int count = 0;
	int key;
	//int pos = 1;
	while (1)
	{
		fileSystem.printDirectory();


		key = _getch();
		if (key == KB_UP)
			fileSystem--;
		else if (key == KB_DOWN)
			fileSystem++;
		else if (key == KB_ENTER)
		{
			int tmp = 0;
			for (auto p : fs::directory_iterator(current))
			{
				tmp++;
				if (fileSystem.getPos() == tmp)
				{
					current = p.path().string();
					break;
				}
			}
			fileSystem.setPos(1);
		}
		else if (key == KB_BACKSPACE)
		{
			while (1)
			{
				if (current.back() != '\\')
					current.pop_back();
				else
					break;
			}
			current.pop_back();
			fileSystem.setPos(1);
		}

		if (fileSystem.getPos() == 0)
			fileSystem.setPos(count);

		else if (fileSystem.getPos() == count + 1)
			fileSystem.setPos(1);
	}

	/*
	std::string base = "%appdata%\\";
	std::string path = base + "test_folder\\";

	for (auto p : fs::recursive_directory_iterator(path))
	{
		auto ftime = fs::last_write_time(p);
		std::time_t
			time = std::chrono::system_clock::to_time_t(ftime);

		//show only relative path
		std::cout << "Filename: " << p << '\n';
		if (!fs::is_directory(p)) {
			std::cout << "Size: " << fs::file_size(p) << '\n';
		}

		std::cout << "Last modified: " << std::asctime(std::localtime(&time)) << ' ';
	}

	if (!fs::create_directories(base + "create_directories\\test\\folder\\")) {
		std::cout << "Cannot create directories\n";
	}
	if (fs::is_empty(base + "create_directories\\test\\folder\\")) {
		std::cout << "Directory is empty\n";
	}

	std::cout << path + "icon4.ico" << '\n';
	std::cout << base + "create_directories\\test\\folder" << '\n';
	try {
		//fs::copy_file(path + "icon4.ico", base + "create_directories\\test\\folder\\new_name.ico");
		fs::copy(path, base + "create_directories\\test\\folder\\");
	}
	catch (fs::filesystem_error& e) {
		std::cout << e.what() << '\n';
	}
	*/


	system("pause");
	return 0;
}