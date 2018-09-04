using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp5
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            string[] str1 = { "C180", "C200", "C220" };
            string[] str2 = { "518", "520", "525" };

            dictionary.Add("Mercedes", str1);
            dictionary.Add("BMW", str2);

            InitializeComponent();
        }
        Dictionary<string, string[]> dictionary = new Dictionary<string, string[]>();

        private void Form1_Load(object sender, EventArgs e)
        {
            foreach (var item in dictionary)
                comboBox1.Items.Add(item.Key);
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            comboBox2.Items.Clear();
            // foreach (var item in dictionary[comboBox1.Text])
            //comboBox2.Items.Add(item);
            dictionary.TryGetValue(comboBox1.Text, out string[] value);
            comboBox2.Items.Add(value);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            var a = dateTimePicker1.Value;
            DateTime dateTime = new DateTime();

            var b = a - DateTime.Now;
            MessageBox.Show( b.Days.ToString());
        }
    }
}