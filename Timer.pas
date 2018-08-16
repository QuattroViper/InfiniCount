unit Timer;

interface
uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
TTimer = class(TThread)
   protected
    procedure execute; override;
  end;

implementation

uses admin;

{ TTimer }

procedure TTimer.execute;
var
 iInc : integer;
 OnTerminate : TNotifyEvent;
begin
  inherited;
  FreeOnTerminate := True;
  iInc := 1;
 while not Terminated do
  begin
   repeat
    Sleep(1);
    Inc(iInc);
   until iInc = 600000;
   if iInc = 600000 then
    begin
     ShowMessage('For security purposes, every 10 minutes you will be signed out of the Admin');
     frmAdmin.Close;
     Self.Terminate;
    end;
  end;
end;

  //Ekstra Notas
   //Is verbonde aan die Admin form
end.
