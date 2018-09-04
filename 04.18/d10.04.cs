using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp18
{
    class Program
    {
        static void Main(string[] args)
        {
            Train[] train = new Train[5];
            train[0] = new Train();
            train[0].Number = 1;
            train[0].DateTime = new DateTime(2018, 04, 10, 22, 00, 00);
            train[0].Destinations = Destinations.Baki;

            train[1] = new Train();
            train[1].Number = 2;
            train[1].DateTime = new DateTime(2018, 04, 11, 23, 00, 00);
            train[1].Destinations = Destinations.Gence;

            train[2] = new Train();
            train[2].Number = 3;
            train[2].DateTime = new DateTime(2018, 04, 11, 00, 00, 00);
            train[2].Destinations = Destinations.Zaqatala;

            train[3] = new Train();
            train[3].Number = 4;
            train[3].DateTime = new DateTime(2018, 04, 11, 01, 00, 00);
            train[3].Destinations = Destinations.Baki;

            train[4] = new Train();
            train[4].Number = 5;
            train[4].DateTime = new DateTime(2018, 04, 10, 02, 00, 00);
            train[4].Destinations = Destinations.Gence;

            Person person = new Person();
            Console.WriteLine("Enter name");
            person.Name = Console.ReadLine();
            Console.WriteLine("Enter surname");

            person.Surname = Console.ReadLine();
            int a;
            Console.WriteLine("Enter id");

            int.TryParse(Console.ReadLine(), out a);
            person.Id = a;

            Train temp;


            var t = train.OrderBy(x => x.DateTime).ToArray();

            Console.WriteLine("Baki 1");
            Console.WriteLine("Gence 2");
            Console.WriteLine("Zaqatala 3");

            int.TryParse(Console.ReadLine(), out a);

            Destinations? des = null;
            switch (a)
            {
                case 1:
                    des = Destinations.Baki;
                    break;
                case 2:
                    des = Destinations.Gence;
                    break;
                case 3:
                    des = Destinations.Zaqatala;
                    break;
            }
            Console.WriteLine("\n\n========================================\n");
            for (int i = 0; i < t.Length; i++)
                if (t[i].Destinations == des)
                {
                    Console.WriteLine("Number " + t[i].Number);
                    Console.WriteLine("Time " + t[i].DateTime);
                    Console.WriteLine("Destination " + t[i].Destinations);
                    Console.WriteLine("\n\n========================================\n");
                }
        }
    }
    struct Train
    {
        public int Number { get; set; }
        public DateTime DateTime { get; set; }
        public Destinations Destinations { get; set; }
    }
    class Person
    {
        public string Name { get; set; }
        public string Surname { get; set; }
        public int Id { get; set; }
    }

    enum Destinations
    {
        Baki, Gence, Zaqatala
    }
}
