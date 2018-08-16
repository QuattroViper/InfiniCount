unit TClass;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TTransaction = class(TObject)
   private
    fCnumber : Integer;
    fiAmount : Integer;
    fPayee : string;
    fID : string;
    fDate : TDateTime;
    fType : Integer;
    fCategory : Integer;
   public
    constructor Create(iCNumber,iamount,iCbbTrans,icbbCategory:Integer;spayee,sID:string;ckdate:TDateTime); overload;
    function GetiCNumber : Integer;
    function Getiamount : integer;
    function Getspayee : string;
    function GetsID : string;
    function GetsTrans : string;
    function GetsCatergory : string;
    function GetDate : TDateTime;
    function ToString : string;
    function ToDatabasis : string;
  end;

implementation

uses Transaction, Connection, Connection2;

{ TTransaction }

constructor TTransaction.Create(iCNumber,iamount,iCbbTrans,icbbCategory:Integer;spayee,sID:string;ckdate:TDateTime);
begin
 fCnumber := iCNumber;
 fiAmount := iamount;
 fPayee := spayee;
 fID := sID;
 fDate := ckdate;
 fType := iCbbTrans;
 fCategory := icbbCategory;
end;

function TTransaction.GetDate: TDateTime;
begin
 Result := fDate;
end;

function TTransaction.Getiamount: integer;
begin
 Result := fiAmount;
end;

function TTransaction.GetiCNumber: Integer;
begin
 Result := fCnumber;
end;

function TTransaction.GetsCatergory: string;
begin
 Result := frmTrans.cbbCategoryTrans.Items[fCategory];
end;

function TTransaction.GetsID: string;
begin
 Result := fID;
end;

function TTransaction.Getspayee: string;
begin
 Result := fPayee;
end;

function TTransaction.GetsTrans: string;
begin
 case fType of
  0 : Result := 'Deposit';
  1 : Result := 'Purchase';
  2 : Result := 'Transfer';
  3 : Result := 'Check';
 end;
end;

