using System;
using System.Net;
using System.IO;
using System.Text;
using System.Windows.Forms;
using System.Web;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace GetWebPage
{
    public partial class Form1 : Form
    {
         //WebProxy - содержит параметры HTTP-прокси для класса WebRequest.
        WebProxy proxy = new WebProxy("10.0.0.1", 3128); //Считывает параметры прокси из Internet Explorer.
                
        public Form1()
        {
            InitializeComponent();
            proxy.UseDefaultCredentials = true; // учетные данные по умолчанию
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            await Task.Run(() =>
            { 
                try
                {
                    // WebRequest — базовый класс abstract модели "запрос-ответ" платформы .NET Framework для доступа к данным из Интернета.
                    // Выполняет запрос к универсальному коду ресурса (URI). 
                    // HttpWebRequest предоставляет ориентированную на HTTP-протокол реализацию класса WebRequest.
                    string query = "http://www.yandex.ru/";

                    // Create инициализирует новый экземпляр HttpWebRequest для заданной схемы URI.
                    HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(query /* URI, определяющий интернет-ресурс */);

                    // request.Proxy = proxy; // задает сетевой прокси, используемый для доступа к данному интернет-ресурсу.

                    // GetResponse возвращает ответ от интернет-ресурса.
                    HttpWebResponse response = (HttpWebResponse)request.GetResponse();

                    // GetResponseStream возвращает поток, используемый для чтения основного текста ответа с сервера
                    StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.UTF8);

                    // считываем данные из потока в строку
                    string data = sr.ReadToEnd();

                    // сохраняем полученные данные в файл
                    StreamWriter sw = new StreamWriter("../../yandex.html", false);
                    sw.WriteLine(data);
                    MessageBox.Show("Файл успешно загружен с сервера: " + response.Server);
                    sw.Close();
                    response.Close();
                    sr.Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            });
        }

        private async void button3_Click(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                try
                {
                    // WebClient предоставляет общие методы обмена данными с ресурсом, заданным URI
                    WebClient client = new WebClient();

                   //  client.Proxy = proxy; // задает сетевой прокси, используемый для доступа к данному интернет-ресурсу. 

                    //  DownloadData загружает данные с указанным URI в байтовый массив.
                    byte[] urlData = client.DownloadData("http://www.rambler.ru");

                    // преобразуем данные в строку
                    string data = Encoding.UTF8.GetString(urlData);

                    // сохраняем полученные данные в файл
                    StreamWriter sw = new StreamWriter("../../rambler.html", false);
                    sw.WriteLine(data);
                    sw.Close();
                    MessageBox.Show("Файл успешно загружен!");
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            });
            
        }

        private async void button4_Click(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                try
                {
                    string siteURL = "http://rutechdays.blob.core.windows.net/video/da14185b-8933-488c-8224-9113ac0e264c/ruspeekdefinition_mid_1280.mp4";
                    string fileName = "../../GoToDefinition.mp4";
                    WebClient client = new WebClient();

                    // client.Proxy = proxy; // задает сетевой прокси, используемый для доступа к данному интернет-ресурсу. 

                    // Загружаем Web-ресурс и сохраняем его на диске
                    client.DownloadFile(siteURL, fileName);
                    MessageBox.Show("Файл успешно загружен!");
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            });    
        }

        private async void button5_Click(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                try
                {
                    string siteURL = "http://www.itstep.org/";
                    WebClient client = new WebClient();

                   //  client.Proxy = proxy; // задает сетевой прокси, используемый для доступа к данному интернет-ресурсу. 

                    // Копируем Web-ресурс из RemoteURL
                    Stream stmData = client.OpenRead(siteURL);
                    StreamReader srData = new StreamReader(stmData, Encoding.UTF8);
                    FileInfo fiData = new FileInfo("../../itstep.html");
                    StreamWriter st = fiData.CreateText(); // создаем новый файл
                    st.WriteLine(srData.ReadToEnd()); // записываем в него строку
                    st.Close();
                    stmData.Close();
                    MessageBox.Show("Файл успешно загружен!");
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            });      
        }

        private async void button6_Click(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                try
                {
                    // URI, определяющий интернет-ресурс 
                    // URI (англ. Uniform Resource Identifier) — единообразный идентификатор ресурса
                    string h = "http://od.itstep.org/images/stories/openlesson/anatomiya.jpg";

                    HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(h /* URI, определяющий интернет-ресурс */);

                    // Задаем сетевой прокси, используемый для доступа к данному интернет-ресурсу
                    // request.Proxy = proxy; 
                    // Получим ответ на интернет-запрос
                    HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                    // Возвращаем поток данных из полученного интернет-ресурса.
                    Stream stream = response.GetResponseStream();
                    byte[] b = new byte[response.ContentLength];
                    int c = 0;
                    int i = 0;
                    while ((c = stream.ReadByte()) != -1)
                    {
                        b[i++] = (byte)c;
                    }
                    // сохраняем полученные данные в файл
                    FileStream st = new FileStream("../../anatomiya.jpg", FileMode.OpenOrCreate);
                    BinaryWriter writer = new BinaryWriter(st);
                    writer.Write(b);
                    writer.Close();
                    MessageBox.Show("Файл успешно загружен с сервера: " + response.Server);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            });          
        }

        private async void button7_Click(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                try
                {
                    FtpWebRequest request = (FtpWebRequest)WebRequest.Create("ftp://begemot.farlep.net/");

                    // request.Proxy = proxy; // задаем сетевой прокси, используемый для доступа к данному интернет-ресурсу. 
                    // request.Credentials = new NetworkCredential("anonymous", "");

                    // ListDirectoryDetails представляет метод протокола FTP LIST, 
                    // который возвращает подробный список файлов на FTP-сервере.
                    request.Method = WebRequestMethods.Ftp.ListDirectoryDetails;

                    // Получим ответ на ftp-запрос
                    FtpWebResponse response = (FtpWebResponse)request.GetResponse();

                    // Возвращаем поток данных из полученного интернет-ресурса
                    StreamReader reader = new StreamReader(response.GetResponseStream());
                    string res = reader.ReadToEnd();
                    // сохраняем полученные данные в файл
                    StreamWriter sw = new StreamWriter("../../list.txt", false);

                    sw.WriteLine(res);
                    sw.Close();
                    MessageBox.Show("Список директорий сохранен!");
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            });         
        }

        private async void button8_Click(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                try
                {
                    // URI, определяющий интернет-ресурс 
                    // URI (англ. Uniform Resource Identifier) — единообразный идентификатор ресурса
                    // Инициализируем новый экземпляр WebRequest
                    string URI = "ftp://begemot.farlep.net/images/prikols/nr.gif";
                    FtpWebRequest request = (FtpWebRequest)FtpWebRequest.Create(URI);

                    // Задаем сетевой прокси, используемый для доступа к данному ресурсу
                     // request.Proxy = proxy;

                    // request.Credentials = new NetworkCredential("anonymous", "");

                    // Получим ответ на ftp-запрос
                    FtpWebResponse response = (FtpWebResponse)request.GetResponse();
                    Stream stream = response.GetResponseStream();
                    List<byte> list = new List<byte>();
                    int c = 0;
                    while ((c = stream.ReadByte()) != -1)
                    {
                        list.Add((byte)c);
                    }
                    // сохраняем полученные данные в файл
                    FileStream st = new FileStream("../../pricol.gif", FileMode.OpenOrCreate);
                    BinaryWriter writer = new BinaryWriter(st);
                    writer.Write(list.ToArray());
                    writer.Close();
                    MessageBox.Show("Файл успешно загружен!");
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            });           
        }
    }
}