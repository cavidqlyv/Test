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
            public string user; // имя пользователя
            public string host; // DNS-имя компьютера
        }
        public SynchronizationContext uiContext;

        public Form1()
        {
            InitializeComponent();
            // Получим контекст синхронизации для текущего потока 
            uiContext = SynchronizationContext.Current;
            WaitClientQuery();
        }

        // прием сообщения
        private async void WaitClientQuery()
        {
            await Task.Run(() =>
            {
                try
                {
                    Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
                    /* Значение InterNetwork указывает на то, что при подключении объекта Socket к конечной точке предполагается использование IPv4-адреса.
                       Поддерживает датаграммы — ненадежные сообщения с фиксированной (обычно малой) максимальной длиной, передаваемые без установления подключения. 
                     * Возможны потеря и дублирование сообщений, а также их получение не в том порядке, в котором они отправлены. 
                     * Объект Socket типа Dgram не требует установки подключения до приема и передачи данных и может обеспечивать связь со множеством одноранговых узлов.
                     * Dgram использует протокол Datagram (Udp) и InterNetwork.
                     */
                    IPEndPoint ipEndPoint = new IPEndPoint(
                        IPAddress.Any /* Предоставляет IP-адрес, указывающий, что сервер должен контролировать действия клиентов на всех сетевых интерфейсах.*/,
                        49152  /* порт */);
                    socket.Bind(ipEndPoint); // Свяжем объект Socket с локальной конечной точкой.

                    IPAddress ip = IPAddress.Parse("239.255.255.255"); // 224.0.0.0 - 239.255.255.255 диапазон multicast-адресов
                    // Регистрируем multicast-адрес
                    socket.SetSocketOption(SocketOptionLevel.IP  /* Параметры Socket применяются только для IP-сокетов. */,
                        SocketOptionName.AddMembership /* Добавить членство в IP-группе. */,
                        new MulticastOption(ip, IPAddress.Any) /* Содержит значения IPAddress, используемые для подключения и отключения групп многоадресной рассылки. */);
                    while (true)
                    {
                        byte[] buff = new byte[1024];
                        socket.Receive(buff);
                        MemoryStream stream = new MemoryStream(buff);
                        // BinaryFormatter сериализует и десериализует объект в двоичном формате 
                        BinaryFormatter formatter = new BinaryFormatter();
                        Message m = (Message)formatter.Deserialize(stream); // выполняем десериализацию
                        // полученную от удаленного узла информацию добавляем в список
                        uiContext.Send(d => listBox1.Items.Add(m.host), null);
                        uiContext.Send(d => listBox1.Items.Add(m.user), null);
                        uiContext.Send(d => listBox1.Items.Add(m.mes), null);
                        stream.Close(); // закрываем поток
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Получатель: " + ex.Message);
                }
            });         
        }

        // отправление сообщения
        private async void button1_Click(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                try
                {
                    Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
                    /* Значение InterNetwork указывает на то, что при подключении объекта Socket к конечной точке предполагается использование IPv4-адреса.
                       Поддерживает датаграммы — ненадежные сообщения с фиксированной (обычно малой) максимальной длиной, передаваемые без установления подключения. 
                     * Возможны потеря и дублирование сообщений, а также их получение не в том порядке, в котором они отправлены. 
                     * Объект Socket типа Dgram не требует установки подключения до приема и передачи данных и может обеспечивать связь со множеством одноранговых узлов.
                     * Dgram использует протокол Datagram (Udp) и InterNetwork.
                     */
                    // SetSocketOption устанавливает заданное целое значение для указанного параметра Socket.
                    socket.SetSocketOption(SocketOptionLevel.IP /* Параметры Socket применяются только для IP-сокетов. */, 
                        SocketOptionName.MulticastTimeToLive /* Срок жизни многоадресной IP-рассылки. */,
                        2); // значение 1 - дейтаграмма не выйдет из локальной сети, значение, большее 1 - дейтаграмма пройдёт через несколько роутеров

                    IPAddress dest = IPAddress.Parse("239.255.255.255"); // 224.0.0.0 - 239.255.255.255 диапазон multicast-адресов
                    // Регистрируем multicast-адрес
                    socket.SetSocketOption(SocketOptionLevel.IP /* Параметры Socket применяются только для IP-сокетов. */,  
                        SocketOptionName.AddMembership /* Добавить членство в IP-группе. */, 
                        new MulticastOption(dest) /* Содержит значения IPAddress, используемые для подключения и отключения групп многоадресной рассылки. */);
                    // Создаем на основе multicast-адреса оконечную точку
                    IPEndPoint ipEndPoint = new IPEndPoint(dest /* IP-адрес */, 49152 /* порт */);

                    // Создаем подключение к удаленному узлу, соединяя сокет с оконечной точкой
                    socket.Connect(ipEndPoint);

                    // Создадим поток, резервным хранилищем которого является память.
                    MemoryStream stream = new MemoryStream();
                    // BinaryFormatter сериализует и десериализует объект в двоичном формате 
                    BinaryFormatter formatter = new BinaryFormatter();
                    Message m = new Message();
                    m.mes = textBox2.Text; // текст сообщения
                    m.user = Environment.UserDomainName + @"\" + Environment.UserName; // имя пользователя
                    m.host = Dns.GetHostName(); // получаем DNS-имя локального компьютера
                    formatter.Serialize(stream, m); // выполняем сериализацию
                    byte[] arr = stream.ToArray(); // записываем содержимое потока в байтовый массив
                    stream.Close(); // закрываем поток
                    socket.Send(arr); //Передаем данные в подключенный объект Socket.
                    socket.Close(); // закрываем сокет
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Отправитель: " + ex.Message);
                }
            });        
        }
    }
}
