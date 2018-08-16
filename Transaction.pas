unit Transaction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, jpeg, ExtCtrls;

type
  TfrmTrans = class(TForm)
    bmbOk: TBitBtn;
    bmbCancel: TBitBtn;
    bmbHelp: TBitBtn;
    cbbAccountKies: TComboBox;
    chkDatum: TCheckBox;
    dtpTime: TDateTimePicker;
    cbbType: TComboBox;
    edtCNumber: TEdit;
    edtPayee: TEdit;
    cbbCategoryTrans: TComboBox;
    edtAmount: TEdit;
    img1: TImage;
    lbl8: TLabel;
    lblChecking: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    lbl4: TLabel;
    lbl9: TLabel;
    cbbToAccount: TComboBox;
    lbl10: TLabel;
    redHelp: TRichEdit;
    lbl6: TLabel;
    img2: TImage;
    procedure bmbOkClick(Sender: TObject);
    procedure bmbCancelClick(Sender: TObject);
    procedure cbbTypeSelect(Sender: TObject);
    procedure chkDatumClick(Sender: TObject);
    procedure cbbAccountKiesChange(Sender: TObject);
    procedure bmbHelpMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure bmbHelpMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cbbCategoryTransDropDown(Sender: TObject);
    procedure cbbTypeChange(Sender: TObject);
  private
    HelpDown : Boolean;
  public
    CheckKies, SavingKies, CreditKies : Boolean;
    procedure CheckLock;
    procedure CbbTypeTo;
  end;

var
  frmTrans: TfrmTrans;

implementation

uses Main, Warning, TClass, Connection, Category;

{$R *.dfm}

procedure TfrmTrans.bmbCancelClick(Sender: TObject);
begin
frmTrans.Close;
end;

procedure TfrmTrans.bmbHelpMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 redHelp.Lines.LoadFromFile('text\TransHelp.rtf');
 HelpDown :=  True;
 frmTrans.Width := 955;
end;

procedure TfrmTrans.bmbHelpMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 HelpDown := False;
 frmTrans.Width := 485;
end;

procedure TfrmTrans.bmbOkClick(Sender: TObject);                                //Accounts panel word hier geupdate
var
 objClassTrans : TTransaction;
 sgetal : string;
 igetal, ifout : integer;
 CheckNumberOK, AmountOK, AllAccOK : Boolean;
 spayee, sID : string;
 iamount, iCNumber, iCbbTrans, icbbCategory : Integer;
 ckDate : TDateTime;
