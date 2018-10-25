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
                    //MailMessage - ������������ ��������� ����������� �����, ������� ����� ���� ���������� � ������� ������ SmtpClient.
                    MailMessage message = new MailMessage();
                    message.To.Add(new MailAddress(txtTo.Text)); // ����������� ����� ����������  (login@gmail.com)  
                    message.From = new MailAddress(txtFrom.Text); // ����������� ����� ����������� (login@mail.ru)
                    message.Subject = txtSubject.Text; // ���� ������
                    message.Body = txtBody.Text; // ���������� ������
                    // ���������, ������������ ��� ���� ������� ��������� ����������� �����
                    message.SubjectEncoding = Encoding.UTF8;
                    // ���������, ������������ ��� ����������� ������ ������
                    message.BodyEncoding = Encoding.UTF8;
                    message.Attachments.Add(new Attachment(txtPath.Text)); // ���� � �������������� �����
                    // SmtpClient ��������� ����������� ���������� ����������� ����� � ������� ��������� SMTP (Simple Mail Transfer Protocol)
                    int port = Convert.ToInt32(txtPort.Text);
                    SmtpClient smtp = new SmtpClient(txtServer.Text /* ������ SMTP */, port /* ���� */); // ��������, smtp.mail.ru  2525, ���� smtp.gmail.com   587

                    // Credentials - ������� ������, ������������ ��� �������� ����������� �����������
                    smtp.Credentials = new NetworkCredential(txtFrom.Text /* ����� */, txtPassword.Text /* ������ */);
                    smtp.EnableSsl = true; // ���������, ���������� �� SmtpClient �������� SSL ��� ���������� �����������.
                    // Send ���������� ��������� ��������� �� ������ SMTP ��� ��������
                    smtp.Send(message);
                    MessageBox.Show("������ ����������!!!");
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
            openFileDialog1.Multiselect = false; // ��������� ������������� ����� ������
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
                txtPath.Text = openFileDialog1.FileName; // ���� � ���������� �����
        }
    }
}