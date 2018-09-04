#include <iostream>

using namespace std;
/*
struct Node
{
	int value;
	Node* next = nullptr;
};
int main()
{
	Node* head = new Node;
	head->value = 1;

	head->next = new Node;
	head->next->value = 10;

	Node* newNode = new Node;
	newNode->value = 40;

	newNode->next = head->next;
	head->next = newNode;

	Node* current = head;
	while (current)
	{
		cout << current->value << '\n';
		current = current->next;
	}
	system("pause");
	return 0;
}
*/

struct Node
{
	int id;
	int value;
	Node* next = nullptr;
};

int generateId()
{
	static int id = 0;
	++id;
	return id;
}



void first(Node *&prev, int a)
{
	Node * newnode = new Node;
	newnode->id = generateId();
	newnode->value = a;
	newnode->next = prev;
	prev = newnode;
}

void last(Node *head , int a) 
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
void print(Node* current)
{
	//Node * tmp = current;
	//cout << tmp->value << '\n';
	//cout << tmp->next->value << '\n';
	//return;
	
	while (current)
	{
		cout << "\n------------------------------\n";
		cout << current->value << '\n';
		cout << current->id;

		current = current->next;

	}
	cout << "\n------------------------------\n\n";
}

int main()
{
	int a;

	Node* head = new Node;
	
	head->value = 1;
	head->id =generateId() ;
	while (true)
	{


		cout << "Evvele 1\n";
		cout << "Axira 2\n";
		cin >> a;

		if (a == 1)
		{
			cout << "Qiymetini daxil et\n";
			cin >> a;
			first(head, a);
		}
		else if (a == 2)
		{
			cout << "Qiymetini daxil etasdhjkda\n";
			cin >> a;
			
			last(head, a);

		/*	Node * newnode = new Node;
			newnode->id = generateId();
			newnode->value = a;
			current = newnode;
*/
			
		}
		cout << "\n\n\n";

		
		print(head);
	}
	system("pause");
	return 0;
}