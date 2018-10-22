#include "stock.cpp"
#include <fstream>

class App
{
	size_t size = 3;
	Node<Task> *head[3];// priority
	Stock stock;
	Node<Message> * message;
	int messageCount = 0;
public:
	App()
	{
		for (int i = 0; i < size; i++)
			head[i] = nullptr;
	}
	~App()
	{
		for (int i = 0; i < size; i++)
		{
			Node<Task> * current;

			while (head[i])
			{
				current = head[i];
				head[i] = current->next;
				delete current->value;
				delete current;
				current = nullptr;
			}
		}
		Node<Message>* tmp;
		while (message)
		{
			tmp = message;
			message = message->next;
			delete tmp->value;
			delete tmp;
			tmp = nullptr;
		}
	}
	void addTask(std::string name, int priority, std::string deadline)
	{
		Task * task = new Task(name, priority, deadline);

		if (head[priority - 1])
		{
			Node<Task>  * current = head[priority - 1];
			while (current->next)
				current = current->next;
			current->next = new Node<Task>;
			current->next->value = task;
		}
		else
		{
			head[priority - 1] = new Node<Task>;
			head[priority - 1]->value = task;
		}
	}
	size_t getTaskCount()
	{
		return size;
	}
	size_t getProductCount()
	{
		return stock.getCount();
	}
	Node<Task> * getTask(int index)
	{
		return head[index];
	}
	Node<Product> * getProduct(int index)
	{
		return stock.getList(index);
	}
	void addProduct(std::string pName, int pPrice, int pCount, std::string category)
	{
		stock.addProduct(pName, pPrice, pCount, category);
	}
	void addMessage(std::string name, std::string content)
	{
		Message * tmp = new Message(name, content);
		Node<Message> * current = message;
		while (current)
		{
			current = current->next;
		}
		current = new Node<Message>;
		current->value = tmp;
		std::string usersFile = "\\\\ITSTEP\\students redirection$\\sale_rv37\\Desktop\\news.bin";
		std::fstream file(usersFile, std::ios::binary | std::ios::in | std::ios::out | std::ios::app);

		/*
		if (messageCount != 0)
			file.seekg(sizeof(Message) * messageCount++);
		else
		*/

		messageCount++;
		std::cout << messageCount << '\n';
		file.write(reinterpret_cast<char*>(tmp), sizeof(Message));

		std::string usersFile1 = "\\\\ITSTEP\\students redirection$\\sale_rv37\\Desktop\\save.bin";
		//std::fstream file1(usersFile1, std::ios::binary | std::ios::in | std::ios::out );
		std::ofstream file1(usersFile1);
		file1 << messageCount;
		file1.close();

		//file1.write(reinterpret_cast<char*>(&messageCount), sizeof(int));

	}
};