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
            //controller.WorkerMenu();
        }
    }
    class Controller
    {
        List<User> userList = new List<User>();
        public void MainMenu()
        {
            int menu = 1;
            while (true)
            {
                List<string> mainMenu = new List<string>
                {
                    "Sign in",
                    "Sign up",
                    "Exit"
                };
                int i = 0;
                foreach (var item in mainMenu)
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
                switch (key.Key)
                {
                    case ConsoleKey.UpArrow:
                        menu--;
                        if (menu == 0)
                            menu = 3;
                        break;
                    case ConsoleKey.DownArrow:
                        menu++;
                        if (menu == 4)
                            menu = 1;
                        break;
                    case ConsoleKey.Enter:
                        if (menu == 1)
                            WorkerMenu(Registation.SignIn(userList) as Worker);
                        else if (menu == 2)
                            userList.Add(Registation.SignUp());
                        break;
                }
                Console.Clear();
            }
        }
        public void WorkerMenu(Worker worker)
        {
            int menu = 1;
            while (true)
            {
                int i = 0;
                List<string> workerMenu = new List<string>
                {
                    "Add CV",
                    "Find Work",
                    "Search",
                    "Show CV",
                    "Show all",
                    "Log out"
                };
                foreach (var item in workerMenu)
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
                switch (key.Key)
                {
                    case ConsoleKey.UpArrow:
                        menu--;
                        if (menu == 0)
                            menu = 6;
                        break;
                    case ConsoleKey.DownArrow:
                        menu++;
                        if (menu == 7)
                            menu = 1;
                        break;
                }
                Console.Clear();
            }
        }
        public void EmployerMenu()
        {
            int menu = 1;
            while (true)
            {
                int i = 0;
                List<string> workerMenu = new List<string>
                {
                    "Add advertisement",
                    "Find Worker",
                    "Wiew Appeals",
                    "Log out"
                };
                foreach (var item in workerMenu)
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
                switch (key.Key)
                {
                    case ConsoleKey.UpArrow:
                        menu--;
                        if (menu == 0)
                            menu = 4;
                        break;
                    case ConsoleKey.DownArrow:
                        menu++;
                        if (menu == 5)
                            menu = 1;
                        break;
                }
                Console.Clear();
            }
        }
    }
    static class Registation
    {
        static public User SignUp()
        {
            string mail;
            string username;
            string password;
            string password1;
            int stat;
            Random random = new Random();
            Console.WriteLine("Enter Username");
            username = Console.ReadLine();
            while (true)
            {
                Console.WriteLine("Enter eMail");
                mail = Console.ReadLine();
                Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
                if (regex.IsMatch(mail))
                    break;
            }
            while (true)
            {
                Console.WriteLine("1.Isci\n 2.Isveren");
                int.TryParse(Console.ReadLine(), out stat);
                if (stat == 1 || stat == 2)
                    break;
            }
            while (true)
            {
                Console.WriteLine("Enter Password");
                password = Console.ReadLine();
                Regex regex = new Regex(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,15}$");
                if (regex.IsMatch(password))
                    break;
            }
            while (true)
            {
                Console.WriteLine("Confirm Password");
                password1 = Console.ReadLine();
                if (password == password1)
                    break;
            }
            while (true)
            {
                const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmopqrstuvwxyz0123456789";
                string chapctha = new string(Enumerable.Repeat(chars, 4).Select(s => s[random.Next(s.Length)]).ToArray());
                Console.WriteLine(chapctha + "\nEnter");
                string tmp = Console.ReadLine();
                if (chapctha == tmp)
                    break;
            }
            User user;
            if (stat == 1)
                user = new Worker { Username = username, Email = mail, Password = password, Stat = stat };
            else
                user = new Employer { Username = username, Email = mail, Password = password, Stat = stat };
            return user;
        }
        static public User SignIn(List<User> list)
        {
            string mail;
            string pass;
            while (true)
            {
                Console.WriteLine("Enter eMail");
                mail = Console.ReadLine();
                Console.WriteLine("Enter Passord");
                pass = Console.ReadLine();
                foreach (var item in list)
                {
                    if (item.Email == mail && item.Password == pass)
                        return item;
                }
                Console.WriteLine("Wrong mail or password");
            }
        }
    }
    abstract class User
    {
        public string Username { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public int Stat { get; set; }
    }
    class Worker : User
    {

    }
    class Employer : User
    {

    }
    class CV
    {
        public string Name { get; set; }
        public string Surname { get; set; }
        //public int Gender { get; set; }
        public int Age { get; set; }
        public string Phone { get; set; }
    }
    enum Gender
    {
        Male,
        Female
    }
    enum Category
    {
        Doctor
    }
    enum Experience
    {

    }
}