using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Globalization;


namespace ConsoleApp6
{
    class Program
    {
        static void Main(string[] args)
        {
            Worker[] worker = new Worker[2];
            for (int i = 0; i < worker.Length; i++)
            {
                worker[i] = new Worker();
                Console.WriteLine("Enter name");
                worker[i].Name = Console.ReadLine();
                Console.WriteLine("Enter Surname");
                worker[i].Surname = Console.ReadLine();
                Console.WriteLine("Enter job");
                worker[i].Job = Console.ReadLine();
                Console.WriteLine("Enter year");
                try
                {
                    worker[i].Year = Convert.ToInt32(Console.ReadLine());
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                    i--;
                }
            }
            for (int i = 0; i < worker.Length; i++)
            {
                Console.Write(worker[i].Name);
                Console.Write("\t");
                Console.WriteLine(worker[i].getData());
            }
        }
        class Worker
        {
            public string Name { get; set; }
            public string Surname { get; set; }
            public string Job { get; set; }
            public int Year { get; set; }
            public int getData()
            {
                DateTime data = new DateTime(2018);
                int currentYear = data.Year;
                if (currentYear - Year >= 1 && currentYear - Year < 5)
                    return 30;
                else if (currentYear - Year >= 5 && currentYear - Year < 7)
                    return 33;
                else if (currentYear - Year >= 7 && currentYear - Year < 10)
                    return 35;
                else if (currentYear - Year >= 10)
                    return 40;
                return 0;
            }
        }
    }
}
