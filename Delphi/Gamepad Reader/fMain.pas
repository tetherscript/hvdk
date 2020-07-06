unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvComponentBase, JvHidControllerClass, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ComCtrls, Vcl.ToolWin;

type
  TfrmMain = class(TForm)
    HidCtlGamepad: TJvHidDeviceController;
    memLog: TMemo;
    Panel1: TPanel;
    btnConnect: TButton;
    btnDisconnect: TButton;
    pnlOutput: TPanel;
    gXRot: TGauge;
    lblRotX: TLabel;
    lblRotY: TLabel;
    gYRot: TGauge;
    gXTra: TGauge;
    lblXTra: TLabel;
    lblZTra: TLabel;
    gZTra: TGauge;
    lblYTra: TLabel;
    gYTra: TGauge;
    lblhat: TLabel;
    lblHatVal: TLabel;
    lbbtn: TLabel;
    lblBtnVal: TLabel;
    tmrConnect: TTimer;
    procedure HidCtlGamepadDeviceCreateError(Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo; var Handled, RetryCreate: Boolean);
    procedure HidCtlGamepadDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
    procedure HidCtlGamepadDeviceDataError(HidDev: TJvHidDevice; Error: Cardinal);
    function HidCtlGamepadEnumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrConnectTimer(Sender: TObject);
  private
    FCurrentDeviceGamepad: TJvHidDevice;
    procedure Log(AMsg: string);
    procedure ResetHIDGamepad;
    procedure Disconnect;
    function IsBitSet(const AValueToCheck, ABitIndex: Integer): Boolean;
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
  //always disconnect before shutting down app or you can leave the gamepad driver with strange axis position or button states
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
  if not assigned(FCurrentDeviceGamepad) then
  begin
    Log('Connecting...');
    //this is how we tell it to go find our driver
    HidCtlGamepad.Enumerate;
  end
  else
    Log('Already connected.');
end;

procedure TfrmMain.Disconnect;
begin
  if Assigned(FCurrentDeviceGamepad) then
  begin
    Log('Disconnecting...');
    //if we have checked out a gamepad, check it in since we are done with it
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
  Handled := True;
end;

function TfrmMain.HidCtlGamepadEnumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
begin
  //here we are iterating through all the HID Devices and matching the product name
  //on some computers with strange driver configurations, each call to .ProductName can take 5-10 seconds
  //I have fixed this before by deleting hidden and unused drivers in the Device Manager then rebooting, but
  //be aware that this may not be the best way to deal with this problem.  You might also try comparing the GUID, which may
  //be faster. This is a known issue and is a bug in Windows.
  if HidDev.ProductName = HIDDEV_PRODUCTNAME_GAMEPAD then
  //if HidDev.ProductName = 'Controller (Gamepad F310)' then
  begin
    Log('Found ' + HIDDEV_PRODUCTNAME_GAMEPAD + ' driver.');
    HidCtlGamepad.CheckOutByIndex(FCurrentDeviceGamepad, Idx);
    ResetHIDGamepad;
    Result := False;
    exit;
  end;
  Result := True;
end;

procedure TfrmMain.HidCtlGamepadDeviceDataError(HidDev: TJvHidDevice; Error: Cardinal);
begin
  Log('** HidCtlGamepadDeviceDataError: ' + SysErrorMessage(Error));
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

procedure TfrmMain.tmrConnectTimer(Sender: TObject);
begin
  tmrConnect.Enabled := False;
  btnConnectClick(nil);
end;

procedure TfrmMain.HidCtlGamepadDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
var
b: string;
i: Integer;
h: Byte;
FGamepadState: TDriverDataGamepad;
begin
  if HidDev <> FCurrentDeviceGamepad then exit;
  CopyMemory(@FGamepadState, Data, Size);
  //each axis has a value of 0 to 32766
  gXRot.Progress := FGamepadState.rX;
  gYRot.Progress := FGamepadState.rY;
  gXTra.Progress := FGamepadState.X;
  gYTra.Progress := FGamepadState.Y;
  gZTra.Progress := FGamepadState.Z;
  //buttons states are in a ten bit array.  You can have more than one button pressed simultaneously
  b := '';
  if IsBitSet(FGamepadState.buttons[0], 0) then b := b + '1 ';
  if IsBitSet(FGamepadState.buttons[0], 1) then b := b + '2 ';
  if IsBitSet(FGamepadState.buttons[0], 2) then b := b + '3 ';
  if IsBitSet(FGamepadState.buttons[0], 3) then b := b + '4 ';
  if IsBitSet(FGamepadState.buttons[0], 4) then b := b + '5 ';
  if IsBitSet(FGamepadState.buttons[0], 5) then b := b + '6 ';
  if IsBitSet(FGamepadState.buttons[0], 6) then b := b + '7 ';
  if IsBitSet(FGamepadState.buttons[0], 7) then b := b + '8 ';
  if IsBitSet(FGamepadState.buttons[1], 0) then b := b + '9 ';
  if IsBitSet(FGamepadState.buttons[1], 1) then b := b + '10 ';
  if b = '' then b := '-';
  lblBtnVal.Caption := Trim(b);
  //the current hat state is in a 5 bit array.
  h := FGamepadState.buttons[1] and not 3;
  b := inttostr(Trunc(h / 4));
  if b = '0' then b := '-';
  lblHatVal.Caption := b;
end;

function TfrmMain.IsBitSet(const AValueToCheck, ABitIndex: Integer): Boolean;
begin
  Result := AValueToCheck and (1 shl ABitIndex) <> 0;
end;

end.
