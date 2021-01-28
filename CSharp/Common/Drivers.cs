using System;
using System.Runtime.InteropServices;

namespace Hvdk.Common
{
    public enum DriversConst : ushort
    {
        TTC_VENDORID = 0xF00F,
        TTC_PRODUCTID_JOYSTICK = 0x00000001,
        TTC_PRODUCTID_MOUSEABS = 0x00000002,
        TTC_PRODUCTID_KEYBOARD = 0x00000003,
        TTC_PRODUCTID_GAMEPAD = 0x00000004,
        TTC_PRODUCTID_MOUSEREL = 0x00000005,
    }

    //KEYBOARD ------------------------------------------------------------------------------------------------------------
    [StructLayout(LayoutKind.Sequential, Pack = 1)]
    public struct SetFeatureKeyboard
    {
        public byte ReportID;
        public byte CommandCode;
        public uint Timeout;
        public byte Modifier;
        public byte Padding;
        public byte Key0;
        public byte Key1;
        public byte Key2;
        public byte Key3;
        public byte Key4;
        public byte Key5;
    }

    //MOUSE ABS ------------------------------------------------------------------------------------------------------------
    [StructLayout(LayoutKind.Sequential, Pack = 1)]
    public struct SetFeatureMouseAbs
    {
        public byte ReportID;
        public byte CommandCode;
        public byte Buttons;
        public ushort X;
        public ushort Y;
    }

    //MOUSE REL ------------------------------------------------------------------------------------------------------------
    [StructLayout(LayoutKind.Sequential, Pack = 1)]
    public struct SetFeatureMouseRel
    {
        public byte ReportID;
        public byte CommandCode;
        public byte Buttons;
        public sbyte X;
        public sbyte Y;
    }

    //JOYSTICK -------------------------------------------------------------------------------------------------------------
    [StructLayout(LayoutKind.Sequential, Pack = 1)]
    public struct SetFeatureJoy
    {
        public byte ReportID;
        public byte CommandCode;
        public ushort X;
        public ushort Y;
        public ushort Z;
        public ushort rX;
        public ushort rY;
        public ushort rZ;
        public ushort slider;
        public ushort dial;
        public ushort wheel;
        public byte hat;
        public byte btn0;   //you really could use a byte[15] array here instead, but it's a bit more complex to implement, so we didn't do that here
        public byte btn1;
        public byte btn2;
        public byte btn3;
        public byte btn4;
        public byte btn5;
        public byte btn6;
        public byte btn7;
        public byte btn8;
        public byte btn9;
        public byte btn10;
        public byte btn11;
        public byte btn12;
        public byte btn13;
        public byte btn14;
        public byte btn15;
    }

    [StructLayout(LayoutKind.Sequential, Pack = 1)]
    public struct GetDataJoy
    {
        public byte ReportID;
        public ushort X;
        public ushort Y;
        public ushort Z;
        public ushort rX;
        public ushort rY;
        public ushort rZ;
        public ushort slider;
        public ushort dial;
        public ushort wheel;
        public byte hat;
        public byte btn0; //you really could use a byte[15] array here instead, but it's a bit more complex to implement, so we didn't do that here
        public byte btn1;
        public byte btn2;
        public byte btn3;
        public byte btn4;
        public byte btn5;
        public byte btn6;
        public byte btn7;
        public byte btn8;
        public byte btn9;
        public byte btn10;
        public byte btn11;
        public byte btn12;
        public byte btn13;
        public byte btn14;
        public byte btn15;
    }

}

