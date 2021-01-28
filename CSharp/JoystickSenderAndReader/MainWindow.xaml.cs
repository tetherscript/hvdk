using System;
using System.Windows;
using System.Runtime.InteropServices;
using System.ComponentModel;
using System.Windows.Threading;
using Hvdk.Common;



//this app uses the minimal code to read and write the the virtual HID driver.

namespace JoystickSenderAndReader
{
    public partial class MainWindow : Window
    {
        //create the HIDController object
        HIDController HID = new HIDController();
        DispatcherTimer timer = new DispatcherTimer();
		bool closing = false;

        public MainWindow()
        {
            InitializeComponent();
            tbLog.AppendText("\r\n");
            //create the HIDController 
            HID.OnLog += new EventHandler<LogArgs>(Log);
            HID.VendorID = (ushort)DriversConst.TTC_VENDORID;                //the Tetherscript vendorid
            HID.ProductID = (ushort)DriversConst.TTC_PRODUCTID_JOYSTICK;     //the Tetherscript Virtual Joystick Driver productid
            HID.Connect();
            //create a timer with a 15ms interval.
            //the timer will be used to send data to and read data from the driver.
            timer.Interval = TimeSpan.FromMilliseconds(15);
            timer.Tick += timer_Tick;
            timer.Start();
        }

        private void Window_Closing(object sender, CancelEventArgs e)
        {
            closing = true;
            timer.Stop();
            HID.Disconnect();
        }

        //this log event will be called by HIDController
        public void Log(object s, LogArgs e)
        {
            tbLog.AppendText(e.Msg + "\r\n");
        }

        //the timer which runs every 50ms.  It sends data to the joystick drive, then reads it back
        //normally you would put the reading code in a thread instead of the way we are doing it here
        void timer_Tick(object sender, EventArgs e)
        {
            if (!closing)
            {
                Send_Data_To_Joystick();
                Get_Data_From_Joystick();
            }
        }

        //here we send data to the joystick
        void Send_Data_To_Joystick()
        {
            SetFeatureJoy JoyData = new SetFeatureJoy();
            JoyData.ReportID = 1;
            JoyData.CommandCode = 2;
            JoyData.X = (ushort)slX.Value;
            JoyData.Y = (ushort)slY.Value;
            JoyData.Z = (ushort)slZ.Value;
            JoyData.rX = (ushort)slrX.Value;
            JoyData.rY = (ushort)slrY.Value;
            JoyData.rZ = (ushort)slrZ.Value;
            JoyData.slider = (ushort)slSlider.Value;
            JoyData.wheel = (ushort)slWheel.Value;
            JoyData.dial = (ushort)slDial.Value;
            JoyData.hat = (byte)slHat.Value;
            //non-hat buttons are represented as a bit array of 16 bytes, 1 bit per button.
            //we could have used a byte array here, but for simplicity we instead just declared 16 byte variables.
            //each button is represented by 1 bit.  The bit is 1 if pressed, 0 if not pressed.
            //in this example, we'll only show the first 8 buttons and also button 128.
            JoyData.btn0 = 0;
            if (cb0.IsChecked == true) { JoyData.btn0 = (byte)(JoyData.btn0 | (1 << 0)); }
            if (cb1.IsChecked == true) { JoyData.btn0 = (byte)(JoyData.btn0 | (1 << 1)); }
            if (cb2.IsChecked == true) { JoyData.btn0 = (byte)(JoyData.btn0 | (1 << 2)); }
            if (cb3.IsChecked == true) { JoyData.btn0 = (byte)(JoyData.btn0 | (1 << 3)); }
            if (cb4.IsChecked == true) { JoyData.btn0 = (byte)(JoyData.btn0 | (1 << 4)); }
            if (cb5.IsChecked == true) { JoyData.btn0 = (byte)(JoyData.btn0 | (1 << 5)); }
            if (cb6.IsChecked == true) { JoyData.btn0 = (byte)(JoyData.btn0 | (1 << 6)); }
            if (cb7.IsChecked == true) { JoyData.btn0 = (byte)(JoyData.btn0 | (1 << 7)); }
            JoyData.btn1 = 0;
            if (cb8.IsChecked == true) { JoyData.btn1 = (byte)(JoyData.btn1 | (1 << 0)); }
            JoyData.btn15 = 0;
            if (cb128.IsChecked == true) { JoyData.btn15 = (byte)(JoyData.btn15 | (1 << 0)); }
            //convert struct to buffer
            byte[] buf = getBytesSFJ(JoyData, Marshal.SizeOf(JoyData));
            //send filled buffer to driver
            HID.SendData(buf, (uint)Marshal.SizeOf(JoyData));
        }

