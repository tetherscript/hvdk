unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, ttcHidController, Vcl.ComCtrls, Vcl.Samples.Gauges, Vcl.ToolWin;

type
  TfrmMain = class(TForm)
    memLog: TMemo;
    pnlOutput: TPanel;
    lblRotX: TLabel;
    lblRotY: TLabel;
    lblRotZ: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    lblZTra: TLabel;
    lblYTra: TLabel;
    lblXTra: TLabel;
    lblHat: TLabel;
    pbRx: TTrackBar;
    pbRy: TTrackBar;
    pbRz: TTrackBar;
    pbX: TTrackBar;
    pbY: TTrackBar;
    pbZ: TTrackBar;
    pbSlider: TTrackBar;
    pbDial: TTrackBar;
    pbWheel: TTrackBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    btn1: TToolButton;
    ToolButton11: TToolButton;
    btn2: TToolButton;
    ToolButton3: TToolButton;
    btn3: TToolButton;
    ToolButton14: TToolButton;
    btn4: TToolButton;
    ToolButton13: TToolButton;
    btn5: TToolButton;
    ToolButton4: TToolButton;
    btn6: TToolButton;
    ToolButton2: TToolButton;
    btn128: TToolButton;
    ToolButton5: TToolButton;
    tbHat: TTrackBar;
    tmrSendJoyData: TTimer;
    Panel1: TPanel;
    gXRot: TGauge;
    Label4: TLabel;
    Label5: TLabel;
    gZRot: TGauge;
    Label6: TLabel;
    gYRot: TGauge;
    gXTra: TGauge;
    Label7: TLabel;
    Label8: TLabel;
    gZTra: TGauge;
    Label9: TLabel;
    gYTra: TGauge;
    Label10: TLabel;
    gSlider: TGauge;
    Label11: TLabel;
    gWheel: TGauge;
    Label12: TLabel;
    gDial: TGauge;
    Label13: TLabel;
    lblHatVal: TLabel;
    lbbtn: TLabel;
    lblBtnVal: TLabel;
    Panel2: TPanel;
    btnCreate: TButton;
    btnFree: TButton;
    procedure btnFreeClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrSendJoyDataTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FHIDController: ttcTHidController;
    procedure Log(AMsg: string);
    procedure DeviceData(const Data: Pointer; Size: Word);
    procedure SendJoy;
  public
  end;

type
  PTSetFeatureJoy = ^TSetFeatureJoy;
  TSetFeatureJoy = packed record
    ReportID: Byte;
    CommandCode: Byte;
    X: Word;
    Y: Word;
    Z: Word;
    rX: Word;
    rY: Word;
    rZ: Word;
    slider: Word;
    dial: Word;
    wheel: Word;
    hat: Byte;
    buttons: array[0..15] of Byte;
end;

type
  PTDriverDataJoy = ^TDriverDataJoy;
  TDriverDataJoy = packed record
    X: Word;
    Y: Word;
    Z: Word;
    rX: Word;
    rY: Word;
    rZ: Word;
    slider: Word;
    dial: Word;
    wheel: Word;
    hat: byte;
    buttons: array[0..15] of Byte;
end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  btnFreeClick(nil);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  {$IFDEF CPU64}
  log('64 bit executable');
  {$ENDIF CPU64}
  FHIDController := nil;
  btnCreateClick(nil);
end;

procedure TfrmMain.Log(AMsg: string);
begin
  memLog.Lines.Add(AMsg);
end;

procedure TfrmMain.btnCreateClick(Sender: TObject);
begin
  if not Assigned(FHIDController) then
  begin
    FHIDController := ttcTHidController.Create;
    FHIDController.OnData := DeviceData;
    FHIDController.OnLog := Log;
    FHIDController.DeviceType := dtJoystick;
    FHIDController.Connect;
    tmrSendJoyData.Enabled := True;
  end;
end;

procedure TfrmMain.btnFreeClick(Sender: TObject);
begin
  if Assigned(FHIDController) then
  begin
    tmrSendJoyData.Enabled := False;
    FHIDController.Free;
    FHIDController := nil;
  end;
end;

procedure TfrmMain.DeviceData(const Data: Pointer; Size: Word);
var
i: Integer;
FJoyState: TDriverDataJoy;
begin
  CopyMemory(@FJoyState, Data, Size);
  //each axis has a value of 0 to 32766
  gXRot.Progress := FJoyState.rX;
  gYRot.Progress := FJoyState.rY;
  gZRot.Progress := FJoyState.rZ;
  gXTra.Progress := FJoyState.X;
  gYTra.Progress := FJoyState.Y;
  gZTra.Progress := FJoyState.Z;
  gSlider.Progress := FJoyState.slider;
  gDial.Progress := FJoyState.dial;
  gWheel.Progress := FJoyState.wheel;
  //each hat button has a unique number from 0-8. Only one hat button can be pressed at a time
  lblHatVal.Caption := IntToStr(FJoyState.hat);
  //non-hat buttons can be pressed simultaneously, so the buttons are represented as a bit array of 16 bytes.
  //16 bytes x 8 bits = 128 buttons are supported by the driver.
  //the joystick trigger button is the right-most bit of the first byte for a value of 1.
  //press button two and you'll see it has or'd for a value of 3.
  //Here we'll look at the first byte only.
  lblBtnVal.Caption := IntToStr(FJoyState.buttons[0]);
end;

procedure TfrmMain.SendJoy;
var
Feature: TSetFeatureJoy;
i: Integer;
btns0, btns15: Byte;
begin
  if Assigned(FHIDController) then
  begin
    ZeroMemory(@Feature, SizeOf(Feature));
    Feature.ReportID := 1;
    Feature.CommandCode := 2;
    Feature.X := Word(pbX.Position);
    Feature.Y := Word(pbY.Position);
    Feature.Z := Word(pbZ.Position);
    Feature.rX := Word(pbRx.Position);
    Feature.rY := Word(pbRy.Position);
    Feature.rZ := Word(pbRz.Position);
    Feature.slider := Word(pbSlider.Position);
    Feature.dial := Word(pbDial.Position);
    Feature.wheel := Word(pbWheel.Position);
    if tbHat.Position = 8 then Feature.hat := 255 //255 means hat button is not pressed
      else Feature.hat := Byte(tbHat.Position); //hat button presses are values 0-7.
    //clear the buttons
    for i := 0 to 15 do
      Feature.buttons[i] := 0; //FCurrentJoyState.Buttons[i];
    //now set the bits in the button byte array to correspond to this example
    if btn1.Down then btns0 := 1;
    if btn2.Down then btns0 := btns0 or 2;
    if btn3.Down then btns0 := btns0 or 4;
    if btn4.Down then btns0 := btns0 or 8;
    if btn5.Down then btns0 := btns0 or 16;
    if btn6.Down then btns0 := btns0 or 32;
    //this appears as button array byte zero in the reader program
    Feature.buttons[0] := btns0;
    //button 128 doesn't appear in the reader program since we don't display byte 15 of the button array
    if btn128.Down then btns15 := 1;
    Feature.buttons[15] := btns15;
    //now set the feature with the data
    FHIDController.SendData(Feature, SizeOf(Feature) + 1);
  end;
end;

procedure TfrmMain.tmrSendJoyDataTimer(Sender: TObject);
begin
  if Assigned(FHIDController) then
  begin
    if FHIDController.Connected then
    begin
      try
        tmrSendJoyData.Enabled := False;
        SendJoy;
      finally
        tmrSendJoyData.Enabled := True;
      end;
    end;
  end;
end;

end.
