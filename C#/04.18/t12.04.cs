using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp19
{
    class Program
    {
        static void Main(string[] args)
        {
            MyClass myClass = new MyClass();
            myClass.Space("aaasadjashldashdhasdaa");
            myClass.Reverse("asjdasdaskj;hd");

        }

    }
    class MyClass
    {
        public void Space(string str)
        {
            string tmp;
            for (int i = 1; i < str.Length; i += 2)
            {
                tmp = str.Insert(i, " ");
                str = tmp;
            }
            Console.WriteLine(str);
        }
        public void Reverse(string str)
        {

            char[] cArray = str.ToCharArray();
            string reverse = String.Empty;
            for (int i = cArray.Length - 1; i > -1; i--)
            {
                reverse += cArray[i];
            }
            Console.WriteLine(reverse);
        }
    }

    class Run
    {
        public void RunFunc(Func funcDell, string str)
        {

        }
    }


    delegate void Func(string str);
}
