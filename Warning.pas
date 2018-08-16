unit Warning;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, StdCtrls, Buttons, Connection, Connection2, ComCtrls, CommCtrl,
  XPMan, Gauges;

type
  ArrSom = array[1..31] of Real;
  TfrmWarning = class(TForm)
    imgWarn: TImage;
    lbl6: TLabel;
    lblChecking: TLabel;
    edtMaxR: TEdit;
    lbl1: TLabel;
    edtWarnPer: TEdit;
    lbl2: TLabel;
    lblPerUse: TLabel;
    bmbBack: TBitBtn;
    bmbCheck: TBitBtn;
    lblUsed: TLabel;
    lblPredFor: TLabel;
    lblPredic: TLabel;
    lblPrePer: TLabel;
    lblPrePerUsed: TLabel;
    cbbTrans: TComboBox;
    lblDay: TLabel;
    chkEnabled: TCheckBox;
    PBUsed: TGauge;
    procedure bmbCheckClick(Sender: TObject);
    procedure bmbBackClick(Sender: TObject);
    procedure cbbTransSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkEnabledClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    aSom : ArrSom;
    rPredict, rPredictCh, rPredictS, rPredictCr : Real;
    rPerUsed, rPrePerUsed, rInOut : Real;
    Font, UsCh, UsS, UsCr : Boolean;
  public
    MaxExpense : integer;
    AvgSom, AvgDag : Real;
    MyMonth, MyYear, MyDay, MonthDays, iDag : word;
    procedure BerekenMaxExpCheck;
    procedure BerekenMaxExpSaving;
    procedure BerekenMaxExpCredit;
    procedure RunBereken;
    procedure Dates;
    procedure Update;
    procedure FontColor;
    procedure WaringLevel;
    function LockCheck : Boolean;
    function LockSaving : Boolean;
    function LockCredit : Boolean;
  end;

var
  frmWarning: TfrmWarning;

implementation

uses Register, Main;


{$R *.dfm}

procedure TfrmWarning.BerekenMaxExpCheck;                                       //Bereken die aantal % hoefeel die gebruiker gebruik het
var                                                                             //van sy algehele bedrag geld. Waarsku die gebruiker dan
  I : Integer;                                                                  //en fries die spesifieke account tot die avg per dag weer
  tmpDate, tmpDateRep : TDateTime;                                              //onder die aantal hoeveelheid geld is
  rSom, rSomIn, rAvg : Real;
begin
 Connection.Form1.tblChecking.Open;
 Connection.Form1.tblChecking.First;
 Connection2A.ADOInTable.Open;
 Dates;
     for I := 1 to MyDay do
      begin
       iDag := I;
       tmpDate := EncodeDate(MyYear,MyMonth,iDag);
        if Connection.Form1.tblChecking.Locate('Transaction Date;ID;',VarArrayOf([tmpDate,frmMain.LoggedInID]),[]) = True then
         begin
          repeat
           rSom := rSom + Connection.Form1.tblChecking['Amount Out'];
           rSomIn := rSomIn + Connection.Form1.tblChecking['Amount In'];
           Connection.Form1.tblChecking.Next;
           Inc(iDag);
           tmpDateRep := EncodeDate(MyYear,MyMonth,iDag+1);
           if Connection.Form1.tblChecking.Eof = true then Break;
          until Connection.Form1.tblChecking['Transaction Date'] = tmpDateRep;
         end
        else
       Connection.Form1.tblChecking.Next;
       if Connection.Form1.tblChecking.Eof = true then Break;
      end;

    rInOut := (rSom - rSomIn);
    rAvg := rInOut / MyDay;
    rPredict := rAvg * (MonthDays - MyDay);
    rPredictCh := rPredict;
    rPerUsed := (rInOut * 100) / StrToInt(Connection2A.ADOInTable['MaxExp']);
    rPrePerUsed := (rPredict * 100) / StrToInt(Connection2A.ADOInTable['MaxExp']);
    if rPerUsed > StrToInt(Connection2A.ADOInTable['WarnAt'])
     then UsCh := True
     else UsCh := False;
    FontColor;
    LockCheck;
    WaringLevel;
    frmMain.lblChecking.Caption := ('Checking : R' + FloatToStrF((rSomIn - rSom),ffFixed,8,2));
 //Connection.Form1.tblChecking.Close;
 //Connection2A.ADOInTable.Close;
end;

procedure TfrmWarning.BerekenMaxExpCredit;
var                                                                             //van sy algehele bedrag geld. Waarsku die gebruiker dan
  I : Integer;                                                                  //en fries die spesifieke account tot die avg per dag weer
  tmpDate, tmpDateRep : TDateTime;                                              //onder die aantal hoeveelheid geld is
  rSom, rSomIn, rAvg : Real;
