using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary1
{
    public class Class1
    {
        public int A { get; set; }
        public int B { get; set; }
        

        public void Func()
        {
            Console.WriteLine("OK!");
        }
        public static Class1 operator +(Class1 c1, Class1 c2)
        {
            Class1 c = new Class1();
            c.A = c1.A + c2.A;
            c.B = c1.B + c2.B;
            return c;
        }
    }
}
