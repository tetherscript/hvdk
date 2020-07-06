object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Tetherscript Virtual Mouse Driver Rel Sender'
  ClientHeight = 343
  ClientWidth = 697
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
    Width = 691
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
      Caption = 'Connect to Mouse Rel Driver'
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
    Top = 260
    Width = 691
    Height = 80
    Align = alBottom
    BevelOuter = bvNone
    DockSite = True
    TabOrder = 2
    ExplicitLeft = -2
    object lblX: TLabel
      Left = 19
      Top = 11
      Width = 8
      Height = 17
      Caption = 'X'
    end
    object lblY: TLabel
      Left = 221
      Top = 11
      Width = 7
      Height = 17
      Caption = 'Y'
    end
    object ToolBar1: TToolBar
      AlignWithMargins = True
      Left = 3
      Top = 47
      Width = 685
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
      TabOrder = 3
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
      object btnLeft: TToolButton
        Left = 63
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = 'Left'
        ImageIndex = 1
        Style = tbsCheck
      end
      object ToolButton3: TToolButton
        Left = 100
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object btnRight: TToolButton
        Left = 108
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = 'Right'
        ImageIndex = 4
        Style = tbsCheck
      end
      object ToolButton14: TToolButton
        Left = 154
        Top = 0
        Width = 8
        Caption = 'ToolButton14'
        ImageIndex = 8
        Style = tbsSeparator
      end
      object btnMiddle: TToolButton
        Left = 162
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = 'Middle'
        ImageIndex = 3
        Style = tbsCheck
      end
    end
    object spnX: TSpinEdit
      Left = 33
      Top = 8
      Width = 121
      Height = 27
      MaxValue = 127
      MinValue = -127
      TabOrder = 1
      Value = 10
    end
    object spnY: TSpinEdit
      Left = 235
      Top = 8
      Width = 121
      Height = 27
      MaxValue = 127
      MinValue = -127
      TabOrder = 2
      Value = 10
    end
    object btnSend: TButton
      Left = 392
      Top = 6
      Width = 185
      Height = 30
      Caption = 'Send to Mouse Rel Driver'
      TabOrder = 0
      OnClick = btnSendClick
    end
  end
  object memLog: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 47
    Width = 691
    Height = 207
    Align = alClient
    Lines.Strings = (
      
        '1) Set the X and Y values and press the '#39'Send to Mouse Rel Drive' +
        'r'#39' button.  You will see the mouse move.  1000 '
      
        'ms after the pressing this button, the mouse buttons will be rel' +
        'eased.'
      
        '2) If you have set the Left, Right or Middle buttons, the driver' +
        ' will press the buttons before moving.')
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitLeft = -2
  end
  object HidCtlMouse: TJvHidDeviceController
    DevThreadSleepTime = 10
    OnEnumerate = HidCtlMouseEnumerate
    OnDeviceCreateError = HidCtlMouseDeviceCreateError
    OnDeviceData = HidCtlMouseDeviceData
    OnDeviceDataError = HidCtlMouseDeviceDataError
    Left = 69
    Top = 136
  end
  object tmrRelease: TTimer
    Enabled = False
    OnTimer = tmrReleaseTimer
    Left = 352
    Top = 128
  end
  object tmrConnect: TTimer
    OnTimer = tmrConnectTimer
    Left = 232
    Top = 176
  end
end
