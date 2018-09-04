#include "product.cpp"

class Stock
{
	size_t size = 3;
	Node<Product> * head[3];//Phone 0 , TV 1
public:
	Stock()
	{
		for (int i = 0; i < size; i++)
			head[i] = nullptr;
	}
	~Stock()
	{
		for (int i = 0; i < size; i++)
		{
			Node<Product> * current;

			while (head[i])
			{
				current = head[i];
				head[i] = current->next;
				delete current->value;
				delete current;
				current = nullptr;
			}
		}
	}
	void addProduct(std::string pName, int pPrice, int pCount, std::string category)
	{
		Product * product = new Product(pName, pPrice, pCount);
		int index;
		if (category == "Phone")
			index = 0;
		else if (category == "TV")
			index = 1;
		else
		{
			std::cout << "Error\n";
			return;
		}
		if (head[index])
		{
			Node<Product>  * current = head[index];
			while (current->next)
				current = current->next;
			current->next = new Node<Product>;
			current->next->value = product;
		}
		else
		{
			head[index] = new Node<Product>;
			head[index]->value = product;
		}
	}
	Node<Product>* getList(int index)
	{
		return head[index];
	}
	size_t getCount()
	{
		return size;
	}
};