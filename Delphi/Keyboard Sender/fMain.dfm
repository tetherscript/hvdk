object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Tetherscript Virtual Keyboard Sender'
  ClientHeight = 430
  ClientWidth = 776
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
    Width = 770
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
      Caption = 'Connect to Keyboard Driver'
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
    Top = 320
    Width = 770
    Height = 107
    Align = alBottom
    BevelOuter = bvNone
    DockSite = True
    TabOrder = 2
    object Button1: TButton
      Left = 0
      Top = 0
      Width = 241
      Height = 30
      Caption = 'Press '#39'a'#39' for 50ms, then release'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 0
      Top = 36
      Width = 241
      Height = 30
      Caption = 'Press '#39'a'#39' for 2000ms, then release'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 256
      Top = 0
      Width = 385
      Height = 30
      Caption = 'Press '#39'a'#39' and '#39'b'#39' simultaneously for 50ms, then release'
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 256
      Top = 36
      Width = 401
      Height = 30
      Caption = 'Send '#39'Hello'#39' with 50ms down and 100ms interkey delay'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 0
      Top = 72
      Width = 241
      Height = 30
      Caption = 'Clear the Reader log'
      TabOrder = 4
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 256
      Top = 72
      Width = 505
      Height = 30
      Caption = 
        'Press '#39'a'#39' then forget to release it (stuck key).  Read code comm' +
        'ents first.'
      TabOrder = 5
      OnClick = Button6Click
    end
  end
  object memLog: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 47
    Width = 770
    Height = 267
    Align = alClient
    Lines.Strings = (
      
        '1) Start up the '#39'Tetherscript Virtual Keyboard Driver Reader'#39' pr' +
        'ogram.'
      '2) On the Sender, click the '#39'Connect to Keyboard Driver'#39' button.'
      
        '3) Press the buttons test buttons to send text to the driver, wh' +
        'ich will be displayed in the reader program because it will be '
      'made '#39'active'#39' by the sender program.'
      
        '4) Sending text to a program can be tricky due to the receiving ' +
        'program'#39's sensitivity to keydown and interkey delays.  If you '
      
        'send the text too fast or with too small delays, the text may no' +
        't be received.  You'#39'll need to experiement to find good values, '
      
        'but usually a keydown delay of 50 and interkey delay of 100ms wo' +
        'rks everywhere.')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object HidCtlKeyboard: TJvHidDeviceController
    DevThreadSleepTime = 10
    OnEnumerate = HidCtlKeyboardEnumerate
    OnDeviceCreateError = HidCtlKeyboardDeviceCreateError
    OnDeviceData = HidCtlKeyboardDeviceData
    OnDeviceDataError = HidCtlKeyboardDeviceDataError
    Left = 213
    Top = 224
  end
  object tmrPing: TTimer
    Enabled = False
    Interval = 200
    OnTimer = tmrPingTimer
    Left = 440
    Top = 216
  end
  object tmrConnect: TTimer
    OnTimer = tmrConnectTimer
    Left = 384
    Top = 224
  end
end
