#include <iostream>
#include "reserv.cpp"
template<typename T>
class List
{
	Node<T> * head = new Node<T>;
	Node<T> * curr = head;
	MemoryPool<T>* memoryPool = new MemoryPool<T>;
public:
	List(T value)
	{
		head->value = value;
		head->id = generateId();
	}
	~List()
	{
		Node<T>* current;
		Node<T>* tmp = head;
		while (tmp)
		{
			current = tmp;
			tmp = current->next;
			delete current;
			current = nullptr;
		}
		delete memoryPool;
	}
	int generateId()
	{
		static int id = 0;
		++id;
		return id;
	}
	void pushFront(T value)
	{
		Node<T> * newnode = nullptr;
		if (memoryPool->getCount() == -1)
		{
			newnode = new Node<T>;
		}
		else
		{
			std::cout << memoryPool->getMemory();
			newnode = memoryPool->getMemory();
		}
		//Node<T> * newnode = new Node<T>;
		newnode->id = generateId();
		newnode->value = value;
		newnode->next = head;
		head->prev = newnode;
		head = newnode;
		curr = head;

	}
	void pushBack(T value)
	{
		Node<T>* element = nullptr;
		if (memoryPool->getCount() == -1)
		{
			element = new Node<T>;
		}
		else
		{
			element = memoryPool->getMemory();
		}
		Node<T>* current = head;
		element->value = value;
		element->id = generateId();

		while (current->next)
			current = current->next;

		current->next = element;
		element->prev = current;
		curr = head;

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
		curr = head;
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
	Node<T>* current()
	{
		return curr;
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
			if (current->value == value) {
				break;
			}
			previous = current;
			current = current->next;
		}

		Node<T>* tmp = current->next;
		if (tmp)
			*current = *tmp;
		else {
			tmp = previous->next;
			previous->next = nullptr;
		}
		delete tmp;
		curr = head;
	}
	void next()
	{
		if (curr->next != nullptr)
			curr = curr->next;
	}
	void prev()
	{
		if (curr->prev != nullptr)
			curr = curr->prev;
	}
	void popFront()
	{
		if (head->next != nullptr)
		{
			head = head->next;

			delete head->prev;
			head->prev = nullptr;
		}
		curr = head;
	}
	void popBack()
	{
		Node<T>* current = head;
		if (current->next == nullptr&& current->prev != nullptr)
			current = current->prev;
		if (current->next != nullptr)
		{
			while (current->next->next)
				current = current->next;

			delete current->next;
			current->next = nullptr;
		}
		curr = head;
	}
	template<typename ...Args>
	void emplace(Args&&... args)
	{
		Node<T>* t = new Node<T>(std::forward<Args>(args)...);
		delete t;
	}
	void reserv(int size)
	{
		memoryPool->add(size);
	}
};