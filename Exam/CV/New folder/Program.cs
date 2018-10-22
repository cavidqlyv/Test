using System;
using System.IO;
using ConsoleApp6;
using System.Linq;
using System.Text;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace ConsoleApp37
{
    class Program
    {
        static void Main(string[] args)
        {
            Controller controller = new Controller();
            controller.MainMenu();
        }
    }
    public class Controller
    {
        List<User> userList = new List<User>();
        public Controller()
        {
            using (FileStream stream = new FileStream("Worker.json", FileMode.OpenOrCreate, FileAccess.ReadWrite, FileShare.ReadWrite))
            {
                StreamReader streamReader = new StreamReader(stream);
                string tmp = streamReader.ReadToEnd();
                var a = JsonConvert.DeserializeObject<List<Worker>>(tmp);
                if (a != null)
                    foreach (var item in a)
                    {
                        userList.Add(item as User);
                    }
                streamReader.Close();
            }
            using (FileStream stream = new FileStream("Employer.json", FileMode.OpenOrCreate, FileAccess.ReadWrite, FileShare.ReadWrite))
            {
                StreamReader streamReader = new StreamReader(stream);
                string tmp = streamReader.ReadToEnd();
                var a = JsonConvert.DeserializeObject<List<Employer>>(tmp);
                if (a != null)
                    foreach (var item in a)
                    {
                        userList.Add(item as User);
                    }
                streamReader.Close();
            }
        }
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
                        {
                            var a = Registation.SignIn(userList);
                            if (a.Stat == 1)
                                WorkerMenu(a as Worker);
                            else
                                EmployerMenu(a as Employer);
                        }
                        else if (menu == 2)
                            userList.Add(Registation.SignUp());
                        else if (menu == 3)
                        {
                            StringBuilder stringBuilderEmployer = new StringBuilder();
                            StringBuilder stringBuilderWorker = new StringBuilder();

                            List<Worker> listWorker = new List<Worker>();
                            List<Employer> listEmployer = new List<Employer>();

                            foreach (var item in userList)
                            {
                                if (item.Stat == 1)
                                    listWorker.Add(item as Worker);
                                else
                                    listEmployer.Add(item as Employer);
                            }
                            Console.WriteLine(stringBuilderEmployer);
                            Console.WriteLine(stringBuilderWorker);
                            using (FileStream stream = new FileStream("Worker.json", FileMode.OpenOrCreate, FileAccess.ReadWrite, FileShare.ReadWrite))
                            {
                                StreamWriter streamWriter = new StreamWriter(stream);
                                var a = JsonConvert.SerializeObject(listWorker);
                                streamWriter.WriteLine(a);
                                streamWriter.Close();
                            }
                            using (FileStream stream = new FileStream("Employer.json", FileMode.OpenOrCreate, FileAccess.ReadWrite, FileShare.ReadWrite))
                            {
                                StreamWriter streamWriter = new StreamWriter(stream);
                                var a = JsonConvert.SerializeObject(listEmployer);
                                streamWriter.WriteLine(a);
                                streamWriter.Close();
                            }

                            return;
                        }
                        break;
                }
                Console.Clear();
            }
        }
        public void WorkerMenu(Worker worker)
        {
            Console.Clear();
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
                    case ConsoleKey.Enter:
                        if (menu == 1)
                            worker.AddCV();
                        else if (menu == 2)
                        {
                            Console.Clear();
                            var tmp = worker.FindWork(userList);
                            foreach (var item in tmp)
                            {
                                Console.WriteLine($"Company Name : {item.CompanyName}");
                                Console.WriteLine($"Category : {item.Category}");
                                Console.WriteLine($"Age : {item.Age}");
                                Console.WriteLine($"City : {item.City}");
                                Console.WriteLine($"Education : {item.Education}");
                                Console.WriteLine("1 Yes\n2 No");
                                int.TryParse(Console.ReadLine(), out int a);
                                if (a == 1)
                                    item.Appeals.Add(worker.CV);
                            }
                        }
                        else if (menu == 3)
                        {
                            Console.Clear();
                            var tmp = worker.Search(userList);
                            foreach (var item in tmp)
                            {
                                Console.WriteLine($"Company Name : {item.CompanyName}");
                                Console.WriteLine($"Category : {item.Category}");
                                Console.WriteLine($"Age : {item.Age}");
                                Console.WriteLine($"City : {item.City}");
                                Console.WriteLine($"Education : {item.Education}");
                                Console.WriteLine("1 Yes\n2 No");
                                int.TryParse(Console.ReadLine(), out int a);
                                if (a == 1)
                                    item.Appeals.Add(worker.CV);
                            }
                        }
                        else if (menu == 4)
                            worker.ShowCV();
                        else if (menu == 5)
                        {
                            Console.Clear();
                            var tmp = worker.ViewAll(userList);
                            foreach (var item in tmp)
                            {
                                Console.WriteLine($"Company Name : {item.CompanyName}");
                                Console.WriteLine($"Category : {item.Category}");
                                Console.WriteLine($"Age : {item.Age}");
                                Console.WriteLine($"City : {item.City}");
                                Console.WriteLine($"Education : {item.Education}");
                                Console.WriteLine("1 Yes\n2 No");
                                int.TryParse(Console.ReadLine(), out int a);
                                if (a == 1)
                                    item.Appeals.Add(worker.CV);
                            }
                        }
                        else if (menu == 6)
                            return;
                        break;
                }
                Console.Clear();
            }
        }
        public void EmployerMenu(Employer employer)
        {
            Console.Clear();
            int menu = 1;
            while (true)
            {
                int i = 0;
                List<string> workerMenu = new List<string>
                {
                    "Add advertisement",
                    "View Appeals",
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
                            menu = 3;
                        break;
                    case ConsoleKey.DownArrow:
                        menu++;
                        if (menu == 4)
                            menu = 1;
                        break;
                    case ConsoleKey.Enter:
                        if (menu == 1)
                            employer.AddAdvertisement();
                        else if (menu == 2)
                            employer.ViewAppeals();
                        else if (menu == 3)
                            return;
                        break;
                }
                Console.Clear();
            }
        }
    }
    public static class Registation
    {
        static public User SignUp()
        {
            Console.Clear();
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
                Console.WriteLine("1.Worker\n2.Employer");
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
            Console.Clear();
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
    public enum Gender
    {
        Male,
        Female
    }
    public enum Category
    {
        Doctor,
        Journalist,
        ITspecialist,
        Translator
    }
    public enum Experience
    {
        Year1,
        Year13,
        Year35,
        Year5
    }
    public enum Education
    {
        HighSchool,
        IncompleteUndergraduate,
        Undergraduate
    }
}