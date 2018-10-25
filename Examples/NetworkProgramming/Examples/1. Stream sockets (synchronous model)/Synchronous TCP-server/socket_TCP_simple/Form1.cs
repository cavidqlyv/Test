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

        // обслуживание очередного запроса будем выполнять в отдельном потоке
        public void ThreadForReceive(object param)
        {
            try
            {
                Socket handler = (Socket)param;
                string client = null;
                string data = null;
                byte[] bytes = new byte[1024];
                // Получим от клиента DNS-имя хоста.
                // Метод Receive получает данные от сокета и заполняет массив байтов, переданный в качестве аргумента
                int bytesRec = handler.Receive(bytes); // Возвращает фактически считанное число байтов
                client = Encoding.Default.GetString(bytes, 0, bytesRec); // конвертируем массив байтов в строку
                client += "(" + handler.RemoteEndPoint.ToString() + ")";
                while (true)
                {
                    bytesRec = handler.Receive(bytes); // принимаем данные, переданные клиентом. Если данных нет, поток блокируется
                    data = Encoding.Default.GetString(bytes, 0, bytesRec); // конвертируем массив байтов в строку                  
                    // uiContext.Send отправляет синхронное сообщение в контекст синхронизации
                    // SendOrPostCallback - делегат указывает метод, вызываемый при отправке сообщения в контекст синхронизации. 
                    uiContext.Send(d => listBox1.Items.Add(client) /* Вызываемый делегат SendOrPostCallback */, 
                        null /* Объект, переданный делегату */); // добавляем в список имя клиента

                    uiContext.Send(d => listBox1.Items.Add(data), null); // добавляем в список сообщение от клиента
                    if (data.IndexOf("<end>") > -1) // если клиент отправил эту команду, то заканчиваем обработку сообщений
                        break;
                }
                string theReply = "Я завершаю обработку сообщений";
                byte[] msg = Encoding.Default.GetBytes(theReply); // конвертируем строку в массив байтов
                handler.Send(msg); // отправляем клиенту сообщение
                handler.Shutdown(SocketShutdown.Both); // Блокируем передачу и получение данных для объекта Socket.
                handler.Close(); // закрываем сокет
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

                // Чтобы сокет клиента мог идентифицировать потоковый сокет TCP, сервер должен дать своему сокету имя
                sListener.Bind(ipEndPoint); // Свяжем объект Socket с локальной конечной точкой.

                // Установим объект Socket в состояние прослушивания.
                sListener.Listen(10 /* Максимальная длина очереди ожидающих подключений.*/ ); 
                while (true)
                {
                    /* Блокируется поток до поступления от клиента запроса на соединение. При этом устанавливается связь имен клиента и сервера. 
                       Метод Accept извлекает из очереди ожидающих запросов первый запрос на соединение и создает для его обработки новый сокет.
                       Хотя новый сокет создан, первоначальный сокет продолжает слушать и может использоваться с многопоточной обработкой для 
                       приема нескольких запросов на соединение от клиентов. Сервер не должен закрывать слушающий сокет, который продолжает работать
                       наряду с сокетами, созданными методом Accept для обработки входящих запросов клиентов.
                     */
                    Socket handler = sListener.Accept();
                    // обслуживание текущего запроса будем выполнять в отдельном потоке
                    Thread thread = new Thread(new ParameterizedThreadStart(ThreadForReceive)); 
                    thread.IsBackground = true;
                    thread.Start(handler);
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
