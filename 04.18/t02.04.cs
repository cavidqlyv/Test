using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp3
{
    class Program
    {
        static void Main(string[] args)
        {
            User[] users = new User[5];
            Card[] cards = new Card[5];
            cards[0] = new Card("1616 5678 9012 3456", "1634", "153", "05.19", 500m);
            cards[1] = new Card("2727 5678 9012 3456", "2734", "263", "06.19", 500m);
            cards[2] = new Card("3838 5678 9012 3456", "3834", "373", "07.19", 500m);
            cards[3] = new Card("4949 5678 9012 3456", "4934", "483", "08.19", 500m);
            cards[4] = new Card("5050 5678 9012 3456", "5034", "593", "09.19", 500m);

            users[0] = new User("aaaa", "bbbb", 1234567, cards[0]);
            users[1] = new User("cccc", "dddd", 2345678, cards[1]);
            users[2] = new User("eeee", "ffff", 3456789, cards[2]);
            users[3] = new User("gggg", "hhhh", 4567890, cards[3]);
            users[4] = new User("jjjj", "kkkk", 5678901, cards[4]);

            string tmpPIN;
            User tmpUser;
            User tmpUser1;
            string tmpstr;
            Action action = new Action();
            int key;
            while (true)
            {
                try
                {
                    Console.WriteLine("Enter PIN");
                    tmpPIN = Console.ReadLine();
                    tmpUser = action.CheckPin(ref users, ref tmpPIN);
                    Console.WriteLine($"Hello { tmpUser.Name }  {tmpUser.Surname}");
                    Console.WriteLine("Balans - 1");
                    Console.WriteLine("Nagd pul - 2");
                    Console.WriteLine("Pul gondermey -3");
                    Console.WriteLine("Siyahi - 4");
                    Int32.TryParse(Console.ReadLine(), out key);

                    if (key == 1)
                    {
                        Console.Write("Balans : ");
                        Console.WriteLine(tmpUser.Card_.Balans);
                    }
                    else if (key == 2)
                    {
                        Console.WriteLine("1 - 10 AZN\t\t2 - 20 AZN\n3 - 50 AZN\t\t4 - 100 AZN\n5 - Other");
                        Int32.TryParse(Console.ReadLine(), out key);
                        switch (key)
                        {
                            case 1:
                                if (tmpUser.Card_.Balans < 10)
                                    throw new Exception("Not enough money");
                                tmpUser.Card_.Balans -= 10;
                                tmpstr = $"10 AZN {DateTime.Now}";
                                tmpUser.list.Add(tmpstr);
                                Console.WriteLine("OK!");
                                continue;
                            case 2:
                                if (tmpUser.Card_.Balans < 20)
                                    throw new Exception("Not enough money");
                                tmpUser.Card_.Balans -= 20;
                                tmpstr = $"20 AZN {DateTime.Now}";
                                tmpUser.list.Add(tmpstr);
                                Console.WriteLine("OK!");
                                continue;
                            case 3:
                                if (tmpUser.Card_.Balans < 50)
                                    throw new Exception("Not enough money");
                                tmpUser.Card_.Balans -= 50;
                                tmpstr = $"50 AZN {DateTime.Now}";
                                tmpUser.list.Add(tmpstr);
                                Console.WriteLine("OK!");
                                continue;
                            case 4:
                                if (tmpUser.Card_.Balans < 100)
                                    throw new Exception("Not enough money");
                                tmpUser.Card_.Balans -= 100;
                                tmpstr = $"100 AZN {DateTime.Now}";
                                tmpUser.list.Add(tmpstr);
                                Console.WriteLine("OK!");
                                continue;
                            case 5:
                                Int32.TryParse(Console.ReadLine(), out key);
                                if (tmpUser.Card_.Balans < key)
                                    throw new Exception("Not enough money");
                                tmpUser.Card_.Balans -= key;
                                tmpstr = $"{key} AZN {DateTime.Now}";
                                tmpUser.list.Add(tmpstr);
                                Console.WriteLine("OK!");
                                continue;
                        }
                    }
                    else if (key == 3)
                    {
                        Console.WriteLine("Enter PIN");
                        tmpPIN = Console.ReadLine();
                        tmpUser1 = action.CheckPin(ref users, ref tmpPIN);
                        Console.WriteLine("Enter");
                        Int32.TryParse(Console.ReadLine(), out key);
                        if (tmpUser.Card_.Balans < key)
                            throw new Exception("Not enough money");
                        tmpUser.Card_.Balans -= key;
                        tmpstr = $"{key} AZN {DateTime.Now}";
                        tmpUser.list.Add(tmpstr);
                        tmpUser1.Card_.Balans += key;
                    }
                    else if (key == 4)
                    {
                        foreach (var item in tmpUser.list)
                        {
                            Console.WriteLine(item);
                        }
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }
            }
        }
        class Action
        {
            public User CheckPin(ref User[] users, ref string pin)
            {
                for (int i = 0; i < users.Length; i++)
                    if (users[i].Card_.PIN == pin)
                        return users[i];
                throw new Exception("User not found");
            }
        }
        class Card
        {
            public string PAN { get; set; }
            public string PIN { get; set; }
            public string CVC { get; set; }
            public decimal Balans { get; set; }
            public string ExpireDate { get; set; }
            public Card(string cPAN, string cPIN, string cCVC, string cExpireDate, decimal cBalans)
            {
                PAN = cPAN;
                PIN = cPIN;
                CVC = cCVC;
                ExpireDate = cExpireDate;
                Balans = cBalans;
            }
        }
        class User
        {
            public int ID { get; set; }
            public Card Card_ { get; set; }
            public string Name { get; set; }
            public string Surname { get; set; }
            public List<string> list = new List<string>();
            public User(string uName, string uSurname, int uID, Card uCard)
            {
                Name = uName;
                Surname = uSurname;
                ID = uID;
                Card_ = uCard;
            }
        }
    }
}