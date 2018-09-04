using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace ConsoleApp37
{
    class Program
    {
        static void Main(string[] args)
        {
            Controller controller = new Controller();
            Registation registation = new Registation();
            registation.SignUp();
        }
    }
    class Controller
    {
        public void PrintMenu()
        {
            int menu = 1;
            int i;
            List<string> stringList = new List<string>();
            stringList.Add("Sign in");
            stringList.Add("Sign up");
            stringList.Add("Exit");
            i = 0;
            foreach (var item in stringList)
            {
                i++;
                if (i == menu)
                {
                    Console.BackgroundColor = ConsoleColor.White;
                    Console.ForegroundColor = ConsoleColor.Black;
                    Console.WriteLine(item);
                    Console.BackgroundColor = ConsoleColor.Black;
                    Console.ForegroundColor = ConsoleColor.White;
                    continue;
                }
                Console.WriteLine(item);
            }
            ConsoleKeyInfo key = Console.ReadKey();
            if (ConsoleKey.UpArrow == key.Key)
            {
                menu--;
                if (menu == 0)
                    menu = 3;
            }
            else if (ConsoleKey.DownArrow == key.Key)
            {
                menu++;
                if (menu == 4)
                    menu = 1;
            }
            Console.Clear();
        }

    }
    class Registation
    {
        public void SignUp()
        {
            string mail;
            string username;
            string password;
            string password1;
            Random random = new Random();
            Console.WriteLine("Enter Username");
            //username = Console.ReadLine();
            //while (true)
            //{
            //    Console.WriteLine("Enter eMail");
            //    mail = Console.ReadLine();
            //    Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
            //    if (regex.IsMatch(mail))
            //        break;
            //}
            //while (true)
            //{
            //    Console.WriteLine("Enter Password");
            //    password = Console.ReadLine();
            //    Regex regex = new Regex(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,15}$");
            //    if (regex.IsMatch(password))
            //        break;
            //}
            //while (true)
            //{
            //    Console.WriteLine("Confirm Password");
            //    password1 = Console.ReadLine();
            //    if (password == password1)
            //        break;
            //}
          //  while (true)
            {
                const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmopqrstuvwxyz0123456789";
                string a = new string(Enumerable.Repeat(chars, 4).Select(s => s[random.Next(s.Length)]).ToArray());
                Console.WriteLine(a);
            }
        }
        public void SignIn()
        {

        }
    }
}
//Reg
//Cv
//User1
//User2
//User1 con
//User2 con
//Action
//

