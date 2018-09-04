using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using System.Threading.Tasks;

namespace ConsoleApp33
{
    class Program
    {
        static void Main(string[] args)
        {
            List<TelephoneBook> list = new List<TelephoneBook>
            {
                new TelephoneBook(){Name = "aaaa" , Group = "bbbb" , Number = "1234"},
                new TelephoneBook(){Name = "cccc" , Group = "bbbb" , Number = "5678"},
                new TelephoneBook(){Name = "ffff" , Group = "gggg" , Number = "9012"},
                new TelephoneBook(){Name = "hhhh" , Group = "jjjj" , Number = "3456"},
                new TelephoneBook(){Name = "kkkk" , Group = "llll" , Number = "7890"},
            };
            using (XmlTextWriter xmlTextWriter = new XmlTextWriter("file.xml", Encoding.UTF8) { Formatting = Formatting.Indented })
            {
                xmlTextWriter.WriteStartDocument();
                xmlTextWriter.WriteStartElement("MyContacts");
                foreach (var item in list)
                {
                    xmlTextWriter.WriteStartElement("Contact");
                    xmlTextWriter.WriteStartAttribute(nameof(item.Group));
                    xmlTextWriter.WriteString(item.Group);
                    xmlTextWriter.WriteEndAttribute();
                    xmlTextWriter.WriteStartElement(nameof(item.Name));
                    xmlTextWriter.WriteString(item.Name);
                    xmlTextWriter.WriteEndElement();
                    xmlTextWriter.WriteStartElement(nameof(item.Number));
                    xmlTextWriter.WriteString(item.Number);
                    xmlTextWriter.WriteEndElement();
                    xmlTextWriter.WriteEndElement();
                }
                xmlTextWriter.WriteEndElement();
                xmlTextWriter.WriteEndDocument();
            }

            foreach (var item in GetList(list , "bbbb"))
            {
                Console.WriteLine("Name : " + item.Name);
                Console.WriteLine("Number : " + item.Number);

            }

        }
        static List<TelephoneBook> GetList(List<TelephoneBook> list , string group)
        {
            var a = from x in list
                                    where x.Group == @group
                                    select x;
            return a.ToList();
        }
    }
    public class TelephoneBook
    {
        public string Name { get; set; }
        public string Group { get; set; }
        public string Number { get; set; }
    }
}
