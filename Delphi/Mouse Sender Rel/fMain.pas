unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, JvComponentBase, JvHidControllerClass, Vcl.ComCtrls, Vcl.Samples.Spin, Vcl.ToolWin;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    btnConnect: TButton;
    btnDisconnect: TButton;
    pnlOutput: TPanel;
    HidCtlMouse: TJvHidDeviceController;
    lblX: TLabel;
    lblY: TLabel;
    ToolBar1: TToolBar;
    btnLeft: TToolButton;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    btnMiddle: TToolButton;
    btnRight: TToolButton;
    ToolButton10: TToolButton;
    ToolButton14: TToolButton;
    spnX: TSpinEdit;
    spnY: TSpinEdit;
    btnSend: TButton;
    tmrRelease: TTimer;
    tmrConnect: TTimer;
    memLog: TMemo;
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure HidCtlMouseDeviceCreateError(Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo; var Handled, RetryCreate: Boolean);
    procedure HidCtlMouseDeviceDataError(HidDev: TJvHidDevice; Error: Cardinal);
    function HidCtlMouseEnumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
    procedure HidCtlMouseDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
    procedure btnSendClick(Sender: TObject);
    procedure tmrReleaseTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrConnectTimer(Sender: TObject);
  private
    FCurrentDeviceMouse: TJvHidDevice;
    procedure Disconnect;
    procedure Log(AMsg: string);
    procedure ResetHIDMouse;
    procedure SendMouseRel(AIgnoreMove: Boolean);
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
  //we'll use this as a reference to the mouse driver later
  FCurrentDeviceMouse := nil;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Width := Width + 10;  //to fix tmemo wordwrap issues
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //always disconnect before shutting down app.
  Disconnect;
end;

procedure TfrmMain.Log(AMsg: string);
begin
  //memLog.Lines.Add(AMsg);
  memLog.Lines.Add(AMsg);
end;

procedure TfrmMain.btnConnectClick(Sender: TObject);
begin
  if not assigned(FCurrentDeviceMouse) then
  begin
    Log('Connecting...');
    //this is how we tell it to go find our driver
    HidCtlMouse.Enumerate;
  end
  else
    Log('Already connected.');
end;

procedure TfrmMain.btnDisconnectClick(Sender: TObject);
begin
  Disconnect;
end;

procedure TfrmMain.Disconnect;
begin
  if Assigned(FCurrentDeviceMouse) then
  begin
    Log('Disconnecting...');
    //this is how we tell it to absolute position to center position and release mouse button presses.
    ResetHIDMouse;
    //if we have checked out a joystick, check it in since we are done with it
    if assigned(FCurrentDeviceMouse) then
      if FCurrentDeviceMouse.IsCheckedOut then HidCtlMouse.Checkin(FCurrentDeviceMouse);
    //reset the driver to neutral axis position and no buttons pressed so we leave it in good condition for next user
    ResetHIDMouse;
    FCurrentDeviceMouse := nil;
    Log('Disconnected.');
  end
  else
  begin
    Log('Already disconnected.');
  end;
end;

procedure TfrmMain.HidCtlMouseDeviceCreateError(Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo; var Handled, RetryCreate: Boolean);
begin
  //this can happen on computers with that have drivers that can't be opened (they are readonly).  Rare, but it happens
  Log('** HidCtlMouseDeviceCreateError: ' + PNPInfo.DeviceDescr + ': ' + PNPInfo.ClassDescr + ': ' + PNPInfo.DevicePath);
  Handled := True
end;

procedure TfrmMain.HidCtlMouseDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
begin
  //we don't use this since we are just sending data to the driver.
end;

procedure TfrmMain.HidCtlMouseDeviceDataError(HidDev: TJvHidDevice; Error: Cardinal);
begin
  Log('** HidCtlMouseDeviceDataError: ' + SysErrorMessage(Error));
end;

function TfrmMain.HidCtlMouseEnumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
begin
  Result := False;
  //here we are iterating through all the HID Devices and matching the product name
  //on some computers with strange driver configurations, each call to .ProductName can take 5-10 seconds
  //I have fixed this before by deleting hidden and unused drivers in the Device Manager then rebooting, but
  //be aware that this may not be the best way to deal with this problem.  You might also try comparing the GUID, which may
  //be faster. This is a known issue and is a bug in Windows.
  if HidDev.ProductName = HIDDEV_PRODUCTNAME_MOUSEREL then
  begin
    Log('Found ' + HIDDEV_PRODUCTNAME_MOUSEREL + ' driver.');
    HidCtlMouse.CheckOutByIndex(FCurrentDeviceMouse, Idx);
    ResetHIDMouse;
  end;
  Result := True;
end;


procedure TfrmMain.ResetHIDMouse;
var
Feature: TSetFeatureMouseAbs;
i: Integer;
begin
  //only reset the mouse when you absolutely need to, otherwise the user will notice the mouse jumping to center of screen
  //when the reset occurs.
  if Assigned(FCurrentDeviceMouse) then
  begin
    try
      ZeroMemory(@Feature, SizeOf(Feature));
      Feature.ReportID := 1;
      Feature.CommandCode := 1;
      Feature.Buttons := 0;
      Feature.X := 0;
      Feature.Y := 0;
      FCurrentDeviceMouse.SetFeature(Feature, SizeOf(Feature) + 1);
    finally
      Log('Mouse driver reset.');
    end;
  end;
end;

procedure TfrmMain.btnSendClick(Sender: TObject);
begin
  if Assigned(FCurrentDeviceMouse) then
  begin
    Log('Sending data to mouse rel driver...');
    SendMouseRel(False);
    //set a timer to release these buttons, othersize they will still be pressed
    //if you don't set a timer and the mouse buttons are stuck down, just press those buttons on a real physical mouse to reset them.
    //if you don't, you'll be using alt-F4 and other tricks to get your app to shut down
    tmrRelease.Enabled := True;
  end;
end;

procedure TfrmMain.SendMouseRel(AIgnoreMove: Boolean);
var
Feature: TSetFeatureMouseRel;
sX, sY, sBtn: string;
btnval: Byte;
begin
  if Assigned(FCurrentDeviceMouse) then
  begin
    ZeroMemory(@Feature, SizeOf(Feature));
    Feature.ReportID := 1;
    Feature.CommandCode := 2;
    if AIgnoreMove then
    begin
      Feature.X := 0;
      Feature.Y := 0;
    end
    else
    begin
      Feature.X := Byte(spnX.Value);
      Feature.Y := Byte(spnY.Value);
    end;
    //calc button value
    btnval := 0;
    if btnLeft.Down then btnVal := 1;
    if btnRight.Down then btnVal := btnVal or 2;
    if btnMiddle.Down then btnVal := btnVal or 4;
    Feature.buttons := btnval;
    //send the data to the driver
    FCurrentDeviceMouse.SetFeature(Feature, SizeOf(Feature) + 1);
    Log('Data sent.');
  end;
end;

procedure TfrmMain.tmrConnectTimer(Sender: TObject);
begin
  tmrConnect.Enabled := False;
  btnConnectClick(nil);
end;

procedure TfrmMain.tmrReleaseTimer(Sender: TObject);
begin
  Log('Releasing mouse buttons..');
  tmrRelease.Enabled := False;
  btnLeft.Down := False;
  btnMiddle.Down := False;
  btnRight.Down := False;
  SendMouseRel(True);
end;

end.
