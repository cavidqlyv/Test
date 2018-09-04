using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Threading.Tasks;

namespace ConsoleApp28
{
    class Program
    {
        static void Main(string[] args)
        {
            ////FileInfo file = new FileInfo(@".\New Text Document");

            ////Console.WriteLine(file.FullName);
            ////Console.WriteLine(file);

            ////DirectoryInfo directory = new DirectoryInfo(@".");

            ////Console.WriteLine(directory.Root);

            ////var a = directory.GetFiles("*.txt");

            //foreach (var item in a)
            //{
            //    Console.WriteLine(item.Name);
            //}

            //  Console.WriteLine(file.FullName);

            FileInfo file = new FileInfo(@".\New Text Document2.txt");

            using (StreamWriter streamWriter = new StreamWriter(@".\New Text Document2.txt",true))
            {

                streamWriter.WriteLine("aaaaaaaaaaaaaklajhslkdj;asaaaaaaa");
            }



        }
    }
}
