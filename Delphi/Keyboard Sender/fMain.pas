unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, JvComponentBase, JvHidControllerClass, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Samples.Spin, uKeyboardUtils;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    btnConnect: TButton;
    btnDisconnect: TButton;
    pnlOutput: TPanel;
    memLog: TMemo;
    HidCtlKeyboard: TJvHidDeviceController;
    tmrPing: TTimer;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    tmrConnect: TTimer;
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure HidCtlKeyboardDeviceCreateError(Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo; var Handled, RetryCreate: Boolean);
    procedure HidCtlKeyboardDeviceDataError(HidDev: TJvHidDevice; Error: Cardinal);
    function HidCtlKeyboardEnumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
    procedure HidCtlKeyboardDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
    procedure tmrPingTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrConnectTimer(Sender: TObject);
  private
    FCurrentDeviceKeyboard: TJvHidDevice;
    FTimeOut: Integer;
    KeyboardUtils: TTTCKeyboardUtils;
    procedure Disconnect;
    procedure Log(AMsg: string);
    procedure Ping;
    procedure ResetHIDKeyboard;
    procedure Send(AModifier, APadding, AKey0, AKey1, AKey2, AKey3, AKey4, AKey5: Byte);
    procedure SetTarget;
    procedure SendText(AText: string; ADown, AInterkey: Integer);
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
  FCurrentDeviceKeyboard:= nil;
  KeyboardUtils := TTTCKeyboardUtils.Create;
  FTimeOut := 1000; //in milliseconds, used to prevent endless keystrokes if a release is not sent by user.
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Width := Width + 10;  //to fix tmemo wordwrap issues
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //always disconnect before shutting down app.
  Disconnect;
  KeyboardUtils.Free;
end;

procedure TfrmMain.Log(AMsg: string);
begin
  memLog.Lines.Add(AMsg);
end;

procedure TfrmMain.btnConnectClick(Sender: TObject);
begin
  if not assigned(FCurrentDeviceKeyboard) then
  begin
    Log('Connecting...');
    //this is how we tell it to go find our driver
    HidCtlKeyboard.Enumerate;
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
  if Assigned(FCurrentDeviceKeyboard) then
  begin
    Log('Disconnecting...');
    //this is how we tell it to release all key presses
    tmrPing.Enabled := False;
    ResetHIDKeyboard;
    //if we have checked out a joystick, check it in since we are done with it
    if assigned(FCurrentDeviceKeyboard) then
      if FCurrentDeviceKeyboard.IsCheckedOut then HidCtlKeyboard.Checkin(FCurrentDeviceKeyboard);
    FCurrentDeviceKeyboard := nil;
    Log('Disconnected.');
  end
  else
  begin
    Log('Already disconnected.');
  end;
end;

procedure TfrmMain.HidCtlKeyboardDeviceCreateError(Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo; var Handled, RetryCreate: Boolean);
begin
  //this can happen on computers with that have drivers that can't be opened (they are readonly).  Rare, but it happens
  Log('** HidCtlKeyboardDeviceCreateError: ' + PNPInfo.DeviceDescr + ': ' + PNPInfo.ClassDescr + ': ' + PNPInfo.DevicePath);
  Handled := True
end;

procedure TfrmMain.HidCtlKeyboardDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
begin
  //we don't use this since we are just sending data to the driver.
end;

procedure TfrmMain.HidCtlKeyboardDeviceDataError(HidDev: TJvHidDevice; Error: Cardinal);
begin
  Log('** HidCtlKeyboardDeviceDataError: ' + SysErrorMessage(Error));
end;

function TfrmMain.HidCtlKeyboardEnumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
begin
  Result := False;
  //here we are iterating through all the HID Devices and matching the product name
  //on some computers with strange driver configurations, each call to .ProductName can take 5-10 seconds
  //I have fixed this before by deleting hidden and unused drivers in the Device Manager then rebooting, but
  //be aware that this may not be the best way to deal with this problem.  You might also try comparing the GUID, which may
  //be faster. This is a known issue and is a bug in Windows.
  if HidDev.ProductName = HIDDEV_PRODUCTNAME_KEYBOARD then
  begin
    Log('Found ' + HIDDEV_PRODUCTNAME_KEYBOARD + ' driver.');
    HidCtlKeyboard.CheckOutByIndex(FCurrentDeviceKeyboard, Idx);
    ResetHIDKeyboard;
    tmrPing.Enabled := True;
  end;
  Result := True;
