using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Xml.Serialization;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace ConsoleApp31
{
    class Program
    {
        static void Main(string[] args)
        {
            //using (FileStream stream = new FileStream("test.xml", FileMode.OpenOrCreate, FileAccess.ReadWrite, FileShare.ReadWrite))
            //{
            // var a = new { Name = "B", Surname = "C" };
            //XmlSerializer xmlSerializer = new XmlSerializer(typeof(User));
            //User user = new User { Id = 1, Name = "A", Surname = "B" };
            // xmlSerializer.Serialize(stream, user);

            //  User b = xmlSerializer.Deserialize(stream) as User;

            //Console.WriteLine(b.Name);

            // var c = new { Name = "", Surname = "" };
            // c = Cast(c, b);

            //var a = new { Name = "aaaa", Surname = "bbbb" };
            //string json = JsonConvert.SerializeObject(a);
            //var b = JsonConvert.DeserializeAnonymousType(json, a);
            //Console.WriteLine(json);
            //Console.WriteLine(b.Name);

            //var definition = new { Name = "" };

            //string json1 = @"{'Name':'James'}";
            //var customer1 = JsonConvert.DeserializeAnonymousType(json1, definition);

            //Console.WriteLine(customer1.Name);
            //// James

            //string json2 = @"{'Name':'Mike'}";
            //var customer2 = JsonConvert.DeserializeAnonymousType(json2, definition);

            //Console.WriteLine(customer2.Name);

            //JObject o = new JObject();


            //o["Name"] = "name";
            //o["Surname"] = "surname";

            //var arr = new JArray();
            //arr.Add("aaa");
            //arr.Add("bbb");
            //o["Users"] = arr;

            //Console.WriteLine(o.ToString());

            Func(new User { Name = "aaaa", Surname = "bbbb" }, "0511234567", 10);

            //}
        }
        public static void Func(User user, string number, int num)
        {
            using (FileStream stream = new FileStream("test1.xml", FileMode.OpenOrCreate, FileAccess.ReadWrite, FileShare.ReadWrite))
            {
                if (number[0] == '0' && number[1] == '5' && (number[2] == '0' || number[2] == '1') && (num == 2 || num == 5 || num == 10))
                {
                    XmlSerializer xmlSerializer = new XmlSerializer(typeof(Log));
                    Log log = new Log { Number = number, date = DateTime.Now, Price = num, Result = "Ok!" };

                    xmlSerializer.Serialize(stream, log);
                }
                else
                {
                    XmlSerializer xmlSerializer = new XmlSerializer(typeof(Log));
                    Log log = new Log { Number = number, date = DateTime.Now, Price = num, Result = "Error!" };
                    xmlSerializer.Serialize(stream, log);
                }
                // User b = xmlSerializer.Deserialize(stream) as User

            }
            using (StreamReader reader = new StreamReader(".\\test1.xml"))
            {
                Console.WriteLine(reader.ReadToEnd());
            }

            //public static T Cast<T>(T typeHolder, Object x)
            //{
            //    // typeHolder above is just for compiler magic
            //    // to infer the type to cast x to
            //    return (T)x;
            //}
        }

        //public class Obj
        //{
        //    public string first { get; set; }
        //    public string second { get; set; }
        //}
    }
    public class User
    {
        public string Name { get; set; }
        public string Surname { get; set; }
        //public Obj[] obj = new Obj[3]
        //{
        //    new Obj{first = "aab" , second = "bbb"},
        //    new Obj{first = "aab" , second = "bbb"},
        //    new Obj{first = "aab" , second = "bbb"}
        //};
    }
    public class Log
    {
        public string Number { get; set; }
        public DateTime date { get; set; }
        public int Price { get; set; }
        public string Result { get; set; }
    }
}
