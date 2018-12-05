#include<iostream>

class PointerWrapper
{
    int *buf = nullptr;

  public:
    PointerWrapper(int *b)
    {
        buf = b;
    }
    PointerWrapper(const PointerWrapper &ref) = delete;
    PointerWrapper &operator=(const PointerWrapper &ref) = delete;
    PointerWrapper(PointerWrapper &&pw)
    {
        buf = pw.buf;
        pw.buf = nullptr;
    }
    PointerWrapper &operator=(PointerWrapper &&pw)
    {
        buf = pw.buf;
        pw.buf = nullptr;
        return *this;
    }

    int &operator*()
    {
        return *buf;
    }

    ~PointerWrapper()
    {
        std::cout << "~PointerWrapper()\n";
        if (buf)
        {
            delete[] buf;
        }
    }
};

PointerWrapper filter()
{
    PointerWrapper wrapper(new int(5));
    return wrapper;
}

void test()
{
    PointerWrapper &&wrapper = filter();
    std::cout << *wrapper << '\n';
}

int main()
{
    test();
}