begin
 Connection.Form1.tblCredit.Open;
 Connection.Form1.tblCredit.First;   //Word locate van die user wat ingesign is
 Connection2A.ADOInTable.Open;
 Dates;
     for I := 1 to MyDay do
      begin
       iDag := I;
       tmpDate := EncodeDate(MyYear,MyMonth,iDag);
        if Connection.Form1.tblCredit.Locate('Transaction Date;ID;',VarArrayOf([tmpDate,frmMain.LoggedInID]),[]) = True then
         begin
          repeat
           rSom := rSom + Connection.Form1.tblCredit['Amount Out'];
           rSomIn := rSomIn + Connection.Form1.tblCredit['Amount In'];
           Connection.Form1.tblCredit.Next;
           Inc(iDag);
           tmpDateRep := EncodeDate(MyYear,MyMonth,iDag+1);
           if Connection.Form1.tblCredit.Eof = true then Break;
          until Connection.Form1.tblCredit['Transaction Date'] = tmpDateRep;
         end
        else
       Connection.Form1.tblCredit.Next;
       if Connection.Form1.tblCredit.Eof = true then Break;
      end;

    rInOut := (rSom - rSomIn);
    rAvg := rInOut / MyDay;
    rPredict := rAvg * (MonthDays - MyDay);
    rPredictCr := rPredict;
    rPerUsed := (rInOut * 100) / StrToInt(Connection2A.ADOInTable['MaxExp']);
    rPrePerUsed := (rPredict * 100) / StrToInt(Connection2A.ADOInTable['MaxExp']);
    if rPerUsed > StrToInt(Connection2A.ADOInTable['WarnAt'])
     then UsCr := True
     else UsCr := False;
    FontColor;
    LockCredit;
    WaringLevel;
    frmMain.lblCredit.Caption := ('Credit : R' + FloatToStrF((rSomIn - rSom),ffFixed,8,2));
 //Connection.Form1.tblChecking.Close;
 //Connection2A.ADOInTable.Close;
end;

procedure TfrmWarning.BerekenMaxExpSaving;
var                                                                             //van sy algehele bedrag geld. Waarsku die gebruiker dan
  I : Integer;                                                                  //en fries die spesifieke account tot die avg per dag weer
  tmpDate, tmpDateRep : TDateTime;                                              //onder die aantal hoeveelheid geld is
  rSom, rSomIn, rAvg : Real;
begin
 Connection.Form1.tblSavings.Open;
 Connection.Form1.tblSavings.First;   //Word locate van die user wat ingesign is
 Connection2A.ADOInTable.Open;
 Dates;
     for I := 1 to MyDay do
      begin
       iDag := I;
       tmpDate := EncodeDate(MyYear,MyMonth,iDag);
        if Connection.Form1.tblSavings.Locate('Transaction Date;ID;',VarArrayOf([tmpDate,frmMain.LoggedInID]),[]) = True then
         begin
          repeat
           rSom := rSom + Connection.Form1.tblSavings['Amount Out'];
           rSomIn := rSomIn + Connection.Form1.tblSavings['Amount In'];
           Connection.Form1.tblSavings.Next;
           Inc(iDag);
           tmpDateRep := EncodeDate(MyYear,MyMonth,iDag+1);
           if Connection.Form1.tblSavings.Eof = true then Break;
          until Connection.Form1.tblSavings['Transaction Date'] = tmpDateRep;
         end
        else
       Connection.Form1.tblSavings.Next;
       if Connection.Form1.tblSavings.Eof = true then Break;
      end;

    rInOut := (rSom - rSomIn);
    rAvg := rInOut / MyDay;
    rPredict := rAvg * (MonthDays - MyDay);
    rPredictS := rPredict;
    rPerUsed := (rInOut * 100) / StrToInt(Connection2A.ADOInTable['MaxExp']);
    rPrePerUsed := (rPredict * 100) / StrToInt(Connection2A.ADOInTable['MaxExp']);
    if rPerUsed > StrToInt(Connection2A.ADOInTable['WarnAt'])
     then UsS := True
     else UsS := False;
    FontColor;
    LockSaving;
    WaringLevel;
    frmMain.lblSavings.Caption := ('Savings : R' + FloatToStrF((rSomIn - rSom),ffFixed,8,2));
 //Connection.Form1.tblChecking.Close;
 //Connection2A.ADOInTable.Close;
end;

procedure TfrmWarning.bmbBackClick(Sender: TObject);
begin
frmWarning.Close;
end;

procedure TfrmWarning.bmbCheckClick(Sender: TObject);
begin
if chkEnabled.Checked = True
then Update;
RunBereken;
frmWarning.Close;
end;

