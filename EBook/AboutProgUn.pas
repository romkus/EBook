unit AboutProgUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TAboutProg = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    Edit3: TEdit;
    Edit4: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  AboutProg: TAboutProg;

implementation

{$R *.dfm}

procedure TAboutProg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

end.
