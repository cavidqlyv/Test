using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp5
{
    class Program
    {
        static void Main(string[] args)
        {

            User[] users = new User[5];
            int userCount = 0;
            bool flag = false;
            while (true)
            {
                if (!flag)
                    Console.WriteLine("Sign up - 1");
                else
                {
                    Console.WriteLine("Sign up - 1");
                    Console.WriteLine("Sign in - 2");
                }
                int key = Convert.ToInt32(Console.ReadLine());
                if (key == 1)
                {
                    users[userCount] = new User();
                    Console.WriteLine("Enter Name");
                    users[userCount].name = Console.ReadLine();
                    Console.WriteLine("Enter Surname");
                    users[userCount].surname = Console.ReadLine();
                    Console.WriteLine("Enter Username");
                    users[userCount].username = Console.ReadLine();
                    Console.WriteLine("Enter Number");
                    users[userCount].number = Console.ReadLine();
                    Console.WriteLine("Enter Password");
                    users[userCount++].password = Console.ReadLine();
                    flag = true;
                }
                else if (key == 2)
                {
                    if (Func(users, userCount))
                        Console.WriteLine("Succesfully logined");
                    else
                        Console.WriteLine("Error");
                }
            }
        }
        static bool Func(User[] users, int userCount)
        {
            Console.WriteLine("Enter Username");
            string tmp1 = Console.ReadLine();
            Console.WriteLine("Enter Password");
            string tmp2 = Console.ReadLine();
            for (int i = 0; i < userCount; i++)
            {
                if (tmp1 == users[i].username && tmp2 == users[i].password)
                    return true;
            }
            return false;
        }
        class User
        {
            public string name;
            public string surname;
            public string username;
            public string number;
            public string password;
        }
    }
}
