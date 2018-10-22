#include <iostream>

class Worker
{
	char* name = nullptr;
	int age;
	int salary;
public:
	Worker(char* wName, int wAge, int  wSalary)
	{
		setname(wName);
		setage(wAge);
		setsalary(wSalary);
	}
	Worker() = default;
	~Worker()
	{
		if (name) {
			delete[] name;
		}
	}
	void showInfo()
	{
		std::cout << "Name is: " << getname() << '\n';
		std::cout << "Age is: " << getage() << '\n';
		std::cout << "Salary is: " << getsalary() << '\n';
	}
	char* getname()
	{
		return name;
	}
	int getage()
	{
		return age;
	}
	int getsalary()
	{
		return salary;
	}
	void setname(char *wName)
	{
		name = wName;
	}
	bool setage(int wAge)
	{
		if (wAge > 0)
		{
			age = wAge;
			return true;
		}
		return false;
	}
	void setsalary(int wSalary)
	{
		salary = wSalary;
	}
};

int main()
{
	Worker worker1(new char[5]{ "Mike" }, 20, 500);
	Worker worker2(new char[5]{ "John" }, 30, 600);
	Worker worker3;

	worker3.setname(new char[5]{ "aaaa" });
	worker3.setage(-50);
	worker3.setsalary(500);

	worker1.showInfo();
	worker2.showInfo();
	worker3.showInfo();

	std::cout << sizeof(worker1)<<"\n";
	std::cout << sizeof(worker2)<<"\n";
	std::cout << sizeof(worker3)<<"\n";

	system("pause");
	return 0;
}