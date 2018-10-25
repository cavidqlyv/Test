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

namespace socket_TCP_simple
{
    public partial class Form1 : Form
    {
        public SynchronizationContext uiContext;

        // буфер для получения и отправки данных
        byte[] buffer = new byte[1024];

        // Объекты события с ручным сбросом необходимы для синхронизации потоков в асинхронной модели клиент-серверного приложения
        ManualResetEvent AcceptDone = new ManualResetEvent(false);

        public Form1()
        {
            InitializeComponent();
            // Получим контекст синхронизации для текущего потока 
            uiContext = SynchronizationContext.Current;
        }

        /*
                                                
        SOCKET – это некоторое логическое гнездо, которое позволяет двум приложениям обмениватся информацией 
        по сети не задумываяся о месте расположения. SOCKET – это комбинация IP-address и номера порта.
        
        Internet Protocol (IP) - широко используемый протокол как в локальных, так и в глобальных сетях.
        Этот протокол не требует установления соединения и не гарантирует доставку данных. Поэтому для
        передачи данных поверх IP используются два протокола более высокого уровня: TCP, UDP.
        
        Transmission Control Protocol (TCP) реализует связь с установлением соединения, обеспечивая 
        безошибочную передачу данных между компьютерами. 
        
        Связь без установления соединения выполняется при помощи User Datagram Protocol (UDP). Не гарантируя
        надёжности, UDP может осуществлять передачу данных множеству адресатов и принимать данные от множества
        источников. Например, данные, отправляемые клиентом на сервер, передаются немедленно, независимо от того,
        готов ли сервер к приёму. При получении данных от клиента, сервер не подтверждает их приём. Данные 
        передаются в виде дейтаграмм. И TCP, и UDP передают данные по IP, поэтому обычно говорят об использовании 
        TCP/IP или UDP/IP.
        */

        // метод обратного вызова реализует программную логику завершения асинхронной отправки данных
        public void SendCallback(IAsyncResult ar /* информация о состоянии асинхронной операции */)
        {
            try
            {
                Socket handler = (Socket)ar.AsyncState; // извлекаем аргумент, который был передан в последнем параметре метода BeginSend
                int bytesSent = handler.EndSend(ar); // завершаем асинхронный запрос на отправку данных
                handler.Shutdown(SocketShutdown.Both); // Блокируем передачу и получение данных для объекта Socket.
                handler.Close(); // закрываем сокет
            }
            catch (Exception ex)
            {
                MessageBox.Show("Сервер: " + ex.Message);
            }
        }

        // метод обратного вызова реализует программную логику завершения асинхронного приема данных
        public void ReceiveCallback(IAsyncResult ar /* информация о состоянии асинхронной операции */)
        {
            try
            {
                string content = String.Empty;
                Socket handler = (Socket)ar.AsyncState; // извлекаем аргумент, который был передан в последнем параметре метода BeginReceive
                int bytesRead = handler.EndReceive(ar); // завершаем асинхронную операцию приема данных
                if (bytesRead > 0)
                {
                    content = Encoding.Default.GetString(buffer, 0, bytesRead); // конвертируем массив байтов в строку 

                    // uiContext.Send отправляет синхронное сообщение в контекст синхронизации
                    // SendOrPostCallback - делегат указывает метод, вызываемый при отправке сообщения в контекст синхронизации. 
                    uiContext.Send(d => listBox1.Items.Add(content) /* Вызываемый делегат SendOrPostCallback */,
                        null /* Объект, переданный делегату */); // добавляем в список сообщение от клиента
                    if (content.IndexOf("<end>") > -1) // если клиент отправил эту команду, то заканчиваем обработку сообщений
                    {
                        string theReply = "Я завершаю обработку сообщений";
                        byte[] msg = Encoding.Default.GetBytes(theReply); // конвертируем строку в массив байтов
                        handler.BeginSend(msg, 0, msg.Length, 0, new AsyncCallback(SendCallback), handler); // начинаем асинхронную отправку данных клиенту
                    }
                    else
                    {
                        // иначе получаем оставшиеся данные
                        handler.BeginReceive(buffer, 0, buffer.Length, 0, new AsyncCallback(ReceiveCallback), handler);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Сервер: " + ex.Message);
            }
        }

        // метод обратного вызова реализует программную логику завершения асинхронной операции принятия соединения
        public void AcceptCallback(IAsyncResult ar /* информация о состоянии асинхронной операции */)
        {
            try
            {
                Socket listener = (Socket)ar.AsyncState; // извлекаем аргумент, который был передан в последнем параметре метода BeginAccept
                Socket handler = listener.EndAccept(ar); // завершаем асинхронную операцию принятия соединения
                AcceptDone.Set(); // сообщим потоку ThreadForAccept, что соединение установлено
                // начинаем асинхронный прием данных
                handler.BeginReceive(buffer, 0, buffer.Length, 0, new AsyncCallback(ReceiveCallback), handler);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Сервер: " + ex.Message);
            }
        }

        //  ожидать запросы на соединение будем в отдельном потоке
       public void ThreadForAccept()
        {
            try
            {
                // установим для сокета адрес локальной конечной точки
                // уникальный адрес для обслуживания TCP/IP определяется комбинацией IP-адреса хоста с номером порта обслуживания
                IPEndPoint ipEndPoint = new IPEndPoint(
                    IPAddress.Any /* Предоставляет IP-адрес, указывающий, что сервер должен контролировать действия клиентов на всех сетевых интерфейсах.*/,
                    49152 /* порт */);

                // создаем потоковый сокет
                Socket sListener = new Socket(AddressFamily.InterNetwork /*схема адресации*/, SocketType.Stream /*тип сокета*/, ProtocolType.Tcp /*протокол*/ );
                /* Значение InterNetwork указывает на то, что при подключении объекта Socket к конечной точке предполагается использование IPv4-адреса.
                   SocketType.Stream поддерживает надежные двусторонние байтовые потоки в режиме с установлением подключения, без дублирования данных и 
                   без сохранения границ данных. Объект Socket этого типа взаимодействует с одним узлом и требует предварительного установления подключения 
                   к удаленному узлу перед началом обмена данными. Тип Stream использует протокол Tcp и схему адресации AddressFamily.
                 */

                // Чтобы сокет клиента мог идентифицировать потоковый сокет TCP, сервер дать своему сокету имя
                sListener.Bind(ipEndPoint); // Свяжем объект Socket с локальной конечной точкой.

                // Установим объект Socket в состояние прослушивания.
                sListener.Listen(10 /* Максимальная длина очереди ожидающих подключений.*/ );
                AsyncCallback aCallback = new AsyncCallback(AcceptCallback);
                while (true)
                {
                    // асинхронная функция, дающая согласие на соединения с клиентами
                    sListener.BeginAccept(aCallback, sListener);
                    AcceptDone.WaitOne(); //поток блокируется до тех пор, пока не будет получен сигнал об установлении соединения
                    AcceptDone.Reset(); // переведем событие в несигнальное состояние
                }            
            }
            catch (Exception ex)
            {
                MessageBox.Show("Сервер: " + ex.Message);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Thread thread = new Thread(new ThreadStart(ThreadForAccept));
            thread.IsBackground = true;
            thread.Start();
        }
    }
}
