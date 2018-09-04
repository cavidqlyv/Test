template <typename T>
struct Node
{
	int id;
	T value;
	Node* next = nullptr;
};