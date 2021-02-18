# hvdk
The HVDK is a Windows SDK that allows you to send data to Tetherscript's Virtual HID Keyboard, Joystick, Mouse and Gamepad drivers.  These are the same drivers used by Tetherscript's ControlMyJoystick program.

The Drivers are 64-bit only and must be installed only on Windows 7, 8, 8.1 or 10 64bit.  The drivers will not work on 32-bit Windows operating systems.

These examples were created on Delphi 10.1 Berlin (32-bit builds) and Visual Studio in C# .Net 3.5/4.72 (with 64-bit builds).  These examples require that the HVDK Standard or Professional drivers are installed.  They are available from https://www.tetherscript.com/hid-driver-kit-home/.  The driver source code has not and will not made available publicly.

You can find the SDK documentation at:

https://www.tetherscript.com/hid-driver-kit-kb/

Driver Licensing info is at:

https://www.tetherscript.com/kbhid/hidkb-licensing/

In Summary, for HVDK Standard (free version) users:
- The user is granted permission to install HVDK Standard on any computers that the user or users’ organization owns.
- The user is not granted permission to redistribute the HVDK drivers.  This means that you can't include the actual drivers in your application .zip, installer or any other kind of redistributable package.  
- The developers of Non-Commercial Public Open Source software projects hosted on GitHub are granted permission to advise that their project requires HVDK Standard and that end-users of the project will need to download and install HVDK Standard from the Tetherscript HVDK Download page. The GitHub project page or help files must link directly to the Tetherscript HVDK Download page. The GitHub project page is not granted permission to host the HVDK Standard files or installer. We are happy to support the free and open source community, but also want to ensure that all users are getting official and secure HVDK Standard files.
