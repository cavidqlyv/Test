using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp16
{
    class Program
    {
        static void Main(string[] args)
        {
            MyEnum myEnum= MyEnum.Red;
           A a = new A();
            a.Colors(myEnum);
        }

    }
    enum MyEnum
    {
        Red, Yellow
    }
    class A
    {
        public void Colors(MyEnum myEnum )
        {
            switch (myEnum)
            {
                case MyEnum.Red:
                    Console.WriteLine("Red");
                    break;
                case MyEnum.Yellow:
                    Console.WriteLine("Yellow");
                    break;
            }
        }
    }
}