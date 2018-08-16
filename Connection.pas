unit Connection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, WideStrings, ADODB, SqlExpr, DB;

type
  TForm1 = class(TForm)
    ADOConnection: TADOConnection;
    ADODataSetSavings: TADODataSet;
    ADODataSetCredit: TADODataSet;
    ADODataSetChecking: TADODataSet;
    ADODataSourceSavings: TDataSource;
    ADODataSourceCredit: TDataSource;
    ADODataSourceChecking: TDataSource;
    ADODataSourceRun: TDataSource;
    ADODataSetRun: TADODataSet;
    ADODataSetTime: TADODataSet;
    ADODataSourceTime: TDataSource;
    tblChecking: TADOTable;
    tblCredit: TADOTable;
    tblSavings: TADOTable;
    ADODataSetPMD: TADODataSet;
    ADODataSourcePMD: TDataSource;
    tblPMD: TADOTable;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
const
  ConnString = 'Provider=Microsoft.Jet.OLEDB.4.0;' +
  'User ID=Admin;Data Source=InfiniCount.mdb;Mode=ReadWrite;' +
  'Persist Security Info=False;Jet OLEDB:System database="";' +
  'Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";' +
  'Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;' +
  'Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;' +
  'Jet OLEDB:New Database Password="";Jet OLEDB:Create System Database=False;' +
  'Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don''t Copy Locale on Compact=False;' +
  'Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False';
begin
 //ADOConnection.ConnectionString := ConnString;
 //ADODataSetRun.Active := True;
end;

end.
