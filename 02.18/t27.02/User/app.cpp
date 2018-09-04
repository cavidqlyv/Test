#include "message.cpp"
#include <fstream>
#include <iostream>


class App
{
	Node<Message>* read = nullptr;
	Node<Message>* unread = nullptr;
	int size=157;
public:
	App()
	{
		std::string usersFile1 = "\\\\ITSTEP\\students redirection$\\sale_rv37\\Desktop\\save.bin";
		std::ifstream file1(usersFile1);

		file1 >> size;
		file1.close();

		std::cout << size << '\n';

		std::string usersFile = "\\\\ITSTEP\\students redirection$\\sale_rv37\\Desktop\\news.bin";
		std::fstream file(usersFile, std::ios::binary | std::ios::in | std::ios::out | std::ios::app);
		unread = new Node<Message>;
		unread->value = new Message;

		file.read(reinterpret_cast<char*>(unread->value), sizeof(Message));

		for (int i = 1; i < size; i++)
		{
			Node<Message> * current = unread;
			while (current->next)
				current = current->next;

			current->next = new Node<Message>;
			current->next->value = new Message;
			file.seekg(sizeof(Message)*(i));

			file.read(reinterpret_cast<char*>(current->next->value), sizeof(Message));
		}
	}
	~App()
	{
		Node<Message> * tmp;
		while (read)
		{
			tmp = read;
			read = read->next;
			delete tmp->value;
			delete tmp;
		}
		while (unread)
		{
			tmp = unread;
			unread = unread->next;
			delete tmp->value;
			delete tmp;
		}
	}
	void print1()
	{
		Node<Message> * tmp = unread;
		std::cout << "Unread" << '\n';
		while (tmp)
		{
			std::cout <<"Title : " << tmp->value->getName() << '\n';
			std::cout <<"Content : "<<  tmp->value->getContent() << "\n\n";
			tmp = tmp->next;
		}
	}
};
