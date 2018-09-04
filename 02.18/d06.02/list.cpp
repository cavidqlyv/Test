#include <iostream>
#include "node.cpp"

template<typename T>
class List
{
	Node<T> * head = new Node;
public:
	int generateId()
	{
		static int id = 0;
		++id;
		return id;
	}

	void addFirst(Node<T> *&prev, int a)
	{
		Node * newnode = new Node;
		newnode->id = generateId();
		newnode->value = a;
		newnode->next = prev;
		prev = newnode;
	}

	void addLast(Node<T> *head, int a)
	{
		Node** current = &head;
		while (*current)
		{
			current = &((*current)->next);
		}
		Node * newnode = new Node;
		newnode->id = generateId();
		newnode->value = a;
		*current = newnode;
	}
	
	void printList(Node<T>* current)
	{
		while (current)
		{
			std::cout << "\n------------------------------\n";
			std::cout << "Value : " << current->value << '\n';
			std::cout << "Id : " << current->id;
			current = current->next;
		}
		std::cout << "\n------------------------------\n\n";
	}
};