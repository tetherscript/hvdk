object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Tetherscript Virtual Keyboard Driver Reader'
  ClientHeight = 443
  ClientWidth = 713
  Color = clBtnShadow
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object memLog: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 47
    Width = 707
    Height = 393
    Align = alClient
    Lines.Strings = (
      
        '1. Run the Tetherscript Virtual Keyboard Sender program and send' +
        ' some text by pressing the '#39'Send'#39' '
      'button.'
      
        '2. The Sender program is hard-coded to set this reader program b' +
        'efore sending the text, so the text '
      'will appear here.  '
      
        '3. Keystrokes always go to the program that has focus or is acti' +
        've.'
      
        '4. You can also use Wordpad for testing, or any other app to rec' +
        'eive the text.'
      
        '----------------------------------------------------------------' +
        '--------------------------')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 707
    Height = 38
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object btnClear: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 125
      Height = 32
      Align = alLeft
      Caption = 'Clear'
      TabOrder = 0
      TabStop = False
      OnClick = btnClearClick
    end
  end
end
