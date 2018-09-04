#include<iostream>
#pragma warning(disable : 4996) 
class Product
{
	char * name;
	int price = 0;
	int count = 0;
public:
	Product(char * uName, int uPrice)
	{
		setName(uName);
		setPrice(uPrice);
	}
	~Product()
	{
		delete[] name;
	}
	char * getName()
	{
		return name;
	}
	void setName(char * uName)
	{
		name = uName;
	}
	int getCount()
	{
		return count;
	}
	void setCount(int pCount)
	{
		count = pCount;
	}
	int getPrice()
	{
		return price;
	}
	void setPrice(int pPrice)
	{
		price = pPrice;
	}
};

class Cart
{
	char name[10];
	char adress[20];
	int number;
	int count = 0;
	int productCount[10] = { 0 };
	bool stat = false;
	Product* product[10];
public:
	~Cart()
	{
		//delete[] name;
		//delete[] adress;
		//for (int i = 0; i < count; i++)
		//delete product[i];
	}
	void setNumber(int uNumber)
	{
		number = uNumber;
	}
	int getNubmer()
	{
		return number;
	}
	void setName(char * uName)
	{
		//name = uName;
		strcpy(name, uName);
	}
	char * getName()
	{
		return name;
	}
	void setAdress(char * uAdress)
	{
		//adress = uAdress;
		strcpy(adress, uAdress);
	}
	char * getAdress()
	{
		return adress;
	}
	void setStat(bool uStat)
	{
		stat = uStat;
	}
	void setProductCount(int uCount)
	{
		productCount[count] = uCount;
	}
	bool getStat()
	{
		return stat;
	}
	int getCount()
	{
		return count;
	}
	int getPrice()
	{
		int sum = 0;
		for (int i = 0; i < count; i++)
		{
			sum += product[i]->getPrice() * productCount[i];
		}
		return sum;
	}
	void addProduct(Product * uProduct)
	{
		product[count++] = uProduct;
	}
	void printProductInfo()
	{
		std::cout << "============================================\n";

		for (int i = 0; i < count; i++)
		{
			std::cout << product[i]->getName() << "\n";
			std::cout << productCount[i] << " Eded\n";
			std::cout << "============================================\n";

		}
		std::cout << getPrice() << " Manat\n";

	}
};

class Shop
{
	Cart * cart[10];
	Product * product[10];
	int productCount = 0;
	int cartCount = 0;
public:

	void addItem(Product *uProduct)
	{
		product[productCount++] = uProduct;
	}
	~Shop()
	{
		for (int i = 0; i < productCount; i++)
			delete product[i];
		for (int i = 0; i < cartCount; i++)
			delete cart[i];
	}
	void printProductList()
	{
		system("cls");
		std::cout << "Products : \n";
		for (int i = 0; i < productCount; i++)
		{
			std::cout << i + 1 << "." << product[i]->getName() << "\t\t" << product[i]->getPrice() << "\n";
		}
	}
	void addTocart(bool flag, int num, int count)
	{
		if (flag)
			cart[cartCount] = new Cart;
		//cart[cartCount] = ucart;
		cart[cartCount]->setProductCount(count);
		cart[cartCount]->addProduct(product[num]);
	}
	void addcartInfo(char * uName, char * uAdress, int uNumber)
	{
		cart[cartCount]->setName(uName);
		cart[cartCount]->setAdress(uAdress);
		cart[cartCount]->setNumber(uNumber);
		cartCount++;
	}
	void printcartInfo()
	{
		std::cout << "Name : " << cart[cartCount - 1]->getName() << "\n";
		std::cout << "Adress : " << cart[cartCount - 1]->getAdress() << "\n";
		std::cout << "Number : " << cart[cartCount - 1]->getNubmer() << "\n";
		cart[cartCount - 1]->printProductInfo();
		if (!(cart[cartCount - 1]->getStat()))
			std::cout << "======\nWait\n======\n";
		else
			std::cout << "======\nOK!\n======\n";
	}
	int earnings()
	{
		int sum = 0;
		for (int i = 0; i < cartCount; i++)
		{
			if (cart[i]->getStat())
				sum += cart[i]->getPrice();
		}
		return sum;
	}
	void printAllcarts()
	{
		system("cls");
		std::cout << "\n==============================================================================================\n\n";
		for (int i = 0; i < cartCount; i++)
		{
			std::cout << "Name : " << cart[i]->getName() << "\n";
			std::cout << "Adress : " << cart[i]->getAdress() << "\n";
			std::cout << "Number : " << cart[i]->getNubmer() << "\n";
			cart[i]->printProductInfo();
			if (!cart[i]->getStat())
				std::cout << "======\nWait\n======\n";
			else
				std::cout << "======\nOK!\n======\n";
			std::cout << "\n==============================================================================================\n\n";
		}
		std::cout << "Earning : " << earnings() << "\n";
	}
	void changeStat(bool flag, int num)
	{
		cart[num]->setStat(flag);
	}
};

int main()
{
	Product * tmp;
	int tmp2 = 0;
	bool flag = true;
	int a;
	char* name = new char[10];
	char* adress = new char[20];
	int number;

	Shop shop;
	shop.addItem((new Product(new char[10]{ "Alma" }, 10)));
	shop.addItem((new Product(new char[10]{ "Armud" }, 20)));
	shop.addItem((new Product(new char[10]{ "Heyva" }, 30)));
	shop.addItem((new Product(new char[10]{ "Nar" }, 40)));
	shop.addItem((new Product(new char[10]{ "Uzum" }, 50)));
	shop.addItem((new Product(new char[10]{ "Banan" }, 60)));
	//cart* tmp3 = new cart;
	while (1)
	{
		std::cout << "Sifaris 1\n";
		std::cout << "Baxmaq 2\n";
		std::cin >> a;
		if (a == 1)
		{
			while (1)
			{
				shop.printProductList();
				std::cout << "Enter product number. Enter 0 continue \n";
				std::cin >> a;
				if (a == 0)
				{
					std::cout << "Enter name\n";
					std::cin >> name;
					std::cout << "Enter adress\n";
					std::cin >> adress;
					std::cout << "Enter number\n";
					std::cin >> number;
					shop.addcartInfo(name, adress, number);
					flag = true;
					break;
				}
				std::cout << "Enter product count\n";
				std::cin >> tmp2;
				shop.addTocart(flag, a - 1, tmp2);
				flag = false;
			}
		}
		if (a == 2)
		{
			shop.printAllcarts();
			std::cout << "Enter number\n";
			std::cin >> a;
			if (a != 0)
				shop.changeStat(true, a - 1);
		}
	}
	shop.printcartInfo();
	system("pause");
	return 0;
}