object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Tetherscript Virtual Mouse Driver Abs Sender'
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
      Caption = 'Connect to Mouse Abs Driver'
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
      object ToolButton11: TToolButton
        Left = 100
        Top = 0
        Width = 8
        Caption = 'ToolButton11'
        ImageIndex = 9
        Style = tbsSeparator
      end
      object btnMiddle: TToolButton
        Left = 108
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = 'Middle'
        ImageIndex = 3
        Style = tbsCheck
      end
      object ToolButton3: TToolButton
        Left = 165
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object btnRight: TToolButton
        Left = 173
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = 'Right'
        ImageIndex = 4
        Style = tbsCheck
      end
      object ToolButton14: TToolButton
        Left = 219
        Top = 0
        Width = 8
        Caption = 'ToolButton14'
        ImageIndex = 8
        Style = tbsSeparator
      end
    end
    object spnX: TSpinEdit
      Left = 34
      Top = 8
      Width = 121
      Height = 27
      MaxValue = 99999
      MinValue = 0
      TabOrder = 0
      Value = 16384
    end
    object spnY: TSpinEdit
      Left = 235
      Top = 8
      Width = 121
      Height = 27
      MaxValue = 99999
      MinValue = 0
      TabOrder = 1
      Value = 16384
    end
    object btnSend: TButton
      Left = 392
      Top = 6
      Width = 185
      Height = 30
      Caption = 'Send to Mouse Abs Driver'
      TabOrder = 2
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
      '1) Click the '#39'Connect to Mouse Abs Driver'#39' button.'
      
        '2) Enter absolute desktop [X,Y] coords.  [0,0] is upper left, [1' +
        '6384,16384] is center, [32767,32767] is lower right.')
    ScrollBars = ssVertical
    TabOrder = 1
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
    Left = 496
    Top = 152
  end
end
