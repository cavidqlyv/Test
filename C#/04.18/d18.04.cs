using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.IO;
using System.Threading.Tasks;

namespace ConsoleApp29
{
    class Program
    {
        static void Main(string[] args)
        {
            // User user1 = new User(Guid.NewGuid().ToString(), "aaaa", "bbbb");
            //User user2 = new User(Guid.NewGuid().ToString(), "cccc", "dddd");
            //User user3 = new User(Guid.NewGuid().ToString(), "eeee", "ffff");
            //User user4 = new User(Guid.NewGuid().ToString(), "gggg", "hhhh");

            var user = new[]
            {
                new { ID = Guid.NewGuid().ToString(), Name = "aaaa", Surname = "bbbb" },
                new { ID = Guid.NewGuid().ToString(), Name = "cccc", Surname = "dddd" },
                new { ID = Guid.NewGuid().ToString(), Name = "eeee", Surname = "ffff" },
                new { ID = Guid.NewGuid().ToString(), Name = "gggg", Surname = "hhhh" }
            }.ToList();

            var user1 = new { ID = Guid.NewGuid().ToString(), Name = "aaaa", Surname = "bbbb" };
            var user2 = new { ID = Guid.NewGuid().ToString(), Name = "cccc", Surname = "dddd" };
            var user3 = new { ID = Guid.NewGuid().ToString(), Name = "eeee", Surname = "ffff" };
            var user4 = new { ID = Guid.NewGuid().ToString(), Name = "gggg", Surname = "hhhh" };

            UserIO userIO = new UserIO();

            userIO.Write(user);
            userIO.Read();

        }
    }
    class User
    {
        public User(string uId, string uName, string uSurname)
        {
            Id = uId;
            Name = uName;
            Surname = uSurname;
        }
        public string Id { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
    }
    class UserIO
    {
        //public void AddList<T>(T user)
        //{
        //    list.Add(user);
        //}
        public List<T> CreateList<T>(params T[] elements)
        {
            return new List<T>(elements);
        }

        //public void Dispose()
        //{
        //    using (StreamWriter streamWriter = new StreamWriter(@".\text.txt", true))
        //    {
        //        foreach (var item in list)
        //        {
        //            streamWriter.WriteLine($"{item.Id} {item.Name} {item.Surname}");
        //        }
        //    }
        //}

        public void Write<T>(List<T> list)
        {
            using (XmlTextWriter xmlTextWriter = new XmlTextWriter("file.xml", Encoding.UTF8) { Formatting = Formatting.Indented})
            {
                var a = new { ID = "0", Name = "0", Surname = "0" };
                xmlTextWriter.WriteStartDocument();
                xmlTextWriter.WriteStartElement("User_LIst");
                int b = 0;
                foreach (var item in list)
                {
                    a = Cast(a, item);
                    xmlTextWriter.WriteStartElement("User");
                    xmlTextWriter.WriteStartElement(nameof(a.ID));
                    xmlTextWriter.WriteStartAttribute("id");
                    xmlTextWriter.WriteString((b++).ToString());
                    xmlTextWriter.WriteEndAttribute();
                    xmlTextWriter.WriteString(a.ID.ToString());
                    xmlTextWriter.WriteEndElement();
                    xmlTextWriter.WriteStartElement(nameof(a.Name));
                    xmlTextWriter.WriteString(a.Name.ToString());
                    xmlTextWriter.WriteEndElement();
                    xmlTextWriter.WriteStartElement(nameof(a.Surname));
                    xmlTextWriter.WriteString(a.Surname.ToString());
                    xmlTextWriter.WriteEndElement();
                    xmlTextWriter.WriteEndElement();
                }
                xmlTextWriter.WriteEndElement();
            }
        }
        private static T Cast<T>(T typeHolder, Object x)
        {
            // typeHolder above is just for compiler magic
            // to infer the type to cast x to
            return (T)x;
        }
        public void Read()
        {

            XmlDocument xmlDocument = new XmlDocument();

            xmlDocument.Load("file.xml");

            var root = xmlDocument.DocumentElement;

            foreach (XmlNode item in root.ChildNodes)
            {

            if (root.HasChildNodes)
                {
                    foreach (XmlNode item1 in item.ChildNodes)
                    {
                        Console.WriteLine(item1.Name + " " + item1.InnerText);
                    }
                }
            }

            
        }
    }
}
