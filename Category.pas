unit Category;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, jpeg, ComCtrls;

type
  TFrmCategory = class(TForm)
    edtCatName: TEdit;
    bmbOk: TBitBtn;
    bmbCancel: TBitBtn;
    img1: TImage;
    lblChecking: TLabel;
    lbl6: TLabel;
    lbl1: TLabel;
    cbbDeleteCategory: TComboBox;
    btnDeleteCat: TButton;
    btnAddCategory: TButton;
    RedHou: TRichEdit;
    procedure bmbOkClick(Sender: TObject);
    procedure bmbCancelClick(Sender: TObject);
    procedure btnDeleteCatClick(Sender: TObject);
    procedure btnAddCategoryClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ReadToCbb;
  end;

var
  FrmCategory: TFrmCategory;

implementation

uses Main, Transaction, Connection;

{$R *.dfm}

procedure TFrmCategory.bmbCancelClick(Sender: TObject);
begin
FrmCategory.Close;
end;

procedure TFrmCategory.bmbOkClick(Sender: TObject);
begin
FrmCategory.Close;
end;

procedure TFrmCategory.btnAddCategoryClick(Sender: TObject);
var
 slyn : string;
 teks : TextFile;
begin
 AssignFile(teks,'text\Categories.txt');
 if FileExists('text\Categories.txt') <> True
  then Rewrite(teks)
  else Append(teks);
  slyn := edtCatName.Text + '.';
  Writeln(teks,slyn);
  CloseFile(teks);
  ReadToCbb;
end;

procedure TFrmCategory.btnDeleteCatClick(Sender: TObject);
var
 Del, tmp : string;
 slyn, steks : string;
 teks : TextFile;
 itel, I, R : Integer;
begin
 if cbbDeleteCategory.ItemIndex = -1
  then ShowMessage('Please make sure you choose a correct category')
  else
 begin
 Del := cbbDeleteCategory.Items[cbbDeleteCategory.ItemIndex];
 with Connection.Form1 do
  begin
    tblChecking.Open;
    tblChecking.First;
    while not tblChecking.Eof do
     begin
       if tblChecking.Locate('Category',Del,[]) then
        begin
          tblChecking.Edit;
          tblChecking['Category'] := 'Category Removed';
        end;
       tblChecking.Next;
     end;
    tblChecking.Close;

    tblSavings.Open;
    tblSavings.First;
    while not tblSavings.Eof do
     begin
       if tblSavings.Locate('Category',Del,[]) then
        begin
          tblSavings.Edit;
          tblSavings['Category'] := 'Category Removed';
        end;
       tblSavings.Next;
     end;
    tblSavings.Close;

    tblCredit.Open;
    tblCredit.First;
    while not tblCredit.Eof do
     begin
       if tblCredit.Locate('Category',Del,[]) then
        begin
          tblCredit.Edit;
          tblCredit['Category'] := 'Category Removed';
        end;
       tblCredit.Next;
     end;
    tblCredit.Close;
  end;

 RedHou.Lines.Clear;
 AssignFile(teks,'text\Categories.txt');
 if FileExists('text\Categories.txt') <> True
  then ShowMessage('Please add a category first')
  else Reset(teks);
    while not Eof(teks) do
     begin
      Readln(teks,slyn);
      if cbbDeleteCategory.Items[cbbDeleteCategory.ItemIndex] = slyn then
       begin
        Next;
        Readln(teks,slyn);
        showmessage('Delete OK');
       end;
      RedHou.Lines.Add(slyn);
     end;

  Rewrite(teks);
  for R := 1 to RedHou.Lines.Count  do
   begin
    if RedHou.Lines[R] <> ''
    then Inc(iTel)
   end;

  for I := 0 to iTel do
   begin
    tmp := RedHou.Lines[I];
    Writeln(teks,tmp);
   end;
  CloseFile(teks);
  ReadToCbb;
 end;

end;

procedure TFrmCategory.FormResize(Sender: TObject);
begin
FrmCategory.Height := 264;
FrmCategory.Width := 377;
end;

procedure TFrmCategory.FormShow(Sender: TObject);
begin
 ReadToCbb;
end;

procedure TFrmCategory.ReadToCbb;
var
 slyn1, steks : string;
 teks : TextFile;
begin
 cbbDeleteCategory.Items.Clear;
 frmTrans.cbbCategoryTrans.Items.Clear;
 AssignFile(teks,'text\Categories.txt');
 if FileExists('text\Categories.txt') <> True
  then ShowMessage('Please add a category first')
  else
   begin
    Reset(teks);
    while not Eof(teks) do
     begin
      Readln(teks,slyn1);
      cbbDeleteCategory.Items.Add(slyn1);
      frmTrans.cbbCategoryTrans.Items.Add(slyn1);
     end;
     cbbDeleteCategory.ItemIndex := -1;
   end;
  CloseFile(teks);
end;



 //Ekstra Notas
   //Die button gaan die combobox op FrmTrans verander ook.

 //Vloei vanaf hierdie form
  //OK en Cancel gaan terug na FrmMain(Main)

end.