end;

procedure TfrmMain.tmrPingTimer(Sender: TObject);
begin
  try
    tmrPing.Enabled := False;
    Ping;  //try disabling this and then send some text.  It will stop sending after FTimeout.
  finally
    tmrPing.Enabled := True;
  end;
end;

procedure TfrmMain.Ping;
var
Feature: TSetFeatureKeyboard;
i: Integer;
begin
  if Assigned(FCurrentDeviceKeyboard) then
  begin
    try
      ZeroMemory(@Feature, SizeOf(Feature));
      Feature.ReportID := 1;
      Feature.CommandCode := 3;
      //the timeout is how long the driver will wait (milliseconds) without receiving a ping before resetting itself
      //we'll be pinging every 200ms, and the timeout calculates to 1000ms here.
      //No more stuck keys requiring reboot to clear.
      Feature.timeout := FTimeout;
      Feature.modifier := 0;
      Feature.padding := 0;
      Feature.key0 := 0;
      Feature.key1 := 0;
      Feature.key2 := 0;
      Feature.key3 := 0;
      Feature.key4 := 0;
      Feature.key5 := 0;
      FCurrentDeviceKeyboard.SetFeature(Feature, SizeOf(Feature) + 1);
    finally

    end;
  end;
end;

procedure TfrmMain.ResetHIDKeyboard;
var
Feature: TSetFeatureKeyboard;
i: Integer;
begin
  if Assigned(FCurrentDeviceKeyboard) then
  begin
    try
      ZeroMemory(@Feature, SizeOf(Feature));
      Feature.ReportID := 1;
      Feature.CommandCode := 1;
      Feature.timeout := FTimeout;
      Feature.modifier := 0;
      Feature.padding := 0;
      Feature.key0 := 0;
      Feature.key1 := 0;
      Feature.key2 := 0;
      Feature.key3 := 0;
      Feature.key4 := 0;
      Feature.key5 := 0;
      FCurrentDeviceKeyboard.SetFeature(Feature, SizeOf(Feature) + 1);
    finally
      Log('Keyboard Driver reset.');
    end;
  end;
end;

procedure TfrmMain.Send(AModifier, APadding, AKey0, AKey1, AKey2, AKey3, AKey4, AKey5: Byte);
var
Feature: TSetFeatureKeyboard;
sX, sY, sBtn: string;
begin
  if Assigned(FCurrentDeviceKeyboard) then
  begin
    ZeroMemory(@Feature, SizeOf(Feature));
    Feature.ReportID := 1;
    Feature.CommandCode := 2;
    Feature.timeout := FTimeout;
    Feature.modifier := AModifier;
    //padding should always be zero.
    Feature.padding := APadding;
    Feature.key0 := AKey0;
    Feature.key1 := AKey1;
    Feature.key2 := AKey2;
    Feature.key3 := AKey3;
    Feature.key4 := AKey4;
    Feature.key5 := AKey5;
    FCurrentDeviceKeyboard.SetFeature(Feature, SizeOf(Feature) + 1);
  end;
end;

procedure TfrmMain.SetTarget;
begin
  //set the focus to something that can receive the text from the driver.
  KeyboardUtils.AppActivate('Tetherscript Virtual Keyboard Driver Reader', 500);
  //memLog.SetFocus; //could do this instead of using the reader program
end;

procedure TfrmMain.tmrConnectTimer(Sender: TObject);
begin
  tmrConnect.Enabled := False;
  btnConnectClick(nil);
end;

//EXAMPLES -------------------------------------------------------------

procedure TfrmMain.Button1Click(Sender: TObject);
var
  k: Byte;
begin
  SetTarget;
  //here we resolved the 'a' to be a keycode of 4 by using the keycode list
  k := KeyboardUtils.GetKeyKeycode('a');
  if k > -1 then
  begin
    Send(0, 0, k, 0, 0, 0, 0, 0);
    //keep the key pressed for this many ms.  If you hold it down for a long time, it will activate the OS key repeat function
    sleep(50);
    //we'll release the 'a' key by no longer including it in the pressed key list
    Send(0, 0, 0, 0, 0, 0, 0, 0);
  end;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
var
  k: Byte;
