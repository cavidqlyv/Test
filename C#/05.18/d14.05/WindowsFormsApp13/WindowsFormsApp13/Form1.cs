using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp13
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            currentPath = path + fileName + count++.ToString() + ".txt";
            InitializeComponent();
        }

        string fileName = "New Text Document";
        string path = @"\\ITSTEP\students redirection$\sale_rv37\Desktop\";
        int count = 1;
        string currentPath  ;
        private void newToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var a = MessageBox.Show("Save file", "File", MessageBoxButtons.YesNoCancel, MessageBoxIcon.Information);
            if (a == DialogResult.Yes)
            {
                //File.Create(currentPath);
                using (System.IO.StreamWriter file = new System.IO.StreamWriter(currentPath, true))
                {
                  //  MessageBox.Show(richTextBox1.Text);
                    file.WriteLine(richTextBox1.Text);
                    richTextBox1.Clear();
                }
                currentPath = path + fileName + count++.ToString() + ".txt";
            }
            else if (a == DialogResult.No)
                richTextBox1.Clear();
        }

        private void saveToolStripMenuItem_Click(object sender, EventArgs e)
        {
          //  currentPath = path + fileName + count++.ToString() + ".txt";
            //File.Create(currentPath);
            using (System.IO.StreamWriter file = new System.IO.StreamWriter(currentPath, false))
            {
             //   MessageBox.Show(richTextBox1.Text);
                file.WriteLine(richTextBox1.Text);
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            
        }

        private void cutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            richTextBox1.Cut();
        }

        private void copyToolStripMenuItem_Click(object sender, EventArgs e)
        {
            richTextBox1.Copy();
        }

        private void pasteToolStripMenuItem_Click(object sender, EventArgs e)
        {
            richTextBox1.Paste();
            
        }

        private void selectAllToolStripMenuItem_Click(object sender, EventArgs e)
        {
            richTextBox1.SelectAll();
        }

        private void undoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            richTextBox1.Undo();
        }

        private void redoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            richTextBox1.Redo();
        }

        private void openToolStripMenuItem_Click(object sender, EventArgs e)
        {
            openFileDialog1.ShowDialog();
            using (StreamReader stream = new StreamReader(openFileDialog1.FileName))
            {
                richTextBox1.Text = stream.ReadToEnd();
            }
        }

        private void saveAsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            saveFileDialog1.ShowDialog();
            using (System.IO.StreamWriter file = new System.IO.StreamWriter(saveFileDialog1.FileName, false))
            {
                //   MessageBox.Show(richTextBox1.Text);
                file.WriteLine(richTextBox1.Text);
            }
        }

        private void toolStripTextBox1_KeyDown(object sender, KeyEventArgs e)
        {
            if (Keys.Enter == e.KeyCode)
            {
                Utility.HighlightText(richTextBox1, toolStripTextBox2.Text, toolStripTextBox1.Text);
            }
            
        }

        private void richTextBox1_TextChanged(object sender, EventArgs e)
        {
        }

        private void toolStripTextBox1_Enter(object sender, EventArgs e)
        {

        }

        private void toolStripTextBox1_Click(object sender, EventArgs e)
        {

        }

        private void toolStripTextBox1_TextChanged(object sender, EventArgs e)
        {
            richTextBox1.ForeColor = Color.Black;

        }
    }
    static class Utility
    {
        public static void HighlightText(this RichTextBox myRtb, string word, string text)
        {

            if (word == string.Empty)
                return;

            int s_start = myRtb.SelectionStart, startIndex = 0, index;

            while ((index = myRtb.Text.IndexOf(word, startIndex)) != -1)
            {
                myRtb.Select(index, word.Length);
                myRtb.SelectedText = text;

                startIndex = index + word.Length;
            }

            myRtb.SelectionStart = s_start;
            myRtb.SelectionLength = 0;
            myRtb.SelectionColor = Color.Black;
        }
    }
}
