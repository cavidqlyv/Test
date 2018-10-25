using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Net.Mail;
using System.Net;
using System.Threading.Tasks;

namespace WindowsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private async void butSend_Click(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                try
                {
                    //MailMessage - представляет сообщение электронной почты, которое может быть отправлено с помощью класса SmtpClient.
                    MailMessage message = new MailMessage();
                    message.To.Add(new MailAddress(txtTo.Text)); // электронный адрес получателя  (login@gmail.com)  
                    message.From = new MailAddress(txtFrom.Text); // электронный адрес отправителя (login@mail.ru)
                    message.Subject = txtSubject.Text; // тема письма
                    message.Body = txtBody.Text; // содержимое письма
                    // кодировка, используемая для темы данного сообщения электронной почты
                    message.SubjectEncoding = Encoding.UTF8;
                    // кодировка, используемая для кодирования текста письма
                    message.BodyEncoding = Encoding.UTF8;
                    message.Attachments.Add(new Attachment(txtPath.Text)); // путь к прикрепленному файлу
                    // SmtpClient позволяет приложениям отправлять электронную почту с помощью протокола SMTP (Simple Mail Transfer Protocol)
                    int port = Convert.ToInt32(txtPort.Text);
                    SmtpClient smtp = new SmtpClient(txtServer.Text /* сервер SMTP */, port /* порт */); // например, smtp.mail.ru  2525, либо smtp.gmail.com   587

                    // Credentials - учетные данные, используемые для проверки подлинности отправителя
                    smtp.Credentials = new NetworkCredential(txtFrom.Text /* логин */, txtPassword.Text /* пароль */);
                    smtp.EnableSsl = true; // Указывает, использует ли SmtpClient протокол SSL для шифрования подключения.
                    // Send отправляет указанное сообщение на сервер SMTP для доставки
                    smtp.Send(message);
                    MessageBox.Show("Письмо отправлено!!!");
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            });
        }

        private void button1_Click(object sender, EventArgs e)
        {
            openFileDialog1.FileName = "";
            openFileDialog1.Multiselect = false; // запретить множественный выбор файлов
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
                txtPath.Text = openFileDialog1.FileName; // путь к выбранному файлу
        }
    }
}