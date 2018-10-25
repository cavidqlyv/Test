using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WpfApp6 {
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window {
        public MainWindow() {
            InitializeComponent();
        }

        private TcpClient tcpClient;
        private BinaryWriter writer;
        private BinaryReader reader;
        private NetworkStream stream;

        // connect
        private void ConnectClick(object sender, RoutedEventArgs e) {
            this.tcpClient = new TcpClient();
            this.tcpClient.Connect("127.0.0.1", 41111);// handshake
            if (this.tcpClient.Connected) {
                this.stream = this.tcpClient.GetStream();
                this.reader = new BinaryReader(this.stream);
                this.writer = new BinaryWriter(this.stream);
            }
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e) {
            if (this.tcpClient?.Connected ?? false) {
                this.writer.Write("goodbye");
                this.writer.Close();
                this.tcpClient.Close();
            }
        }
        private void Canvas_Drop(object sender, DragEventArgs e) {
            if (e.Data.GetDataPresent(DataFormats.FileDrop)) {
                var files = (string[])e.Data.GetData(DataFormats.FileDrop);
                var file = new FileInfo(files[0]);
                this.writer.Write(file.Name);
                this.writer.Write(file.Length);
                this.writer.Write(File.ReadAllBytes(file.FullName));
            }
        }
        private void DisconnectClick(object sender, RoutedEventArgs e) {

        }
    }
}