function TTransaction.ToDatabasis: string;
begin
 if frmTrans.cbbAccountKies.ItemIndex = 0 then
  begin
   with Connection.Form1 do
    begin
     tblChecking.Open;
     tblChecking.Last;
     tblChecking.Insert;
     tblChecking['ID'] := GetsID;
     tblChecking['Transaction Date'] := GetDate;
     tblChecking['Number'] := GetiCNumber;
     tblChecking['Payee'] := Getspayee;
     tblChecking['Category'] := GetsCatergory;
     if frmTrans.cbbType.ItemIndex = 0
      then tblChecking['Amount In'] := Getiamount
      else
       begin
        if frmTrans.cbbToAccount.ItemIndex = 0 then
         begin
          tblChecking['Amount Out'] := Getiamount;
          tblChecking['Amount In'] := Getiamount;
         end
        else tblChecking['Amount Out'] := Getiamount;
       end;

     if frmTrans.cbbType.ItemIndex = 2 then
      begin
       if frmTrans.cbbToAccount.ItemIndex = 1 then
        begin
         tblSavings.Open;
         tblSavings.Last;
         tblSavings.Insert;
         tblSavings['ID'] := GetsID;
         tblSavings['Transaction Date'] := GetDate;
         tblSavings['Payee'] := Getspayee;
         tblSavings['Category'] := 'Transfer';
         tblSavings['Amount In'] := Getiamount;
         tblSavings['Transaction Type'] := 'Transfer';
         tblSavings.Post;
         tblSavings.Close;
        end;
       if frmTrans.cbbToAccount.ItemIndex = 2 then
        begin
         tblCredit.Open;
         tblCredit.Last;
         tblCredit.Insert;
         tblCredit['ID'] := GetsID;
         tblCredit['Transaction Date'] := GetDate;
         tblCredit['Payee'] := Getspayee;
         tblCredit['Category'] := 'Transfer';
         tblCredit['Amount In'] := Getiamount;
         tblCredit['Transaction Type'] := 'Transfer';
         tblCredit.Post;
         tblCredit.Close;
        end;
      end;
     tblChecking['Transaction Type'] := GetsTrans;
     tblChecking.Post;
     tblChecking.Close;
    end;
  end;

 if frmTrans.cbbAccountKies.ItemIndex = 1 then
  begin
   with Connection.Form1 do
    begin
     tblSavings.Open;
     tblSavings.Last;
     tblSavings.Insert;
     tblSavings['ID'] := GetsID;
     tblSavings['Transaction Date'] := GetDate;
     tblSavings['Payee'] := Getspayee;
     tblSavings['Category'] := GetsCatergory;
     if frmTrans.cbbType.ItemIndex = 0
      then tblSavings['Amount In'] := Getiamount
      else
       begin
        if frmTrans.cbbToAccount.ItemIndex = 1 then
         begin
          tblSavings['Amount Out'] := Getiamount;
          tblSavings['Amount In'] := Getiamount;
         end
        else tblSavings['Amount Out'] := Getiamount;
       end;

      if frmTrans.cbbType.ItemIndex = 2 then
      begin
       if frmTrans.cbbToAccount.ItemIndex = 0 then
        begin
         tblChecking.Open;
         tblChecking.Last;
         tblChecking.Insert;
         tblChecking['ID'] := GetsID;
         tblChecking['Transaction Date'] := GetDate;
         tblChecking['Payee'] := Getspayee;
         tblChecking['Category'] := 'Transfer';
         tblChecking['Amount In'] := Getiamount;
         tblChecking['Transaction Type'] := 'Transfer';
         tblChecking.Post;
         tblChecking.Close;
        end;
       if frmTrans.cbbToAccount.ItemIndex = 2 then
        begin
         tblCredit.Open;
         tblCredit.Last;
         tblCredit.Insert;
         tblCredit['ID'] := GetsID;
         tblCredit['Transaction Date'] := GetDate;
         tblCredit['Payee'] := Getspayee;
         tblCredit['Category'] := 'Transfer';
         tblCredit['Amount In'] := Getiamount;
         tblCredit['Transaction Type'] := 'Transfer';
         tblCredit.Post;
         tblCredit.Close;
        end;
      end;
     tblSavings['Transaction Type'] := GetsTrans;
     tblSavings.Post;
     tblSavings.Close;
    end;
  end;

 if frmTrans.cbbAccountKies.ItemIndex = 2 then
  begin
   with Connection.Form1 do
    begin
     tblCredit.Open;
     tblCredit.Last;
     tblCredit.Insert;
     tblCredit['ID'] := GetsID;
     tblCredit['Transaction Date'] := GetDate;
     tblCredit['Payee'] := Getspayee;
     tblCredit['Category'] := GetsCatergory;
     if frmTrans.cbbType.ItemIndex = 0
      then tblCredit['Amount In'] := Getiamount
      else
       begin
        if frmTrans.cbbToAccount.ItemIndex = 2 then
         begin
          tblCredit['Amount Out'] := Getiamount;
          tblCredit['Amount In'] := Getiamount;
         end
        else tblCredit['Amount Out'] := Getiamount;
       end;

      if frmTrans.cbbType.ItemIndex = 2 then
      begin
       if frmTrans.cbbToAccount.ItemIndex = 0 then
        begin
         tblChecking.Open;
         tblChecking.Last;
         tblChecking.Insert;
         tblChecking['ID'] := GetsID;
         tblChecking['Transaction Date'] := GetDate;
         tblChecking['Payee'] := Getspayee;
         tblChecking['Category'] := 'Transfer';
         tblChecking['Amount In'] := Getiamount;
         tblChecking['Transaction Type'] := 'Transfer';
         tblChecking.Post;
         tblChecking.Close;
        end;
       if frmTrans.cbbToAccount.ItemIndex = 1 then
        begin
         tblSavings.Open;
         tblSavings.Last;
         tblSavings.Insert;
         tblSavings['ID'] := GetsID;
         tblSavings['Transaction Date'] := GetDate;
         tblSavings['Payee'] := Getspayee;
         tblSavings['Category'] := 'Transfer';
         tblSavings['Amount In'] := Getiamount;
         tblSavings['Transaction Type'] := 'Transfer';
         tblSavings.Post;
         tblSavings.Close;
        end;
      end;
     tblCredit['Transaction Type'] := GetsTrans;
     tblCredit.Post;
     tblCredit.Close;
    end;
  end;

  Result := 'OK'
end;

function TTransaction.ToString: string;
begin
 if ToDatabasis = 'OK'
  then Result := 'Transaction is successful with :' + #13 + 'ID: ' + GetsID + #13 + 'Date: ' + DateToStr(GetDate) + #13 + 'Number: ' + IntToStr(GetiCNumber) + #13 + 'Payee: ' + Getspayee + #13 + 'Amount: R' + IntToStr(Getiamount) + #13 + 'Transaction: ' + GetsTrans;
end;

//Ekstra Notas
   //Is verbonde aan die Transaction form
end.
