unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, JvComponentBase, JvHidControllerClass, Vcl.ComCtrls, Vcl.ToolWin;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    btnConnect: TButton;
    btnDisconnect: TButton;
    pnlOutput: TPanel;
    memLog: TMemo;
    HidCtlJoy: TJvHidDeviceController;
    lblRotX: TLabel;
    lblRotY: TLabel;
    lblRotZ: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    lblZTra: TLabel;
    lblYTra: TLabel;
    lblXTra: TLabel;
    pbRx: TTrackBar;
    tmrSendJoyData: TTimer;
    pbRy: TTrackBar;
    pbRz: TTrackBar;
    pbX: TTrackBar;
    pbY: TTrackBar;
    pbZ: TTrackBar;
    pbSlider: TTrackBar;
    pbDial: TTrackBar;
    pbWheel: TTrackBar;
    ToolBar1: TToolBar;
    btn1: TToolButton;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    btn2: TToolButton;
    btn3: TToolButton;
    btn4: TToolButton;
    btn5: TToolButton;
    btn6: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton2: TToolButton;
    btn128: TToolButton;
    ToolButton5: TToolButton;
    tbHat: TTrackBar;
    lblHat: TLabel;
    tmrConnect: TTimer;
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure HidCtlJoyDeviceCreateError(Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo; var Handled, RetryCreate: Boolean);
    procedure HidCtlJoyDeviceDataError(HidDev: TJvHidDevice; Error: Cardinal);
    function HidCtlJoyEnumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
    procedure HidCtlJoyDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
    procedure tmrSendJoyDataTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrConnectTimer(Sender: TObject);
  private
    FCurrentDeviceJoy: TJvHidDevice;
    procedure Disconnect;
    procedure Log(AMsg: string);
    procedure ResetHIDJoy;
    procedure SendJoy;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses uHVDK_Types, uHVDK_Const;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  //we'll use this as a reference to the joystick later
  FCurrentDeviceJoy := nil;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Width := Width + 10;  //to fix tmemo wordwrap issues
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //always disconnect before shutting down app or you can leave the joystick driver with strange axis position or button states
  Disconnect;
end;

procedure TfrmMain.Log(AMsg: string);
begin
  memLog.Lines.Add(AMsg);
end;

procedure TfrmMain.btnConnectClick(Sender: TObject);
begin
  if not assigned(FCurrentDeviceJoy) then
  begin
    Log('Connecting...');
    //this is how we tell it to go find our driver
    HidCtlJoy.Enumerate;
  end
  else
    Log('Already connected.');
end;

procedure TfrmMain.tmrConnectTimer(Sender: TObject);
begin
  tmrConnect.Enabled := False;
  btnConnectClick(nil);
end;

procedure TfrmMain.btnDisconnectClick(Sender: TObject);
begin
  Disconnect;
end;

procedure TfrmMain.Disconnect;
begin
  if Assigned(FCurrentDeviceJoy) then
  begin
    tmrSendJoyData.Enabled := False;
    Log('Disconnecting...');
    //this is how we tell it to reset axis to neutral position and all hat and buttons to unpressed.
    ResetHIDJoy;
    //if we have checked out a joystick, check it in since we are done with it
    if assigned(FCurrentDeviceJoy) then
      if FCurrentDeviceJoy.IsCheckedOut then HidCtlJoy.Checkin(FCurrentDeviceJoy);
    //reset the driver to neutral axis position and no buttons pressed so we leave it in good condition for next user
    ResetHIDJoy;
    FCurrentDeviceJoy := nil;
    Log('Disconnected.');
  end
  else
  begin
    Log('Already disconnected.');
  end;
end;

procedure TfrmMain.HidCtlJoyDeviceCreateError(Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo; var Handled, RetryCreate: Boolean);
begin
  //this can happen on computers with that have drivers that can't be opened (they are readonly).  Rare, but it happens
  Log('** HidCtlJoyDeviceCreateError: ' + PNPInfo.DeviceDescr + ': ' + PNPInfo.ClassDescr + ': ' + PNPInfo.DevicePath);
  Handled := True
end;

procedure TfrmMain.HidCtlJoyDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
begin
  //we don't use this since we are just sending date to the driver.  We could use it though to see what the driver is sending out
  //instead for now, use the Reader program so we know a separate program can read the output.
end;

procedure TfrmMain.HidCtlJoyDeviceDataError(HidDev: TJvHidDevice; Error: Cardinal);
begin
  Log('** HidCtlJoyDeviceDataError: ' + SysErrorMessage(Error));
end;

function TfrmMain.HidCtlJoyEnumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
begin
  Result := False;
  //here we are iterating through all the HID Devices and matching the product name
  //on some computers with strange driver configurations, each call to .ProductName can take 5-10 seconds
  //I have fixed this before by deleting hidden and unused drivers in the Device Manager then rebooting, but
  //be aware that this may not be the best way to deal with this problem.  You might also try comparing the GUID, which may
  //be faster. This is a known issue and is a bug in Windows.
  if HidDev.ProductName = HIDDEV_PRODUCTNAME_JOY then
  begin
    Log('Found ' + HIDDEV_PRODUCTNAME_JOY + ' driver.');
    HidCtlJoy.CheckOutByIndex(FCurrentDeviceJoy, Idx);
    ResetHIDJoy;
    tmrSendJoyData.Enabled := True;
  end;
  Result := True;
end;

procedure TfrmMain.ResetHIDJoy;
var
Feature: TSetFeatureJoy;
i: Integer;
begin
  if Assigned(FCurrentDeviceJoy) then
  begin
    try
      ZeroMemory(@Feature, SizeOf(Feature));
      Feature.ReportID := 1;
      Feature.CommandCode := 1;
      Feature.X := JOYRANGE_MID;
      Feature.Y := JOYRANGE_MID;
      Feature.Z := JOYRANGE_MID;
      Feature.RX := JOYRANGE_MID;
      Feature.RY := JOYRANGE_MID;
      Feature.RZ := JOYRANGE_MID;
      Feature.Slider := JOYRANGE_MID;
      Feature.Dial := JOYRANGE_MID;
      Feature.Wheel := JOYRANGE_MID;
      Feature.Hat := 255;
      for i := 0 to 15 do
        Feature.Buttons[i] := 0;
      FCurrentDeviceJoy.SetFeature(Feature, SizeOf(Feature) + 1);
    finally
      Log('Joystick driver reset.');
    end;
  end;
end;

procedure TfrmMain.SendJoy;
var
Feature: TSetFeatureJoy;
i: Integer;
btns0, btns15: Byte;
begin
  if Assigned(FCurrentDeviceJoy) then
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
    FCurrentDeviceJoy.SetFeature(Feature, SizeOf(Feature) + 1);
  end;
end;

procedure TfrmMain.tmrSendJoyDataTimer(Sender: TObject);
begin
  if Assigned(FCurrentDeviceJoy) then
  begin
    try
      tmrSendJoyData.Enabled := False;
      SendJoy;
    finally
      tmrSendJoyData.Enabled := True;
    end;
  end;
end;

end.
