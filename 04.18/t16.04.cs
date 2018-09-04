using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp4
{
    class Program
    {
        static void Main(string[] args)
        {
            User user = new User();
            int key;
            int key1;
            int key2;


            Hospital hospital = new Hospital();

            while (true)
            {
                Console.WriteLine("Enter Name");
                user.Name = Console.ReadLine();
                Console.WriteLine("Enter Surname");
                user.Surname = Console.ReadLine();
                Console.WriteLine("Enter Mail");
                user.Mail = Console.ReadLine();
                Console.WriteLine("Enter Phone");
                user.Phone = Console.ReadLine();

                Console.WriteLine("Pediatriya - 1");
                Console.WriteLine("Travmatologiya - 2");
                Console.WriteLine("Stamotologiya - 3");
                int.TryParse(Console.ReadLine(), out key);
                hospital.Print(key);
                int.TryParse(Console.ReadLine(), out key1);
                Console.WriteLine("09:00-11:00 - 1");
                Console.WriteLine("12:00-14:00 - 2");
                Console.WriteLine("15:00-17:00 - 3");
                int.TryParse(Console.ReadLine(), out key2);

                hospital.Rezerv(key1, key2);
            }

        }
    }
    class Hospital
    {
        List<Doctor> Pediatriya;
        List<Doctor> Travmatologiya;
        List<Doctor> Stamotologiya;
        int current;
        public Hospital()
        {
            Pediatriya = new List<Doctor>
            {
                new Doctor{Name = "qqqq" , Surname = "wwww" , Experience = 1},
                new Doctor { Name = "eeee", Surname = "rrrr", Experience = 2 },
                new Doctor { Name = "tttt", Surname = "yyyy", Experience = 3 },
                new Doctor { Name = "uuuu", Surname = "iiii", Experience = 4 },
            };
            Travmatologiya = new List<Doctor>
            {
                new Doctor{Name = "oooo" , Surname = "pppp" , Experience = 5},
                new Doctor { Name = "aaaa", Surname = "ssss", Experience = 6 },
                new Doctor { Name = "dddd", Surname = "ffff", Experience = 7 },
            };
            Stamotologiya = new List<Doctor>
            {
                new Doctor{Name = "gggg" , Surname = "hhhh" , Experience = 8},
                new Doctor { Name = "jjjj", Surname = "kkkk", Experience = 9 },
            };
        }
        public void Print(int list)
        {
            current = list;
            List<Doctor> tmp = null;
            if (list == 1)
                tmp = Pediatriya;
            else if (list == 2)
                tmp = Travmatologiya;
            else if (list == 3)
                tmp = Stamotologiya;
            int i = 1;
            foreach (var item in tmp)
            {
                Console.WriteLine(item.Name + " " + item.Surname + " - " + i);
                i++;
            }
        }
        public void Rezerv(int index, int time)
        {
            List<Doctor> tmp = null;
            if (current == 1)
                tmp = Pediatriya;
            else if (current == 2)
                tmp = Travmatologiya;
            else if (current == 3)
                tmp = Stamotologiya;
            if (tmp[index].Check(time))
                Console.WriteLine("ok");
            else
                Console.WriteLine("error");

        }
    }
    class Doctor
    {
        public string Name { get; set; }
        public string Surname { get; set; }
        public int Experience { get; set; }
        bool[] Time = new bool[3];
        public Doctor()
        {
            for (int i = 0; i < Time.Length; i++)
                Time[i] = true;
        }
        public bool Check(int index)
        {
            if (!Time[index])
                return false;

            Time[index] = false;
            return true;
        }
    }
    class User
    {
        public string Name { get; set; }
        public string Surname { get; set; }
        public string Mail { get; set; }
        public string Phone { get; set; }
    }
}