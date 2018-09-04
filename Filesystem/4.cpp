#include <iostream>
#include <string>
#include <chrono>
#include <filesystem>
#include <conio.h>
#include <Windows.h>
#include <experimental\filesystem>

#define KB_C 99
#define KB_H 104
#define KB_M 109
#define KB_P 112
#define KB_R 114
#define KB_F 102
#define KB_UP 72
#define KB_LEFT 75
#define KB_DOWN 80
#define KB_RIGHT 77
#define KB_ENTER 13
#define KB_ESCAPE 27
#define KB_DElETE 127
#define KB_BACKSPACE 8

#pragma warning (disable : 4996)

namespace fs = std::experimental::filesystem;

class FSInterface
{
public:
	virtual void createFolder(std::string) = 0;
	virtual void copy(std::string from, std::string to) = 0;
	virtual void move(std::string from, std::string to) = 0;
	virtual void printDirectory(std::string dir, int pos, bool flag = false) = 0;
	virtual void printRecursiveDirectory(std::string dir, int pos, bool flag = false) = 0;
	virtual void rename(std::string from, std::string to) = 0;
	virtual void deleteFolder(std::string dir) = 0;
	virtual std::string getDir(std::string dir, int pos) = 0;
};

class Filesystem : public FSInterface
{
	std::string base;
	std::string current;
	int count;
	//int pos = 1;
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
	void printDirectory(std::string dir, int pos, bool flag = false)override
	{
		HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

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
			if (flag && i == pos)
			{
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
	}
	int getDirCount(std::string dir)
	{
		for (auto p : fs::directory_iterator(current))
			count++;
	}
	void printRecursiveDirectory(std::string dir, int pos, bool flag = false)override
	{
		HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

		int i = 0;
		for (auto p : fs::recursive_directory_iterator(current))
		{
			i++;
			auto ftime = fs::last_write_time(p);
			std::time_t time = std::chrono::system_clock::to_time_t(ftime);

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
			if (flag && i == pos)
			{
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
	}
	void createFolder(std::string fName) override
	{
		fs::create_directories(current + fName);
	}
	void copy(std::string from, std::string to) override
	{
		fs::copy(from, to);
	}
	void move(std::string from, std::string to) override
	{
		fs::rename(from, to);
	}
	void rename(std::string from, std::string to)override
	{
		fs::rename(from, to);
	}
	void deleteFolder(std::string dir)override
	{
		fs::remove(dir);
	}
	std::string getDir(std::string dir, int pos)override
	{
		int i = 0;
		for (auto p : fs::directory_iterator(dir))
		{
			i++;
			if (i == pos)
				return p.path().string();
		}
	}
};

class TMP
{
	int pos = 1;
	Filesystem * fileSystem;
	std::string currentDir;
	std::string tmpDir;

	void checkPos()
	{
		int count = fileSystem->getDirCount(currentDir);
		if (pos == 0)
			pos = count;
		else if (pos == count + 1)
			pos = 1;
	}
public:
	TMP(Filesystem * cFileSystem)
	{
		fileSystem = cFileSystem;
	}
	void up()
	{
		pos--;
		checkPos();
		system("cls");
		fileSystem->printDirectory(currentDir, pos);
	}
	void down()
	{
		pos++;
		checkPos();
		system("cls");
		fileSystem->printDirectory(currentDir, pos);
	}
	void left()
	{

	}
	void right()
	{

	}
	void enter()
	{
		currentDir = fileSystem->getDir(currentDir, pos);
		pos = 1;
		system("cls");
		fileSystem->printDirectory(currentDir, pos);
	}
	void backspace()
	{
		while (1)
		{
			if (currentDir.back() != '\\')
				currentDir.pop_back();
			else
				break;
		}
		currentDir.pop_back();
		pos = 1;
		system("cls");
		fileSystem->printDirectory(currentDir, pos);
	}
	void H()
	{

	}
	void C()
	{
		if (tmpDir.empty())
		{
			tmpDir = currentDir;
			system("cls");
			fileSystem->printDirectory(currentDir, pos);
		}
		else
		{
			fileSystem->copy(tmpDir, currentDir);
			tmpDir.clear();
			system("cls");
			fileSystem->printDirectory(currentDir, pos);
		}
	}
	void M()
	{

	}
};


int main()
{
	std::string base = "%appdata%\\";
	fs::create_directories(base + "New Folder");
	std::string current = base + "New Folder";

	Filesystem *fileSystem = new Filesystem;

	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	TMP ctrl(fileSystem);

	int count = 0;
	int key;
	while (1)
	{
		key = _getch();
		if (key == KB_UP)
			ctrl.up();
		else if (key == KB_DOWN)
			ctrl.down();
		else if (key == KB_ENTER)
		{
			ctrl.enter();
		}
		else if (key == KB_BACKSPACE)
		{
			ctrl.backspace();
		}
		else if (key == KB_ESCAPE)
			return 0;

		//if (fileSystem.getPos() == 0)
		//	fileSystem.setPos(count);

		//else if (fileSystem.getPos() == count + 1)
		//	fileSystem.setPos(1);
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