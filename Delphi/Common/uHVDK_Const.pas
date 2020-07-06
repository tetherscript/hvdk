unit uHVDK_Const;

interface

const
  // GAMEPAD --------------------------------------------------------
  HIDDEV_PRODUCTNAME_GAMEPAD = 'Tetherscript Virtual Gamepad';
  GAMEPADRANGE_HIGH = $FFFF;
  GAMEPADRANGE_MID = $7FFF;
  GAMEPADRANGE_LOW = $0000;

  // JOYSTICK --------------------------------------------------------
  HIDDEV_PRODUCTNAME_JOY = 'Tetherscript Virtual Joystick';
  JOYRANGE_HIGH = $7FFF;
  JOYRANGE_MID = $3FFF;
  JOYRANGE_LOW = $0000;
  MAX_BUTTONS = 128;

  // MOUSE -----------------------------------------------------------
  HIDDEV_PRODUCTNAME_MOUSEABS = 'Tetherscript Virtual Mouse Abs';
  HIDDEV_PRODUCTNAME_MOUSEREL = 'Tetherscript Virtual Mouse Rel';

  // KEYBOARD---------------------------------------------------------
  HIDDEV_PRODUCTNAME_KEYBOARD = 'Tetherscript Virtual Keyboard';

implementation

end.
