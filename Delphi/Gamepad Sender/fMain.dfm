object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Tetherscript Virtual Gamepad Driver Sender'
  ClientHeight = 352
  ClientWidth = 644
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
    Width = 638
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
      Caption = 'Connect to Gamepad Driver'
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
    Top = 207
    Width = 638
    Height = 142
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
      Left = 265
      Top = 85
      Width = 20
      Height = 17
      Caption = 'Hat'
    end
    object pbRx: TTrackBar
      Left = 39
      Top = 16
      Width = 192
      Height = 17
      Max = 65535
      Position = 32767
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
      Max = 65535
      Position = 32767
      ShowSelRange = False
      TabOrder = 2
      ThumbLength = 13
      TickStyle = tsNone
    end
    object pbX: TTrackBar
      Left = 295
      Top = 16
      Width = 192
      Height = 17
      Max = 65535
      Position = 32767
      ShowSelRange = False
      TabOrder = 1
      ThumbLength = 13
      TickStyle = tsNone
    end
    object pbY: TTrackBar
      Left = 295
      Top = 39
      Width = 192
      Height = 17
      Max = 65535
      Position = 32767
      ShowSelRange = False
      TabOrder = 3
      ThumbLength = 13
      TickStyle = tsNone
    end
    object pbZ: TTrackBar
      Left = 295
      Top = 62
      Width = 192
      Height = 17
      Max = 65535
      Position = 32767
      ShowSelRange = False
      TabOrder = 4
      ThumbLength = 13
      TickStyle = tsNone
    end
    object ToolBar1: TToolBar
      AlignWithMargins = True
      Left = 3
      Top = 109
      Width = 632
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
      TabOrder = 5
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
      object ToolButton5: TToolButton
        Left = 249
        Top = 0
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 9
        Style = tbsSeparator
      end
    end
  end
  object memLog: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 47
    Width = 638
    Height = 154
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      
        '1. Run the Tetherscript Virtual Gamepad Reader program and tell ' +
        'it to connect to the joystick driver.'
      
        '2. In the Sender program, click the '#39'Connect to Gamepad Driver'#39' ' +
        'button.'
      
        '3) Adjust some axis, buttons and hat values.  They will be shown' +
        ' in the Reader program.')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object HidCtlGamepad: TJvHidDeviceController
    DevThreadSleepTime = 10
    OnEnumerate = HidCtlGamepadEnumerate
    OnDeviceCreateError = HidCtlGamepadDeviceCreateError
    OnDeviceData = HidCtlGamepadDeviceData
    OnDeviceDataError = HidCtlGamepadDeviceDataError
    Left = 69
    Top = 136
  end
  object tmrSendGamepadData: TTimer
    Enabled = False
    Interval = 50
    OnTimer = tmrSendGamepadDataTimer
    Left = 496
    Top = 136
  end
  object tmrConnect: TTimer
    OnTimer = tmrConnectTimer
    Left = 304
    Top = 136
  end
end
