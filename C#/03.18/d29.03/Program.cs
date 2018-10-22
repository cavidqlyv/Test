using ClassLibrary1;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp7
{
    class Program
    {
        static void Main(string[] args)
        {
            //Class1 class1 = new Class1();
            //Class1 class2 = new Class1();

            //class1.A = 5;
            //class1.B = 10;
            //class2.A = 5;
            //class2.B = 10;
            //Class1 class3 = class1 + class2;

            //class3.Func();

            //Console.WriteLine(class3.A);
            //Console.WriteLine(class3.B);

            int a = 5;
            int b = a.ExternMethod();
            Console.WriteLine(b);
        }

    }
    static class Extension
    {
        public static int ExternMethod(this int number)
        {
            return number + 5;
        }
    }
}
