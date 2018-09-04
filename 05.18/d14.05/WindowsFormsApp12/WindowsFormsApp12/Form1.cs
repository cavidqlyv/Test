using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp12
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        List<Items> list = new List<Items>
            {
                new Items{Id = 1 , Name = "aaaa" , Count = 5 , Price = 100},
                new Items{Id = 2 , Name = "bbbb" , Count = 6 , Price = 200},
                new Items{Id = 3 , Name = "cccc" , Count = 7 , Price = 300},
                new Items{Id = 4 , Name = "dddd" , Count = 8 , Price = 400},
                new Items{Id = 5 , Name = "eeee" , Count = 9 , Price = 500},
                new Items{Id = 6 , Name = "ffff" , Count = 4 , Price = 600}

            };
        private void Form1_Load(object sender, EventArgs e)
        {
            AddItems();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Items tmp = null;
            if (textBox1.Text != null)
            {
                foreach (var item in list)
                {
                    if (textBox1.Text == item.Name)
                    {
                        tmp = item;
                        break;
                    }
                }
            }
            else
            {
                MessageBox.Show("Error!");
                return;
            }
            if (numericUpDown1.Value <= tmp.Count)
            {
                tmp.Count -= Convert.ToInt32(numericUpDown1.Value);
                MessageBox.Show("ok!");
                AddItems();
            }
            else
                MessageBox.Show("Error!");

        }
        private void AddItems()
        {
            listView1.Items.Clear();
            foreach (var item in list)
            {
                listView1.Items.Add(new ListViewItem(new string[] { item.Id.ToString(), item.Name, item.Price.ToString(), item.Count.ToString() }));
            }
        }

        private void listView1_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            //numericUpDown1.
            textBox1.Text = listView1.SelectedItems[0].SubItems[1].Text;
            numericUpDown1.Value = Convert.ToInt32(listView1.SelectedItems[0].SubItems[3].Text);
        }
    }
    class Items
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Price { get; set; }
        public int Count { get; set; }
    }
}
