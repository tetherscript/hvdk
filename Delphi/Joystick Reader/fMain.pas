unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvComponentBase, JvHidControllerClass, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ComCtrls, Vcl.ToolWin;

type
  TfrmMain = class(TForm)
    HidCtlJoy: TJvHidDeviceController;
    memLog: TMemo;
    Panel1: TPanel;
    btnConnect: TButton;
    btnDisconnect: TButton;
    pnlOutput: TPanel;
    gXRot: TGauge;
    lblRotX: TLabel;
    lblRotZ: TLabel;
    gZRot: TGauge;
    lblRotY: TLabel;
    gYRot: TGauge;
    gXTra: TGauge;
    lblXTra: TLabel;
    lblZTra: TLabel;
    gZTra: TGauge;
    lblYTra: TLabel;
    gYTra: TGauge;
    Label1: TLabel;
    gSlider: TGauge;
    Label2: TLabel;
    gWheel: TGauge;
    Label3: TLabel;
    gDial: TGauge;
    lblhat: TLabel;
    lblHatVal: TLabel;
    lbbtn: TLabel;
    lblBtnVal: TLabel;
    tmrConnect: TTimer;
    procedure HidCtlJoyDeviceCreateError(Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo; var Handled, RetryCreate: Boolean);
    procedure HidCtlJoyDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
    procedure HidCtlJoyDeviceDataError(HidDev: TJvHidDevice; Error: Cardinal);
    function HidCtlJoyEnumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrConnectTimer(Sender: TObject);
  private
    FCurrentDeviceJoy: TJvHidDevice;
    procedure Log(AMsg: string);
    procedure ResetHIDJoy;
    procedure Disconnect;
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

procedure TfrmMain.btnDisconnectClick(Sender: TObject);
begin
  Disconnect;
end;

procedure TfrmMain.Log(AMsg: string);
begin
  memLog.Lines.Add(AMsg);
end;

procedure TfrmMain.btn1Click(Sender: TObject);
begin
  caption := '';
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

procedure TfrmMain.Disconnect;
begin
  if Assigned(FCurrentDeviceJoy) then
  begin
    Log('Disconnecting...');
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
  Handled := True;
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
  end;
  Result := True;
end;

procedure TfrmMain.HidCtlJoyDeviceDataError(HidDev: TJvHidDevice; Error: Cardinal);
begin
  Log('** HidCtlJoyDeviceDataError: ' + SysErrorMessage(Error));
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

procedure TfrmMain.HidCtlJoyDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
var
i: Integer;
FJoyState: TDriverDataJoy;
begin
  if HidDev <> FCurrentDeviceJoy then exit;
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

end.
