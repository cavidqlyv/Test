using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//namespace ConsoleApp3
//{
//    class Program
//    {
//        static void Main(string[] args)
//        {

//            Console.WriteLine("Enter number");
//            int num = Convert.ToInt32(Console.ReadLine());

//            Console.WriteLine(Factorial(num));


//        }
//       static int Factorial(int n)
//        {
//            int sum = n;
//            if (n >1)
//            sum = sum * Factorial(n - 1);
//            return sum;
//        }
//    }
//}



namespace ConsoleApp3
{
    class Program
    {
        static void Main(string[] args)
        {

            Console.WriteLine("Enter number");
            int num = Convert.ToInt32(Console.ReadLine());

            string result = null;
            string strTmp = null;
            int tmp;
            while (true)
            {
                if (num == 1)
                {
                    strTmp = "1";
                    strTmp += result;
                    result = strTmp;
                    break;
                }
                tmp = num % 2;
                num /= 2;
                strTmp = tmp.ToString();
                strTmp += result;
                result = strTmp;
            }

            Console.WriteLine(result);
        }

    }
}