procedure TfrmWarning.cbbTransSelect(Sender: TObject);
begin
 if (StrToInt(edtWarnPer.Text) <= 0) and (StrToInt(edtMaxR.Text) <= 0)  then
  ShowMessage('Please make sure the Max expense or Warn at % Box is above 0')
 else
  begin
   Update;
   if cbbTrans.ItemIndex = 0 then
    begin
     BerekenMaxExpCheck;
     lblPredic.Caption := ('R' + FloatToStrF(rPredict,ffFixed,8,2));
     lblPredFor.Caption := 'Predicted expense for Checking Account :';
     lblUsed.Caption := ('%' + FloatToStrF(rPerUsed,ffFixed,8,2));
     lblPerUse.Caption := '% used so far for Checking Account :';
     lblPrePerUsed.Caption := ('%' + FloatToStrF(rPrePerUsed,ffFixed,8,2));
     lblPrePer.Caption := 'Predicted % used for Checking Account :';
     if (rPerUsed <75) then PBUsed.ForeColor := clGreen;
     if (rPerUsed >StrToInt(edtWarnPer.Text)) and (rPerUsed <99) then PBUsed.ForeColor := clYellow;
     if rPerUsed >=100 then PBUsed.ForeColor := clRed;
     pbUsed.Progress := Round(rPerUsed);
    end;

   if cbbTrans.ItemIndex = 1 then
    begin
     BerekenMaxExpSaving;
     lblPredic.Caption := ('R' + FloatToStrF(rPredict,ffFixed,8,2));
     lblPredFor.Caption := 'Predicted expense for Savings Account :';
     lblUsed.Caption := ('%' + FloatToStrF(rPerUsed,ffFixed,8,2));
     lblPerUse.Caption := '% used so far for Savings Account :';
     lblPrePerUsed.Caption := ('%' + FloatToStrF(rPrePerUsed,ffFixed,8,2));
     lblPrePer.Caption := 'Predicted % used for Savings Account :';
     if (rPerUsed <75) then PBUsed.ForeColor := clGreen;
     if (rPerUsed >StrToInt(edtWarnPer.Text)) and (rPerUsed <99) then PBUsed.ForeColor := clYellow;
     if rPerUsed >=100 then PBUsed.ForeColor := clRed;
     pbUsed.Progress := Round(rPerUsed);
    end;

   if cbbTrans.ItemIndex = 2 then
    begin
     BerekenMaxExpCredit;
     lblPredic.Caption := ('R' + FloatToStrF(rPredict,ffFixed,8,2));
     lblPredFor.Caption := 'Predicted expense for Credit Account :';
     lblUsed.Caption := ('%' + FloatToStrF(rPerUsed,ffFixed,8,2));
     lblPerUse.Caption := '% used so far for Credit Account :';
     lblPrePerUsed.Caption := ('%' + FloatToStrF(rPrePerUsed,ffFixed,8,2));
     lblPrePer.Caption := 'Predicted % used for Credit Account :';
    if (rPerUsed <75) then PBUsed.ForeColor := clGreen;
     if (rPerUsed >StrToInt(edtWarnPer.Text)) and (rPerUsed <99) then PBUsed.ForeColor := clYellow;
     if rPerUsed >=100 then PBUsed.ForeColor := clRed;
     pbUsed.Progress := Round(rPerUsed);
    end;
  end;
end;

procedure TfrmWarning.chkEnabledClick(Sender: TObject);
begin
 if chkEnabled.Checked = true then
  begin
   edtMaxR.Enabled := True;
   edtWarnPer.Enabled := True;
   cbbTrans.Enabled := True;
  end
 else
  begin
   edtMaxR.Enabled := False;
   edtWarnPer.Enabled := False;
   cbbTrans.Enabled := False;
  end;

   Connection2A.ADOInTable.Open;
   Connection2A.ADOInTable.Locate('RName',frmMain.LoggedInAs,[]);
   edtWarnPer.Text := IntToStr(Connection2A.ADOInTable['WarnAt']);
   edtMaxR.Text := IntToStr(Connection2A.ADOInTable['MaxExp']);
   //Connection2A.ADOInTable.Close;
end;

procedure TfrmWarning.Dates;
var
  MyDate : TDateTime;                                                           //extract die dae van die jaar en maand
begin
  MyDate := Now;
  DecodeDate(MyDate, MyYear, MyMonth, MyDay);
  if MyMonth = 2 then
   begin
    if IsLeapYear(MyYear)
     then MonthDays := 29
     else MonthDays := 28;
   end
  else
   if MyMonth = 4 or 6 or 9 or 11
    then MonthDays := 30
    else MonthDays := 31
end;

