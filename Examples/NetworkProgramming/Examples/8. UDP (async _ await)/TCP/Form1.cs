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
                    // Инициализируем новый экземпляр класса UdpClient и связываем его с заданным номером локального порта.
                    UdpClient client = new UdpClient(49152 /* порт */); // принимаются все входящие соединения с локальной конечной точкой
                    client.EnableBroadcast = true;
                    while (true)
                    {
                        IPEndPoint remote = null; // информация об удаленном хосте, который отправил датаграмму
                        byte[] arr = client.Receive(ref remote); // получим UDP-датаграмму
                        if (arr.Length > 0)
                        {
                            // Создадим поток, резервным хранилищем которого является память.
                            MemoryStream stream = new MemoryStream(arr);
                            // BinaryFormatter сериализует и десериализует объект в двоичном формате 
                            BinaryFormatter formatter = new BinaryFormatter();
                            Message m = (Message)formatter.Deserialize(stream); // выполняем десериализацию
                            // полученную от удаленного узла информацию добавляем в список
                            uiContext.Send(d => listBox1.Items.Add(remote.Address.ToString()), null);
                            uiContext.Send(d => listBox1.Items.Add(m.user), null);
                            uiContext.Send(d => listBox1.Items.Add(m.mes), null);
                            stream.Close();
                        }
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
                    // Инициализируем новый экземпляр класса UdpClient и устанавливаем удаленный узел
                    UdpClient client = new UdpClient(
                        textBox1.Text.ToString() /* IP-адрес удаленного DNS-узла, к которому планируется подключение. */,
                        49152 /* Номер удаленного порта, к которому планируется выполнить подключение. */ );
                    // Для широковещательной передачи данных всем удаленным узлам следует указать 255.255.255.255
                    client.EnableBroadcast = true;
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
                    client.Send(arr, arr.Length); // передаем UDP-датаграмму на удаленный узел
                    client.Close(); // закрываем UDP-подключение и освобождаем все ресурсы, связанные с объектом UdpClient.
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Отправитель: " + ex.Message);
                }
            });        
        }
    }
}
