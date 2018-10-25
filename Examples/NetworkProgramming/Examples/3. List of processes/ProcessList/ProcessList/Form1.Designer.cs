namespace ProcessList
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.button1 = new System.Windows.Forms.Button();
            this.listBox1 = new System.Windows.Forms.ListBox();
            this.button2 = new System.Windows.Forms.Button();
            this.butGetNETBIOS = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(0, 0);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(197, 36);
            this.button1.TabIndex = 0;
            this.button1.Text = "Получить список всех процессов";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // listBox1
            // 
            this.listBox1.FormattingEnabled = true;
            this.listBox1.Location = new System.Drawing.Point(1, 146);
            this.listBox1.Name = "listBox1";
            this.listBox1.Size = new System.Drawing.Size(197, 225);
            this.listBox1.TabIndex = 1;
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(0, 40);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(197, 36);
            this.button2.TabIndex = 2;
            this.button2.Text = "Получить список оконных процессов";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // butGetNETBIOS
            // 
            this.butGetNETBIOS.Location = new System.Drawing.Point(-1, 80);
            this.butGetNETBIOS.Margin = new System.Windows.Forms.Padding(2);
            this.butGetNETBIOS.Name = "butGetNETBIOS";
            this.butGetNETBIOS.Size = new System.Drawing.Size(198, 24);
            this.butGetNETBIOS.TabIndex = 3;
            this.butGetNETBIOS.Text = "Получить NETBIOS-имя сервера";
            this.butGetNETBIOS.UseVisualStyleBackColor = true;
            this.butGetNETBIOS.Click += new System.EventHandler(this.butGetNETBIOS_Click);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(0, 108);
            this.button3.Margin = new System.Windows.Forms.Padding(2);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(198, 34);
            this.button3.TabIndex = 4;
            this.button3.Text = "Получить имя текущего пользователя";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(199, 372);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.butGetNETBIOS);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.listBox1);
            this.Controls.Add(this.button1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Processes";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.ListBox listBox1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button butGetNETBIOS;
        private System.Windows.Forms.Button button3;
    }
}