procedure TfrmWarning.FontColor;
begin
 if rPrePerUsed > 100 then
  begin
   lblPredic.Font.Color := clRed;
   lblPredic.Font.Style := [fsBold];
   lblPrePerUsed.Font.Color := clRed;
   lblPrePerUsed.Font.Style := [fsBold];
  end
 else
  begin
   lblPredic.Font.Color := clLime;
   lblPredic.Font.Style := [fsBold];
   lblPrePerUsed.Font.Color := clLime;
   lblPrePerUsed.Font.Style := [fsBold];
  end;

 if (rPrePerUsed = 100) or (rPrePerUsed = 0) then
  begin
   lblPredic.Font.Color := clBlack;
   lblPredic.Font.Style := [];
   lblPrePerUsed.Font.Color := clBlack;
   lblPrePerUsed.Font.Style := [];
  end;
end;

procedure TfrmWarning.FormCreate(Sender: TObject);
begin
 if chkEnabled.Checked = true then
  begin
   Connection2A.ADOInTable.Open;
   Connection2A.ADOInTable.Locate('RName',frmMain.LoggedInAs,[]);
   edtWarnPer.Text := IntToStr(Connection2A.ADOInTable['WarnAt']);
   edtMaxR.Text := IntToStr(Connection2A.ADOInTable['MaxExp']);
  end;
 lblDay.Caption := 'Date :' + DateToStr(Now);
 edtMaxR.Enabled := False;
 edtWarnPer.Enabled := False;
 cbbTrans.Enabled := False;
 //Connection2A.ADOInTable.Close;
end;

procedure TfrmWarning.FormResize(Sender: TObject);
begin
frmWarning.Height := 376;
frmWarning.Width := 520;
end;

function TfrmWarning.LockCheck: Boolean;
begin
 Connection2.Connection2A.ADOInTable.Open;
 if rPredictCh > Connection2.Connection2A.ADOInTable['MaxExp']
  then Result := True
  else Result := False;
end;

function TfrmWarning.LockCredit: Boolean;
begin
 Connection2.Connection2A.ADOInTable.Open;
 if rPredictCr > Connection2.Connection2A.ADOInTable['MaxExp']
  then Result := True
  else Result := False;
end;

function TfrmWarning.LockSaving: Boolean;
begin
 Connection2.Connection2A.ADOInTable.Open;
 if rPredictS > Connection2.Connection2A.ADOInTable['MaxExp']
  then Result := True
  else Result := False;
end;

procedure TfrmWarning.RunBereken;
begin
 BerekenMaxExpCheck;
 BerekenMaxExpSaving;
 BerekenMaxExpCredit;
end;

procedure TfrmWarning.Update;
begin
 with Connection2.Connection2A do
  begin
   ADOInTable.Open;
   ADOInTable.Locate('ID',frmMain.LoggedInID,[]);
   ADOInTable.Edit;
   ADOInTable['MaxExp'] := StrToInt(edtMaxR.Text);
   if frmWarning.chkEnabled.Checked = true
    then ADOInTable['Warning'] := True
    else ADOInTable['Warning'] := False;
   ADOInTable['WarnAt'] := StrToInt(edtWarnPer.Text);
   ADOInTable.Post;
  end;
  //Connection2A.ADOInTable.Close;
end;

procedure TfrmWarning.WaringLevel;
begin
 if UsCh = True then
  begin
    with frmMain.lblUsWar do
      begin
       Caption := 'Checking Account';
       Font.Color := clRed;
      end;
  end
 else
  begin
    with frmMain.lblUsWar do
      begin
       Caption := 'All Good';
       Font.Color := clBlack;
      end;
   if UsS = True then
    begin
     with frmMain.lblUsWar do
      begin
       Caption := 'Savings Account';
       Font.Color := clRed;
      end;
    end
   else
    begin
     with frmMain.lblUsWar do
      begin
       Caption := 'All Good';
       Font.Color := clBlack;
      end;
       if UsCr = True then
        begin
         with frmMain.lblUsWar do
          begin
           Caption := 'Credit Account';
           Font.Color := clRed;
          end;
        end
       else
        begin
         with frmMain.lblUsWar do
          begin
           Caption := 'All Good';
           Font.Color := clBlack;
          end;
        end;
    end;
  end;
end;


 //Ekstra Notas
  //-Hierdie deel van die program is baie moeilik om te volg
  //omdat die kompleksieteit van die deel baie hoog is.
  //-Die deel keer dat die gebruiker nie meer as n spesifieke
  //bedrag per maand uitgee per tabel nie.
  //-Hy waarsku ook die gebruiker as hy oor gaan gaan en sluit
  //dan die sekere account tot verdere kennis.
  //-Die form is verantwoordelik vir die instanthouding
  //van die gebruiker se finansiele status.

  //Vloei vanaf hierdie form
   //BUTTONS
    //..OK --> FrmMain(Main). Procedures word herroep
    //..Cancel --> FrmMain(Main). FrmWarning word net geclose
end.
