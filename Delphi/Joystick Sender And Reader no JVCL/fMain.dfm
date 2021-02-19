object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Joystick Sender And Reader No JVCL'
  ClientHeight = 483
  ClientWidth = 674
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object memLog: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 31
    Width = 668
    Height = 112
    Align = alClient
    Lines.Strings = (
      
        'This uses only the bare minimum code for communicating with the ' +
        'joystick driver.  You can change the sliders '
      
        'to send data to the driver, and the thread will read from the dr' +
        'iver and display the values on gauges.')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object pnlOutput: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 149
    Width = 668
    Height = 172
    Align = alBottom
    BevelOuter = bvNone
    DockSite = True
    TabOrder = 2
    object lblRotX: TLabel
      Left = 19
      Top = 11
      Width = 14
      Height = 16
      Caption = 'Rx'
    end
    object lblRotY: TLabel
      Left = 19
      Top = 34
      Width = 14
      Height = 16
      Caption = 'Ry'
    end
    object lblRotZ: TLabel
      Left = 19
      Top = 59
      Width = 14
      Height = 16
      Caption = 'Rz'
    end
    object Label1: TLabel
      Left = 23
      Top = 82
      Width = 11
      Height = 16
      Caption = 'Sl'
    end
    object Label3: TLabel
      Left = 20
      Top = 105
      Width = 11
      Height = 16
      Caption = 'Dl'
    end
    object Label2: TLabel
      Left = 268
      Top = 82
      Width = 22
      Height = 16
      Caption = 'Whl'
    end
    object lblZTra: TLabel
      Left = 280
      Top = 59
      Width = 7
      Height = 16
      Caption = 'Z'
    end
    object lblYTra: TLabel
      Left = 281
      Top = 34
      Width = 7
      Height = 16
      Caption = 'Y'
    end
    object lblXTra: TLabel
      Left = 280
      Top = 11
      Width = 8
      Height = 16
      Caption = 'X'
    end
    object lblHat: TLabel
      Left = 268
      Top = 105
      Width = 19
      Height = 16
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
      Left = 294
      Top = 16
      Width = 192
      Height = 17
      Max = 32766
      Position = 8000
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
      Width = 662
      Height = 30
      Align = alBottom
      BorderWidth = 1
      ButtonWidth = 54
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
        Left = 54
        Top = 0
        Width = 8
        Caption = 'ToolButton10'
        ImageIndex = 8
        Style = tbsSeparator
      end
      object btn1: TToolButton
        Left = 62
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = '1'
        ImageIndex = 1
        Style = tbsCheck
      end
      object ToolButton11: TToolButton
        Left = 85
        Top = 0
        Width = 8
        Caption = 'ToolButton11'
        ImageIndex = 9
        Style = tbsSeparator
      end
      object btn2: TToolButton
        Left = 93
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = '2'
        ImageIndex = 3
        Style = tbsCheck
      end
      object ToolButton3: TToolButton
        Left = 116
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object btn3: TToolButton
        Left = 124
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = '3'
        ImageIndex = 4
        Style = tbsCheck
      end
      object ToolButton14: TToolButton
        Left = 147
        Top = 0
        Width = 8
        Caption = 'ToolButton14'
        ImageIndex = 8
        Style = tbsSeparator
      end
      object btn4: TToolButton
        Left = 155
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = '4'
        ImageIndex = 5
        Style = tbsCheck
      end
      object ToolButton13: TToolButton
        Left = 178
        Top = 0
        Width = 8
        Caption = 'ToolButton13'
        ImageIndex = 11
        Style = tbsSeparator
      end
      object btn5: TToolButton
        Left = 186
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = '5'
        ImageIndex = 6
        Style = tbsCheck
      end
      object ToolButton4: TToolButton
        Left = 209
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object btn6: TToolButton
        Left = 217
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = '6'
        ImageIndex = 7
        Style = tbsCheck
      end
      object ToolButton2: TToolButton
        Left = 240
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 8
        Style = tbsSeparator
      end
      object btn128: TToolButton
        Left = 248
        Top = 0
        AllowAllUp = True
        AutoSize = True
        Caption = '128'
        ImageIndex = 8
        Style = tbsCheck
      end
      object ToolButton5: TToolButton
        Left = 285
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
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 327
    Width = 668
    Height = 153
    Align = alBottom
    BevelOuter = bvNone
    DockSite = True
    TabOrder = 3
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
    object Label4: TLabel
      Left = 19
      Top = 11
      Width = 14
      Height = 16
      Caption = 'Rx'
    end
    object Label5: TLabel
      Left = 19
      Top = 59
      Width = 14
      Height = 16
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
    object Label6: TLabel
      Left = 19
      Top = 34
      Width = 14
      Height = 16
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
    object Label7: TLabel
      Left = 280
      Top = 11
      Width = 8
      Height = 16
      Caption = 'X'
    end
    object Label8: TLabel
      Left = 280
      Top = 59
      Width = 7
      Height = 16
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
    object Label9: TLabel
      Left = 281
      Top = 34
      Width = 7
      Height = 16
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
    object Label10: TLabel
      Left = 23
      Top = 82
      Width = 11
      Height = 16
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
    object Label11: TLabel
      Left = 271
      Top = 82
      Width = 22
      Height = 16
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
    object Label12: TLabel
      Left = 20
      Top = 105
      Width = 11
      Height = 16
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
    object Label13: TLabel
      Left = 8
      Top = 131
      Width = 24
      Height = 16
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
      Width = 132
      Height = 16
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
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 668
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnCreate: TButton
      Left = 0
      Top = 0
      Width = 75
      Height = 22
      Align = alLeft
      Caption = 'Create'
      TabOrder = 0
      OnClick = btnCreateClick
    end
    object btnFree: TButton
      Left = 75
      Top = 0
      Width = 75
      Height = 22
      Align = alLeft
      Caption = 'Free'
      TabOrder = 1
      OnClick = btnFreeClick
    end
  end
  object tmrSendJoyData: TTimer
    Enabled = False
    Interval = 50
    OnTimer = tmrSendJoyDataTimer
    Left = 536
    Top = 144
  end
end
