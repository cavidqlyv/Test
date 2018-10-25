using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp8 {
    class Program {
        static void Main(string[] args) {
            TcpListener listener = null;

            try {
                var ip = IPAddress.Parse("127.0.0.1");
                listener = new TcpListener(ip, 41111);
                listener.Start();
                Console.WriteLine("Server listener start...");
                while (true) {
                    var client = listener.AcceptTcpClient();
                    Console.WriteLine($"{client.Client.RemoteEndPoint} connected");
                    Task.Run(() => {
                        var stream = client.GetStream();
                        var bw = new BinaryWriter(stream);
                        var br = new BinaryReader(stream);
                        while (true) {
                            try {
                                var name = br.ReadString();
                                var length = br.ReadInt64();
                                var bytes = br.ReadBytes((int)length);


                                File.WriteAllBytes($"Files/{name}", bytes);                                
                            } catch (EndOfStreamException ex) {
                                var cl = client.Client.RemoteEndPoint;
                                Console.WriteLine($"{cl} disconnected");
                                break;
                            }
                        }
                    });
                }
            } catch { }
        }
    }
}
