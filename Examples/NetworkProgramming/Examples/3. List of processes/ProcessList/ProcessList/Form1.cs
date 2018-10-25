using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;
using System.Security.Principal;

namespace ProcessList
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

        private async void button1_Click(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                try
                {
                    uiContext.Send(d => listBox1.Items.Clear(), null);
                    Process[] lp = Process.GetProcesses();
                    foreach (Process p in lp) // список всех процессов, запущенных в системе
                    {
                        // uiContext.Send отправляет синхронное сообщение в контекст синхронизации
                        // SendOrPostCallback - делегат указывает метод, вызываемый при отправке сообщения в контекст синхронизации. 
                        uiContext.Send(d => listBox1.Items.Add(p.ProcessName) /* Вызываемый делегат SendOrPostCallback */,
                            null /* Объект, переданный делегату */);// получим имя очередного процесса
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            });
        }

        private async void button2_Click(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                try
                {
                    listBox1.Items.Clear();
                    Process[] lp = Process.GetProcesses();
                    foreach (Process p in lp) // список всех процессов, запущенных в системе
                    {
                        if (p.MainWindowHandle != IntPtr.Zero) // только оконный процесс
                            listBox1.Items.Add(p.ProcessName); // получим имя очередного процесса
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            });         
        }

        private void butGetNETBIOS_Click(object sender, EventArgs e)
        {
            try
            {
                MessageBox.Show(Environment.MachineName);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            MessageBox.Show(Environment.UserDomainName + @"\" + Environment.UserName);
            WindowsIdentity user = WindowsIdentity.GetCurrent();
            MessageBox.Show(user.Name);
        }
    }
}
