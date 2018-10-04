unit MFirstFaceUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TMFirstFace = class(TForm)
    Timer1: TTimer;
    Image1: TImage;
    procedure FormClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  end;

var
  MFirstFace: TMFirstFace;

implementation

{$R *.dfm}

procedure TMFirstFace.FormClick(Sender: TObject);
begin
  Close;
end;

procedure TMFirstFace.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=CaFree;
  Action:=caFree;
end;

procedure TMFirstFace.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Self.OnClick(Sender);
end;

procedure TMFirstFace.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Self.OnClick(Sender);
end;

procedure TMFirstFace.FormCreate(Sender: TObject);
begin
  Self.Timer1.Enabled:=true;
end;

procedure TMFirstFace.Timer1Timer(Sender: TObject);
begin
  Self.Close;
end;

procedure TMFirstFace.Image1Click(Sender: TObject);
begin
  Self.OnClick(Sender);
end;

procedure TMFirstFace.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Self.OnClick(Sender);
end;

end.
