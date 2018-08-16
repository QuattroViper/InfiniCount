program InfiniCount_p;

uses
  Forms,
  Register in 'Register.pas' {FrmRegister},
  Login in 'Login.pas' {FrmLogin},
  Main in 'Main.pas' {frmMain},
  Transaction in 'Transaction.pas' {frmTrans},
  Begin_u in 'Begin_u.pas' {frmBegin},
  Category in 'Category.pas' {FrmCategory},
  Connection in 'Connection.pas' {Form1},
  Connection2 in 'Connection2.pas' {Connection2A},
  Idees in 'Idees.pas',
  Warning in 'Warning.pas' {frmWarning},
  frmLoadingg in 'frmLoadingg.pas' {frmLoading},
  TClass in 'TClass.pas',
  admin in 'admin.pas' {frmAdmin},
  Timer in 'Timer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'InfiniCount';
  Application.CreateForm(TFrmRegister, FrmRegister);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmTrans, frmTrans);
  Application.CreateForm(TfrmBegin, frmBegin);
  Application.CreateForm(TFrmCategory, FrmCategory);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TConnection2A, Connection2A);
  Application.CreateForm(TfrmWarning, frmWarning);
  Application.CreateForm(TfrmLoading, frmLoading);
  Application.CreateForm(TfrmAdmin, frmAdmin);
  Application.Run;
end.
