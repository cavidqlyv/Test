using System;
using ConsoleApp37;
using System.Collections.Generic;

namespace ConsoleApp6
{
    public abstract class User
    {
        public string Username { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public int Stat { get; set; }
    }
    public class Worker : User
    {
        public CV CV { get; set; }
        public void AddCV()
        {
            CV = new CV
            {
                Name = GetData.GetName(),
                Surname = GetData.GetSurname(),
                Gender = GetData.GetGender(),
                Age = GetData.GetAge(),
                Education = GetData.GetEducation(),
                Experience = GetData.GetExperience(),
                Category = GetData.GetCategory(),
                City = GetData.GetCity(),
                MinSalary = GetData.GetMinSalary(),
                Phone = GetData.GetPhone()
            };
        }
        public List<Job> FindWork(List<User> list)
        {
            List<Job> tmpList = new List<Job>();
            if (CV != null)
                foreach (var item in list)
                {
                    if (item.Stat == 2)
                    {
                        Employer employer = item as Employer;
                        foreach (var item1 in employer.List)
                        {
                            if (item1.Salary > CV.MinSalary &&
                                item1.City == CV.City &&
                                item1.Category == CV.Category &&
                                item1.Age <= CV.Age &&
                                item1.Education == CV.Education &&
                                item1.Experience <= CV.Experience)
                                tmpList.Add(item1);
                        }
                    }
                }
            return tmpList;
        }
        public List<Job> Search(List<User> user)
        {
            List<Job> list = new List<Job>();
            Console.WriteLine("Select Category");
            Console.WriteLine("1\tSalary");
            Console.WriteLine("2\tCity");
            Console.WriteLine("3\tCategory");
            Console.WriteLine("4\tAge");
            Console.WriteLine("5\tEducation");
            Console.WriteLine("6\tExperience");
            int.TryParse(Console.ReadLine(), out int key);
            switch (key)
            {
                case (int)SearchJ.Salary:
                    foreach (var item in user)
                    {
                        if (item.Stat == 2)
                        {
                            Employer employer = item as Employer;
                            foreach (var item1 in employer.List)
                            {
                                if (item1.Salary > GetData.GetMinSalary())
                                    list.Add(item1);
                            }
                        }
                    }
                    break;
                case (int)SearchJ.City:
                    foreach (var item in user)
                    {
                        if (item.Stat == 2)
                        {
                            Employer employer = item as Employer;
                            foreach (var item1 in employer.List)
                            {
                                if (item1.City == GetData.GetCity())
                                    list.Add(item1);
                            }
                        }
                    }
                    break;
                case (int)SearchJ.Category:
                    foreach (var item in user)
                    {
                        if (item.Stat == 2)
                        {
                            Employer employer = item as Employer;
                            foreach (var item1 in employer.List)
                            {
                                if (item1.Category == GetData.GetCategory())
                                    list.Add(item1);
                            }
                        }
                    }
                    break;
                case (int)SearchJ.Age:
                    foreach (var item in user)
                    {
                        if (item.Stat == 2)
                        {
                            Employer employer = item as Employer;
                            foreach (var item1 in employer.List)
                            {
                                if (item1.Age <= GetData.GetAge())
                                    list.Add(item1);
                            }
                        }
                    }
                    break;
                case (int)SearchJ.Education:
                    foreach (var item in user)
                    {
                        if (item.Stat == 2)
                        {
                            Employer employer = item as Employer;
                            foreach (var item1 in employer.List)
                            {
                                if (item1.Education == GetData.GetEducation())
                                    list.Add(item1);
                            }
                        }
                    }
                    break;
                case (int)SearchJ.Experience:
                    foreach (var item in user)
                    {
                        if (item.Stat == 2)
                        {
                            Employer employer = item as Employer;
                            foreach (var item1 in employer.List)
                            {
                                if (
                                    item1.Experience <= GetData.GetExperience())
                                    list.Add(item1);
                            }
                        }
                    }
                    break;
            }
            return list;
        }
        public void ShowCV()
        {
            Console.Clear();
            Console.WriteLine($"Name : {CV.Name}");
            Console.WriteLine($"Surname : {CV.Surname}");
            Console.WriteLine($"Gender : {CV.Gender}");
            Console.WriteLine($"Age : {CV.Age}");
            Console.WriteLine($"Education : {CV.Education}");
            if (CV.Experience == Experience.Y1)
                Console.WriteLine($"Experience : Under 1 Year");
            else if (CV.Experience == Experience.Y13)
                Console.WriteLine("Experience : 1-3 Year");
            else if (CV.Experience == Experience.Y35)
                Console.WriteLine("Experience : 3-5 Year");
            else if (CV.Experience == Experience.Y5)
                Console.WriteLine("Experience : More 5 Year");
            Console.ReadLine();
        }
        public List<Job> ViewAll(List<User> users)
        {
            List<Job> jobs = new List<Job>();
            foreach (var item in users)
            {
                if (item.Stat == 2)
                {
                    Employer employer = item as Employer;
                    foreach (var item1 in employer.List)
                        jobs.Add(item1);
                }
            }
            return jobs;
        }
    }
    enum SearchJ
    {
        Salary = 1,
        City,
        Category,
        Age,
        Education,
        Experience
    }
    public class Employer : User
    {
        private List<Job> list = new List<Job>();

