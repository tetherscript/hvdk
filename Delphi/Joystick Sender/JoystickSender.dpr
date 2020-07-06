program JoystickSender;

uses
  Vcl.Forms,
  fMain in 'fMain.pas' {frmMain},
  uHVDK_Types in '..\Common\uHVDK_Types.pas',
  uHVDK_Const in '..\Common\uHVDK_Const.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