begin
 if edtCNumber.Enabled = True then                                               //Validate
  begin
   sgetal := edtCNumber.Text;
   Val(sgetal,igetal,ifout);
   if ifout <> 0
    then
     begin
      ShowMessage('Please make sure tha tyou only typed numbers in at the Number box');
      CheckNumberOK := False;
     end
    else CheckNumberOK := True;
  end;

   sgetal := edtAmount.Text;                                                     //Validate
   Val(sgetal,igetal,ifout);
   if ifout <> 0 then
    begin
     ShowMessage('Please make sure the Amount box contain only Numbers');
     AmountOK := False;
    end
   else AmountOK := True;

   if (frmWarning.LockCheck = False) or (frmWarning.LockCredit = False) or (frmWarning.LockSaving = False)
    then AllAccOK := True
    else AllAccOK := False;

 if (frmWarning.chkEnabled.Checked = false) or (AllAccOK = True) then                                   //As Warning system af is gaan hierdie roete gevolg word
  begin
   if chkDatum.Checked = True
    then ckDate := Now
    else ckDate := Now;

   if ((edtCNumber.Enabled = False) and (AmountOK = True)) or ((CheckNumberOK = True) and (AmountOK = True))  then
    begin
     if edtCNumber.Enabled = False
      then iCNumber := 0
      else iCNumber := StrToInt(edtCNumber.Text);
     iCbbTrans := cbbType.ItemIndex;
     spayee := edtPayee.Text;
     iamount := StrToInt(edtAmount.Text);
     sID := frmMain.LoggedInID;
     icbbCategory := cbbCategoryTrans.ItemIndex;
     objClassTrans := TTransaction.Create(iCNumber,iamount,iCbbTrans,icbbCategory,spayee,sID,ckDate);
     ShowMessage(objClassTrans.ToString);
     objClassTrans.Free;
     frmWarning.RunBereken;
     frmTrans.Close;
    end;
  end;

 if frmWarning.chkEnabled.Checked = True then
  begin
   if chkDatum.Checked = True
    then ckDate := Now
    else ckDate := Now;

   if frmWarning.LockCheck = True then
    begin
     if cbbAccountKies.Items[cbbAccountKies.ItemIndex] = 'Checking Account' then
      begin
       with Connection.Form1 do
        begin
         tblChecking.Open;
         tblChecking.Last;
         tblChecking.Insert;
         tblChecking['ID'] := frmMain.LoggedInID;
         tblChecking['Transaction Date'] := ckDate;
         tblChecking['Payee'] := edtPayee.Text;
         tblChecking['Category'] := 'Warning System';
         tblChecking['Amount In'] := StrToInt(edtAmount.Text);
         tblChecking['Transaction Type'] := 'Deposit';
         tblChecking.Post;
         tblChecking.Close;
         ShowMessage('Transaction successful with : ' + #13 + 'ID: '+ frmMain.LoggedInID + #13 + 'Date: ' + DateToStr(Now) + #13 + 'Payee: '+ edtPayee.Text + #13 + 'Amount IN: ' + edtAmount.Text + #13 + 'Transaction: Deposit');
        end;
      end;

     if cbbAccountKies.Items[cbbAccountKies.ItemIndex] = 'Savings Account' then
      begin
       with Connection.Form1 do
        begin
         tblSavings.Open;
         tblSavings.Last;
         tblSavings.Insert;
         tblSavings['ID'] := frmMain.LoggedInID;
         tblSavings['Transaction Date'] := ckDate;
         tblSavings['Payee'] := edtPayee.Text;
         tblSavings['Category'] := 'Warning System';
         tblSavings['Amount Out'] := StrToInt(edtAmount.Text);
         tblSavings['Transaction Type'] := 'Transfer';
          tblChecking.Open;
          tblChecking.Last;
          tblChecking.Insert;
          tblChecking['ID'] := frmMain.LoggedInID;
          tblChecking['Transaction Date'] := ckDate;
          tblChecking['Payee'] := edtPayee.Text;
          tblChecking['Category'] := 'Warning System';
          tblChecking['Amount In'] := StrToInt(edtAmount.Text);
          tblChecking['Transaction Type'] := 'Transfer';
          tblChecking.Post;
          tblChecking.Close;
         tblSavings.Post;
         tblSavings.Close;
         ShowMessage('Transaction successful with : ' + #13 + 'ID: '+ frmMain.LoggedInID + #13 + 'Date: ' + DateToStr(Now) + #13 + 'Payee: '+ edtPayee.Text + #13 + 'Amount IN/OUT: ' + edtAmount.Text + #13 + 'Transaction: Transfer');
        end;
      end;

     if cbbAccountKies.Items[cbbAccountKies.ItemIndex] = 'Credit Account' then
      begin
       with Connection.Form1 do
        begin
         tblCredit.Open;
         tblCredit.Last;
         tblCredit.Insert;
         tblCredit['ID'] := frmMain.LoggedInID;
         tblCredit['Transaction Date'] := ckDate;
         tblCredit['Payee'] := edtPayee.Text;
         tblCredit['Category'] := 'Warning System';
         tblCredit['Amount Out'] := StrToInt(edtAmount.Text);
         tblCredit['Transaction Type'] := 'Transfer';
          tblChecking.Open;
          tblChecking.Last;
          tblChecking.Insert;
          tblChecking['ID'] := frmMain.LoggedInID;
          tblChecking['Transaction Date'] := ckDate;
          tblChecking['Payee'] := edtPayee.Text;
          tblChecking['Category'] := 'Warning System';
          tblChecking['Amount In'] := StrToInt(edtAmount.Text);
          tblChecking['Transaction Type'] := 'Transfer';
          tblChecking.Post;
          tblChecking.Close;
         tblCredit.Post;
         tblCredit.Close;
         ShowMessage('Transaction successful with : ' + #13 + 'ID: '+ frmMain.LoggedInID + #13 + 'Date: ' + DateToStr(Now) + #13 + 'Payee: '+ edtPayee.Text + #13 + 'Amount IN/OUT: ' + edtAmount.Text + #13 + 'Transaction: Transfer');
        end;
      end;

    end
   else
    begin
     if frmWarning.LockSaving = True then
      begin
       if cbbAccountKies.Items[cbbAccountKies.ItemIndex] = 'Savings Account' then
        begin
         with Connection.Form1 do
          begin
           tblSavings.Open;
           tblSavings.Last;
           tblSavings.Insert;
           tblSavings['ID'] := frmMain.LoggedInID;
           tblSavings['Transaction Date'] := ckDate;
           tblSavings['Payee'] := edtPayee.Text;
           tblSavings['Category'] := 'Warning System';
           tblSavings['Amount In'] := StrToInt(edtAmount.Text);
           tblSavings['Transaction Type'] := 'Deposit';
           tblSavings.Post;
           tblSavings.Close;
           ShowMessage('Transaction successful with : ' + #13 + 'ID: '+ frmMain.LoggedInID + #13 + 'Date: ' + DateToStr(Now) + #13 + 'Payee: '+ edtPayee.Text + #13 + 'Amount IN: ' + edtAmount.Text + #13 + 'Transaction: Deposit');
          end;
        end;

       if cbbAccountKies.Items[cbbAccountKies.ItemIndex] = 'Checking Account' then
        begin
         with Connection.Form1 do
          begin
           tblChecking.Open;
           tblChecking.Last;
           tblChecking.Insert;
           tblChecking['ID'] := frmMain.LoggedInID;
           tblChecking['Transaction Date'] := ckDate;
           tblChecking['Payee'] := edtPayee.Text;
           tblChecking['Category'] := 'Warning System';
           tblChecking['Amount Out'] := StrToInt(edtAmount.Text);
           tblChecking['Transaction Type'] := 'Transfer';
            tblSavings.Open;
            tblSavings.Last;
            tblSavings.Insert;
            tblSavings['ID'] := frmMain.LoggedInID;
            tblSavings['Transaction Date'] := ckDate;
            tblSavings['Payee'] := edtPayee.Text;
            tblSavings['Category'] := 'Warning System';
            tblSavings['Amount In'] := StrToInt(edtAmount.Text);
            tblSavings['Transaction Type'] := 'Transfer';
            tblSavings.Post;
            tblSavings.Close;
           tblChecking.Post;
           tblChecking.Close;
           ShowMessage('Transaction successful with : ' + #13 + 'ID: '+ frmMain.LoggedInID + #13 + 'Date: ' + DateToStr(Now) + #13 + 'Payee: '+ edtPayee.Text + #13 + 'Amount IN/OUT: ' + edtAmount.Text + #13 + 'Transaction: Transfer');
          end;
        end;

       if cbbAccountKies.Items[cbbAccountKies.ItemIndex] = 'Credit Account' then
        begin
        with Connection.Form1 do
          begin
           tblCredit.Open;
           tblCredit.Last;
           tblCredit.Insert;
           tblCredit['ID'] := frmMain.LoggedInID;
           tblCredit['Transaction Date'] := ckDate;
           tblCredit['Payee'] := edtPayee.Text;
           tblCredit['Category'] := 'Warning System';
           tblCredit['Amount Out'] := StrToInt(edtAmount.Text);
           tblCredit['Transaction Type'] := 'Transfer';
            tblSavings.Open;
            tblSavings.Last;
            tblSavings.Insert;
            tblSavings['ID'] := frmMain.LoggedInID;
            tblSavings['Transaction Date'] := ckDate;
            tblSavings['Payee'] := edtPayee.Text;
            tblSavings['Category'] := 'Warning System';
            tblSavings['Amount In'] := StrToInt(edtAmount.Text);
            tblSavings['Transaction Type'] := 'Transfer';
            tblSavings.Post;
            tblSavings.Close;
           tblCredit.Post;
           tblCredit.Close;
           ShowMessage('Transaction successful with : ' + #13 + 'ID: '+ frmMain.LoggedInID + #13 + 'Date: ' + DateToStr(Now) + #13 + 'Payee: '+ edtPayee.Text + #13 + 'Amount IN/OUT: ' + edtAmount.Text + #13 + 'Transaction: Transfer');
          end;
        end
      end
     else
      begin
       if frmWarning.LockCredit = True then
        begin
         if cbbAccountKies.Items[cbbAccountKies.ItemIndex] = 'Credit Account' then
          begin
           with Connection.Form1 do
            begin
             tblCredit.Open;
             tblCredit.Last;
             tblCredit.Insert;
             tblCredit['ID'] := frmMain.LoggedInID;
             tblCredit['Transaction Date'] := ckDate;
             tblCredit['Payee'] := edtPayee.Text;
             tblCredit['Category'] := 'Warning System';
             tblCredit['Amount In'] := StrToInt(edtAmount.Text);
             tblCredit['Transaction Type'] := 'Deposit';
             tblCredit.Post;
             tblCredit.Close;
             ShowMessage('Transaction successful with : ' + #13 + 'ID: '+ frmMain.LoggedInID + #13 + 'Date: ' + DateToStr(Now) + #13 + 'Payee: '+ edtPayee.Text + #13 + 'Amount IN: ' + edtAmount.Text + #13 + 'Transaction: Deposit');
            end;
          end;

         if cbbAccountKies.Items[cbbAccountKies.ItemIndex] = 'Savings Account' then
          begin
           with Connection.Form1 do
            begin
             tblSavings.Open;
             tblSavings.Last;
             tblSavings.Insert;
             tblSavings['ID'] := frmMain.LoggedInID;
             tblSavings['Transaction Date'] := ckDate;
             tblSavings['Payee'] := edtPayee.Text;
             tblSavings['Category'] := 'Warning System';
             tblSavings['Amount Out'] := StrToInt(edtAmount.Text);
             tblSavings['Transaction Type'] := 'Transfer';
              tblCredit.Open;
              tblCredit.Last;
              tblCredit.Insert;
              tblCredit['ID'] := frmMain.LoggedInID;
              tblCredit['Transaction Date'] := ckDate;
              tblCredit['Payee'] := edtPayee.Text;
              tblCredit['Category'] := 'Warning System';
              tblCredit['Amount In'] := StrToInt(edtAmount.Text);
              tblCredit['Transaction Type'] := 'Transfer';
              tblCredit.Post;
              tblCredit.Close;
             tblSavings.Post;
             tblSavings.Close;
             ShowMessage('Transaction successful with : ' + #13 + 'ID: '+ frmMain.LoggedInID + #13 + 'Date: ' + DateToStr(Now) + #13 + 'Payee: '+ edtPayee.Text + #13 + 'Amount IN/OUT: ' + edtAmount.Text + #13 + 'Transaction: Transfer');
            end;
          end;

         if cbbAccountKies.Items[cbbAccountKies.ItemIndex] = 'Checking Account' then
          begin
           with Connection.Form1 do
            begin
             tblChecking.Open;
             tblChecking.Last;
             tblChecking.Insert;
             tblChecking['ID'] := frmMain.LoggedInID;
             tblChecking['Transaction Date'] := ckDate;
             tblChecking['Payee'] := edtPayee.Text;
             tblChecking['Category'] := 'Warning System';
             tblChecking['Amount Out'] := StrToInt(edtAmount.Text);
             tblChecking['Transaction Type'] := 'Transfer';
              tblCredit.Open;
              tblCredit.Last;
              tblCredit.Insert;
              tblCredit['ID'] := frmMain.LoggedInID;
              tblCredit['Transaction Date'] := ckDate;
              tblCredit['Payee'] := edtPayee.Text;
              tblCredit['Category'] := 'Warning System';
              tblCredit['Amount In'] := StrToInt(edtAmount.Text);
              tblCredit['Transaction Type'] := 'Transfer';
              tblCredit.Post;
              tblCredit.Close;
             tblChecking.Post;
             tblChecking.Close;
             ShowMessage('Transaction successful with : ' + #13 + 'ID: '+ frmMain.LoggedInID + #13 + 'Date: ' + DateToStr(Now) + #13 + 'Payee: '+ edtPayee.Text + #13 + 'Amount IN/OUT: ' + edtAmount.Text + #13 + 'Transaction: Transfer');
            end;
          end;
        end;
      end;
    end;
  end;

end;

procedure TfrmTrans.cbbAccountKiesChange(Sender: TObject);
begin
 CheckLock;
 if cbbAccountKies.ItemIndex = 0
  then CheckKies := True
  else CheckKies := False;

 if cbbAccountKies.ItemIndex = 1
  then SavingKies := True
  else SavingKies := False;

 if cbbAccountKies.ItemIndex = 2
  then CreditKies := True
  else CreditKies := False;


 if (frmWarning.LockCheck = False) and (frmWarning.LockSaving = False) and (frmWarning.LockCredit = False) then
  begin
   if cbbAccountKies.ItemIndex = 0 then                                             // As check select is
    begin
     cbbType.Clear;
     cbbType.Items.Add('Deposit');
     cbbType.Items.Add('Purchase');
     cbbType.Items.Add('Transfer');
     cbbType.Items.Add('Check');
    end
   else                                                                             // Andersins
    begin
     cbbType.Clear;
     cbbType.Items.Add('Deposit');
     cbbType.Items.Add('Purchase');
     cbbType.Items.Add('Transfer');
    end;
  end;

end;

procedure TfrmTrans.cbbCategoryTransDropDown(Sender: TObject);
begin
 FrmCategory.ReadToCbb;
end;

procedure TfrmTrans.cbbTypeChange(Sender: TObject);
begin
  CbbTypeTo;
end;

procedure TfrmTrans.cbbTypeSelect(Sender: TObject);
begin
if (frmWarning.chkEnabled.Checked = False) or ((frmWarning.LockCheck = False) and (frmWarning.LockSaving = False) and (frmWarning.LockCredit = False)) then
 begin
  if cbbAccountKies.ItemIndex = 0 then
  begin
   if cbbType.ItemIndex = 3 then                                                  //If Check selected, edtCNumber will enable
    edtCNumber.Enabled := True
   else
    edtCNumber.Enabled := False;
  end;

  if cbbType.ItemIndex = 2 then
   begin                                                                         //if Transfer selected, cbbToAccount will enable
    cbbToAccount.Enabled := True;
    cbbCategoryTrans.Enabled := False;
   end
  else
   begin
    cbbToAccount.Enabled := False;
    cbbCategoryTrans.Enabled := True;
   end;
 end
else
 begin
  if cbbType.Items[cbbType.ItemIndex] = 'Deposit' then
   begin
    cbbCategoryTrans.Enabled := False;
    cbbToAccount.Enabled := False;
    //CbbTypeTo;
   end;

  if cbbType.Items[cbbType.ItemIndex] = 'Transfer' then
   begin
    cbbCategoryTrans.Enabled := False;
    cbbToAccount.Enabled := True;
    CbbTypeTo;
   end;

 end;

end;

procedure TfrmTrans.CbbTypeTo;                                                  //As Transfer gekies word is hier waar
begin
 if cbbType.ItemIndex = 0 then
  begin
    if (frmWarning.LockCheck = true) and (CheckKies = True) then
     begin
      cbbToAccount.Enabled := True;
      cbbToAccount.Clear;
      cbbToAccount.Items.Add('Checking Account');
     // cbbToAccount.Items.Add('Savings Account');
     // cbbToAccount.Items.Add('Credit Account');
     end;

    if (frmWarning.LockSaving = true) and (SavingKies = True) then
     begin
      cbbToAccount.Enabled := True;
      cbbToAccount.Clear;
      cbbToAccount.Items.Add('Savings Account');
      //cbbToAccount.Items.Add('Checking Account');
      //cbbToAccount.Items.Add('Credit Account');
     end;

    if (frmWarning.LockCredit = true) and (CreditKies = True) then
     begin
      cbbToAccount.Enabled := True;
      cbbToAccount.Clear;
      cbbToAccount.Items.Add('Credit Account');
      //cbbToAccount.Items.Add('Checking Account');
      //cbbToAccount.Items.Add('Savings Account');
     end;

  end
 else cbbToAccount.Enabled := False;
end;

procedure TfrmTrans.CheckLock;
begin
 if frmWarning.chkEnabled.Checked = True then                                   //Kom van Warning af
  begin                                                                         //Account se transaksie gaan disable word
     frmWarning.RunBereken;                                                     //Daar sal net deposit kan word
     if frmWarning.LockCheck = true then
      begin
       dtpTime.Enabled := False;
       if cbbAccountKies.ItemIndex = 0 then
        begin
         cbbType.Items.Clear;
         cbbType.Items.Add('Deposit');
        end
       else
        begin
         cbbType.Items.Clear;
         cbbType.Items.add('Transfer');
        end;
       CbbTypeTo;
       edtCNumber.Enabled := False;
      end;

     if frmWarning.LockSaving = true then
      begin
       dtpTime.Enabled := False;
       if cbbAccountKies.ItemIndex = 1 then
        begin
         cbbType.Items.Clear;
         cbbType.Items.Add('Deposit');
        end
       else
        begin
         cbbType.Items.Clear;
         cbbType.Items.add('Transfer');
        end;
       CbbTypeTo;
       edtCNumber.Enabled := False;
      end;

     if frmWarning.LockCredit = true then
      begin
       dtpTime.Enabled := False;
       if cbbAccountKies.ItemIndex = 2 then
        begin
         cbbType.Items.Clear;
         cbbType.Items.Add('Deposit');
        end
       else
        begin
         cbbType.Items.Clear;
         cbbType.Items.add('Transfer');
        end;
       CbbTypeTo;
       edtCNumber.Enabled := False;
      end;
   cbbType.ItemIndex := -1;
  end;
end;

procedure TfrmTrans.chkDatumClick(Sender: TObject);
begin
 if frmWarning.chkEnabled.Checked = False then
  begin
   if chkDatum.Checked = true then
    dtpTime.Enabled := false
   else
    dtpTime.Enabled := True;
  end
 else
  begin
   dtpTime.Enabled := False;
   frmTrans.chkDatum.Checked := True;
  end;
end;

procedure TfrmTrans.FormCreate(Sender: TObject);
begin
frmTrans.Width := 485;
end;

procedure TfrmTrans.FormResize(Sender: TObject);
begin
if HelpDown = False then
 begin
  frmTrans.Width := 485;
  frmTrans.Height := 505;
 end;
end;


 //Ekstra Notas
  //-Die gebruiker gaan hier al sy transaksies gaan kan doen
  //-Die comboboxes gaan verander soos wat die gebuiker
  //die accounts verander.

 //Vloei vanaf hierdie form
  //BUTTONS
   //..bmbHelp --> Maak die help aan die regterkant van die form oop
   //..OK --> FrmMain(Main). Form word geclose en wys n message
   //                        dat die transaksie suksesvol was
end.
