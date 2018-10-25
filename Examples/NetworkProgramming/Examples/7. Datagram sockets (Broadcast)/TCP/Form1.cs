﻿using System;
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
                     // установим для сокета адрес локальной конечной точки
                    IPEndPoint ipEndPoint = new IPEndPoint(IPAddress.Any /* Предоставляет IP-адрес, указывающий, что сервер должен контролировать действия клиентов на всех сетевых интерфейсах.*/, 
                        49152 /* порт */);

                    // создаем дейтаграммный сокет
                    Socket socket = new Socket(AddressFamily.InterNetwork /*схема адресации*/, SocketType.Dgram /*тип сокета*/, ProtocolType.Udp /*протокол*/ );
                    /* Значение InterNetwork указывает на то, что при подключении объекта Socket к конечной точке предполагается использование IPv4-адреса.
                       Поддерживает датаграммы — ненадежные сообщения с фиксированной (обычно малой) максимальной длиной, передаваемые без установления подключения. 
                     * Возможны потеря и дублирование сообщений, а также их получение не в том порядке, в котором они отправлены. 
                     * Объект Socket типа Dgram не требует установки подключения до приема и передачи данных и может обеспечивать связь со множеством одноранговых узлов.
                     * Dgram использует протокол Datagram (Udp) и InterNetwork.
                     */

                    socket.Bind(ipEndPoint); // Свяжем объект Socket с локальной конечной точкой.
                    socket.EnableBroadcast = true;
                    // Значение true, если объект Socket разрешает использование широковещательных пакетов; в противном случае — значение false. 
                    // Значение по умолчанию – false. 
                    while (true)
                    {
                        EndPoint remote = new IPEndPoint(0x7F000000, 100); // информация об удаленном хосте, который отправил датаграмму
                        byte[] arr = new Byte[1024];
                        socket.ReceiveFrom(arr, ref remote); // получим UDP-датаграмму
                        string clientIP = ((IPEndPoint)remote).Address.ToString(); // получим IP-адрес удаленного 

                        // Создадим поток, резервным хранилищем которого является память.
                        MemoryStream stream = new MemoryStream(arr);
                        // BinaryFormatter сериализует и десериализует объект в двоичном формате 
                        BinaryFormatter formatter = new BinaryFormatter();
                        Message m = (Message)formatter.Deserialize(stream); // выполняем десериализацию
                        // полученную от удаленного узла информацию добавляем в список
                        uiContext.Send(d => listBox1.Items.Add(clientIP), null);
                        uiContext.Send(d => listBox1.Items.Add(m.user), null);
                        uiContext.Send(d => listBox1.Items.Add(m.mes), null);
                        stream.Close();
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
                    IPEndPoint ipEndPoint = new IPEndPoint(
                        IPAddress.Parse(ip_address.Text) /* IP-адрес удаленного DNS-узла, к которому планируется подключение. */, 49152 /* порт */);

                    // создаем дейтаграммный сокет
                    Socket socket = new Socket(AddressFamily.InterNetwork /*схема адресации*/, SocketType.Dgram /*тип сокета*/, ProtocolType.Udp /*протокол*/ );
                    /* Значение InterNetwork указывает на то, что при подключении объекта Socket к конечной точке предполагается использование IPv4-адреса.
                       Поддерживает датаграммы — ненадежные сообщения с фиксированной (обычно малой) максимальной длиной, передаваемые без установления подключения. 
                     * Возможны потеря и дублирование сообщений, а также их получение не в том порядке, в котором они отправлены. 
                     * Объект Socket типа Dgram не требует установки подключения до приема и передачи данных и может обеспечивать связь со множеством одноранговых узлов.
                     * Dgram использует протокол Datagram (Udp) и InterNetwork.
                     */
                    socket.EnableBroadcast = true;
                    // Значение true, если объект Socket разрешает использование широковещательных пакетов; в противном случае — значение false. 
                    // Значение по умолчанию – false. 

                    // Создадим поток, резервным хранилищем которого является память.
                    MemoryStream stream = new MemoryStream();
                    // BinaryFormatter сериализует и десериализует объект в двоичном формате 
                    BinaryFormatter formatter = new BinaryFormatter();
                    Message m = new Message();
                    m.mes = textBox2.Text; // текст сообщения
                    m.user = Environment.UserDomainName + @"\" + Environment.UserName; // имя пользователя
                    formatter.Serialize(stream, m); // выполняем сериализацию
                    byte[] arr = stream.ToArray(); // записываем содержимое потока в байтовый массив
                    stream.Close();
                    socket.SendTo(arr, ipEndPoint); // передаем UDP-датаграмму на удаленный узел
                    socket.Shutdown(SocketShutdown.Send); // Отключаем объект Socket от передачи.
                    socket.Close(); // закрываем UDP-подключение и освобождаем все ресурсы
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Отправитель: " + ex.Message);
                }
            });        
        }
    }
}
