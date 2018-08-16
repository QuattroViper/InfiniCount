unit Begin_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmBegin = class(TForm)
    btnToLogin: TButton;
    btnToRegister: TButton;
    procedure btnToLoginClick(Sender: TObject);
    procedure btnToRegisterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBegin: TfrmBegin;

implementation

uses Login, Register, frmLoadingg;

{$R *.dfm}

procedure TfrmBegin.btnToLoginClick(Sender: TObject);
begin
frmBegin.Hide;
FrmLogin.Show;
end;

procedure TfrmBegin.btnToRegisterClick(Sender: TObject);
begin
frmBegin.Hide;
FrmRegister.Show;
end;

end.