        public List<Job> List { get => list; set => list = value; }

        public void AddAdvertisement()
        {
            Job job = new Job
            {
                Name = GetData.GetName(),
                CompanyName = GetData.GetCompanyName(),
                Category = GetData.GetCategory(),
                Info = GetData.GetInfo(),
                City = GetData.GetCity(),
                Salary = GetData.GetMinSalary(),
                Age = GetData.GetAge(),
                Education = GetData.GetEducation(),
                Experience = GetData.GetExperience(),
                Phone = GetData.GetPhone()
            };
            list.Add(job);
        }
        public void ViewAppeals()
        {
            foreach (var item in list)
            {
                Console.WriteLine("Name " + item.Name);
                foreach (var item1 in item.Appeals)
                {
                    Console.WriteLine("Name : " + item1.Name);
                    Console.WriteLine("Surname : " + item1.Surname);
                    Console.WriteLine("Phone : " + item1.Phone);
                }
                Console.WriteLine("\n\n==========================================\n");
            }
            Console.ReadLine();
        }
    }
    static class GetData
    {
        public static string GetName()
        {
            Console.WriteLine("Enter Name");
            return Console.ReadLine();
        }
        public static string GetSurname()
        {
            Console.WriteLine("Enter Surname");
            return Console.ReadLine();
        }
        public static Gender GetGender()
        {
            while (true)
            {
                Console.WriteLine("Select Gender");
                Console.WriteLine("1.Male 2.Female");
                int.TryParse(Console.ReadLine(), out int key);
                if (key == 1)
                    return Gender.Male;
                else if (key == 2)
                    return Gender.Female;
                else
                    Console.WriteLine("Wrong");
            }
        }
        public static int GetAge()
        {
            Console.WriteLine("Enter Age");
            return Convert.ToInt32(Console.ReadLine());
        }
        public static Education GetEducation()
        {
            while (true)
            {
                Console.WriteLine("Select Education");
                Console.WriteLine("1\tHigh School\n2\tIncomplete Undergraduate\n3\tUndergraduate");
                int.TryParse(Console.ReadLine(), out int key);
                if (key == 1)
                    return Education.HighSchool;
                else if (key == 2)
                    return Education.IncompleteUndergraduate;
                else if (key == 3)
                    return Education.Undergraduate;
                else
                    Console.WriteLine("Wrong");
            }
        }
        public static Experience GetExperience()
        {
            while (true)
            {
                Console.WriteLine("Select Experience");
                Console.WriteLine("1\t1 Year\n2\t1-3 Year\n3\t3-5 Year\n4\tMore 5 Year");
                int.TryParse(Console.ReadLine(), out int key);
                if (key == 1)
                    return Experience.Y1;
                else if (key == 2)
                    return Experience.Y13;
                else if (key == 3)
                    return Experience.Y35;
                else if (key == 4)
                    return Experience.Y5;
                else
                    Console.WriteLine("Wrong");
            }
        }
        public static Category GetCategory()
        {
            while (true)
            {
                Console.WriteLine("Select Category");
                Console.WriteLine("1\tDoctor\n2\tJournalist\n3\tITspecialist\n4\tTranslator");
                int.TryParse(Console.ReadLine(), out int key);
                if (key == 1)
                    return Category.Doctor;
                else if (key == 2)
                    return Category.Journalist;
                else if (key == 3)
                    return Category.ITspecialist;
                else if (key == 4)
                    return Category.Translator;
                else
                    Console.WriteLine("Wrong");
            }
        }
        public static string GetCity()
        {
            Console.WriteLine("Enter City");
            return Console.ReadLine();
        }
        public static int GetMinSalary()
        {
            Console.WriteLine("Enter Minimum Salary");
            return Convert.ToInt32(Console.ReadLine());
        }
        public static string GetPhone()
        {
            Console.WriteLine("Enter Phone");
            return Console.ReadLine();
        }
        public static string GetCompanyName()
        {
            Console.WriteLine("Enter Company Name");
            return Console.ReadLine();
        }
        public static string GetInfo()
        {
            Console.WriteLine("Enter Information");
            return Console.ReadLine();
        }
    }
    public class Job
    {
        public string Name { get; set; }
        public string CompanyName { get; set; }
        public Category Category { get; set; }
        public string Info { get; set; }
        public string City { get; set; }
        public int Salary { get; set; }
        public int Age { get; set; }
        public Education Education { get; set; }
        public Experience Experience { get; set; }
        public string Phone { get; set; }
        public List<CV> Appeals { get => appeals; set => appeals = value; }
        private List<CV> appeals = new List<CV>();
    }
    public class CV
    {
        public string Name { get; set; }
        public string Surname { get; set; }
        public Gender Gender { get; set; }
        public int Age { get; set; }
        public Education Education { get; set; }
        public Experience Experience { get; set; }
        public Category Category { get; set; }
        public string City { get; set; }
        public int MinSalary { get; set; }
        public string Phone { get; set; }
    }
}