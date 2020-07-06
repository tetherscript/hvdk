unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmMain = class(TForm)
    memLog: TMemo;
    Panel1: TPanel;
    btnClear: TButton;
    procedure btnClearClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnClearClick(Sender: TObject);
begin
  memLog.Lines.Clear;
  memLog.SetFocus;
end;


procedure TfrmMain.FormActivate(Sender: TObject);
begin
  memLog.SetFocus;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Width := Width + 10;  //to fix tmemo wordwrap issues
end;

end.
