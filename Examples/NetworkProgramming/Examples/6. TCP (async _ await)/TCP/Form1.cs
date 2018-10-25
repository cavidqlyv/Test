using System;
using System.IO;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;


namespace TCP
{
    public partial class Form1 : Form
    {
        [Serializable]
        struct Message
        {
            public string mes; // текст сообщения
            public string host; // имя хоста
            public string user; // имя пользователя
        }
        public SynchronizationContext uiContext;

        public Form1()
        {
            InitializeComponent();
            // Получим контекст синхронизации для текущего потока 
            uiContext = SynchronizationContext.Current;
            WaitClientQuery();
        }
        // ********************************* серверная часть ************************************************
        private async void WaitClientQuery()
        {
            await Task.Run(() =>
            {
                try
                {
                    // TcpListener ожидает подключения от TCP-клиентов сети.
                    TcpListener listener = new TcpListener(
                    IPAddress.Any /* Предоставляет IP-адрес, указывающий, что сервер должен контролировать действия клиентов на всех сетевых интерфейсах.*/,
                    49152 /* порт */);
                    listener.Start(); // Запускаем ожидание входящих запросов на подключение
                    while (true)
                    {
                        // Принимаем ожидающий запрос на подключение 
                        // Метод AcceptTcpClient — это блокирующий метод, возвращающий объект TcpClient, 
                        // который может использоваться для приема и передачи данных.
                        TcpClient client = listener.AcceptTcpClient();
                        ReadMessage(client);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Сервер: " + ex.Message);
                }
            });
            
        }

        private async void ReadMessage(TcpClient client)
        {
            await Task.Run(() =>
            {
                try
                {
                    // Получим объект NetworkStream, используемый для приема и передачи данных.
                    NetworkStream netstream = client.GetStream();
                    byte[] arr = new byte[client.ReceiveBufferSize /* размер приемного буфера */];
                    // Читаем данные из объекта NetworkStream.
                    int len = netstream.Read(arr, 0, client.ReceiveBufferSize);
                    if (len > 0)
                    {
                        // Создадим поток, резервным хранилищем которого является память.
                        MemoryStream stream = new MemoryStream(arr);
                        // BinaryFormatter сериализует и десериализует объект в двоичном формате 
                        BinaryFormatter formatter = new BinaryFormatter();
                        Message m = (Message)formatter.Deserialize(stream); // выполняем десериализацию
                        // полученную от клиента информацию добавляем в список

                        // uiContext.Send отправляет синхронное сообщение в контекст синхронизации
                        // SendOrPostCallback - делегат указывает метод, вызываемый при отправке сообщения в контекст синхронизации. 
                        uiContext.Send(d => listBox1.Items.Add(m.host) /* Вызываемый делегат SendOrPostCallback */,
                            null /* Объект, переданный делегату */); // добавляем в список имя клиента
                        uiContext.Send(d => listBox1.Items.Add(m.user), null);
                        uiContext.Send(d => listBox1.Items.Add(m.mes), null);
                        stream.Close();
                    }
                    netstream.Close();
                    client.Close(); // закрываем TCP-подключение и освобождаем все ресурсы, связанные с объектом TcpClient.
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Сервер: " + ex.Message);
                }
            });
            
        }

        // *****************************************клиентская часть*************************************************************
        private void button1_Click(object sender, EventArgs e)
        {
            ConnectAndSend();
        }

        private async void ConnectAndSend()
        {
            await Task.Run(() =>
            {
                try
                {
                    // Конструктор TcpClient инициализирует новый экземпляр класса и подключает его к указанному порту заданного узла.
                    TcpClient client = new TcpClient(textBox1.Text /* имя хоста */, 49152 /* порт */);
                    // Получим объект NetworkStream, используемый для приема и передачи данных.
                    NetworkStream netstream = client.GetStream();
                    // Создадим поток, резервным хранилищем которого является память.
                    MemoryStream stream = new MemoryStream();
                    // BinaryFormatter сериализует и десериализует объект в двоичном формате 
                    BinaryFormatter formatter = new BinaryFormatter();
                    Message m = new Message();
                    m.mes = textBox2.Text; // текст сообщения
                    m.host = Dns.GetHostName(); // имя хоста
                    m.user = Environment.UserDomainName + @"\" + Environment.UserName; // имя пользователя
                    formatter.Serialize(stream, m); // выполняем сериализацию
                    byte[] arr = stream.ToArray(); // записываем содержимое потока в байтовый массив
                    stream.Close();
                    netstream.Write(arr, 0, arr.Length); // записываем данные в NetworkStream.
                    netstream.Close();
                    client.Close(); // закрываем TCP-подключение и освобождаем все ресурсы, связанные с объектом TcpClient.

                }
                catch (Exception ex)
                {
                    MessageBox.Show("Клиент: " + ex.Message);
                }
            });        
        }
    }
}
