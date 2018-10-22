using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp17
{
    class Program
    {
        static void Main(string[] args)
        {
            Accauntant accauntant;
            try
            {

                Console.WriteLine(accauntant.AskForBonus(Worker.Developer, 205));
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }
    }
    enum Worker
    {
        Manager = 195,
        Developer = 200
    }
    struct Accauntant
    {
        public bool AskForBonus(Worker worker, int hours)
        {
            switch (worker)
            {
                case Worker.Manager:
                    if (hours > 195)
                        return true;
                    break;
                case Worker.Developer:
                    if (hours > 200)
                        return true;
                    break;
            }
            throw new Exception("Error");
        }
    }
}
