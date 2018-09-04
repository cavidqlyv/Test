//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;

//namespace ConsoleApp14
//{
//    class Program
//    {
//        static void Main(string[] args)
//        {

//            IPlayable playable = new Player();
//            playable.Play();
//            playable.Pause();
//            playable.Stop();

//            IReordeble reordeble = new Player();
//            reordeble.Stop();
//            reordeble.Pause();
//            reordeble.Record();
//        }
//        interface IPlayable
//        {
//            void Play();
//            void Pause();
//            void Stop();
//        }
//        interface IReordeble
//        {
//            void Record();
//            void Pause();
//            void Stop();
//        }
//        class Player : IPlayable, IReordeble
//        {
//            void IPlayable.Pause()
//            {
//                Console.WriteLine("Player Pause!");
//            }

//            void IPlayable.Play()
//            {
//                Console.WriteLine("Player Play!");

//            }
//            void IPlayable.Stop()
//            {
//                Console.WriteLine("Player Stop");
//            }
//            void IReordeble.Pause()
//            {
//                Console.WriteLine("Recorder Pause!");
//            }
//            void IReordeble.Record()
//            {
//                Console.WriteLine("Recording");
//            }
//            void IReordeble.Stop()
//            {
//                Console.WriteLine("Recorder Stop");
//            }
//        }
//    }
//}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp14
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Azercell 1");
            Console.WriteLine("Bakcell 2");
            Console.WriteLine("Nar 3");
            int a;
            CIB cib = null;
            try
            {

                Int32.TryParse(Console.ReadLine(), out a);
                if (a == 1)
                {
                    string num;
                    Console.WriteLine("Enter number");
                    num = Console.ReadLine();
                    cib = new CIB(new Azercell(num));

                }
                else if (a == 2)
                {
                    string num;
                    Console.WriteLine("Enter number");
                    num = Console.ReadLine();
                    cib = new CIB(new Bakcell(num));
                }
                else if (a == 3)
                {
                    string num;
                    Console.WriteLine("Enter number");
                    num = Console.ReadLine();
                    cib = new CIB(new Nar(num));
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return;
            }
            while (true)
            {
                try
                {
                    Console.WriteLine("\n\n=========================================================\n");
                    Console.WriteLine("IncreaseBalance 1");
                    Console.WriteLine("Show Balance 2");
                    Int32.TryParse(Console.ReadLine(), out a);
                    if (a == 1)
                    {
                        Int32.TryParse(Console.ReadLine(), out a);

                        cib.IncreaseBalance(a);
                    }
                    else if (a == 2)
                    {
                        cib.ShowBalance();

                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }
            }
        }
    }
    class Azercell : IPay
    {
        string num;
        public int Balance { get; set; }
        public Azercell(string bNum)
        {
            if (!(bNum[0] == '0' && bNum[1] == '5' && bNum[2] == '0' && bNum.Length == 10))
                throw new Exception("Wrong Number");
            num = bNum;
        }
        public void Pay(int n)
        {
            Balance += n;
            Console.WriteLine("Azercell " + num + " " + n);
        }
    }
    class Bakcell : IPay
    {
        string num;
        public int Balance { get; set; }
        public Bakcell(string bNum)
        {
            if (!(bNum[0] == '0' && bNum[1] == '5' && bNum[2] == '5' && bNum.Length == 10))
                throw new Exception("Wrong Number");
            num = bNum;
        }
        public void Pay(int n)
        {
            Balance += n;
            Console.WriteLine("Bakcell " + num + " " + n);
        }
    }
    class Nar : IPay
    {
        string num;
        public int Balance { get; set; }
        public Nar(string bNum)
        {
            if (!(bNum[0] == '0' && bNum[1] == '7' && bNum[2] == '0' && bNum.Length == 10))
                throw new Exception("Wrong Number");
            num = bNum;
        }
        public void Pay(int n)
        {
            Balance += n;
            Console.WriteLine("Nar " + num + " " + n);
        }
    }
    class CIB
    {
        IPay cPay;
        public CIB(IPay cPay1)
        {
            cPay = cPay1;
        }
        public void IncreaseBalance(int n)
        {
            cPay.Pay(n);
        }
        public void ShowBalance()
        {
            Console.WriteLine("Balans : " + cPay.Balance);
        }
    }
    interface IPay
    {
        int Balance { get; set; }
        void Pay(int n);
    }
}

