unit uKeyboardUtils;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, DateUtils, Types, StrUtils,
  ShellAPI, Forms;

type
  TTTCKeyboardUtils = class
  private
    FModifiers: TStrings;
    FKeys: TStrings;
    procedure AddKeyKeycodes;
    procedure AddModifierKeycodes;
  public
    constructor Create;
    destructor Destroy; override;
    function AppActivate(const AName: string; APauseAfterActivation: Integer): Boolean;
    function GetModifierKeycode(AModifier: string): Byte;
    function GetKeyKeycode(AModifier: string): Byte;
  end;


implementation

constructor TTTCKeyboardUtils.Create;
begin
  FModifiers := TStringlist.Create;
  FKeys := TStringlist.Create;
  AddModifierKeycodes;
  AddKeyKeycodes;
end;

destructor TTTCKeyboardUtils.Destroy;
begin
  FModifiers.Free;
  FKeys.Free;
  inherited;
end;

//this will bring the AName app to the foreground.
//some apps take a while to respond after activation, so use the APauseAfterActivation for this
//best to run this function in a thread so the Sleep doesn't freez the app
function TTTCKeyboardUtils.AppActivate(const AName: string; APauseAfterActivation: Integer): Boolean;
var
wnd1, wnd: HWND;
WinCaptionEx: array [0..MAX_PATH] of Char;
begin
  Result := False;
  if AName <> '' then
  begin
    //is it already the foreground window?
    wnd1 := GetForeGroundWindow;
    GetWindowText(wnd1, WinCaptionEx, SizeOf(WinCaptionEx));
    if WinCaptionEx = AName then
    begin
      Result := True;
      Exit;
    end;
    if WinCaptionEx <> AName then
    begin
      wnd := FindWindow(nil, Pchar(AName));
      if wnd <> 0 then
      begin
        SetForegroundwindow(wnd);
        Sleep(APauseAfterActivation);
        Result := True;
      end;
    end;
  end;
end;


function TTTCKeyboardUtils.GetModifierKeycode(AModifier: string): Byte;
begin
  Result := FModifiers.IndexOf(AModifier);
end;

//keys must be converted to keystrokes
//this is based specs in /common/hut1_12v2.pdf
//special keycodes for modifiers like shift and control
procedure TTTCKeyboardUtils.AddModifierKeycodes;
begin
  with (FModifiers as TStringlist) do
  begin
    //the [ and ] and text is arbitrary. You can call the modifiers whatever you like, as long as the list order is preserved
    Add('[LCTRL]');
    Add('[LSHIFT]');
    Add('[LALT]');
    Add('[LWIN]');
    Add('[RCTRL]');
    Add('[RSHIFT]');
    Add('[RALT]');
    Add('[RWIN]');
  end;
end;

function TTTCKeyboardUtils.GetKeyKeycode(AModifier: string): Byte;
begin
  Result := FKeys.IndexOf(AModifier);
end;

//and special keycodes for non-modifer keys
procedure TTTCKeyboardUtils.AddKeyKeycodes;
begin
  //from page 54 of HID Keyboard Usage specs
  with (FKeys as TStringlist) do
  begin
    //the use of upper and lowercase here is arbitrary. You can call the keys whatever you like, as long as the list order is preserved
    Add('');
    Add('');
    Add('');
    Add('');
    Add('a');
    Add('b');
    Add('c');
    Add('d');
    Add('e');
    Add('f');
    Add('g');
    Add('h');
    Add('i');
    Add('j');
    Add('k');
    Add('l');
    Add('m');
    Add('n');
    Add('o');
    Add('p');
    Add('q');
    Add('r');
    Add('s');
    Add('t');
    Add('u');
    Add('v');
    Add('w');
    Add('x');
    Add('y');
    Add('z');
    Add('1');
    Add('2');
    Add('3');
    Add('4');
    Add('5');
    Add('6');
    Add('7');
    Add('8');
    Add('9');
    Add('0');
    Add('ENTER');
    Add('ESCAPE');
    Add('BACKSPACE');
    Add('TAB');
    Add('SPACEBAR');
    Add('-');
    Add('=');
    Add('[');
    Add(']');
    Add('\');
    Add('');
    Add(';');
    Add('''');
    Add('`');
    Add(',');
    Add('.');
    Add('/');
    Add('CAPSLOCK');
    Add('F1');
    Add('F2');
    Add('F3');
    Add('F4');
    Add('F5');
    Add('F6');
    Add('F7');
    Add('F8');
    Add('F9');
    Add('F10');
    Add('F11');
    Add('F12');
    Add('PRINTSCREEN');
    Add('SCROLLLOCK');
    Add('PAUSE');
    Add('INSERT');
    Add('HOME');
    Add('PAGEUP');
    Add('DELETE');
    Add('END');
    Add('PAGEDOWN');
    Add('RIGHTARROW');
    Add('LEFTARROW');
    Add('DOWNARROW');
    Add('UPARROW');
    Add('NUMLOCK');
    Add('K/');
    Add('K*');
    Add('K-');
    Add('K+');
    Add('KENTER');
    Add('K1');
    Add('K2');
    Add('K3');
    Add('K4');
    Add('K5');
    Add('K6');
    Add('K7');
    Add('K8');
    Add('K9');
    Add('K0');
    Add('K.');
    Add('F13');
    Add('F14');
    Add('F15');
    Add('F16');
    Add('F17');
    Add('F18');
    Add('F19');
    Add('F20');
    Add('F21');
    Add('F22');
    Add('F23');
    Add('F24'); //115
  end;
end;




end.