begin
  SetTarget;
  //here we resolved the 'a' to be a keycode of 4 by using the keycode list
  k := KeyboardUtils.GetKeyKeycode('a');
  if k > -1 then
  begin
    Send(0, 0, k, 0, 0, 0, 0, 0);
    //keep the key pressed for this many ms.  If you hold it down for a long time, it will activate the OS key repeat function
    sleep(2000);
    //we'll release the 'a' key by no longer including it in the pressed key list
    Send(0, 0, 0, 0, 0, 0, 0, 0);
  end;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
var
  k1, k2: Byte;
begin
  SetTarget;
  k1 := KeyboardUtils.GetKeyKeycode('a');
  k2 := KeyboardUtils.GetKeyKeycode('b');
  if k1 > -1 then
  begin
    //you can press up to six keys (not including modifiers) simultaneously.
    Send(0, 0, k1, k2, 0, 0, 0, 0);
    //keep the key pressed for this many ms.  If you hold it down for a long time, it will activate the OS key repeat function
    sleep(50);
    //we'll release the 'a' and 'b' key by no longer including it in the pressed key list
    Send(0, 0, 0, 0, 0, 0, 0, 0);
  end;
end;

procedure TfrmMain.Button4Click(Sender: TObject);
begin
  SendText('Hello', 50, 100);
end;

procedure TfrmMain.SendText(AText: string; ADown, AInterkey: Integer);
var
i, k1, m1: Byte;
s, s1: string;
m: Integer;
begin
  SetTarget;
  //we will put each character in the key0 slot, wait a bit, clear the slot, wait a bit and then do the next letter
  s := AText;
  //iterate through the text.  We'll send one character at a time
  for i := 1 to Length(s) do
  begin
    s1 := s[i];
    //check for modifiers
    if s1 = Uppercase(s1) then
    begin
      //it is capitalized, so get the modifier keycode
      m := KeyboardUtils.GetModifierKeycode('[LSHIFT]');
      if m = -1 then m := 0;
    end
    else
    begin
      //no modifier needed
      m := -1;
    end;
    //the modifier is represented by bit positions in a single byte
    //in this example we are allowing only one modifier to be pressed
    //but you could have something like a LALT-LSHIFT-A sequence which means
    //that you would need to set the bit for LALT, then OR that with LSHIFT to give a value of 6
    //calc the modifier
    case m of
        0: m1 := 1;
        1: m1 := 2;
        2: m1 := 4;
        3: m1 := 8;
        4: m1 := 16;
        5: m1 := 32;
        6: m1 := 64;
        7: m1 := 128;
      else
        m1 := 0;
    end;

    //the keycode is the same whether it is capitalized or not
    k1 := KeyboardUtils.GetKeyKeycode(Lowercase(s1));
    if k1 > -1 then
    begin
      //pressing the key down
      Send(m1, 0, k1, 0, 0, 0, 0, 0);
      //keep the key pressed for this many ms.
      sleep(ADown);
      //release the key
      Send(0, 0, 0, 0, 0, 0, 0, 0);
      //wait before sending the next key
      sleep(AInterkey);
    end;
  end;
end;

procedure TfrmMain.Button5Click(Sender: TObject);
var
k1: Integer;
begin
  SetTarget;
  //we'll need to send a CTRL-A simultaneously, then press the Delete key to clear the selected text.
  //for simplicity, we have pre-computed the values needed
  //Send LCTRL
  Send(1, 0, 0, 0, 0, 0, 0, 0);
  sleep(50);
  //wait a bit
  sleep(100);
  //Send A
  Send(1, 0, 4, 0, 0, 0, 0, 0);
  sleep(50);
  Send(0, 0, 0, 0, 0, 0, 0, 0);
  //wait a bit
  sleep(1000);
  //Send Delete
  Send(0, 0, 76, 0, 0, 0, 0, 0);
  sleep(50);
  Send(0, 0, 0, 0, 0, 0, 0, 0);
end;

procedure TfrmMain.Button6Click(Sender: TObject);
begin
  SetTarget;
  //press the 'a' key
  Send(0, 0, 4, 0, 0, 0, 0, 0);
  //whoops we forget to release it, so it will remain pressed.
  //shutting down the app will cause the driver to reset
  //since the driver is no longer being pinged
  //you'll need to comment out the Disconnect in FormCloseQuery since it is doing a reset of it's own to see this happen
  //the driver timeout will save you many headaches if your app doesn't properly close (crashes) while a key is pressed.
end;

end.
