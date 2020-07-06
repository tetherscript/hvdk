object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Tetherscript Virtual Joystick Driver Reader'
  ClientHeight = 377
  ClientWidth = 713
  Color = clBtnShadow
  Font.Charset = ANSI_CHARSET
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
  object memLog: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 47
    Width = 707
    Height = 168
    Align = alClient
    Lines.Strings = (
      '1. Press the '#39'Connect to Joystick Driver'#39' button.'
      
        '2. Run the Tetherscript Virtual Joystick Sender program and send' +
        ' some joystick axis, hat and button '
      'data to the driver.  It will be displayed here.'
      
        '3. You can also use ControlMyJoystick (free trial available) to ' +
        'send data to the driver so that it can be '
      'read here.')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 707
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
      Width = 125
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
    Top = 221
    Width = 707
    Height = 153
    Align = alBottom
    BevelOuter = bvNone
    DockSite = True
    TabOrder = 2
    object gXRot: TGauge
      Left = 40
      Top = 14
      Width = 203
      Height = 17
      ForeColor = clMaroon
      MaxValue = 32766
      Progress = 0
      ShowText = False
    end
    object lblRotX: TLabel
      Left = 19
      Top = 11
      Width = 14
      Height = 17
      Caption = 'Rx'
    end
    object lblRotZ: TLabel
      Left = 19
      Top = 59
      Width = 14
      Height = 17
      Caption = 'Rz'
    end
    object gZRot: TGauge
      Left = 40
      Top = 61
      Width = 203
      Height = 17
      ForeColor = clMaroon
      MaxValue = 32766
      Progress = 0
      ShowText = False
    end
    object lblRotY: TLabel
      Left = 19
      Top = 34
      Width = 14
      Height = 17
      Caption = 'Ry'
    end
    object gYRot: TGauge
      Left = 40
      Top = 37
      Width = 203
      Height = 17
      ForeColor = clMaroon
      MaxValue = 32766
      Progress = 0
      ShowText = False
    end
    object gXTra: TGauge
      Left = 301
      Top = 13
      Width = 203
      Height = 17
      ForeColor = clMaroon
      MaxValue = 32766
      Progress = 0
      ShowText = False
    end
    object lblXTra: TLabel
      Left = 280
      Top = 11
      Width = 8
      Height = 17
      Caption = 'X'
    end
    object lblZTra: TLabel
      Left = 280
      Top = 59
      Width = 7
      Height = 17
      Caption = 'Z'
    end
    object gZTra: TGauge
      Left = 301
      Top = 61
      Width = 203
      Height = 17
      ForeColor = clMaroon
      MaxValue = 32766
      Progress = 0
      ShowText = False
    end
    object lblYTra: TLabel
      Left = 281
      Top = 34
      Width = 7
      Height = 17
      Caption = 'Y'
    end
    object gYTra: TGauge
      Left = 301
      Top = 37
      Width = 203
      Height = 17
      ForeColor = clMaroon
      MaxValue = 32766
      Progress = 0
      ShowText = False
    end
    object Label1: TLabel
      Left = 23
      Top = 82
      Width = 10
      Height = 17
      Caption = 'Sl'
    end
    object gSlider: TGauge
      Left = 40
      Top = 85
      Width = 203
      Height = 17
      ForeColor = clMaroon
      MaxValue = 32766
      Progress = 0
      ShowText = False
    end
    object Label2: TLabel
      Left = 271
      Top = 82
      Width = 22
      Height = 17
      Caption = 'Whl'
    end
    object gWheel: TGauge
      Left = 301
      Top = 85
      Width = 203
      Height = 17
      ForeColor = clMaroon
      MaxValue = 32766
      Progress = 0
      ShowText = False
    end
    object Label3: TLabel
      Left = 20
      Top = 105
      Width = 12
      Height = 17
      Caption = 'Dl'
    end
    object gDial: TGauge
      Left = 40
      Top = 108
      Width = 203
      Height = 17
      ForeColor = clMaroon
      MaxValue = 32766
      Progress = 0
      ShowText = False
    end
    object lblhat: TLabel
      Left = 8
      Top = 131
      Width = 23
      Height = 17
      Caption = 'Hat:'
    end
    object lblHatVal: TLabel
      Left = 40
      Top = 131
      Width = 200
      Height = 20
      AutoSize = False
      Caption = '-'
    end
    object lbbtn: TLabel
      Left = 271
      Top = 131
      Width = 133
      Height = 17
      Caption = 'Button array byte zero:'
    end
    object lblBtnVal: TLabel
      Left = 427
      Top = 131
      Width = 77
      Height = 20
      AutoSize = False
      Caption = '-'
    end
  end
  object HidCtlJoy: TJvHidDeviceController
    DevThreadSleepTime = 10
    OnEnumerate = HidCtlJoyEnumerate
    OnDeviceCreateError = HidCtlJoyDeviceCreateError
    OnDeviceData = HidCtlJoyDeviceData
    OnDeviceDataError = HidCtlJoyDeviceDataError
    Left = 165
    Top = 152
  end
  object tmrConnect: TTimer
    OnTimer = tmrConnectTimer
    Left = 352
    Top = 152
  end
end
