program EBook;

uses
  Forms,
  MainUn in 'MainUn.pas' {Form1},
  MyObjects in 'MyObjects.pas' {FormPage},
  AboutProgUn in 'AboutProgUn.pas' {AboutProg},
  AboutMeUn in 'AboutMeUn.pas' {AboutMe},
  MFirstFaceUn in 'MFirstFaceUn.pas' {MFirstFace};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
