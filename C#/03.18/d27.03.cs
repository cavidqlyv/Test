using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//namespace ConsoleApp1
//{
//    class Program
//    {
//        static void Main(string[] args)
//        {
//            Book book = new Book("aaaa", "bbbbb", "ccccc");
//            book.show();
//        }
//        class Author
//        {
//            public string name;
//            public Author(string aName)
//            {
//                name = aName;
//            }
//        }
//        class Content
//        {
//            public string content;
//            public Content(string cContent)
//            {
//                content = cContent;
//            }
//        }
//        class Title
//        {
//            public string title;
//            public Title(string tTitle)
//            {
//                title = tTitle;
//            }
//        }
//        class Book
//        {
//            Author author;
//            Content content;
//            Title title;
//            public Book(string name, string cContent, string tTitle)
//            {
//                author = new Author(name);
//                content = new Content(cContent);
//                title = new Title(tTitle);
//            }
//            public void show()
//            {
//                Console.WriteLine(author.name);
//                Console.WriteLine(content.content);
//                Console.WriteLine(title.title);
//            }
//        }
//    }
//}


//namespace ConsoleApp1
//{
//    class Program
//    {
//        static void Main(string[] args)
//        {
//            Employee employee = new Employee("qqq", "www");
//            employee.exp = 5;
//            employee.position = "bbb";

//            employee.ShowSalary();
//        }
//        class Employee
//        {
//            public string name;
//            public string surname;
//            public string position;
//            public float exp;
//            public Employee(string eName, string eSurname)
//            {
//                name = eName;
//                surname = eSurname;
//            }
//            public void ShowSalary()
//            {
//                switch (position)
//                {

//                    case "aaa":
//                        Console.WriteLine(500 * (exp / 10 + 1));
//                        break;
//                    case "bbb":
//                        Console.WriteLine(700 * (exp / 10 + 1));
//                        break;
//                    case "ccc":
//                        Console.WriteLine(1000 * (exp / 10 + 1));
//                        break;
//                }
//            }
//        }
//    }
//}


namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            Invoice invoice = new Invoice(123, "qqqq", "wwww")
            { article = "bbb", quantity = 5 };

            invoice.CostCalculation(true);
            invoice.CostCalculation(false);


        }
        class Invoice
        {
            public int ID;
            public string name;
            public string surname;
            public string article;
            public int quantity;
            public Invoice(int iID, string iName, string iSurname)
            {
                ID = iID;
                name = iName;
                surname = iSurname;
            }
            public void CostCalculation(bool flag)
            {
                switch (article)
                {

                    case "aaa":
                        if (flag)
                            Console.WriteLine((100 * quantity * 0.18) + (100 * quantity));
                        else
                            Console.WriteLine(100 * quantity);
                        break;
                    case "bbb":
                        if (flag)
                            Console.WriteLine((200 * quantity * 0.18) + (200 * quantity));
                        else
                            Console.WriteLine(200 * quantity);
                        break;
                    case "ccc":
                        if (flag)
                            Console.WriteLine((300 * quantity * 0.18) + (300 * quantity));
                        else
                            Console.WriteLine(300 * quantity);
                        break;
                }
            }
        }

    }
}
