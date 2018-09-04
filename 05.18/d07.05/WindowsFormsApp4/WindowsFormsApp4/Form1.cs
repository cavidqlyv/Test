using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp4
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();


        }

        private void button1_Click(object sender, EventArgs e)
        {
            var a = groupBox3.Controls.OfType<RadioButton>().ToList().FirstOrDefault(x => x.Checked);
            var b = groupBox2.Controls.OfType<RadioButton>().ToList().FirstOrDefault(x => x.Checked);
            var c = groupBox1.Controls.OfType<RadioButton>().ToList().FirstOrDefault(x => x.Checked);
            StringBuilder stringBuilder = new StringBuilder();
            if (a != null && b != null && c != null)
            {
                if (a.Text == "1")
                    stringBuilder.Append("1. Duz\n");
                else
                    stringBuilder.Append("1. Sehv\n");
                if (b.Text == "2")
                    stringBuilder.Append("2. Duz\n");
                else
                    stringBuilder.Append("2. Sehv\n");
                if (c.Text == "3")
                    stringBuilder.Append("3. Duz\n");
                else
                    stringBuilder.Append("3. Sehv\n");
                MessageBox.Show(stringBuilder.ToString());
            }
            else
                MessageBox.Show("Error");
        }
    }
}
