#include "message.cpp"
#include <fstream>
#include <iostream>


class App
{
	Node<Message>* read;
	Node<Message>* unread = nullptr;
public:
	App()
	{
		std::string usersFile = "\\\\ITSTEP\\students redirection$\\sale_rv37\\Desktop\\news.bin";
		std::fstream file(usersFile, std::ios::binary | std::ios::in | std::ios::out | std::ios::app);
	/*	for (int i = 0; i < 1; i++)
		{*/
			Node<Message> * tmp = unread;
			while (tmp)
				tmp = tmp->next;
			tmp = new Node<Message>;
			tmp->value = new Message;
			file.read(reinterpret_cast<char*>(&tmp->value), sizeof(Message));
			//file.seekg(sizeof(Message) * (i+1));
		//}
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
	std::cout << unread << '\n';
		while (tmp)
		{
			std::cout << tmp->value->getName();
			std::cout << tmp->value->getName();
			tmp = tmp->next;
		}
	}
};
