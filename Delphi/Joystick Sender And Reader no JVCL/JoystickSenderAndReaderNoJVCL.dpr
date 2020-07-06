program JoystickSenderAndReaderNoJVCL;

uses
  //FastMM4,
  Vcl.Forms,
  fMain in 'fMain.pas' {frmMain},
  ttcHidController in '..\Common\ttcHidController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
