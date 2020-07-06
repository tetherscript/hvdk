unit uHVDK_Types;

interface

// GAMEPAD -----------------------------------------------------------
type
  PTSetFeatureGamepad = ^TSetFeatureGamepad;
  TSetFeatureGamepad = packed record
    ReportID: Byte;
    CommandCode: Byte;
    X: Word;
    Y: Word;
    rX: Word;
    rY: Word;
    Z: Word;
    buttons: array[0..1] of Byte;
    padding: array[0..1] of Byte;
end;

type
  PTDriverDataGamepad = ^TDriverDataGamepad;
  TDriverDataGamepad = packed record
    X: Word;
    Y: Word;
    rX: Word;
    rY: Word;
    Z: Word;
    buttons: array[0..1] of Byte;
    padding: array[0..1] of Byte;
end;

// JOYSTICK -----------------------------------------------------------    00000
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


// MOUSE -----------------------------------------------------------
type
  PTSetFeatureMouseAbs = ^TSetFeatureMouseAbs;
  TSetFeatureMouseAbs = packed record
    ReportID: Byte;
    CommandCode: Byte;
    buttons: byte;
    X: Word;
    Y: Word;
end;

type
  PTSetFeatureMouseRel = ^TSetFeatureMouseRel;
  TSetFeatureMouseRel = packed record
    ReportID: Byte;
    CommandCode: Byte;
    buttons: byte;
    X: Byte;
    Y: Byte;
end;

// KEYBOARD --------------------------------------------------------
type
  PTSetFeatureKeyboard = ^TSetFeatureKeyboard;
  TSetFeatureKeyboard = packed record
    ReportID: Byte;
    CommandCode: Byte;
    timeout: Longword;
    modifier: byte;
    padding: byte;
    key0: byte;
    key1: byte;
    key2: byte;
    key3: byte;
    key4: byte;
    key5: byte;
end;

type
  TButtonMovement = (bmPress = 0, bmRelease = 1);

type
  TKeyCode = record
    Movement: TButtonMovement;
    Key: string;
    Delay: Integer;
    TargetAppEnabled: Boolean;
    TargetApp: string;
    modifier: byte;
    padding: byte;
    key0: byte;
    key1: byte;
    key2: byte;
    key3: byte;
    key4: byte;
    key5: byte;
end;


implementation

end.
