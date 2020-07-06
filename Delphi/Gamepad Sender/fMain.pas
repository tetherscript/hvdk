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
    HidCtlGamepad: TJvHidDeviceController;
    lblRotX: TLabel;
    lblRotY: TLabel;
    lblZTra: TLabel;
    lblYTra: TLabel;
    lblXTra: TLabel;
    pbRx: TTrackBar;
    tmrSendGamepadData: TTimer;
    pbRy: TTrackBar;
    pbX: TTrackBar;
    pbY: TTrackBar;
    pbZ: TTrackBar;
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
    ToolButton5: TToolButton;
    lblHat: TLabel;
    tmrConnect: TTimer;
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure HidCtlGamepadDeviceCreateError(Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo; var Handled, RetryCreate: Boolean);
    procedure HidCtlGamepadDeviceDataError(HidDev: TJvHidDevice; Error: Cardinal);
    function HidCtlGamepadEnumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
    procedure HidCtlGamepadDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
    procedure tmrSendGamepadDataTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrConnectTimer(Sender: TObject);
  private
    FCurrentDeviceGamepad: TJvHidDevice;
    procedure Disconnect;
    procedure Log(AMsg: string);
    procedure ResetHIDGamepad;
    procedure SendGamepad;
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
  //we'll use this as a reference to the Gamepad later
  FCurrentDeviceGamepad := nil;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Width := Width + 10;  //to fix tmemo wordwrap issues
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //always disconnect before shutting down app or you can leave the Gamepad driver with strange axis position or button states
  Disconnect;
end;

procedure TfrmMain.Log(AMsg: string);
begin
  memLog.Lines.Add(AMsg);
end;

procedure TfrmMain.btnConnectClick(Sender: TObject);
begin
  if not assigned(FCurrentDeviceGamepad) then
  begin
    Log('Connecting...');
    //this is how we tell it to go find our driver
    HidCtlGamepad.Enumerate;
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
  if Assigned(FCurrentDeviceGamepad) then
  begin
    tmrSendGamepadData.Enabled := False;
    Log('Disconnecting...');
    //this is how we tell it to reset axis to neutral position and all hat and buttons to unpressed.
    ResetHIDGamepad;
    //if we have checked out a Gamepad, check it in since we are done with it
    if assigned(FCurrentDeviceGamepad) then
      if FCurrentDeviceGamepad.IsCheckedOut then HidCtlGamepad.Checkin(FCurrentDeviceGamepad);
    FCurrentDeviceGamepad := nil;
    Log('Disconnected.');
  end
  else
  begin
    Log('Already disconnected.');
  end;
end;

procedure TfrmMain.HidCtlGamepadDeviceCreateError(Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo; var Handled, RetryCreate: Boolean);
begin
  //this can happen on computers with that have drivers that can't be opened (they are readonly).  Rare, but it happens
  Log('** HidCtlGamepadDeviceCreateError: ' + PNPInfo.DeviceDescr + ': ' + PNPInfo.ClassDescr + ': ' + PNPInfo.DevicePath);
  Handled := True
end;

procedure TfrmMain.HidCtlGamepadDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
begin
  //we don't use this since we are just sending date to the driver.  We could use it though to see what the driver is sending out
  //instead for now, use the Reader program so we know a separate program can read the output.
end;

procedure TfrmMain.HidCtlGamepadDeviceDataError(HidDev: TJvHidDevice; Error: Cardinal);
begin
  Log('** HidCtlGamepadDeviceDataError: ' + SysErrorMessage(Error));
end;

function TfrmMain.HidCtlGamepadEnumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
begin
  Result := False;
  //here we are iterating through all the HID Devices and matching the product name
  //on some computers with strange driver configurations, each call to .ProductName can take 5-10 seconds
  //I have fixed this before by deleting hidden and unused drivers in the Device Manager then rebooting, but
  //be aware that this may not be the best way to deal with this problem.  You might also try comparing the GUID, which may
  //be faster. This is a known issue and is a bug in Windows.
  if HidDev.ProductName = HIDDEV_PRODUCTNAME_GAMEPAD then
  begin
    Log('Found ' + HIDDEV_PRODUCTNAME_GAMEPAD + ' driver.');
    HidCtlGamepad.CheckOutByIndex(FCurrentDeviceGamepad, Idx);
    ResetHIDGamepad;
    tmrSendGamepadData.Enabled := True;
    Exit;
  end;
  Result := True;
end;

procedure TfrmMain.ResetHIDGamepad;
var
Feature: TSetFeatureGamepad;
i: Integer;
begin
  if Assigned(FCurrentDeviceGamepad) then
  begin
    try
      ZeroMemory(@Feature, SizeOf(Feature));
      Feature.ReportID := 1;
      Feature.CommandCode := 1;
      Feature.X := GAMEPADRANGE_MID;
      Feature.Y := GAMEPADRANGE_MID;
      Feature.RX := GAMEPADRANGE_MID;
      Feature.RY := GAMEPADRANGE_MID;
      Feature.Z := GAMEPADRANGE_MID;
      Feature.Buttons[0] := 0;
      Feature.Buttons[1] := 0;
      FCurrentDeviceGamepad.SetFeature(Feature, SizeOf(Feature) + 1);
    finally
      Log('Gamepad driver reset.');
    end;
  end;
end;

procedure TfrmMain.SendGamepad;
var
Feature: TSetFeatureGamepad;
i: Integer;
btns0, btns15: Byte;
begin
  if Assigned(FCurrentDeviceGamepad) then
  begin
    ZeroMemory(@Feature, SizeOf(Feature));
    Feature.ReportID := 1;
    Feature.CommandCode := 2;
    Feature.X := Word(pbX.Position);
    Feature.Y := Word(pbY.Position);
    Feature.rX := Word(pbRx.Position);
    Feature.rY := Word(pbRy.Position);
    Feature.Z := Word(pbZ.Position);
    //clear the buttons
    Feature.buttons[0] := 0;
    Feature.buttons[1] := 0;
    Feature.padding[0] := 0;
    Feature.padding[1] := 0;

    //fix the button and hat sender code here
    //now set the bits in the button byte array to correspond to this example
   // if btn1.Down then btns0 := 1;
   // if btn2.Down then btns0 := btns0 or 2;
   // if btn3.Down then btns0 := btns0 or 4;
   // if btn4.Down then btns0 := btns0 or 8;
   // if btn5.Down then btns0 := btns0 or 16;
   // if btn6.Down then btns0 := btns0 or 32;
    //this appears as button array byte zero in the reader program
    //Feature.buttons[0] := btns0;
    //now set the feature with the data
    FCurrentDeviceGamepad.SetFeature(Feature, SizeOf(Feature) + 1);
  end;
end;

procedure TfrmMain.tmrConnectTimer(Sender: TObject);
begin
  tmrConnect.Enabled := False;
  btnConnectClick(nil);
end;

procedure TfrmMain.tmrSendGamepadDataTimer(Sender: TObject);
begin
  if Assigned(FCurrentDeviceGamepad) then
  begin
    try
      tmrSendGamepadData.Enabled := False;
      SendGamepad;
    finally
      tmrSendGamepadData.Enabled := True;
    end;
  end;
end;

end.
