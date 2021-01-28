using System;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using Common;

namespace App
{

    //create the HIDController object
    public partial class Form1 : Form
    {

        private HIDController HID = new HIDController();

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Shown(object sender, EventArgs e)
        {
            tbLog.AppendText("\r\n");
            //create the HIDController 
            HID.OnLog += new EventHandler<LogArgs>(Log);
            HID.VendorID = (ushort)DriversConst.TTC_VENDORID;                //the Tetherscript vendorid
            HID.ProductID = (ushort)DriversConst.TTC_PRODUCTID_MOUSEREL;     //the Tetherscript Virtual Mouse Absolute Driver productid
            HID.Connect();
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            HID.Disconnect();
        }

        public void Log(object s, LogArgs e)
        {
            tbLog.AppendText(e.Msg + "\r\n");
        }

        private void btnSend_Click(object sender, EventArgs e)
        {
            tbLog.AppendText("Sending mouse rel movement and button states...\r\n");
            Send_Data_To_MouseRel(false);
            tmrRelease.Enabled = true; //this will release the mouse buttons if they are pressed
        }

        //here we send data to the mouse
        void Send_Data_To_MouseRel(bool ignoreMove)
        {
            SetFeatureMouseRel MouseRelData = new SetFeatureMouseRel();
            MouseRelData.ReportID = 1;
            MouseRelData.CommandCode = 2;
            byte btns = 0;
            if (cbLeft.Checked) { btns = 1; };
            if (cbRight.Checked) { btns = (byte)(btns | (1 << 1)); }
            if (cbLeft.Checked) { btns = (byte)(btns | (1 << 2)); }
            MouseRelData.Buttons = btns;  //button states are represented by the 3 least significant bits
            if (!ignoreMove)
            {
                MouseRelData.X = (sbyte)spnX.Value;
                MouseRelData.Y = (sbyte)spnY.Value;
            }
            //convert struct to buffer
            byte[] buf = getBytesSFJ(MouseRelData, Marshal.SizeOf(MouseRelData));
            //send filled buffer to driver
            HID.SendData(buf, (uint)Marshal.SizeOf(MouseRelData));
        }

        //for converting a struct to byte array
        public static byte[] getBytesSFJ(SetFeatureMouseRel sfj, int size)
        {
            byte[] arr = new byte[size];
            IntPtr ptr = Marshal.AllocHGlobal(size);
            Marshal.StructureToPtr(sfj, ptr, false);
            Marshal.Copy(ptr, arr, 0, size);
            Marshal.FreeHGlobal(ptr);
            return arr;
        }

        private void tmrRelease_Tick(object sender, EventArgs e)
        {
            tmrRelease.Enabled = false;
            tbLog.AppendText("Releasing buttons...\r\n");
            cbLeft.Checked = false;
            cbRight.Checked = false;
            cbMiddle.Checked = false;
            Send_Data_To_MouseRel(true); //in this example, when we release the buttons we don't to move
        }
    }
}
