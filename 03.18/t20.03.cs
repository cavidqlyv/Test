using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            string[] question = new string[10];
            string[,] answer = new string[10, 3];
            string[] correctAnswer = new string[10];
            int points = 0;

            question[0] = "aaabbbccc";
            answer[0, 0] = "aaa";
            answer[0, 1] = "bbb";
            answer[0, 2] = "ccc";
            correctAnswer[0] = "aaa";

            question[1] = "dddeeefff";
            answer[1, 0] = "ddd";
            answer[1, 1] = "eee";
            answer[1, 2] = "fff";
            correctAnswer[1] = "eee";

            question[2] = "qqqwwweee";
            answer[2, 0] = "qqq";
            answer[2, 1] = "www";
            answer[2, 2] = "eee";
            correctAnswer[2] = "eee";

            question[3] = "rrrtttyyy";
            answer[3, 0] = "rrr";
            answer[3, 1] = "ttt";
            answer[3, 2] = "yyy";
            correctAnswer[3] = "rrr";

            question[4] = "uuuiiiooo";
            answer[4, 0] = "uuu";
            answer[4, 1] = "iii";
            answer[4, 2] = "ooo";
            correctAnswer[4] = "iii";

            question[5] = "pppaaasss";
            answer[5, 0] = "ppp";
            answer[5, 1] = "aaa";
            answer[5, 2] = "sss";
            correctAnswer[5] = "sss";

            question[6] = "dddfffggg";
            answer[6, 0] = "ddd";
            answer[6, 1] = "fff";
            answer[6, 2] = "ggg";
            correctAnswer[6] = "ddd";

            question[7] = "hhhjjjkkk";
            answer[7, 0] = "hhh";
            answer[7, 1] = "jjj";
            answer[7, 2] = "kkk";
            correctAnswer[7] = "jjj";

            question[8] = "lllzzzxxx";
            answer[8, 0] = "lll";
            answer[8, 1] = "zzz";
            answer[8, 2] = "xxx";
            correctAnswer[8] = "xxx";

            question[9] = "cccvvvbbb";
            answer[9, 0] = "ccc";
            answer[9, 1] = "vvv";
            answer[9, 2] = "bbb";
            correctAnswer[9] = "ccc";

            Random rand = new Random(10);
            string[] tmp = new string[3];
            int tmpNum;
            int key;
            for (int i = 0; i < 10; i++)
            {
                for (int j = 0; j < 3; j++)
                {
                    tmpNum = rand.Next(0, 3);
                    if (answer[i, tmpNum] == tmp[0] || answer[i, tmpNum] == tmp[1] || answer[i, tmpNum] == tmp[2])
                        j--;
                    else
                        tmp[j] = answer[i, tmpNum];
                }
                Console.WriteLine(question[i]);
                Console.WriteLine(tmp[0]);
                Console.WriteLine(tmp[1]);
                Console.WriteLine(tmp[2]);
                key = Convert.ToInt32(Console.ReadLine());
                key--;
                if (key > 2 || key < 0)
                {
                    i--;
                    continue;
                }
                if (tmp[key] == correctAnswer[i])
                {
                    Console.ForegroundColor = ConsoleColor.Green;
                    Console.WriteLine("Correct");
                    Console.ForegroundColor = ConsoleColor.Gray;
                    points += 10;
                }
                else
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("Wrong");
                    Console.ForegroundColor = ConsoleColor.Gray;
                    points -= 10;
                    if (points < 0)
                        points = 0;
                }
            }
            Console.WriteLine(points);
        }
    }
}
