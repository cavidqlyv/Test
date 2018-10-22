#include <iostream>
#include <string>
#include <chrono>
#include <filesystem>
#include <conio.h>
#include <Windows.h>
#include <experimental\filesystem>
#include <set>
#include <functional>
#include <fstream>

#define KB_A 97 // recursiv print
#define KB_C 99 // copy
#define KB_I 105 // info
#define KB_H 104 // help
#define KB_S 115 // sort
#define KB_M 109 // move
#define KB_N 110 // create //file
#define KB_R 114 // rename
#define KB_F 102 // create folder
#define KB_UP 72
#define KB_DOWN 80
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
	virtual void printDirectory(std::string dir, int pos) = 0;
	virtual void printRecursiveDirectory(std::string dir) = 0;
	virtual void rename(std::string from, std::string to) = 0;
	virtual std::string getDir(std::string dir, int pos) = 0;
	virtual int getDirCount(std::string dir) = 0;
	virtual void remove(std::string dir) = 0;
	virtual void createFile(std::string dir) = 0;
	virtual std::string getFileName(std::string fBase, std::string dir) = 0;
	virtual std::string getCurrentDir() = 0;
	virtual void printSort(std::string dir) = 0;
	virtual void createFolder(std::string dir, std::string fName) = 0;
	virtual void printInfo(std::string dir) = 0;
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
	void printDirectory(std::string dir, int pos) override
	{
		HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

		int i = 0;
		std::string tmp = dir;
		std::string tmp2;
		tmp.pop_back();

		while (1)
		{
			if (tmp.back() != '\\')
				tmp.pop_back();
			else
				break;
		}
		for (auto p : fs::directory_iterator(dir))
		{
			i++;
			tmp2 = p.path().string();
			if (i != pos)
				std::cout << tmp2.substr(tmp.size()) << '\n';
			else
			{
				SetConsoleTextAttribute(hConsole, 112);
				std::cout << tmp2.substr(tmp.size());
				SetConsoleTextAttribute(hConsole, 7);
				std::cout << '\n';
			}
		}
	}
	void printInfo(std::string dir) override
	{
		auto ftime = fs::last_write_time(dir);
		std::time_t time = std::chrono::system_clock::to_time_t(ftime);
		std::cout << "Directory : " << dir << '\n';
		if (!fs::is_directory(dir))
		{
			if (fs::file_size(dir) >= 1048576)
				std::cout << "Size: " << fs::file_size(dir) / 1048576 << " MB\n";
			else if (fs::file_size(dir) >= 1024)
				std::cout << "Size: " << fs::file_size(dir) / 1024 << " KB\n";
			else
				std::cout << "Size: " << fs::file_size(dir) << " B\n" << '\n';
		}
		std::cout << "Last modified: " << std::asctime(std::localtime(&time)) << '\n';
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

		std::string tmp = dir;
		std::string tmp2;
		tmp.pop_back();

		while (1)
		{
			if (tmp.back() != '\\')
				tmp.pop_back();
			else
				break;
		}

		for (auto p : fs::recursive_directory_iterator(dir))
		{
			tmp2 = p.path().string();
			std::cout << tmp2.substr(tmp.size()) << '\n';
		}
	}
	void createFolder(std::string dir, std::string fName) override
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
	void rename(std::string from, std::string to) override
	{
		fs::rename(from, to);
	}
	std::string getDir(std::string dir, int pos) override
	{
		int i = 0;
		for (auto p : fs::directory_iterator(dir))
		{
			i++;
			if (i == pos)
				return p.path().string();
		}
	}
	void printSort(std::string dir) override
	{
		std::string tmp = dir;
		std::string tmp2;

		while (1)
		{
			if (tmp.back() != '\\')
				tmp.pop_back();
			else
				break;
		}

		std::set<std::string, std::greater<std::string>> mySet;
		for (auto p : fs::directory_iterator(dir))
		{
			tmp2 = p.path().string();
			mySet.insert(tmp2.substr(tmp.size()));
		}
		for (auto it = mySet.begin(); it != mySet.end(); ++it)
			std::cout << *it << '\n';
	}
	std::string getCurrentDir() override
	{
		return current;
	}
	std::string getFileName(std::string fBase, std::string dir) override
	{
		return dir.substr(fBase.size());
	}
	void createFile(std::string dir) override
	{
		std::ofstream file(dir);
		file.close();
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
	void backspace() //++ 
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
	void H() //++ // help
	{
		system("cls");
		std::cout << "Press C for copy\n";
		std::cout << "Press M for move\n";
		std::cout << "Press S for sort\n";
		std::cout << "Press I for info\n";
		std::cout << "Press R for rename\n";
		std::cout << "Press N for create file\n";
		std::cout << "Press A for recursive print\n";
		std::cout << "Press F for create new Folder\n";
		system("pause");
	}
	void C() //++ // copy
	{
		if (tmpDirCopy.empty())
		{
			tmpDirCopy = fileSystem->getDir(currentDir, pos);
			tmpFilename = fileSystem->getFileName(currentDir, tmpDirCopy);
		}
		else
		{
			fileSystem->copy(tmpDirCopy, currentDir + tmpFilename);
			tmpDirCopy.clear();
		}
	}
	void M() //++ // move
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
	void S() //++ // sort z-a
	{
		system("cls");
		fileSystem->printSort(currentDir);
		system("pause");
	}
	void print() //++ // print
	{
		system("cls");
		fileSystem->printDirectory(currentDir, pos);
	}
	void A() //++ // Recursiv print
	{
		system("cls");
		fileSystem->printRecursiveDirectory(currentDir);
		system("pause");
	}
	void Del() //++ // Delete
	{
		tmpDir = fileSystem->getDir(currentDir, pos);
		std::cout << tmpDir << '\n';
		system("pause");
		fileSystem->remove(tmpDir);
		pos = 1;
	}
	void R() //++ //Rename
	{
		std::string tmp;
		std::string tmp1 = fileSystem->getDir(currentDir, pos);
		std::cout << "Enter name\n";
		std::cin >> tmp;
		tmp1.pop_back();

		while (1)
		{
			if (tmp1.back() != '\\')
				tmp1.pop_back();
			else
				break;
		}
		tmp1 = tmp1 + tmp;
		fileSystem->rename(fileSystem->getDir(currentDir, pos), tmp1);
	}
	void F() //++ // Create folder
	{
		std::string name;
		std::cout << "Enter folder name\n";
		std::cin >> name;
		fileSystem->createFolder(currentDir, name);
	}
	void I() // ++ // show info
	{
		std::string tmp = fileSystem->getDir(currentDir, pos);
		fileSystem->printInfo(tmp);
		system("pause");
	}
	void N() // ++ // create file
	{
		std::string tmp;
		std::cout << "Enter file name\n";
		std::cin >> tmp;
		std::string tmp2;
		tmp2 = currentDir + '\\' + tmp;
		std::cout << tmp2 << '\n';

		system("pause");

		fileSystem->createFile(tmp2);
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
		if (key == KB_UP) // ++
			ctrl.up();
		else if (key == KB_DOWN) // ++
			ctrl.down();
		else if (key == KB_ENTER) // ++
			ctrl.enter();
		else if (key == KB_BACKSPACE) // ++
			ctrl.backspace();
		else if (key == KB_M) // ++
			ctrl.M();
		else if (key == KB_C) // ++
			ctrl.C();
		else if (key == KB_DELETE) // 
			ctrl.Del();
		else if (key == KB_F) // ++
			ctrl.F();
		else if (key == KB_S) // ++
			ctrl.S();
		else if (key == KB_A) // ++
			ctrl.A();
		else if (key == KB_R) // ++
			ctrl.R();
		else if (key == KB_I) // ++
			ctrl.I();
		else if (key == KB_N) // ++
			ctrl.N();
		else if (key == KB_H) // ++
			ctrl.H();
		else if (key == KB_ESCAPE) // ++
			return 0;
	}
	system("pause");
	return 0;
}