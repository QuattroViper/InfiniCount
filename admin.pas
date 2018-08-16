unit admin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, Buttons, jpeg;

type
  TfrmAdmin = class(TForm)
    dbgrdAdmin: TDBGrid;
    pnl1: TPanel;
    btnCredit: TButton;
    btnChecking: TButton;
    btnSavings: TButton;
    pnl2: TPanel;
    btnUsers: TButton;
    dbnvgrAdmin: TDBNavigator;
    bmbBack: TBitBtn;
    pnl3: TPanel;
    lbl10: TLabel;
    btnPMD: TButton;
    img1: TImage;
    lbl1: TLabel;
    procedure btnSavingsClick(Sender: TObject);
    procedure btnCheckingClick(Sender: TObject);
    procedure btnCreditClick(Sender: TObject);
    procedure btnUsersClick(Sender: TObject);
    procedure bmbBackClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
   CloseA : Boolean;
  public

  end;

var
  frmAdmin: TfrmAdmin;

implementation

uses Main, Connection, Connection2, Timer;

{$R *.dfm}

procedure TfrmAdmin.bmbBackClick(Sender: TObject);
begin
 frmAdmin.Close;
 CloseA := True
end;

procedure TfrmAdmin.btnCheckingClick(Sender: TObject);
begin
 ShowMessage('Due to Strict security, You will only be able to view this tabel');
 dbnvgrAdmin.VisibleButtons := [nbFirst,nbPrior,nbNext,nbLast,nbRefresh];
 Form1.ADODataSetChecking.Active := False;
 dbgrdAdmin.DataSource.DataSet := Form1.ADODataSetChecking;
 dbnvgrAdmin.DataSource.DataSet := Form1.ADODataSetChecking;
 Form1.ADODataSetChecking.CommandText := 'SELECT * FROM [Checking Account]';
 Form1.ADODataSetChecking.Active := True;
end;

procedure TfrmAdmin.btnCreditClick(Sender: TObject);
begin
ShowMessage('Due to Strict security, You will only be able to view this tabel');
dbnvgrAdmin.VisibleButtons := [nbFirst,nbPrior,nbNext,nbLast,nbRefresh];
end;

procedure TfrmAdmin.btnSavingsClick(Sender: TObject);
begin
 ShowMessage('Due to Strict security, You will only be able to view this tabel');
 dbnvgrAdmin.VisibleButtons := [nbFirst,nbPrior,nbNext,nbLast,nbRefresh];
end;

procedure TfrmAdmin.btnUsersClick(Sender: TObject);
begin
 dbnvgrAdmin.VisibleButtons := [nbFirst,nbPrior,nbNext,nbLast,nbDelete,nbDelete,nbRefresh]
end;

procedure TfrmAdmin.FormResize(Sender: TObject);
begin
frmAdmin.Height := 609;
frmMain.Width := 871
end;

procedure TfrmAdmin.FormShow(Sender: TObject);
var ThreadTimer : TTimer;
begin
 ThreadTimer := TTimer.Create(false);
 if CloseA = true
  then ThreadTimer.Terminate;
 CloseA := False;
end;

 //Ekstra Notas
  //-Net 'n admin kan hier inkom
  //-Die Timer word apart deur a Thread gedoen op
  //die ander Unit(ThreadTimer)

end.
