#include "task.cpp"

template<typename T>
struct Node
{
	Node * next = nullptr;
	T * value;
};