//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;

//namespace ConsoleApp11
//{
//    class Program
//    {
//        static void Main(string[] args)
//        {
//            A a = new A();
//            a[0] = 10;
//            Console.WriteLine(a[0]);
//        }
//        class Dic
//        {
//            string[] key = new string[3];
//            string[] val = new string[3];
//            public Dic()
//            {
//                key[0] = "Kitab";
//                key[1] = "Alma";
//                key[2] = "Qelem";
//                val[0] = "Book";
//                val[1] = "Apple";
//                val[2] = "Pen";
//            }
//            public string this[string str]
//            {
//                get
//                {
//                    for (int i = 0; i < key.Length; i++)
//                    {
//                        if (str == key[i])
//                            return val[i];
//                        if (str == val[i])
//                            return key[i];
//                    }
//                    throw new Exception("Not Found");
//                }
//            }
//            public string this[int i]
//            {
//                get
//                {
//                    return key[i];
//                }
//            }
//        }
//        class A
//        {
//            int[] arr = new int[3];
//            public int this[int i]
//            {
//                set
//                {
//                    arr[i] = value;
//                }
//                get
//                {
//                    return arr[i];
//                }
//            }
//        }
//    }
//}


using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp11
{
    class Program
    {
        static void Main(string[] args)
        {
            Store store = new Store();
            store.AddArticle(new Article("bbbb", "aaaa", 6000));
            store.AddArticle(new Article("cccc", "aaaa", 5000));
            store.AddArticle(new Article("dddd", "ffff", 7000));

            foreach (var item in store["aaaa"])
            {
                Console.WriteLine(item);
            }
            Console.WriteLine("============================");
            Console.WriteLine(store[0]);
            Console.WriteLine("============================");
            foreach (var item in store.GetAll())
            {
                Console.WriteLine(item);
            }
            Console.WriteLine("============================");
            foreach (var item in store.Sort())
            {
                Console.WriteLine(item.Price);
            }
        }
    }
    class Store
    {
        Article[] article = new Article[3];
        int index = 0;
        public void AddArticle(Article sArticle)
        {
            article[index++] = sArticle;
        }
        public List<string> this[string str]
        {
            get
            {
                List<string> list = new List<string>();
                for (int i = 0; i < article.Length; i++)
                {
                    if (article[i].ProductName == str)
                        list.Add($"{article[i].ProductName} {article[i].StoreName} {article[i].Price}");
                    if (article[i].StoreName == str)
                        list.Add($"{article[i].ProductName} {article[i].StoreName} {article[i].Price}");
                }
                return list;
            }
        }
        public string this[int i]
        {
            get
            {
                return $"{article[i].ProductName} {article[i].StoreName} {article[i].Price}";
            }
        }
        public List<string> GetAll()
        {
            List<string> list = new List<string>();
            for (int i = 0; i < article.Length; i++)
                list.Add($"{article[i].ProductName} {article[i].StoreName} {article[i].Price}");
            return list;
        }
        public Article[] Sort()
        {
            var a = article.OrderBy(x => x.Price).ToArray();
            return a;

            Article[] tmpArticle = new Article[3];
            for (int i = 0; i < tmpArticle.Length; i++)
            {
                tmpArticle[i] = article[i];
            }

            Article tmp;
            string[] tmpStr = new string[3];
            for (int i = 0; i < tmpArticle.Length; i++)
            {
                for (int j = 0; j < tmpArticle.Length - 1; j++)
                {
                    if (tmpArticle[j].Price > tmpArticle[j + 1].Price)
                    {
                       
                        tmp = tmpArticle[j + 1];
                        tmpArticle[j + 1] = tmpArticle[j];
                        tmpArticle[j] = tmp;
                    }
                }
            }
            for (int i = 0; i < tmpArticle.Length; i++)
                tmpStr[i] = $"{tmpArticle[i].ProductName} {tmpArticle[i].StoreName} {tmpArticle[i].Price}";
            //return tmpStr;
        }
    }
    class Article
    {
        public string ProductName { get; }
        public string StoreName { get; }
        public int Price { get; }
        public Article(string aProductName, string aStoreName, int aPrice)
        {
            ProductName = aProductName;
            StoreName = aStoreName;
            Price = aPrice;
        }
    }
}
