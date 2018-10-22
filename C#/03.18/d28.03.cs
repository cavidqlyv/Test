using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//namespace ConsoleApp5
//{
//    class Program
//    {
//        static void Main(string[] args)
//        {
//            string str = Console.ReadLine();
//            int a;
//            try
//            {

//                try
//                {
//                    if (!int.TryParse(str, out a))
//                        throw new Exception("Error");
//                }
//                catch (Exception e)
//                {
//                    try
//                    {
//                        Func(5, 0);
//                    }
//                    catch (Exception)
//                    {

//                        throw new Exception("Error1" , e);
//                    }
//                }
//            }
//            catch (Exception ex)
//            {

//                Console.WriteLine(ex.Message);
//                Console.WriteLine(ex.InnerException.Message);
//            }
//        }
//        static int Func(int a, int b)
//        {
//            return a / b;
//        }
//    }
//}

namespace ConsoleApp5
{
    class Program
    {
        static void Main(string[] args)
        {
            Price[] price = new Price[5];
            price[0] = new Price("aaa", "sss", "ddd");
            price[1] = new Price("fff", "ggg", "hhh");
            price[2] = new Price("jjj", "kkk", "lll");
            price[3] = new Price("qqq", "www", "eee");
            price[4] = new Price("rrr", "ttt", "yyy");

            try
            {
                string tmp = Console.ReadLine();
                bool flag = false;
                for (int i = 0; i < price.Length; i++)
                    if (tmp == price[i].name)
                    {
                        flag = true;
                        Console.WriteLine(price[i].price);
                        break;
                    }
                if (!flag)
                    throw new Exception("Not Found");
            }
            catch (Exception e)
            {

                Console.WriteLine(e.Message);
            }
        }

        class Price
        {
            public string name;
            public string shop;
            public string price;
            public Price(string pName, string pShop, string pPrice)
            {
                name = pName;
                shop = pShop;
                price = pPrice;
            }
        }
    }
}
