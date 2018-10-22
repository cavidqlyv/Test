#include <iostream>
#include "node.cpp"

template<typename T>
class List
{
	Node<T> * head = new Node<T>;
public:
	List(T value)
	{
		head->value = value;
		head->id = generateId();
	}
	~List()
	{
		Node<T>* current;

		while (head) 
		{
			current = head;
			head = current->next;
			delete current;
			current = nullptr;
		}
	}
	int generateId()
	{
		static int id = 0;
		++id;
		return id;
	}
	void pushFront(T value)
	{
		Node<T> * newnode = new Node<T>;
		newnode->id = generateId();
		newnode->value = value;
		newnode->next = head;
		head = newnode;
	}
	void pushBack(T value)
	{
		Node<T>* element = new Node<T>;
		Node<T>* current = head;
		element->value = value;
		element->id = generateId();

		while (current->next)
			current = current->next;

		current->next = element;
	}
	void insertAfter(int id, T value)
	{
		Node<T>* element = new Node<T>;
		element->value = value;
		element->id = generateId();

		Node<T>* node = findById(id);

		Node<T>* tmp = node->next;
		element->next = tmp;
		node->next = element;
	}
	Node<T>* findById(int id)
	{
		Node<T>* current = head;
		while (current)
		{
			if (current->id == id)
				return current;
			current = current->next;
		}
		return nullptr;
	}
	Node<T>* findByValue(T value)
	{
		Node<T>* current = head;
		while (current)
		{
			if (current->value == value)
				return current;
			current = current->next;
		}
		return nullptr;
	}
	Node<T>* first()
	{
		return head;
	}
	Node<T>* last()
	{
		Node<T>* current = head;

		while (current->next)
			current = current->next;
		return current;
	}
	int size()
	{
		Node<T> * current = head;
		int i = 0;
		while (current)
		{
			i++;
			current = current->next;
		}
		return i;
	}
	void printList()
	{
		Node<T> * current = head;
		std::cout << "List :\n";
		while (current)
		{
			std::cout << "\n------------------------------\n";
			std::cout << "Value : " << current->value << '\n';
			std::cout << "Id : " << current->id;
			current = current->next;
		}
		std::cout << "\n------------------------------\n\n";
	}
	bool empty()
	{
		if (head->next == nullptr) return true;
		return false;
	}
	void removeByVaule(T value)
	{
		Node<T>* current = head;
		Node<T>* previous = nullptr;

		while (current)
		{
			if (current->value == value) 
			{
				break;
			}
			previous = current;
			current = current->next;
		}

		Node<T>* tmp = current->next;
		if (tmp)
			*current = *tmp;
		else 
		{
			tmp = previous->next;
			previous->next = nullptr;
		}
		delete tmp;
	}
};