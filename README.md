HVDK Discontinued as of Dec. 5, 2022.

The HID Virtual Driver Kit has now been discontinued. Supporting the kit in the future is problematic for the following reasons.

- Microsoft continues to lock down access to Windows driver configuration. This has been ongoing since Windows 8, but now with Windows 11, 11S and upcoming releases of Windows, it will become very costly for the certificates needed to sign the HVDK drivers. We expect that soon, you just won’t be able to install drivers like these (HID emulators).

- The drivers were coded with Visual Studio 2013 and Microsoft has made it extremely challenging to get these to compile on newer Visual Studio releases.

For current customers of the paid version of the kit (HVDK Professional), the signed drivers will continue to be install-able until spring 2023. At that point, the drivers can’t be installed due to the certificate expiry. Drivers installed previous to this date will continue to work without issue past the driver certificate expiry date.

You can still obtain the Tetherscript-signed drivers by downloading ControlMyJoystick 14-day free trial. The drivers will continue to work even if you do not purchase ControlMyJoystick. There is no longer a standalone drivers download available.

We’ll continue to keep the knowledge base, Github and forums available.  We will continue to offer tech support for our customers who purchased the HVDK.

We may release the driver source in the future, but have not decided on that yet.

Russ at Tetherscript

------------

# hvdk (edited Dec. 5, 2022 to reflect HVDK commercial discontinuance)
The HVDK is a Windows SDK that allows you to send data to Tetherscript's Virtual HID Keyboard, Joystick, Mouse and Gamepad drivers.  These are the same drivers used by Tetherscript's ControlMyJoystick program.

The Drivers are 64-bit only and must be installed only on Windows 7, 8, 8.1 or 10 64bit.  The drivers will not work on 32-bit Windows operating systems.

These examples were created on Delphi 10.1 Berlin (32-bit builds) and Visual Studio in C# .Net 3.5/4.72 (with 64-bit builds).  These examples require that the HVDK Standard drivers are installed and are available as part of the installation of the free trial ControlMyJoystick at tetherscript.com.  No purchase is necessary to use these drivers for your own projects.  However, you cannot redistribute the drivers.

You can find the SDK documentation at:

https://www.tetherscript.com/hid-driver-kit-kb/