        //here we get data from the joystick
        void Get_Data_From_Joystick()
        {
            GetDataJoy JoyData = new GetDataJoy();
            //convert struct to buffer
            byte[] buf = getBytesGDJ(JoyData, Marshal.SizeOf(JoyData));
            //send empty buffer to driver
            HID.ReadData(buf, (uint)Marshal.SizeOf(JoyData));
            GetDataJoy jd= fromBytes(buf);
            pbX.Value = jd.X;
            pbY.Value = jd.Y;
            pbZ.Value = jd.Z;
            pbrX.Value = jd.rX;
            pbrY.Value = jd.rY;
            pbrZ.Value = jd.rZ;
            pbSlider.Value = jd.slider;
            pbWheel.Value = jd.wheel;
            pbDial.Value = jd.dial;
            lbHatData.Content = jd.hat.ToString();
            //let's convert the button bit array to two strings for display
            string s;
            s = Convert.ToString(jd.btn0, 2).PadLeft(8, '0');
            s = s + " " + Convert.ToString(jd.btn1, 2).PadLeft(8, '0');
            s = s + " " + Convert.ToString(jd.btn2, 2).PadLeft(8, '0');
            s = s + " " + Convert.ToString(jd.btn3, 2).PadLeft(8, '0');
            s = s + " " + Convert.ToString(jd.btn4, 2).PadLeft(8, '0');
            s = s + " " + Convert.ToString(jd.btn5, 2).PadLeft(8, '0');
            s = s + " " + Convert.ToString(jd.btn6, 2).PadLeft(8, '0');
            s = s + " " + Convert.ToString(jd.btn7, 2).PadLeft(8, '0');
            lbButtonsData1.Content = s;
            s = Convert.ToString(jd.btn8, 2).PadLeft(8, '0');
            s = s + " " + Convert.ToString(jd.btn9, 2).PadLeft(8, '0');
            s = s + " " + Convert.ToString(jd.btn10, 2).PadLeft(8, '0');
            s = s + " " + Convert.ToString(jd.btn11, 2).PadLeft(8, '0');
            s = s + " " + Convert.ToString(jd.btn12, 2).PadLeft(8, '0');
            s = s + " " + Convert.ToString(jd.btn13, 2).PadLeft(8, '0');
            s = s + " " + Convert.ToString(jd.btn14, 2).PadLeft(8, '0');
            s = s + " " + Convert.ToString(jd.btn15, 2).PadLeft(8, '0');
            lbButtonsData2.Content = s;
        }

        //for converting a struct to byte array
        public static byte[] getBytesSFJ(SetFeatureJoy sfj, int size)
        {
            byte[] arr = new byte[size];
            IntPtr ptr = Marshal.AllocHGlobal(size);
            Marshal.StructureToPtr(sfj, ptr, false);
            Marshal.Copy(ptr, arr, 0, size);
            Marshal.FreeHGlobal(ptr);
            return arr;
        }

        //for converting a struct to byte array
        public static byte[] getBytesGDJ(GetDataJoy gdj, int size)
        {
            byte[] arr = new byte[size];
            IntPtr ptr = Marshal.AllocHGlobal(size);
            Marshal.StructureToPtr(gdj, ptr, false);
            Marshal.Copy(ptr, arr, 0, size);
            Marshal.FreeHGlobal(ptr);
            return arr;
        }

		//for converting a byte array to struct
		static GetDataJoy fromBytes(byte[] arr)
        {
            GetDataJoy str = new GetDataJoy();
            int size = Marshal.SizeOf(str);
            IntPtr ptr = Marshal.AllocHGlobal(size);
            Marshal.Copy(arr, 0, ptr, size);
            str = (GetDataJoy)Marshal.PtrToStructure(ptr, str.GetType());
            Marshal.FreeHGlobal(ptr);
            return str;
        }

    }
}


