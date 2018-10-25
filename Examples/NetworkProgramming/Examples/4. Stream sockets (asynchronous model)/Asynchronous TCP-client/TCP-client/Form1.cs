using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Net;
using System.Net.Sockets;
using System.Threading;

namespace TCP_client
{
    public partial class Form1 : Form
    {
        Socket sock;
        // Объект события с ручным сбросом необходим для синхронизации потоков в асинхронной модели клиент-серверного приложения
        ManualResetEvent SendDone = new ManualResetEvent(false);
        string theResponse = null;
        // буфер для получения и отправки данных
        byte[] buffer = new byte[1024];
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
             // соединяемся с удаленным устройством
            try
            {
                // устанавливаем удаленную конечную точку для сокета
                // уникальный адрес для обслуживания TCP/IP определяется комбинацией IP-адреса хоста с номером порта обслуживания
                IPEndPoint ipEndPoint = new IPEndPoint(
                    IPAddress.Parse(ip_address.Text) /* IP-адрес удаленного компьютера (сервера), с которым будет установлено соединение */, 
                    49152 /* порт */);

                // создаем потоковый сокет
                sock = new Socket(AddressFamily.InterNetwork /*схема адресации*/, SocketType.Stream /*тип сокета*/, ProtocolType.Tcp /*протокол*/);
                /* Значение InterNetwork указывает на то, что при подключении объекта Socket к конечной точке предполагается использование IPv4-адреса.
                  SocketType.Stream поддерживает надежные двусторонние байтовые потоки в режиме с установлением подключения, без дублирования данных и 
                  без сохранения границ данных. Объект Socket этого типа взаимодействует с одним узлом и требует предварительного установления подключения 
                  к удаленному узлу перед началом обмена данными. Тип Stream использует протокол Tcp и схему адресации AddressFamily.
                */

                // AsyncCallback - класс-делегат для асинхронных операций
                // соединяем сокет с удаленной конечной точкой
                sock.BeginConnect(ipEndPoint/* удаленный хост */, new AsyncCallback(ConnectCallback /* метод обратного вызова */),
                    sock /* параметр, передаваемый в метод обратного вызова */);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Сервер: " + ex.Message);
            }
        }

        // метод обратного вызова реализует программную логику завершения асинхронной установки соединения
         public void ConnectCallback(IAsyncResult ar /* информация о состоянии асинхронной операции */)
         {
             try
             {
                 Socket sclient = (Socket)ar.AsyncState; // извлекаем аргумент, который был передан в последнем параметре метода BeginConnect
                 sclient.EndConnect(ar); // завершаем асинхронный запрос на соединение и возвращаем соединенный сокет
                 MessageBox.Show("Клиент " + Dns.GetHostName() + " установил соединение с " + sclient.RemoteEndPoint.ToString());
             }
             catch (Exception ex)
             {
                 MessageBox.Show("Клиент: " + ex.Message);
             }
         }

         // метод обратного вызова реализует программную логику завершения асинхронной отправки данных
         public void SendCallback(IAsyncResult ar /* информация о состоянии асинхронной операции */)
         {
             try
             {
                 Socket sclient = (Socket)ar.AsyncState; // извлекаем аргумент, который был передан в последнем параметре метода BeginSend
                 int bytesSent = sclient.EndSend(ar); // завершаем асинхронный запрос на отправку данных
                 // MessageBox.Show("Серверу отправлено " + bytesSent.ToString() + " байт");
                 SendDone.Set(); // сообщим основному потоку, что завершили отправку данных
             }
             catch (Exception ex)
             {
                 MessageBox.Show(ex.Message);
             }
         }

         // метод обратного вызова реализует программную логику завершения асинхронного приема данных
         public void ReceiveCallback(IAsyncResult ar /* информация о состоянии асинхронной операции */)
         {
             Socket sclient = null;
             try
             {
                 sclient = (Socket)ar.AsyncState; // извлекаем аргумент, который был передан в последнем параметре метода BeginReceive
                 int bytesRead = sclient.EndReceive(ar); // завершаем асинхронную операцию приема данных
                 if (bytesRead > 0)
                 {
                     theResponse += Encoding.Default.GetString(buffer, 0, bytesRead); // конвертируем массив байтов в строку
                     sclient.BeginReceive(buffer, 0, buffer.Length, 0, new AsyncCallback(ReceiveCallback), sclient); // начинаем асинхронный прием данных
                 }
                 else
                 {
                     MessageBox.Show("Сервер ответил: " + theResponse);
                     theResponse = null;
                     sclient.Shutdown(SocketShutdown.Both); // Блокируем передачу и получение данных для объекта Socket.
                     sclient.Close(); // закрываем сокет
                 }
             }
             catch (Exception ex)
             {
                 MessageBox.Show("Клиент: " + ex.Message);
             }
         }

        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                byte[] msg = Encoding.Default.GetBytes(Dns.GetHostName()); // конвертируем строку, содержащую имя хоста, в массив байтов
                sock.BeginSend(msg, 0, msg.Length, 0, new AsyncCallback(SendCallback), sock); // начинаем асинхронную отправку данных
                SendDone.WaitOne(); // основной поток блокируется до тех пор, пока не будет получен сигнал об окончании отправки данных
                SendDone.Reset(); // переведем событие в несигнальное состояние
                string theMessage = textBox1.Text; // получим текст сообщения, введенный в текстовое поле
                msg = Encoding.Default.GetBytes(theMessage); // конвертируем строку, содержащую сообщение, в массив байтов
                Thread.Sleep(100);
                sock.BeginSend(msg, 0, msg.Length, 0, new AsyncCallback(SendCallback), sock); // начинаем асинхронную отправку данных
                SendDone.WaitOne(); // основной поток блокируется до тех пор, пока не будет получен сигнал об окончании отправки данных на сервер
                SendDone.Reset(); // переведем событие в несигнальное состояние
                if (theMessage.IndexOf("<end>") > -1) // если клиент отправил эту команду, то принимаем сообщение от сервера
                {
                    // начинаем асинхронный прием данных
                    sock.BeginReceive(buffer, 0, buffer.Length, 0, new AsyncCallback(ReceiveCallback), sock);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Клиент: " + ex.Message);
            }
        }
    }
}
