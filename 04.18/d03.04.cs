using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp13
{
    class Program
    {
        static void Main(string[] args)
        {
            Figure u = new UcBucaq();

            Console.WriteLine(u.Perimetr(1, 2, 3));



        }
    }
    abstract class Figure
    {
        public abstract decimal Sahe(int a , int b );
        public abstract decimal Perimetr(int a, int b , int c);
    }
    class UcBucaq : Figure
    {
        public override decimal Perimetr(int a, int b , int c)
        {
            return a + b + c;
        }
        public override decimal Sahe(int a, int b)
        {
            return (a * b) / 2;
        }
    }
    class Kvadrat : Figure
    {
        public override decimal Perimetr(int a , int b , int d = 0)
        {
            return (a + b) * 2;
        }
        public override decimal Sahe(int a , int b)
        {
            return a * b;
        }
    }
    class Daire : Figure 
    {
        public override decimal Perimetr(int r, int c = 0 , int d = 0)
        {
            return r * 2 * 3.14m;
        }
        public override decimal Sahe(int r , int c = 0)
        {
            return 3.14m * r * r;
        }
    }
}
