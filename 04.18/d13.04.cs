using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp23
{
    class Program
    {
        static void Main(string[] args)
        {
            List<Car> list = new List<Car>
            {
                new Car{Model = "aaaa" , Price = "5000" , Year = "1999"},
                new Car{Model = "aaaa" , Price = "6000" , Year = "2001"},
                new Car{Model = "aaaa" , Price = "3000" , Year = "2001"},
                new Car{Model = "dddd" , Price = "9000" , Year = "2003"},
                new Car{Model = "eeee" , Price = "9000" , Year = "2002"}
            };
            List<Car> list5 = new List<Car>
            {
                new Car{Model = "ffff" , Price = "5000" , Year = "1999"},
                new Car{Model = "ffff" , Price = "6000" , Year = "2001"},
                new Car{Model = "ffff" , Price = "3000" , Year = "2001"},
                new Car{Model = "eeee" , Price = "9000" , Year = "2003"},
                new Car{Model = "hhhh" , Price = "9000" , Year = "2002"}
            };
            

            var list1 = list.OrderBy(x => x.Price).ToList();
            var list3 = list.Where(x => x.Price == list.Max(y => y.Price));
            var list4 = list.SkipWhile(x => x.Model == "aaaa").ToList();
            //Console.WriteLine(list3);
            foreach (var item in list1)
            {
                Console.WriteLine(item.Model + " " + item.Price + " " + item.Year);
            }

            var list2 = list.Where(x => x.Model == "aaaa" && x.Year == "2001").ToList();

            Console.WriteLine("\n===========================================================\n\n");


            foreach (var item in list3)
            {
                Console.WriteLine(item.Model + " " + item.Price + " " + item.Year);
            }
            Console.WriteLine("\n===========================================================\n\n");


            foreach (var item in list4)
            {
                Console.WriteLine(item.Model + " " + item.Price + " " + item.Year);
            }

        }
        class Car
        {
            public string Model { get; set; }
            public string Year { get; set; }
            public string Price { get; set; }
        }

    }
}
