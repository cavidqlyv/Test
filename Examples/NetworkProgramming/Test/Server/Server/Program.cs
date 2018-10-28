using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace Server
{
    class Program
    {
        const int PORT_NO = 5000;
        const string SERVER_IP = "127.0.0.1";
        static void Main(string[] args)
        {

            Console.WriteLine(GetLocalIPAddress());
            ////---listen at the specified IP and port no.---
            //IPAddress localAdd = IPAddress.Parse(SERVER_IP);
            //TcpListener listener = new TcpListener(localAdd, PORT_NO);
            //while (true)
            //{

            //    listener.Start();

            //    //---incoming client connected---
            //    TcpClient client = listener.AcceptTcpClient();

            //    //---get the incoming data through a network stream---
            //    NetworkStream nwStream = client.GetStream();
            //    byte[] buffer = new byte[client.ReceiveBufferSize];

            //    //---read incoming stream---
            //    int bytesRead = nwStream.Read(buffer, 0, client.ReceiveBufferSize);

            //    //---convert the data received into a string---
            //    string dataReceived = Encoding.ASCII.GetString(buffer, 0, bytesRead);
            //    Console.WriteLine("Received : " + dataReceived);

            //    //---write back the text to the client---
            //    string textToSend = Console.ReadLine();
            //    byte[] bytesToSend = ASCIIEncoding.ASCII.GetBytes(textToSend);
            //    nwStream.Write(bytesToSend, 0, bytesToSend.Length);
            //    client.Close();
            //    listener.Stop();
            //}
        }
        public static string GetLocalIPAddress()
        {
            var host = Dns.GetHostEntry(Dns.GetHostName());
            foreach (var ip in host.AddressList)
            {
                if (ip.AddressFamily == AddressFamily.InterNetwork)
                {
                    return ip.ToString();
                }
            }
            throw new Exception("No network adapters with an IPv4 address in the system!");
        }
    }
}
