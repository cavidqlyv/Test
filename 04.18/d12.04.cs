//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;

//namespace ConsoleApp20
//{
//    delegate double Deleg(int a, int b);
//    class Program
//    {
//        static void Main(string[] args)
//        {
//            Deleg deleg = null; 
//            int a, b;
//            int.TryParse(Console.ReadLine(), out a);
//            string key = Console.ReadLine();
//            int.TryParse(Console.ReadLine(), out b);
//            // hgkjhgljhljh.kjh
//            ///hjgkjhl
//            ////65432
//            switch (key)
//            {
//                case "+":
//                    deleg = (x, y) =>
//                    {
//                        return x + y;
//                    };
//                    break;
//                case "-":
//                    deleg = (x, y) =>
//                    {
//                        return x - y;
//                    };
//                    break;
//                case "*":
//                    deleg = (x, y) =>
//                    {
//                        return x * y;
//                    };
//                    break;
//                case "/":
//                    deleg = (x, y) =>
//                    {
//                        return x / y;
//                    };
//                    break;
//            }
//            Console.WriteLine(deleg(a,b));
//        }
//    }
//}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using System.Threading.Tasks;

namespace ConsoleApp20
{
    delegate double Deleg(int a, int b);
    class Program
    {
        static void Main(string[] args)
        {
            List list = new List(0);
            list.Add(1);
            list.Add(2);
            list.Add(3);
            list.Add(4);
            list.RemoveAt(4);
            list[1] = 5;
            Console.WriteLine(list[1]);
            list.Print();

            Console.WriteLine("Count " + list.Count);
        }
    }
    class Node
    {
        public int Value { get; set; }
        public Node next = null;
    }
    class List : IEnumerator , IEnumerable
    {
        Node head = null;
        public int Count { get; set; }
        int pos = 0;

        public object Current
        {
            get
                {
                int tmp = 0;
                Node current = head;
                if (pos == 0)
                    return head.Value;
                else
                {
                    while (tmp == pos)
                        current = current.next;
                    return current.Value;
                }
                throw new Exception("Error !");
            }
        }

        public bool MoveNext()
        {
            throw new NotImplementedException();
        }

        public void Reset()
        {
            pos = 0;
        }

        public IEnumerator GetEnumerator()
        {
              
            throw new NotImplementedException();
        }

        public List(int value)
        {
            head = new Node();
            head.Value = value;
            Count++;
        }

        public List()
        {
        }

        public void Add(int value)
        {
            Node current = head;
            if (current == null)
            {
                current = new Node();
                current.Value = value;
                return;
            }
            while (current.next != null)
            {
                current = current.next;
            }
            current.next = new Node();
            current.next.Value = value;
            Count++;
        }

        public void Remove(int value)
        {
            Node current = head;
            if (current.Value == value)
            {
                if (current.next != null)
                    head = current.next;
                else
                    head = null;
                Count--;
                return;
            }
            while (current.next != null)
            {
                if (current.next.Value == value)
                {
                    if (current.next.next != null)
                        current.next = current.next.next;
                    else
                        current.next = null;
                    Count--;
                    return;
                }
                current = current.next;
            }
        }

        public void RemoveAt(int index)
        {
            Node current = head;

            if (index > Count)
                throw new Exception("Error !");
            int tmp = 0;
            if (index == 0)
            {
                if (head.next != null)
                    head = head.next;
                else head = null;
                Count--;
                return;
            }
            while (tmp != index - 1)
            {
                current = current.next;
                tmp++;
            }
            if (current.next.next != null)
            {
                current.next = current.next.next;
            }
            else
                current.next = null;
            Count--;
        }

        public void Print()
        {
            Node current = head;
            while (current != null)
            {
                Console.WriteLine(current.Value);
                current = current.next;
            }
        }

        public int this[int index]
        {
            get
            {
                int tmp = 0;
                Node current = head;
                while(tmp!=index)
                {
                    tmp++;
                    current = current.next;
                }
                return current.Value;

            }
            set
            {
                int tmp = 0;
                Node current = head;
                while (tmp != index)
                {
                    tmp++;
                    current = current.next;
                }
                current.Value = value;
            }
        }
    }
}