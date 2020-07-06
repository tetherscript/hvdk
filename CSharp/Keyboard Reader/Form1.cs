using System;
using System.Windows.Forms;

namespace App
{

    //create the HIDController object
    public partial class Form1 : Form
    {

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            tbLog.Text = "";
            tbLog.Focus();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            this.tbLog.SelectionStart = this.tbLog.Text.Length;
            this.tbLog.DeselectAll();
        }

        private void Form1_Activated(object sender, EventArgs e)
        {
            
        }

        private void Form1_Shown(object sender, EventArgs e)
        {
            
        }
    }
}
