object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Tetherscript Virtual Joystick Driver Sender'
  ClientHeight = 425
  ClientWidth = 835
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 829
    Height = 38
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnConnect: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 211
      Height = 32
      Align = alLeft
      Caption = 'Connect to Joystick Driver'
      TabOrder = 0
      OnClick = btnConnectClick
    end
    object btnDisconnect: TButton
      AlignWithMargins = True
      Left = 220
      Top = 3
      Width = 109
      Height = 32
      Align = alLeft
      Caption = 'Disconnect'
      TabOrder = 1
      OnClick = btnDisconnectClick
    end
  end
  object pnlOutput: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 250
    Width = 829
    Height = 172
    Align = alBottom
    BevelOuter = bvNone
    DockSite = True
    TabOrder = 2
    object lblRotX: TLabel
      Left = 19
      Top = 11
      Width = 14
      Height = 17
      Caption = 'Rx'
    end
    object lblRotY: TLabel
      Left = 19
      Top = 34
      Width = 14
      Height = 17
      Caption = 'Ry'
    end
    object lblRotZ: TLabel
      Left = 19
      Top = 59
      Width = 14
      Height = 17
      Caption = 'Rz'
    end
    object Label1: TLabel
      Left = 23
      Top = 82
      Width = 10
      Height = 17
      Caption = 'Sl'
    end
    object Label3: TLabel
      Left = 20
      Top = 105
      Width = 12
      Height = 17
      Caption = 'Dl'
    end
    object Label2: TLabel
      Left = 268
      Top = 82
      Width = 22
      Height = 17
      Caption = 'Whl'
    end
    object lblZTra: TLabel
      Left = 280
      Top = 59
      Width = 7
      Height = 17
      Caption = 'Z'
    end
    object lblYTra: TLabel
      Left = 281
      Top = 34
      Width = 7
      Height = 17
      Caption = 'Y'
    end
    object lblXTra: TLabel
      Left = 280
      Top = 11
      Width = 8
      Height = 17
      Caption = 'X'
    end
    object lblHat: TLabel
      Left = 268
      Top = 105
      Width = 20
      Height = 17
      Caption = 'Hat'
    end
    object pbRx: TTrackBar
      Left = 41
      Top = 16
      Width = 192
      Height = 17
      Max = 32766
      Position = 16383
      ShowSelRange = False
      TabOrder = 0
      ThumbLength = 13
      TickStyle = tsNone
    end
    object pbRy: TTrackBar
      Left = 41
      Top = 39
      Width = 192
      Height = 17
      Max = 32766
      Position = 16383
      ShowSelRange = False
      TabOrder = 2
      ThumbLength = 13
      TickStyle = tsNone
    end
    object pbRz: TTrackBar
      Left = 41
      Top = 62
      Width = 192
      Height = 17
      Max = 32766
      Position = 16383
      ShowSelRange = False
      TabOrder = 4
      ThumbLength = 13
      TickStyle = tsNone
    end
    object pbX: TTrackBar
      Left = 300
      Top = 16
      Width = 192
      Height = 17
      Max = 32766
      Position = 16383
      ShowSelRange = False
      TabOrder = 1
      ThumbLength = 13
      TickStyle = tsNone
    end
    object pbY: TTrackBar
      Left = 300
      Top = 39
      Width = 192
      Height = 17
      Max = 32766
      Position = 16383
      ShowSelRange = False
      TabOrder = 3
      ThumbLength = 13
      TickStyle = tsNone
    end
    object pbZ: TTrackBar
      Left = 300
      Top = 62
      Width = 192
      Height = 17
      Max = 32766
      Position = 16383
      ShowSelRange = False
      TabOrder = 5
      ThumbLength = 13
      TickStyle = tsNone
    end
    object pbSlider: TTrackBar
      Left = 41
      Top = 85
      Width = 192
      Height = 17
      Max = 32766
      Position = 16383
      ShowSelRange = False
      TabOrder = 6
      ThumbLength = 13
      TickStyle = tsNone
    end
    object pbDial: TTrackBar
      Left = 41
      Top = 108
      Width = 192
      Height = 17
      Max = 32766
      Position = 16383
      ShowSelRange = False
      TabOrder = 8
      ThumbLength = 13
      TickStyle = tsNone
    end
    object pbWheel: TTrackBar
      Left = 300
      Top = 85
      Width = 192
      Height = 17
      Max = 32766
      Position = 16383
      ShowSelRange = False
      TabOrder = 7
      ThumbLength = 13
      TickStyle = tsNone
    end
    object ToolBar1: TToolBar
      AlignWithMargins = True
      Left = 3
      Top = 139
      Width = 823
      Height = 30
      Align = alBottom
      BorderWidth = 1
      ButtonHeight = 23
      ButtonWidth = 55
      Caption = 'ToolBar1'
      Ctl3D = False
      DrawingStyle = dsGradient
      List = True
      ShowCaptions = True
      TabOrder = 10
      Transparent = True
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Caption = 'Buttons'
        ImageIndex = 2
      end
      object ToolButton10: TToolButton
        Left = 55
        Top = 0
        Width = 8
        Caption = 'ToolButton10'
        ImageIndex = 8
        Style = tbsSeparator
      end
      object btn1: TToolButton
        Left = 63
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = '1'
        ImageIndex = 1
        Style = tbsCheck
      end
      object ToolButton11: TToolButton
        Left = 86
        Top = 0
        Width = 8
        Caption = 'ToolButton11'
        ImageIndex = 9
        Style = tbsSeparator
      end
      object btn2: TToolButton
        Left = 94
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = '2'
        ImageIndex = 3
        Style = tbsCheck
      end
      object ToolButton3: TToolButton
        Left = 117
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object btn3: TToolButton
        Left = 125
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = '3'
        ImageIndex = 4
        Style = tbsCheck
      end
      object ToolButton14: TToolButton
        Left = 148
        Top = 0
        Width = 8
        Caption = 'ToolButton14'
        ImageIndex = 8
        Style = tbsSeparator
      end
      object btn4: TToolButton
        Left = 156
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = '4'
        ImageIndex = 5
        Style = tbsCheck
      end
      object ToolButton13: TToolButton
        Left = 179
        Top = 0
        Width = 8
        Caption = 'ToolButton13'
        ImageIndex = 11
        Style = tbsSeparator
      end
      object btn5: TToolButton
        Left = 187
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = '5'
        ImageIndex = 6
        Style = tbsCheck
      end
      object ToolButton4: TToolButton
        Left = 210
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object btn6: TToolButton
        Left = 218
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = '6'
        ImageIndex = 7
        Style = tbsCheck
      end
      object ToolButton2: TToolButton
        Left = 241
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 8
        Style = tbsSeparator
      end
      object btn128: TToolButton
        Left = 249
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = '128'
        ImageIndex = 8
        Style = tbsCheck
      end
      object ToolButton5: TToolButton
        Left = 286
        Top = 0
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 9
        Style = tbsSeparator
      end
    end
    object tbHat: TTrackBar
      Left = 300
      Top = 108
      Width = 192
      Height = 17
      Max = 8
      Position = 8
      ShowSelRange = False
      TabOrder = 9
      ThumbLength = 13
      TickStyle = tsNone
    end
  end
  object memLog: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 47
    Width = 829
    Height = 197
    Align = alClient
    Lines.Strings = (
      
        '1. Run the Tetherscript Virtual Joystick Reader program and tell' +
        ' it to connect to the joystick driver.'
      
        '2. In the Sender program, click the '#39'Connect to Joystick Driver'#39 +
        ' button.'
      
        '3) Adjust some axis sliders, send some hat or button actions to ' +
        'the driver.  They will be shown in the Reader program.')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object HidCtlJoy: TJvHidDeviceController
    DevThreadSleepTime = 10
    OnEnumerate = HidCtlJoyEnumerate
    OnDeviceCreateError = HidCtlJoyDeviceCreateError
    OnDeviceData = HidCtlJoyDeviceData
    OnDeviceDataError = HidCtlJoyDeviceDataError
    Left = 69
    Top = 136
  end
  object tmrSendJoyData: TTimer
    Enabled = False
    Interval = 50
    OnTimer = tmrSendJoyDataTimer
    Left = 536
    Top = 144
  end
  object tmrConnect: TTimer
    OnTimer = tmrConnectTimer
    Left = 240
    Top = 144
  end
end
