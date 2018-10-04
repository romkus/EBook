unit MainUn;

interface

uses
  Windows, Messages,  Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,SysUtils,MyObjects, ExtCtrls, Menus, Buttons,
  AboutProgUn,AboutMeUn,MFirstFaceUn;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    NMenuPages: TMenuItem;
    NMenuMainPage: TMenuItem;
    OpenDialog1: TOpenDialog;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure NMenuMainPageClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
  end;
  TInsertedProcs1=class
    procedure OpenPage(Sender:TObject);
  end;
const ProgName='Книжка';

var
  Form1: TForm1;
  BookOpen:boolean;
  ProcsToSet1:TInsertedProcs1;

implementation


{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
//процедура на подію створення головної форми. Вона приймає вхідну змінну - об'єкт, який її викликав
begin
  Application.Title:=ProgName; {присвоєння назві програми в системі константи
    (назви програми)}
  Self.Caption:=ProgName;  //присвоєння заголовку головної форми тієї ж назви
  MFirstFace:=TMFirstFace.Create(Application); //створення форми заставки із її класу
  MFirstFace.ShowModal;  //відображення форми заставки як модальної форми
  ProcsToSet1:=TInsertedProcs1.Create;
  //створення об'єкта класу з процедурами для обробки ними подій об'єктів
  BookOpen:=false; //ініціювання значення змінної, що вказує на те, чи відкритий підручник
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
//процедура на подію закривання головної форми
begin
  ProcsToSet1.Free;
  //стиряння в пам'яті об'єкта з процедурами для обробки подій об'єктів
  MyObjects.UsingControl.Free;
  //стирання в пам'яті об'єкта форми, що використовувалася для тесту розмірів тексту
  Action:=caFree;
  //задавання вихідній змінній параметра про те, що об'єкт головної форми потрібно стерти в пам'яті
end;

procedure TForm1.FormResize(Sender: TObject);
//процедура обробки події зміни розмірів головної форми
begin
  Refresh; //перемалювати головну форму
end;

procedure TInsertedProcs1.OpenPage(Sender:TObject);
//опис процедури відкривання сторінки по натисненню пункта меню з її ім'ям
var NOWItem:TMenuItem;
    NameOfPageToOpen,s1:string;
    p1:integer;
    NOWForm:TFormPage;
begin
  if BookOpen=true then
  begin
    if Sender.ClassType=TMenuItem then
    begin
      NOWItem:=TMenuItem(Sender);
      NameOfPageToOpen:=NOWItem.Caption;
      if NameOfPageToOpen=Form1.NMenuMainPage.Caption then
      begin
        NameOfPageToOpen:=MyObjects.NameOfMainPage;
        NOWForm:=ImplementOpenPage(NameOfPageToOpen,ZagolovkyOfPages);
      end
      else
      begin
        p1:=pos('.',NameOfPageToOpen);
        s1:=Copy(NameOfPageToOpen,1,p1-1);
        s1:=DeleteWords(s1,CoWAmp);
        s1:=DeleteWords(s1,CoWProbil);
        p1:=StrToInt(s1)-1;
        NOWForm:=ImplementOpenPage('',ZagolovkyOfPages,p1);
      end;
      if NOWForm<>nil then NOWForm.Show;
    end;
  end;
end;

procedure TForm1.NMenuMainPageClick(Sender: TObject);
begin
  ProcsToSet1.OpenPage(Sender);
end;

procedure TForm1.N2Click(Sender: TObject);
var MFileName,NativeDir:string;
    NOWItem:TMenuItem;
    i1:integer;
    NOWForm:TFormPage;
begin
  GetDir(0,NativeDir);
  OpenDialog1.InitialDir:=NativeDir;
  if OpenDialog1.Execute=true then
  begin
    Randomize;
    MFileName:=OpenDialog1.FileName;
    OpenFile(MFileName);
    ZagolovkyOfPages:=findpages;
    for i1:=0 to high(ZagolovkyOfPages) do
    begin
      NOWItem:=TMenuItem.Create(application);
      NOWItem.Caption:=IntToStr(i1+1)+'.'+ZagolovkyOfPages[i1].Caption;
      NOWItem.OnClick:=ProcsToSet1.OpenPage;
      NMenuPages.Insert(i1+1,NOWItem);
    end;
    with MyObjects.Answers1 do
    begin
      TrueAnswers:=0;
      FalseAnswers:=0;
      SystemMarkings:=nil;
      DefSystemMarking:=5;
      ControlsToShow:=nil;
      ControlsToShowFalse:=nil;
      ControlsToShowTrue:=nil;
    end;
    if MyObjects.NameOfBook<>'' then
    begin
      Self.Caption:=Self.Caption+' - '+MyObjects.NameOfBook;
      Application.Title:=Self.Caption;
    end;
    BookOpen:=true;
    NOWForm:=ImplementOpenPage(NameOfMainPage,ZagolovkyOfPages);
    if NOWForm<>nil then NOWForm.Show;
  end;
end;

procedure TForm1.N3Click(Sender: TObject);
var p1,p2:integer;
    NOWForm:TFormPage;
    NOWItem:TMenuItem;
begin
  p1:=0;
  p2:=Application.ComponentCount-1;
  while p1<=p2 do
  begin
    if (Application.Components[p1].ClassType=TFormPage) then
    begin
      NOWForm:=TFormPage(Application.Components[p1]);
      if (NOWForm<>nil) then
      begin
        NOWForm.Free;
        p2:=Application.ComponentCount-1;
        p1:=0;
      end
      else p1:=p1+1;
    end
    else p1:=p1+1;
  end;
  p1:=0;
  p2:=NMenuPages.Count-1;
  while p1<=p2 do
  begin
    NOWItem:=TMenuItem(NMenuPages.Items[p1]);
    if (NOWItem<>nil) and (NOWItem<>NMenuMainPage) then
    begin
      NOWItem.Free;
      p2:=NMenuPages.Count-1;
      p1:=0;
    end
    else p1:=p1+1;
  end;
  with MyObjects.Answers1 do
  begin
    TrueAnswers:=0;
    FalseAnswers:=0;
    SystemMarkings:=nil;
    DefSystemMarking:=5;
    ControlsToShow:=nil;
  end;
  Application.Title:=ProgName;
  Self.Caption:=ProgName;
  BookOpen:=false;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  MyObjects.RefreshPages(MyObjects.ZagolovkyOfPages);
end;

procedure TForm1.N8Click(Sender: TObject);
begin
  AboutProg:=TAboutProg.Create(Application);
  AboutProg.Show;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
  AboutMe:=TAboutMe.Create(Application);
  AboutMe.Show;
end;

end.
