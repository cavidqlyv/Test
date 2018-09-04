using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace ConsoleApp34
{
    class Program
    {
        static void Main(string[] args)
        {
            string num;
            
                //num = Console.ReadLine();
                Regex regex = new Regex(@"^\+994(50|51|55|70)\d{7}$");
                Console.WriteLine(regex.IsMatch("+994505919999"));
            

        }
    }
}
