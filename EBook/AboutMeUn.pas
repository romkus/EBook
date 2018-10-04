unit AboutMeUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TAboutMe = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  AboutMe: TAboutMe;

implementation

{$R *.dfm}

procedure TAboutMe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

end.
