#include <iostream>
#include <string>
#include <chrono>
#include <filesystem>
#include <conio.h>
#include <Windows.h>
#include <experimental\filesystem>
#include <set>

#define KB_C 99
#define KB_D 
#define KB_H 104
#define KB_S 115
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
#define KB_DELETE 127
#define KB_BACKSPACE 8

#pragma warning (disable : 4996)

namespace fs = std::experimental::filesystem;

class FSInterface
{
public:
	virtual void copy(std::string from, std::string to) = 0;
	virtual void move(std::string from, std::string to) = 0;
	virtual void printDirectory(std::string dir, int pos, bool flag = false) = 0;
	virtual void printRecursiveDirectory(std::string dir) = 0;
	virtual void rename(std::string from, std::string to) = 0;
	virtual std::string getDir(std::string dir, int pos) = 0;
	virtual int getDirCount(std::string dir) = 0;
	virtual void remove(std::string dir) = 0;
};

class Filesystem : public FSInterface
{
	std::string base;
	std::string current;
	int count;
public:
	Filesystem(std::string fBase)
	{
		base = fBase;
		current = base;
	}
	Filesystem()
	{
		base = "\\\\ITSTEP\\students redirection$\\sale_rv37\\Desktop\\";
		current = base + "New folder (2)";
	}
	void printDirectory(std::string dir, int pos, bool flag = false)override
	{
		HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

		int i = 0;
			//std::cout << "Filename:\n";
		for (auto p : fs::directory_iterator(dir))
		{
			i++;
			if (i != pos)
			{
				std::cout << p << '\n';
			}
			else
			{
				SetConsoleTextAttribute(hConsole, 112);
				std::cout << p;
				SetConsoleTextAttribute(hConsole, 7);
				std::cout << '\n';
			}
			if (flag && i == pos)
			{
				auto ftime = fs::last_write_time(p);
				std::time_t time = std::chrono::system_clock::to_time_t(ftime);
				std::cout << " : " << '\n';
				if (!fs::is_directory(p))
				{
					if (fs::file_size(p) >= 1048576)
						std::cout << "Size: " << fs::file_size(p) / 1048576 << " MB\n";
					else if (fs::file_size(p) >= 1024)
						std::cout << "Size: " << fs::file_size(p) / 1024 << " KB\n";
					else
						std::cout << "Size: " << fs::file_size(p) <<" B\n" << '\n';
				}
				std::cout << "Last modified: " << std::asctime(std::localtime(&time)) << '\n';
			}
		}
	}
	int getDirCount(std::string dir) override
	{
		int count = 0;
		for (auto p : fs::directory_iterator(dir))
			count++;
		return count;
	}
	void printRecursiveDirectory(std::string dir) override
	{
		HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

		for (auto p : fs::recursive_directory_iterator(dir))
			std::cout << p;
	}
	void createFolder(std::string dir ,std::string fName) 
	{
		fs::create_directories(dir + '\\' + fName);
	}
	void copy(std::string from, std::string to) override
	{
		fs::copy(from, to);
	}
	void move(std::string from, std::string to) override
	{
		fs::rename(from, to);
	}
	void remove(std::string dir) override
	{
		fs::remove(dir);
	}
	void rename(std::string from, std::string to)override
	{
		fs::rename(from, to);
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
	void printSort(std::string dir)
	{
		std::set<std::string> mySet;
		for (auto p : fs::directory_iterator(dir))
			mySet.insert(p.path().string());
		for (auto it = mySet.begin(); it != mySet.end(); ++it)
			std::cout << *it << '\n';
	}
	std::string getCurrentDir()
	{
		return current;
	}
	std::string getFileName(std::string fBase ,std::string dir )
	{
		return dir.substr(fBase.size());
	}
};

class TMP
{
	int pos = 1;
	Filesystem * fileSystem;
	std::string currentDir;
	std::string tmpDirCopy;
	std::string tmpDirMove;
	std::string tmpDir;
	std::string tmpFilename;
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
		currentDir = fileSystem->getCurrentDir();
	}
	void up()
	{
		pos--;
		checkPos();
	}
	void down()
	{
		pos++;
		checkPos();
	}
	void enter()
	{
		currentDir = fileSystem->getDir(currentDir, pos);
		pos = 1;
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
	}
	void H()
	{
		std::cout << "Press C for copy\n";
		std::cout << "Press M for move\n";
		std::cout << "Press S for sort\n";
		std::cout << "Press F for create new Folder\n";
	}
	void C()
	{
		if (tmpDirCopy.empty())
		{
			tmpDirCopy = fileSystem->getDir(currentDir , pos);
			tmpFilename = fileSystem->getFileName(currentDir, tmpDirCopy);
		}
		else
		{
			fileSystem->copy(tmpDirCopy, currentDir + tmpFilename);
			tmpDirCopy.clear();
		}
	}
	void M()
	{
		if (tmpDirMove.empty())
		{
			tmpDirMove = fileSystem->getDir(currentDir, pos);
			tmpFilename = fileSystem->getFileName(currentDir, tmpDirMove);
		}
		else
		{
			fileSystem->move(tmpDirMove, currentDir + tmpFilename);
			tmpDirMove.clear();
		}
	}
	void S()
	{
		system("cls");
		fileSystem->printSort(currentDir);
		system("pause");
	}
	void print()
	{
		system("cls");
		fileSystem->printDirectory(currentDir, pos);
	}
	void A()
	{
		system("cls");
		fileSystem->printRecursiveDirectory(currentDir);
		system("pause");
	}
	void Del()
	{
		tmpDir = fileSystem->getDir(currentDir , pos);
		std::cout << tmpDir << '\n';
		system("pause");
		fileSystem->remove(tmpDir);
		pos = 1;
	}
	void R()
	{

	}
	void N()
	{

	}
	void F()
	{
		std::string name;
		std::cout << "Enter folder name\n";
		std::cin >> name;
		fileSystem->createFolder(currentDir, name);
	}
};

int main()
{
	Filesystem *fileSystem = new Filesystem;

	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	TMP ctrl(fileSystem);

	int count = 0;
	int key;
	while (1)
	{
		ctrl.print();
		key = _getch();
		if (key == KB_UP)
			ctrl.up();
		else if (key == KB_DOWN)
			ctrl.down();
		else if (key == KB_ENTER)
			ctrl.enter();
		else if (key == KB_BACKSPACE)
			ctrl.backspace();
		else if (key == KB_M)
			ctrl.M();
		else if (key == KB_C)
			ctrl.C();
		else if (key == KB_H)
			ctrl.Del();
		else if (key == KB_F)
			ctrl.F();
		else if (key == KB_S)
			ctrl.S();
		else if (key == KB_ESCAPE)
			return 0;
	}
	system("pause");
	return 0;
}