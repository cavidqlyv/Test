using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp26
{
    class Program
    {
        static void Main(string[] args)
        {
            List<Employee> list = new List<Employee>()
            {
                new Employee
                {
                    FirstName = "Ivan",
                    LastName = "Ivanov",
                    Salary = 94000,
                    Id=1
                },
                new Employee
                {
                    FirstName = "Petr",
                    LastName = "Petrov",
                    Salary = 12000000,
                    Id=2
                },
                new Employee
                {
                    FirstName = "Andrew",
                    LastName = "Andreev",
                    Salary = 150000,
                    Id=3
                },
                new Employee
                {
                    FirstName = "aaaa",
                    LastName = "bbbb",
                    Salary = 150000,
                    Id=4
                },
                new Employee
                {
                    FirstName = "cccc",
                    LastName = "dddd",
                    Salary = 150000,
                    Id=5
                }
            };
            List<OtherClass> list1 = new List<OtherClass>()
            {
                new OtherClass
                {
                    Id =1,
                    Age = 2,
                },
                 new OtherClass
                {
                    Id =2,
                    Age = 3,
                },
                new OtherClass
                {
                    Id =3,
                    Age = 4,
                },
                new OtherClass
                {
                    Id =4,
                    Age = 4,
                },
                new OtherClass
                {
                    Id =5,
                    Age = 4,
                }
            };


            //var objQuery = list.Join(list1, x => x.Id, y => y.Id, (z, b) => new { z, b }).Select(x => new {Age = x.b.Age, First = x.z.FirstName });

            var a = from t in list
                    join x in list1
                    on t.Id equals x.Id
                    select new { Name = t.FirstName, Surname = t.LastName, x.Age };

            var b = from y in a
                    group y by y.Age;


            var u = a.GroupBy(g => g.Age).Select(t => new { Name = g.FirstName, Surname = g.LastName, g.Age });

            foreach (var item in u)
            {
                Console.WriteLine("====================================");
                foreach (var item2 in item)
                {
                    Console.WriteLine(item2.Name + " " + item2.Surname + " " + item2.Age);
                }
            }


            //var a = from t in list
            //        where t.Salary > 100000
            //        orderby t.Salary descending
            //        let d = t.FirstName
            //        select new { Name = d , Surname = t.LastName};

            //var b = list.Where(s => s.Salary > 100000).OrderBy(x => x.Salary).Select(y=>new { Name = y.FirstName, Surname = y.LastName });

            //foreach (var item in a)
            //{
            //    Console.WriteLine(item.Name + " " + item.Surname);
            //}
        }
    }
    class Employee
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int Salary { get; set; }
        public int Id { get; set; }
    }
    class OtherClass
    {
        public int Id { get; set; }
        public int Age { get; set; }
    }
}
