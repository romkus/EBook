unit MyObjects;

interface
uses SysUtils,Variants,Controls,Forms,Dialogs,StdCtrls, Classes,
     Graphics,Types,ComCtrls,Buttons,Messages,Math,Windows,ExtCtrls;

  type
    TMyPage=class(TWinControl)
      {procedure MyResize(Sender:TObject);}
    public
      place:longint;
      publicCaption:string;
      StepX,StepY,NewX,NewY,MLineHeight:integer;
    end;

    mwords=array of string;
    mzagolovok=record
      Caption:string;
      Place:longint;
    end;
    mzagolovky=array of mzagolovok;

    mpages=array of TMyPage;
    MPlusMinus=(PMMinus,PMNone,PMPlus);
    MControls=array of TControl;
    MIntegers=array of integer;
    MBooleans=array of boolean;
    MAnswers=record
      TrueAnswers,FalseAnswers,DefSystemMarking:integer;
      SystemMarkings:MIntegers;
      ControlsToShow:MControls;
      ControlsToShowFalse:MControls;
      ControlsToShowTrue:MControls;
    end;
    MMark=record
      Mark:integer;
      PlusMinus:MPlusMinus;
    end;
    TFormPage = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    private
      { Private declarations }
    public
      NOWPage:TMyPage;
      WindowNormalRectangle:TRect;
    protected
      Maximized:boolean;
      procedure FormResize1(var Msg:TMessage); message WM_SysCommand;
      procedure FormClose1(Sender:TObject;var Action:TCloseAction);
    end;
  function ImplementOpenPage(NameOfPageToOpen:string;ZagolovkyOfPages:mzagolovky;NumberOfPage:integer=-1):TFormPage;
  function BuildPage(FormToPlace:TForm;Zagolovok:mzagolovok):TMyPage;
  function GetWords(s,SubstringMarker:string):mwords;
  function PosWord(SubString,SourceString:string;SubStringMarker:string=' '):integer;
  function GetStringBetween(BeforeSymbols,AfterSymbols,
    SourceString:string;IfNotFoundThenWholeString:boolean=true;
    BeforeLast:boolean=false;AfterLast:boolean=false;
    BeforeAfterCaseIgnore:boolean=true):string;
  function GetStringBetweenAndRemained(BeforeSymbols,AfterSymbols,
    SourceString:string;var RemainedString:string;
    IfNotFoundThenWholeString:boolean=true;
    BeforeLast:boolean=false;AfterLast:boolean=false;
    BeforeAfterCaseIgnore:boolean=true):string;
  function DeleteWords(SourceString,SubstringMarker:string):string;
  function ReplaceInString(SourceString,StringToFound,StringToSet:string;
    RegistrIgnore:boolean=true):string;
  function FindAndReturnAssigment(StringToFound,SourceString:string):string;
  function FindPages:mzagolovky;
  function CountPages(PagesZagolovky:mzagolovky):longint;
  function OpenFile(mfile:string):boolean;
  function ReadTextOfPage(Zagolovok:mzagolovok):string;
  function GetSubjects(SourseText:string):mwords;
  function GetNumbersOfPages(NameOfPage:string;PagesZagolovky:mzagolovky):MIntegers;
  function MakeNewName(Component:TComponent;FirstName:string):string;
  function GetTextExtent(TextFont:TFont;TestText:string):tagSize;
  function GetRichEditTextExtent(SourceRichEdit:TRichEdit):tagSize;
  function ConvertStringToColor(SourceString:string):integer;
  function DecodeTextString(SourceString:string):string;
  function EncodeTextString(SourceString:string):string;
  function DecodeFontString(SourceString:string;FirstFont:TFont=nil):TFont;
  function DecodeCaption(TextOfObject:string):string;
  procedure DecodeParagraphString(SourceString:string;SourceParagraph:TParaAttributes);
  function DecodeControlsAndProperties(SourceString:string;ParentControl:TWinControl;var NamesAndProperties:mwords):MControls;
  function ConvertStringToAlign(SourceString:string):TAlign;
  function MyFindChildControl(NameToFound:string;SourceControl:TWinControl):TControl;
  function MyFindChildComponent(NameToFound:string;SourceComponent:TComponent):TComponent;
  procedure MyTiles;
  function MakeMark(SourceAnswers:MAnswers;SystemMarking:integer):MMark;
  procedure PutMark(Answer:boolean);
  procedure MySetAlign(SourceControl:TControl;AlignToSet:TAlign);
  function CheckAlignsOfPage(SourcePage:TWinControl):TWinControl;
  function ReceiveOrSendStringToControl(SourceControl:TControl;ToSet:boolean=false;StringToSet:string='#'):string;
  procedure ShowMark(SourceAnswers:MAnswers);
  procedure DisableRestControls(SourceControls:MControls;CanDisableControls:MBooleans);
  procedure MyFreeControlAndAllChildren(SourceControl:TWincontrol);
  function MakeNewGroupIndex(SourceControl:TWinControl):integer;
  procedure RefreshPages(ZagolovkyOfPages:mzagolovky);
  function MyFindForm(SubStringOfCaption:string):TFormPage;
  function MyCloseForm(SourceForm:TForm):boolean;

  function MMakeButton(SourcePage:TMyPage;TextOfObject:string):TControl;
  function MMakeLabel(SourcePage:TMyPage;TextOfObject:string):TControl;
  function MMakeEdit(SourcePage:TMyPage;TextOfObject:string):TControl;
  function MMakeMemo(SourcePage:TMyPage;TextOfObject:string):TControl;
  function MMakeRichEdit(SourcePage:TMyPage;TextOfObject:string):TControl;
  function MMakeRadioButton(SourcePage:TMyPage;TextOfObject:string):TControl;
  function MMakeCheckBox(SourcePage:TMyPage;TextOfObject:string):TControl;
  function MMakePicture(SourcePage:TMyPage;TextOfObject:string):TControl;

  function MDoNewLine(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
  function MDoSetX(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
  function MDoSetY(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
  function MDoSetStepX(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
  function MDoSetStepy(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
  function MDoSetColor(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
  function MDoProcOnButtonsPress(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
  function MDoAlign(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
  function MDoSetShowMark(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
const CoWCaption='caption';CoWFont='font';CoWName='name';
      CowSize='size';CoWStyle='style';CoWBold='bold';CoWBoldC='b';
      CoWItalic='italic';CoWItalicC='i';CoWUnderline='underline';
      CoWUnderlineC='u';CoWStrikeOut='strikeout';CoWStrikeOutC='s';
      CoWApostrof=''''{chr($27)};CoWApostrofC='&ap&';CoWDuzshka1='(';
      CoWDuzshka2=')';CoWKoma=',';CoWProbil=' ';{CoWApostrofCoded='$ap$';}
      CoWColor='color';CoWT='<';CoWTC='&lt&';CoWT1='>';CoWT1C='&gt&';CoWR='/';
      CoWKrapKom=';';CoWKrapKomC='&krkm&';
      CoWKDuzshka1='[';CoWKDuzshka1C='&kdo&';
      CoWKDuzshka2=']';CoWKDuzshka2C='&kdc&';
      CoWRivno='=';CoWRivnoC='&rv&';
      CoWAmp='&';CoWAmpC='&amp&';CoWTrue='yes';CoWFalse='no';
      CoWSetMainPage='setmainpage';CoWSetX='setx';CoWSetY='sety';
      CoWPage='page';CoWTransparent='transparent';CoWFlat='flat';
      CoWSet='set';CoWEnter=chr(13)+chr(10);CoWEnterC='&br&';
      CoWAutoSize='autosize';CoWParagraph='p';CoWAlign='align';
      CoWCenter='center';CoWLeft='left';CoWRight='right';
      CoWTop='top';CoWBottom='bottom';CoWClient='client';CoWCustom='custom';
      CoWLeftIndent='leftindent';CoWFirstLeftIndent='firstleft';
      CoWRightIndent='rightindent';CoWTab='tab';
      CoWButton='Button';CoWAnswer='answer';CoWTrue1='true';
      CoWFalse1='false';CoWShowMessage='showmessage';CoWShowPage='showpage';
      CoWShowMark='showmark';CoWSystemMarking='systemmarking';
      CoWShowFalseCount='showfalsecount';CoWShowTrueCount='showtruecount';
      CoWMinus='-';CoWPlus='+';CoWCheckedControl='checked';
      CoWNumberMarks='numbermarks';
      CoWDisableChecked='disablechecked';CoWDisableSender='disablethis';
      CoWCheckText='checktext';CoWCheckSpaces='checkspaces';CoWCheckCase='checkcase';
      CoWTrueMessage='truemessage';CoWFalseMessage='falsemessage';
      CoWShowPageOnTrue='showpageontrue';CoWShowPageOnFalse='showpageonfalse';
      CoWAlignment='alignment';CoWSelected='selected';CoWUnselected='unselected';
      CoWGrayed='grayed';CoWGroup='group';CoWRadio='radio';CoWDisableRest='disablerest';
      CoWCanDisable='candisable';CoWPicture='picture';CoWTransparentPicture='transparentpicture';
      CoWTitle='title';CoCHNeedKey=13;CoWTabSymb=chr(9);
      NamesOfSubjects:array [0..7] of string = (CoWButton,'Label','Edit','Memo','RichEdit','RadioButton','CheckBox',CoWPicture);
      GenerationFunctions:array [0..7] of function(SourcePage:TMyPage;TextOfObject:string):TControl=(MMakeButton,MMakeLabel,MMakeEdit,
        MMakeMemo,MMakeRichEdit,MMakeRadioButton,MMakeCheckBox,MMakePicture);
      NamesOfDirectives:array[0..8] of string=('NewLine',CoWSetX,CoWSetY,'SetStepX','SetStepY',CoWColor,
        'DoOnButtonsPress',CoWAlign,'SetShowMark');
      DirectivesFunctions:array[0..8]
        of function(SourcePage:TMyPage;TextOfDirective:string):TMyPage=
        (MDoNewLine,MDoSetX,MDoSetY,MDoSetStepX,MDoSetStepY,MDoSetColor,
        MDoProcOnButtonsPress,MDoAlign,MDoSetShowMark);
var
  NameOfMainPage:string='';
  NameOfBook:string='';
  ZagolovkyOfPages:mzagolovky;
  ShowedPages:MBooleans;
  Answers1:MAnswers;
  UsingControl:TForm=nil;
implementation
type
  MCheckTextParams=record
    TextToCheck,TrueMessage,FalseMessage,
      TruePage,FalsePage:string;
    ToCheckText,ToCheckProbils,ToCheckCase:boolean;
  end;
  MParamsForGroupControls=record
    GroupOfControls:MControls;
    CanDisableControls:MBooleans;
    ToDisableRestControls:boolean;
  end;
  OnButFunctions1=class
    constructor Create;
    procedure OnButPress(Sender:TObject);
    procedure OnKeyDown(Sender:TObject;var Key:Word;Shift:TShiftState);
    public
      ToShowPage,ToShowMessage,ToPutMark,
        MarkToPut,ToDisableControl,ToDisableSender:boolean;
      MessageToShow,PageToShow:string;
      NumberMarksForAnswer:integer;
      CheckTextParams:MCheckTextParams;
      ControlIsChecking:TControl;
      ParamsForGroupControls:MParamsForGroupControls;
  end;

var
  fil1:text;

  {$R *.dfm}

procedure TFormPage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MyFreeControlAndAllChildren(Self.NOWPage);
  Action:=caFree;
end;
procedure TFormPage.FormClose1(Sender:TObject;var Action:TCloseAction);
begin
  ShowMessage(Format('Це вікно ("%0:s") не можна окремо закривати... Закрийте для цього книгу, будьласка...',[Self.Caption]));
  Action:=caNone;
end;
{procedure TMyPage.MyResize(Sender:TObject);
var p1:integer;
    NOWControl:TWinControl;
    NOWChildControl:TControl;
begin
  if Sender is TWinControl then
  begin
    NOWControl:=TWinControl(Sender);
    for p1:=0 to NOWControl.ControlCount-1 do
    begin
      if NOWControl.Controls[p1] is TCustomEdit then
      begin
        NOWChildControl:=NOWControl.Controls[p1];
        if NOWChildControl.Left+NOWChildControl.Width>NOWControl.ClientWidth then
        begin

        end;
      end;
    end;
  end;
end;}
function MyCloseForm(SourceForm:TForm):boolean;
var MyCloseAction:TCloseAction;
    Success:boolean;
begin
  MyCloseAction:=caFree;
  SourceForm.OnClose(Application,MyCloseAction);
  if MyCloseAction=caFree then
  begin
    SourceForm.Free;
    Success:=true;
  end
  else Success:=false;
  MyCloseForm:=Success;
end;

procedure RefreshPages(ZagolovkyOfPages:mzagolovky);
var p1,p2:integer;
    MyForms:array of TFormPage;
    s1,s2:string;
    mchar1:char;
    mboolean1:boolean;
begin
  p2:=0;
  for p1:=0 to Application.ComponentCount-1 do
  begin
    if Application.Components[p1] is TFormPage then
    begin
      SetLength(MyForms,p2+1);
      MyForms[p2]:=TFormPage(Application.Components[p1]);
      p2:=p2+1;
    end;
  end;
  for p1:=0 to High(MyForms) do
  begin
    s1:=MyForms[p1].Caption;
    s1:=AnsiLowerCase(s1);
    s2:=CoWProbil+CoWPage;
    s2:=AnsiLowerCase(s2);
    p2:=Pos(s2,s1);
    if p2<>0 then
    begin
      p2:=p2+Length(s2);
      mchar1:=s1[p2];
      s2:='';
      while mchar1 in ['0','1','2','3','4','5','6','7','8','9'] do
      begin
        s2:=s2+mchar1;
        p2:=p2+1;
        mchar1:=s1[p2];
      end;
      p2:=StrToInt(s2);
      p2:=p2-1;
      if p2<=High(ZagolovkyOfPages) then
      begin
        mboolean1:=MyCloseForm(MyForms[p1]);
        if mboolean1=true then
        begin
          MyForms[p1]:=ImplementOpenPage('',ZagolovkyOfPages,p2);
        end;
      end;
    end;
  end;
end;
function MyFindForm(SubStringOfCaption:string):TFormPage;
var s1,s2:string;
    p1,p2:integer;
    Exists:boolean;
    NOWForm:TFormPage;
begin
  Exists:=false;
  NOWForm:=nil;
  s1:=SubStringOfCaption;
  p1:=0;
  while (not(Exists=true)) and (p1<=Application.ComponentCount-1) do
  begin
    if Application.Components[p1] is TFormPage then
    begin
      s2:=TFormPage(Application.Components[p1]).Caption;
      s2:=AnsiLowerCase(s2);
      s1:=AnsiLowerCase(s1);
      p2:=Pos(s1,s2);
      if p2<>0 then
      begin
        NOWForm:=TFormPage(Application.Components[p1]);
        Exists:=true;
      end;
    end;
    p1:=p1+1;
  end;
  MyFindForm:=NOWForm;
end;
function ImplementOpenPage(NameOfPageToOpen:string;ZagolovkyOfPages:mzagolovky;NumberOfPage:integer=-1):TFormPage;
var sname1:string;
    p1,p2,p3:integer;
    NOWForm:TFormPage;
    numbers1:MIntegers;
    ToExit:boolean;
begin
  numbers1:=nil;
  if (NumberOfPage>-1) and (NumberOfPage<=High(ZagolovkyOfPages)) then
    p1:=NumberOfPage
  else
  begin
    numbers1:=GetNumbersOfPages(NameOfPageToOpen,ZagolovkyOfPages);
    if numbers1<>nil then
    begin
      p3:=Random(High(numbers1)+1);
      if p3>High(numbers1) then p3:=High(numbers1);
      if ShowedPages[numbers1[p3]]=true then
      begin
        p2:=0;
        ToExit:=false;
        while (not(ToExit=true)) and (p2<=High(numbers1)) do
        begin
          if not(ShowedPages[numbers1[p2]]=true) then ToExit:=true
            else p2:=p2+1;
        end;
        if p2<=High(numbers1) then p1:=numbers1[p2]
          else p1:=numbers1[p3];
      end
      else p1:=numbers1[p3];
    end
    else p1:=-1;
  end;
  if p1>-1 then
  begin
    ShowedPages[p1]:=true;
    NOWForm:=MyFindForm(CoWPage+IntToStr(p1+1)+CoWProbil);
    if NOWForm=nil then
    begin
      NOWForm:=TFormPage.Create(application);
      NOWForm.NOWPage:=BuildPage(NOWForm,ZagolovkyOfPages[p1]);
      sname1:='Page'+inttostr(p1+1);
      NOWForm.NOWPage.Name:=MakeNewName(NOWForm.NOWPage,sname1);
      NOWForm.NOWPage.Top:=0;
      NOWForm.NOWPage.Left:=NOWForm.NOWPage.Top;
      NOWForm.NOWPage.Show;
      NOWForm.NOWPage.Parent:=NOWForm;
      NOWForm.Name:=MakeNewName(NOWForm,'FormPage');
      NOWForm.Caption:=ZagolovkyOfPages[p1].Caption+' '+NOWForm.NOWPage.Name+' '+NOWForm.Name;
      NOWForm.NOWPage.Realign;
      ImplementOpenPage:=NOWForm;
    end
    else ImplementOpenPage:=NOWForm;
  end
  else ImplementOpenPage:=nil;
end;

function DecodeTextString(SourceString:string):string;
var s:string;
begin
  s:=SourceString;
  s:=ReplaceInString(s,CoWAmpC,CoWAmp);
  s:=ReplaceInString(s,CoWTC,CoWT);
  s:=ReplaceInString(s,CoWT1C,CoWT1);
  s:=ReplaceInString(s,CoWKrapKomC,CoWKrapKom);
  s:=ReplaceInString(s,CoWKDuzshka1C,CoWKDuzshka1);
  s:=ReplaceInString(s,CoWKDuzshka2C,CoWKDuzshka2);
  s:=ReplaceInString(s,CoWRivnoC,CoWRivno);
  s:=ReplaceInString(s,CoWEnterC,CoWEnter);
  s:=ReplaceInString(s,CoWApostrofC,CoWApostrof);
  DecodeTextString:=s;
end;
function EncodeTextString(SourceString:string):string;
var s:string;
begin
  s:=SourceString;
  s:=ReplaceInString(s,CoWAmp,CoWAmpC);
  s:=ReplaceInString(s,CoWT,CoWTC);
  s:=ReplaceInString(s,CoWT1,CoWT1C);
  s:=ReplaceInString(s,CoWKrapKom,CoWKrapKomC);
  s:=ReplaceInString(s,CoWKDuzshka1,CoWKDuzshka1C);
  s:=ReplaceInString(s,CoWKDuzshka2,CoWKDuzshka2C);
  s:=ReplaceInString(s,CoWRivno,CoWRivnoC);
  s:=ReplaceInString(s,CoWEnter,CoWEnterC);
  s:=ReplaceInString(s,CoWApostrof,CoWApostrofC);
  EncodeTextString:=s;
end;
function PosWord(SubString,SourceString:string;SubStringMarker:string=' '):integer;
var p1:integer;
begin
  p1:=Pos(SubStringMarker+SubString+SubstringMarker,SourceString);
  if p1=0 then
  begin
    p1:=Pos(SubString+SubstringMarker,SourceString);
    if p1>1 then p1:=0;
    if p1=0 then
    begin
      p1:=Pos(SubStringMarker+SubString,SourceString);
      if p1<(Length(SourceString)-Length(SubStringMarker+SubString)+1) then p1:=0;
    end;
    if (p1=0) and ((Length(SourceString))<=(Length(SubString)+Length(SubStringMarker))) then
    begin
      p1:=Pos(SubStringMarker+SubString,SourceString);
      if p1=0 then p1:=Pos(SubString+SubStringMarker,SourceString)
      else p1:=p1+Length(SubStringMarker);
      if (p1=0) and ((Length(SourceString))<=(Length(SubString))) then
        p1:=Pos(SubString,SourceString);
    end;
  end
  else p1:=p1+Length(SubStringMarker);
  PosWord:=p1;
end;
function FindAndReturnAssigment(StringToFound,SourceString:string):string;
var s,s1,s2,sprobil:string;
    p1:integer;
    OnlyOneRivno:boolean;
begin
  s:=SourceString;
  s1:=AnsiLowerCase(s);
  sprobil:=CoWProbil;
  p1:=Pos(CoWProbil+StringToFound+CoWRivno,s1);
  if p1=0 then
  begin
    p1:=Pos(StringToFound+CoWRivno,s1);
    if p1=1 then
    begin
      sprobil:='';
    end
    else p1:=0;
  end;
  if p1<>0 then
  begin
    if StringToFound='' then OnlyOneRivno:=true else OnlyOneRivno:=false;
    s2:=GetStringBetween({CoWProbil}sprobil+StringToFound+CoWRivno,CoWRivno,s,true,false,OnlyOneRivno);
    p1:=Pos(CoWApostrof,s2);
    if p1<>0 then s2:=GetStringBetween(CoWApostrof,CoWApostrof,s2,true,false,true)
      else s2:=GetStringBetween(CoWRivno,CoWProbil,s2);
  end
  else s2:='';
  FindAndReturnAssigment:=s2;
end;
function DecodeFontString(SourceString:string;FirstFont:TFont=nil):TFont;
var s,s1,s2:string;
    words1:mwords;
    p2:integer;
    NOWFont:TFont;
begin
  NOWFont:=FirstFont;
  if NOWFont=nil then NOWFont:=TFont.Create;
  words1:=nil;
  s:=SourceString;
  s1:=ansilowercase(s);
  s2:=FindAndReturnAssigment(CoWName,s);
  if s2<>'' then
  begin
    s2:=DecodeTextString(s2);
    NOWFont.Name:=s2;
  end;
  s2:=FindAndReturnAssigment(CoWSize,s);
  if s2<>'' then
  begin
    s2:=DeleteWords(s2,CoWProbil);
    NOWFont.Size:=StrToInt(s2);
  end;
  s2:=FindAndReturnAssigment(CoWStyle,s);
  if s2<>'' then
  begin
    s2:=DeleteWords(s2,CoWProbil);
    s2:=ansilowercase(s2);
    words1:=GetWords(s2,CoWKoma);
    NOWFont.Style:=[];
    for p2:=0 to High(words1) do
    begin
      if words1[p2]=CoWBold then NOWFont.Style:=NOWFont.Style+[fsBold]
      else if words1[p2]=CoWItalic then NOWFont.Style:=NOWFont.Style+[fsItalic]
      else if words1[p2]=CoWUnderline then NOWFont.Style:=NOWFont.Style+[fsUnderline]
      else if words1[p2]=CoWStrikeOut then NOWFont.Style:=NOWFont.Style+[fsStrikeOut];
    end;
  end;
  s2:=FindAndReturnAssigment(CoWColor,s);
  if s2<>'' then
  begin
    s2:=DeleteWords(s2,CoWProbil);
    NOWFont.Color:=ConvertStringToColor(s2);
  end;
  DecodeFontString:=NOWFont;
end;
function DecodeCaption(TextOfObject:string):string;
var s1,s2,sResult:string;
    p1:integer;
begin
  s1:=ansilowercase(TextOfObject);
  sResult:='';
  p1:=pos(CoWT+CoWCaption+CoWt1,s1);
  if p1<>0 then
  begin
    s2:=GetStringBetween(CoWT+CoWCaption+CoWT1,CoWT+CoWR+CoWCaption+CoWT1,TextOfObject);
    s2:=GetStringBetween(CoWApostrof,CoWApostrof,s2,true,false,true);
    s2:=DecodeTextString(s2);
    sResult:=s2;
  end;
  DecodeCaption:=sResult;
end;
procedure DecodeParagraphString(SourceString:string;SourceParagraph:TParaAttributes);
var s,s1:string;
    words1:mwords;
    p1:integer;
begin
  words1:=nil;
  s:=SourceString;
  s1:=FindAndReturnAssigment(CoWAlign,s);
  if s1<>'' then
  begin
    s1:=AnsiLowerCase(s1);
    s1:=DeleteWords(s1,CoWProbil);
    if s1=CoWLeft then
      SourceParagraph.Alignment:=taLeftJustify
      else if s1=CoWRight then
        SourceParagraph.Alignment:=taRightJustify
      else if s1=CoWCenter then
        SourceParagraph.Alignment:=taCenter;
  end;
  s1:=FindAndReturnAssigment(CoWFirstLeftIndent,s);
  if s1<>'' then
  begin
    s1:=DeleteWords(s1,CoWProbil);
    SourceParagraph.FirstIndent:=StrToInt(s1);
  end;
  s1:=FindAndReturnAssigment(CoWLeftIndent,s);
  if s1<>'' then
  begin
    s1:=DeleteWords(s1,CoWProbil);
    SourceParagraph.LeftIndent:=StrToInt(s1);
  end;
  s1:=FindAndReturnAssigment(CoWRightIndent,s);
  if s1<>'' then
  begin
    s1:=DeleteWords(s1,CoWProbil);
    SourceParagraph.RightIndent:=StrToInt(s1);
  end;
  s1:=FindAndReturnAssigment(CoWTab,s);
  if s1<>'' then
  begin
    s1:=DeleteWords(s1,CoWProbil);
    words1:=GetWords(s1,CoWKoma);
    SourceParagraph.TabCount:=0;
    SourceParagraph.TabCount:=High(words1)+1;
    for p1:=0 to High(words1) do
    begin
      SourceParagraph.Tab[p1]:=StrToInt(words1[p1]);
    end;
  end;
end;
function ConvertStringToAlign(SourceString:string):TAlign;
var Align1:TAlign;
    s:string;
begin
  s:=AnsiLowerCase(SourceString);
  if s=CoWLeft then Align1:=alLeft
  else if s=CoWRight then Align1:=alRight
  else if s=CoWTop then Align1:=alTop
  else if s=CoWBottom then Align1:=alBottom
  else if s=CoWClient then Align1:=alClient
  else if s=CoWCustom then Align1:=alCustom
  else Align1:=alNone;
  ConvertStringToAlign:=Align1;
end;
{procedure SetSizesAndAlignAsFirst(SourceControls:array of TControl);
var p1,x,y:integer;
    Align1:TAlign;
begin
  x:=SourceControls[0].Width;
  y:=SourceControls[0].Height;
  Align1:=SourceControls[0].Align;
  for p1:=1 to High(SourceControls) do
  begin
    with SourceControls[p1] do
    begin
      ClientWidth:=x;
      ClientHeight:=y;
      Align:=Align1;
    end;
  end;
end;}
function CheckAlignsOfPage(SourcePage:TWinControl):TWinControl;
var p1:integer;
    NOWPage:TWinControl;
    Aligns1:TAlignSet;
begin
  NOWPage:=SourcePage;
  Aligns1:=[];
  for p1:=0 to NOWPage.ControlCount-1 do
  begin
    if not((NOWPage.Controls[p1].Align) in (Aligns1)) then
    begin
      Aligns1:=Aligns1+[NOWPage.Controls[p1].Align];
    end;
  end;
  if ((alTop in Aligns1) and (alBottom in Aligns1))
    or ((alLeft in Aligns1) and (alRight in Aligns1))
    or ((alLeft in Aligns1) and (alTop in Aligns1))
    or ((alLeft in Aligns1) and (alBottom in Aligns1))
    or ((alRight in Aligns1) and (alTop in Aligns1))
    or ((alRight in Aligns1) and (alBottom in Aligns1))
    or (alClient in Aligns1)
      then NOWPage.Align:=alClient
  else if alTop in Aligns1 then NOWPage.Align:=alTop
  else if alBottom in Aligns1 then NOWPage.Align:=alBottom
  else if alLeft in Aligns1 then NOWPage.Align:=alLeft
  else if alRight in Aligns1 then NOWPage.Align:=alRight
  else if alCustom in Aligns1 then NOWPage.Align:=alCustom
  else NOWPage.Align:=alNone;
  NOWPage.Refresh;
  CheckAlignsOfPage:=NOWPage;
end;
procedure MySetAlign(SourceControl:TControl;AlignToSet:TAlign);
var NOWControl:TControl;
begin
  NOWControl:=SourceControl;
  repeat
    if NOWControl.Parent<>nil then
    begin
      if NOWControl.Parent.ClientWidth<NOWControl.Width then
        NOWControl.Parent.ClientWidth:=NOWControl.Width;
      if NOWControl.Parent.ClientHeight<NOWControl.Height then
        NOWControl.Parent.ClientHeight:=NOWControl.Height;
      NOWControl:=NOWControl.Parent;
    end
    else NOWControl:=nil;
  until NOWControl=nil;
  SourceControl.Align:=AlignToSet;
end;
function MMakeButton(SourcePage:TMyPage;TextOfObject:string):TControl;
var NOWButton:TSpeedButton;
    s,s1,s2,s3:string;
    p1:integer;
    textextent1:tagSize;
    Align1:TAlign;
begin
  NOWButton:=TSpeedButton.Create(SourcePage);
  NOWButton.Parent:=SourcePage;
  s:=GetStringBetween('[',']',TextOfObject);
  if s<>'' then
  begin
    s:=DeleteWords(s,CoWProbil);
    NOWButton.Name:=MakeNewName(NOWButton,s);
  end;
  s:=GetStringBetween(']',';',TextOfObject);
  s1:=ansilowercase(s);
  s2:=DecodeCaption(s);
  NOWButton.Caption:=s2;
  p1:=Pos(CoWT+CoWFont,s1);
  if p1<>0 then
    NOWButton.Font:=DecodeFontString(GetStringBetween(CoWT+CoWFont+CoWProbil,CoWT1,
      s),NOWButton.Font);
  p1:=Pos(CoWT+CoWSet,s1);
  if p1<>0 then
  begin
    s2:=GetStringBetween(CoWT+CoWSet+CoWProbil,CoWT1,s);
    s3:=FindAndReturnAssigment(CoWPicture,s2);
    if s3<>'' then
    begin
      NOWButton.Glyph.LoadFromFile(s3);
    end;
    s3:=FindAndReturnAssigment(CoWTransparentPicture,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      s3:=AnsiLowerCase(s3);
      if (s3=CoWTrue) or (s3=CoWTrue1) then
        NOWButton.Glyph.TransparentMode:=tmAuto
      else
        NOWButton.Glyph.TransparentColor:=SourcePage.Color;
    end;
  end;
  if NOWButton.Caption<>'' then s2:=NOWButton.Caption
    else s2:=CoWProbil;
  textextent1:=GetTextExtent(NOWButton.Font,s2);
  NOWButton.ClientWidth:=textextent1.cx+10+NOWButton.Glyph.Width;
  if textextent1.cy<NOWButton.Glyph.Height then
    textextent1.cy:=NOWButton.Glyph.Height;
  NOWButton.ClientHeight:=textextent1.cy+5;
  p1:=Pos(CoWT+CoWSet,s1);
  if p1<>0 then
  begin
    s2:=GetStringBetween(CoWT+CoWSet+CoWProbil,CoWT1,s);
    s3:=FindAndReturnAssigment(CoWFlat,s2);
    if s3<>'' then
    begin
      s3:=AnsiLowerCase(s3);
      if s3=CoWTrue then
      begin
        NOWButton.Flat:=true;
        NOWButton.Transparent:=false;
      end
      else NOWButton.Flat:=false;
    end;
    s3:=FindAndReturnAssigment(CoWTransparent,s2);
    if s3<>'' then
    begin
      s3:=AnsiLowerCase(s3);
      if s3=CoWTrue then
      begin
        NOWButton.Flat:=true;
        NOWButton.Transparent:=true;
      end
      else NOWButton.Transparent:=false;
    end;
    s3:=FindAndReturnAssigment(CoWAlign,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      Align1:=ConvertStringToAlign(s3);
      MySetAlign(NOWButton,Align1){)};
      CheckAlignsOfPage(SourcePage);
    end;
  end;
  MMakeButton:=NOWButton;
end;
function MMakePicture(SourcePage:TMyPage;TextOfObject:string):TControl;
var NOWImage:TImage;
    s,s1,s2,s3:string;
    p1,dx1,dy1:integer;
    Align1:TAlign;
    words1:mwords;
begin
  words1:=nil;
  NOWImage:=TImage.Create(SourcePage);
  NOWImage.Parent:=SourcePage;
  s:=GetStringBetween('[',']',TextOfObject);
  if s<>'' then
  begin
    s:=DeleteWords(s,CoWProbil);
    NOWImage.Name:=MakeNewName(NOWImage,s);
  end;
  s:=GetStringBetween(']',';',TextOfObject);
  s1:=ansilowercase(s);
  p1:=Pos(CoWT+CoWSet,s1);
  if p1<>0 then
  begin
    s2:=GetStringBetween(CoWT+CoWSet+CoWProbil,CoWT1,s);
    s3:=FindAndReturnAssigment(CoWPicture,s2);
    if s3<>'' then
    begin
      NOWImage.Picture.LoadFromFile(s3);
      NOWImage.ClientWidth:=NOWImage.Picture.Bitmap.Width;
      NOWImage.ClientHeight:=NOWImage.Picture.Bitmap.Height;
    end;
    s3:=FindAndReturnAssigment(CoWTransparent,s2);
    if s3<>'' then
    begin
      s3:=AnsiLowerCase(s3);
      s3:=DeleteWords(s3,CoWProbil);
      if s3=CoWTrue then
        NOWImage.Transparent:=true
      else NOWImage.Transparent:=false;
    end;
    s3:=FindAndReturnAssigment(CoWSize,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      s3:=AnsiLowerCase(s3);
      words1:=GetWords(s3,CoWKoma);
      if High(words1)>=1 then
      begin
        dx1:=StrToInt(words1[0]);
        dy1:=StrToInt(words1[1]);
        if NOWImage.Width<dx1 then NOWImage.Width:=dx1;
        if NOWImage.Height<dy1 then NOWImage.Height:=dy1;
      end;
    end;
    s3:=FindAndReturnAssigment(CoWAlign,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      Align1:=ConvertStringToAlign(s3);
      MySetAlign(TControl(NOWImage),Align1);
      CheckAlignsOfPage(SourcePage);
      if NOWImage.Align=alClient then
        NOWImage.Stretch:=true;
    end;
  end;
  MMakePicture:=NOWImage;
end;
function MakeMark(SourceAnswers:MAnswers;SystemMarking:integer):MMark;
var NOWAnswers:MAnswers;
    NOWMark:MMark;
    p1,markRounded:integer;
    mark1,mark1_1:extended;
begin
  NOWAnswers:=SourceAnswers;
  with NOWAnswers do
  begin
    with NOWMark do
    begin
      p1:=TrueAnswers+FalseAnswers;
      if p1=0 then
      begin
        PlusMinus:=PMNone;
        Mark:=SystemMarking;
      end
      else
      begin
        mark1:=((TrueAnswers*(SystemMarking-1))/p1)+1;
        markRounded:=Round(mark1);
        mark1_1:=markRounded;
        if (mark1<mark1_1) then
          PlusMinus:=PMMinus
          else if (mark1=mark1_1) then
            PlusMinus:=PMNone
          else PlusMinus:=PMPlus;
        Mark:=markRounded;
      end;
    end;
  end;
  MakeMark:=NOWMark;
end;
function ReceiveOrSendStringToControl(SourceControl:TControl;ToSet:boolean=false;StringToSet:string='#'):string;
var s1:string;
begin
  s1:='';
  if SourceControl<>nil then
  begin
    if SourceControl is TCustomEdit then
    begin
      s1:=TCustomEdit(SourceControl).Text;
      if ToSet=true then
        TCustomEdit(SourceControl).Text:=StringToSet;
    end
    else if SourceControl is TLabel then
    begin
      s1:=TLabel(SourceControl).Caption;
      if ToSet=true then
        TLabel(SourceControl).Caption:=StringToSet;
    end
    else if SourceControl is TSpeedButton then
    begin
      if TSpeedButton(SourceControl).Down=true then
        s1:=CoWSelected
      else s1:=CoWUnselected;
      if ToSet=true then
        TSpeedButton(SourceControl).Caption:=StringToSet;
    end
    else if SourceControl is TButton then
    begin
      s1:=TButton(SourceControl).Caption;
      if ToSet=true then
        TButton(SourceControl).Caption:=StringToSet;
    end
    else if SourceControl is TRadioButton then
    begin
      if TRadioButton(SourceControl).Checked=true then
        s1:=CoWSelected
      else s1:=CoWUnselected;
      if ToSet=true then
        TRadioButton(SourceControl).Caption:=StringToSet;
    end
    else if SourceControl is TCheckBox then
    begin
      if TCheckBox(SourceControl).State=cbChecked then
        s1:=CoWSelected
      else if TCheckBox(SourceControl).State=cbGrayed then
        s1:=CoWGrayed
      else s1:=CoWUnselected;
      if ToSet=true then
        TCheckBox(SourceControl).Caption:=StringToSet;
    end;
  end;
  ReceiveOrSendStringToControl:=s1;
end;
procedure ShowMark(SourceAnswers:MAnswers);
var p1:integer;
    s1:string;
    NOWMark:MMark;
begin
  if SourceAnswers.ControlsToShow<>nil then
  begin
    for p1:=0 to High(SourceAnswers.ControlsToShow) do
    begin
      if SourceAnswers.ControlsToShow[p1]<>nil then
      begin
        NOWMark:=MakeMark(SourceAnswers,SourceAnswers.SystemMarkings[p1]);
        s1:=IntToStr(NOWMark.Mark);
        if NOWMark.PlusMinus=PMMinus then s1:=s1+CoWMinus
          else if NOWMark.PlusMinus=PMPlus then s1:=s1+CoWPlus;
        ReceiveOrSendStringToControl(SourceAnswers.ControlsToShow[p1],true,s1);
      end;
    end;
  end;
  if SourceAnswers.ControlsToShowFalse<>nil then
  begin
    for p1:=0 to High(SourceAnswers.ControlsToShowFalse) do
    begin
      if SourceAnswers.ControlsToShowFalse[p1]<>nil then
      begin
        s1:=IntToStr(SourceAnswers.FalseAnswers);
        ReceiveOrSendStringToControl(SourceAnswers.ControlsToShowFalse[p1],true,s1);
      end;
    end;
  end;
  if SourceAnswers.ControlsToShowTrue<>nil then
  begin
    for p1:=0 to High(SourceAnswers.ControlsToShowTrue) do
    begin
      if SourceAnswers.ControlsToShowTrue[p1]<>nil then
      begin
        s1:=IntToStr(SourceAnswers.TrueAnswers);
        ReceiveOrSendStringToControl(SourceAnswers.ControlsToShowTrue[p1],true,s1);
      end;
    end;
  end;
end;
procedure PutMark(Answer:boolean);
begin
  with Answers1 do
  begin
    if Answer=true then
      TrueAnswers:=TrueAnswers+1
      else FalseAnswers:=FalseAnswers+1;
  end;
end;
function DecodeControl(SourceString:string;ParentControl:TWinControl):TControl;
var s1:string;
    NOWControl:TControl;
begin
  s1:=GetStringBetween(CoWT,CoWProbil,SourceString);
  NOWControl:=MyFindChildControl(s1,ParentControl);
  DecodeControl:=NOWControl;
end;
function DecodeControlsAndProperties(SourceString:string;ParentControl:TWinControl;var NamesAndProperties:mwords):MControls;
var p1,p2:integer;
    s,s1:string;
    words1:mwords;
    NOWControl:TControl;
    NOWControls:MControls;
begin
  s:=SourceString;
  p1:=Pos(CoWT,s);
  words1:=nil;
  NOWControls:=nil;
  p2:=0;
  while p1<>0 do
  begin
    s1:=GetStringBetweenAndRemained(CoWT,CoWT1,s,s);
    NOWControl:=DecodeControl(s1,ParentControl);
    if NOWControl<>nil then
    begin
      SetLength(words1,p2+1);
      words1[p2]:=s1;
      SetLength(NOWControls,p2+1);
      NOWControls[p2]:=NOWControl;
      p2:=p2+1;
    end;
    p1:=Pos(CoWT,s);
  end;
  NamesAndProperties:=words1;
  DecodeControlsAndProperties:=NOWControls;
end;
function MDoSetShowMark(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
var NOWControls:MControls;
    words1:mwords;
    p1,p2,p3,p4:integer;
    s1:string;
begin
  if SourcePage.Parent is TFormPage then
    TFormPage(SourcePage.Parent).OnClose:=TFormPage(SourcePage.Parent).FormClose1;
  NOWControls:=DecodeControlsAndProperties(TextOfDirective,SourcePage,words1);
  if NOWControls<>nil then
  begin
    p2:=High(Answers1.ControlsToShow)+1;
    p3:=High(Answers1.ControlsToShowFalse)+1;
    p4:=High(Answers1.ControlsToShowTrue)+1;
    for p1:=0 to High(NOWControls) do
    begin
      if NOWControls[p1]<>nil then
      begin
        s1:=FindAndReturnAssigment(CoWShowMark,words1[p1]);
        if s1<>'' then
        begin
          s1:=DeleteWords(s1,CoWProbil);
          s1:=AnsiLowerCase(s1);
          if (s1=CoWTrue) or (s1=CoWTrue1) then
          begin
            SetLength(Answers1.ControlsToShow,p2+1);
            Answers1.ControlsToShow[p2]:=NOWControls[p1];
            s1:=FindAndReturnAssigment(CoWSystemMarking,words1[p1]);
            SetLength(Answers1.SystemMarkings,p2+1);
            if s1<>'' then
              Answers1.SystemMarkings[p2]:=StrToInt(s1)
            else Answers1.SystemMarkings[p2]:=Answers1.DefSystemMarking;
            p2:=p2+1;
          end;
        end;
        s1:=FindAndReturnAssigment(CoWShowFalseCount,words1[p1]);
        if s1<>'' then
        begin
          s1:=DeleteWords(s1,CoWProbil);
          s1:=AnsiLowerCase(s1);
          if (s1=CoWTrue) or (s1=CoWTrue1) then
          begin
            SetLength(Answers1.ControlsToShowFalse,p3+1);
            Answers1.ControlsToShowFalse[p3]:=NOWControls[p1];
            p3:=p3+1;
          end;
        end;
        s1:=FindAndReturnAssigment(CoWShowTrueCount,words1[p1]);
        if s1<>'' then
        begin
          s1:=DeleteWords(s1,CoWProbil);
          s1:=AnsiLowerCase(s1);
          if (s1=CoWTrue) or (s1=CoWTrue1) then
          begin
            SetLength(Answers1.ControlsToShowTrue,p4+1);
            Answers1.ControlsToShowTrue[p4]:=NOWControls[p1];
            p4:=p4+1;
          end;
        end;
      end;
    end;
  end;
  ShowMark(Answers1);
  MDoSetShowMark:=SourcePage;
end;
procedure DisableRestControls(SourceControls:MControls;CanDisableControls:MBooleans);
var p1,p2:integer;
    CanSucces:boolean;
begin
  if SourceControls<>nil then
  begin
    CanSucces:=true;
    if High(SourceControls)>High(CanDisableControls) then
      p2:=High(SourceControls)
    else p2:=High(CanDisableControls);
    for p1:=0 to p2 do
    begin
      if SourceControls[p1]<>nil then
        if (not(CanDisableControls[p1]=true)) and (SourceControls[p1].Enabled=true) then
          CanSucces:=false;
    end;
    if CanSucces=true then
      for p1:=0 to p2 do
      begin
        if SourceControls[p1]<>nil then
          SourceControls[p1].Enabled:=false;
      end;
  end;
end;
constructor OnButFunctions1.Create;
begin
  inherited Create;
  ToShowPage:=false;
  ToShowMessage:=false;
  ToPutMark:=false;
  MarkToPut:=true;
  NumberMarksForAnswer:=1;
  with CheckTextParams do
  begin
    ToCheckText:=false;
    ToCheckProbils:=false;
    ToCheckCase:=false;
    TrueMessage:='Відповідь "%s" вірна';
    FalseMessage:='Відповідь "%0:s" не вірна. Правильно є "%1:s"';
    TruePage:='';
    FalsePage:='';
  end;
  with ParamsForGroupControls do
  begin
    GroupOfControls:=nil;
    CanDisableControls:=nil;
    ToDisableRestControls:=false;
  end;
end;
procedure OnButFunctions1.OnButPress(Sender:TObject);
var NOWForm:TFormPage;
    s1,s2:string;
    p1:integer;
begin
  if ToShowMessage=true then
    ShowMessage(MessageToShow);
  if ToPutMark=true then
  begin
    for p1:=1 to NumberMarksForAnswer do PutMark(MarkToPut);
    ShowMark(Answers1);
  end;
  if ToShowPage=true then
  begin
    NOWForm:=ImplementOpenPage(PageToShow,ZagolovkyOfPages);
    if NOWForm<>nil then NOWForm.Show;
  end;
  with CheckTextParams do
  begin
    if ToCheckText=true then
    begin
      s1:=ReceiveOrSendStringToControl(ControlIsChecking);
      s2:=TextToCheck;
      if not(ToCheckProbils=true) then
      begin
        s1:=DeleteWords(s1,CoWProbil);
        s2:=DeleteWords(s2,CoWProbil);
      end;
      if not(ToCheckCase=true) then
      begin
        s1:=AnsiLowerCase(s1);
        s2:=AnsiLowerCase(s2);
      end;
      if s1=s2 then
      begin
        MarkToPut:=true;
        if TrueMessage<>'' then ShowMessage(Format(TrueMessage,[s1]));
        if TruePage<>'' then
        begin
          NOWForm:=ImplementOpenPage(TruePage,ZagolovkyOfPages);
          if NOWForm<>nil then NOWForm.Show;
        end;
      end
      else
      begin
        MarkToPut:=false;
        if FalseMessage<>'' then ShowMessage(Format(FalseMessage,[s1,s2]));
        if FalsePage<>'' then
        begin
          NOWForm:=ImplementOpenPage(FalsePage,ZagolovkyOfPages);
          if NOWForm<>nil then NOWForm.Show;
        end;
      end;
      for p1:=1 to Self.NumberMarksForAnswer do
        PutMark(MarkToPut);
      ShowMark(Answers1);
    end;
  end;
  if (ToDisableSender=true) and (Sender<>nil) and (Sender is TControl) then
    TControl(Sender).Enabled:=false;
  if (ToDisableControl=true) and (ControlIsChecking<>nil) then
    ControlIsChecking.Enabled:=false;
  with ParamsForGroupControls do
  begin
    if ToDisableRestControls=true then
      DisableRestControls(GroupOfControls,CanDisableControls);
  end;
end;
procedure OnButFunctions1.OnKeyDown(Sender:TObject;var Key:word;Shift:TShiftState);
begin
  if Key=CoCHNeedKey then
  begin
    OnButPress(Sender);
  end;
end;
function MyFindChildControl(NameToFound:string;SourceControl:TWinControl):TControl;
var NOWControl:TControl;
    p1:integer;
    ItIsFound:boolean;
begin
  NOWControl:=nil;
  p1:=0;
  ItIsFound:=false;
  while (p1<=SourceControl.ControlCount-1) and (not(ItIsFound=true)) do
  begin
    if AnsiLowerCase(SourceControl.Controls[p1].Name)=
      AnsiLowerCase(NameToFound) then
    begin
      NOWControl:=SourceControl.Controls[p1];
      ItIsFound:=true;
    end
    else p1:=p1+1;
  end;
  MyFindChildControl:=NOWControl;
end;
function MyFindChildComponent(NameToFound:string;SourceComponent:TComponent):TComponent;
var NOWComponent:TComponent;
    p1:integer;
    ItIsFound:boolean;
begin
  NOWComponent:=nil;
  p1:=0;
  ItIsFound:=false;
  while (p1<=SourceComponent.ComponentCount-1) and (not(ItIsFound=true)) do
  begin
    if AnsiLowerCase(SourceComponent.Components[p1].Name)=
      AnsiLowerCase(NameToFound) then
    begin
      NOWComponent:=SourceComponent.Components[p1];
      ItIsFound:=true;
    end
    else p1:=p1+1;
  end;
  MyFindChildComponent:=NOWComponent;
end;
procedure MyFreeControlAndAllChildren(SourceControl:TWincontrol);
var NOWControl:TWinControl;
    p1:integer;
begin
  NOWControl:=SourceControl;
  p1:=0;
  while p1<=NOWControl.ControlCount-1 do
  begin
    if NOWControl.Controls[p1] is TWinControl then
    begin
      MyFreeControlAndAllChildren(TWinControl(NOWControl.Controls[p1]));
      NOWControl.Controls[p1].Free;
    end
    else
    begin
      NOWControl.Controls[p1].Free;
    end;
  end;
end;
function MakeNewGroupIndex(SourceControl:TWinControl):integer;
var p1,p2:integer;
begin
  p2:=0;
  for p1:=0 to SourceControl.ControlCount-1 do
  begin
    if SourceControl.Controls[p1] is TSpeedButton then
    begin
      if p2<TSpeedButton(SourceControl.Controls[p1]).GroupIndex then
        p2:=TSpeedButton(SourceControl.Controls[p1]).GroupIndex;
    end;
  end;
  MakeNewGroupIndex:=p2+1;
end;
function MDoProcOnButtonsPress(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
var s,s1,s2,s3,s4:string;
    p1,p2,p3:integer;
    NOWPage:TMyPage;
    NOWButton:TSpeedButton;
    NOWFunctions:OnButFunctions1;
    NOWControl:TControl;
    NOWGroupIndex:integer;
    MasyvOfControls:MControls;
    CanDisableControls:MBooleans;
begin
  NOWGroupIndex:=0;
  MasyvOfControls:=nil;
  NOWPage:=SourcePage;
  s:=TextOfDirective;
  p1:=Pos(CoWT,s);
  while p1<>0 do
  begin
    s1:=GetStringBetweenAndRemained(CoWT,CoWT1,s,s);
    p2:=PosWord(CoWGroup,s1,CoWProbil);
    if p2<>0 then
    begin
      s2:=FindAndReturnAssigment(CoWRadio,s1);
      if s2<>'' then
      begin
        s2:=DeleteWords(s2,CoWProbil);
        s2:=AnsiLowerCase(s2);
        if (s2=CoWTrue) or (s2=CoWTrue1) then
          NOWGroupIndex:=MakeNewGroupIndex(SourcePage)
        else NOWGroupIndex:=0;
      end;
      s2:=GetStringBetween(CoWT,CoWT+CoWR+CoWGroup,s);
      if s2<>'' then
      begin
        s2:=CoWT+s2;
        MasyvOfControls:=nil;
        p3:=0;
        p2:=Pos(CoWT,s2);
        while p2<>0 do
        begin
          s3:=GetStringBetweenAndRemained(CoWT,CoWT1,s2,s2,false);
          NOWControl:=DecodeControl(s3,SourcePage);
          SetLength(MasyvOfControls,p3+1);
          MasyvOfControls[p3]:=NOWControl;
          SetLength(CanDisableControls,p3+1);
          s4:=FindAndReturnAssigment(CoWCanDisable,s3);
          if s4<>'' then
          begin
            s4:=DeleteWords(s4,CoWProbil);
            s4:=AnsiLowerCase(s4);
            if (s4=CoWTrue) or (s4=CoWTrue1) then
              CanDisableControls[p3]:=true
            else CanDisableControls[p3]:=false;
          end
          else
          begin
            s4:=FindAndReturnAssigment(CoWAnswer,s3);
            if s4<>'' then
            begin
              s4:=DeleteWords(s4,CoWProbil);
              s4:=AnsiLowerCase(s4);
              if (s4=CoWTrue) or (s4=CoWTrue1) then
                CanDisableControls[p3]:=false
              else CanDisableControls[p3]:=true;
            end
            else CanDisableControls[p3]:=true;
          end;
          p3:=p3+1;
          p2:=Pos(CoWT,s2);
        end;
      end;
    end;
    p2:=PosWord(CoWR,s1,CoWProbil);
    if p2<>0 then
    begin
      p2:=PosWord(CoWGroup,s1,CoWProbil);
      if p2<>0 then
      begin
        NOWGroupIndex:=0;
        MasyvOfControls:=nil;
      end;
    end;
    NOWControl:=DecodeControl(s1,SourcePage);
    if NOWControl<>nil then
    begin
    s3:='';
        NOWFunctions:=OnButFunctions1.Create;
        s2:=FindAndReturnAssigment(CoWAnswer,s1);
        if s2<>'' then
        begin
          NOWFunctions.ToPutMark:=true;
          s2:=AnsiLowerCase(s2);
          if (s2=CoWTrue1) or (s2=CoWTrue) then NOWFunctions.MarkToPut:=true
            else NOWFunctions.MarkToPut:=false;
        end;
        s2:=FindAndReturnAssigment(CoWShowMessage,s1);
        if s2<>'' then
        begin
          NOWFunctions.ToShowMessage:=true;
          s2:=DecodeTextString(s2);
          NOWFunctions.MessageToShow:=s2;
        end;
        s2:=FindAndReturnAssigment(CoWShowPage,s1);
        if s2<>'' then
        begin
          NOWFunctions.ToShowPage:=true;
          s2:=DecodeTextString(s2);
          NOWFunctions.PageToShow:=s2;
        end;
        s2:=FindAndReturnAssigment(CoWNumberMarks,s1);
        if s2<>'' then
        begin
          s2:=DeleteWords(s2,CoWProbil);
          NOWFunctions.NumberMarksForAnswer:=StrToInt(s2);
        end;
        s2:=FindAndReturnAssigment(CoWDisableSender,s1);
        if s2<>'' then
        begin
          s2:=AnsiLowerCase(s2);
          if (s2=CoWTrue) or (s2=CoWTrue1) then
            NOWFunctions.ToDisableSender:=true
          else NOWFunctions.ToDisableSender:=false;
        end;
        s2:=FindAndReturnAssigment(CoWDisableChecked,s1);
        if s2<>'' then
        begin
          s2:=AnsiLowerCase(s2);
          if (s2=CoWTrue) or (s2=CoWTrue1) then
            NOWFunctions.ToDisableControl:=true
          else NOWFunctions.ToDisableControl:=false;
        end;
        s2:=FindAndReturnAssigment(CoWCheckedControl,s1);
        if s2<>'' then
        begin
          NOWFunctions.ControlIsChecking:=MyFindChildControl(s2,SourcePage);
        end;
        s2:=FindAndReturnAssigment(CoWCheckText,s1);
        if s2<>'' then
        begin
          NOWFunctions.CheckTextParams.ToCheckText:=true;
          s2:=DecodeTextString(s2);
          NOWFunctions.CheckTextParams.TextToCheck:=s2;
        end;
        s2:=FindAndReturnAssigment(CoWCheckSpaces,s1);
        if s2<>'' then
        begin
          s2:=AnsiLowerCase(s2);
          if (s2=CoWTrue) or (s2=CoWTrue1) then
            NOWFunctions.CheckTextParams.ToCheckProbils:=true
          else NOWFunctions.CheckTextParams.ToCheckProbils:=false;
        end;
        s2:=FindAndReturnAssigment(CoWCheckCase,s1);
        if s2<>'' then
        begin
          s2:=AnsiLowerCase(s2);
          if (s2=CoWTrue) or (s2=CoWTrue1) then
            NOWFunctions.CheckTextParams.ToCheckCase:=true
          else NOWFunctions.CheckTextParams.ToCheckCase:=false;
        end;
        s2:=FindAndReturnAssigment(CoWTrueMessage,s1);
        s2:=DecodeTextString(s2);
        NOWFunctions.CheckTextParams.TrueMessage:=s2;
        s2:=FindAndReturnAssigment(CoWFalseMessage,s1);
        s2:=DecodeTextString(s2);
        NOWFunctions.CheckTextParams.FalseMessage:=s2;
        s2:=FindAndReturnAssigment(CoWShowPageOnFalse,s1);
        NOWFunctions.CheckTextParams.FalsePage:=s2;
        s2:=FindAndReturnAssigment(CoWShowPageOnTrue,s1);
        NOWFunctions.CheckTextParams.TruePage:=s2;
        s2:=FindAndReturnAssigment(CoWDisableRest,s1);
        if s2<>'' then
        begin
          s2:=DeleteWords(s2,CoWProbil);
          s2:=AnsiLowerCase(s2);
          if (s2=CoWTrue) or (s2=CoWTrue1) then
          begin
            NOWFunctions.ParamsForGroupControls.GroupOfControls:=MasyvOfControls;
            NOWFunctions.ParamsForGroupControls.CanDisableControls:=CanDisableControls;
            NOWFunctions.ParamsForGroupControls.ToDisableRestControls:=true;
          end;
        end;
        if NOWControl is TSpeedButton then
        begin
          NOWButton:=TSpeedButton(NOWControl);
          NOWButton.GroupIndex:=NOWGroupIndex;
          NOWButton.OnClick:=NOWFunctions.OnButPress;
        end
        else if NOWControl is TCustomEdit then
        begin
          TEdit(NOWControl).OnExit:=NOWFunctions.OnButPress;
          TEdit(NOWControl).OnDblClick:=NOWFunctions.OnButPress;
          if NOWControl.ClassType=TEdit then
            TEdit(NOWControl).OnKeyDown:=NOWFunctions.OnKeyDown;
        end
        else if NOWControl is TButton then
        begin
          TButton(NOWControl).OnClick:=NOWFunctions.OnButPress;
        end
        else if NOWControl is TRadioButton then
        begin
          TRadioButton(NOWControl).OnClick:=NOWFunctions.OnButPress;
        end
        else if NOWControl is TCheckBox then
        begin
          TCheckBox(NOWControl).OnClick:=NOWFunctions.OnButPress;
        end
        else if NOWControl is TLabel then
        begin
          TLabel(NOWControl).OnClick:=NOWFunctions.OnButPress;
        end
        else if NOWControl is TImage then
        begin
          TImage(NOWControl).OnClick:=NOWFunctions.OnButPress;
        end
        else
        begin
          NOWFunctions.Free;
        end;
    end;
    p1:=Pos(CoWT,s);
  end;
  MDoProcOnButtonsPress:=NOWPage;
end;
function MMakeRadioButton(SourcePage:TMyPage;TextOfObject:string):TControl;
var NOWButton:TRadioButton;
    s,s1,s2,s3:string;
    p1:integer;
    textextent1:tagSize;
    Align1:TAlign;
begin
  NOWButton:=TRadioButton.Create(SourcePage);
  NOWButton.Parent:=SourcePage;
  s:=GetStringBetween('[',']',TextOfObject);
  if s<>'' then
  begin
    s:=DeleteWords(s,CoWProbil);
    NOWButton.Name:=MakeNewName(NOWButton,s);
  end;
  s:=GetStringBetween(']',';',TextOfObject);
  s1:=ansilowercase(s);
  s2:=DecodeCaption(s);
  NOWButton.Caption:=s2;
  p1:=Pos(CoWT+CoWFont,s1);
  if p1<>0 then
    NOWButton.Font:=DecodeFontString(GetStringBetween(CoWT+CoWFont+CoWProbil,CoWT1,
      s),NOWButton.Font);
  if NOWButton.Caption<>'' then s2:=NOWButton.Caption
    else s2:=CoWProbil;
  textextent1:=GetTextExtent(NOWButton.Font,s2);
  NOWButton.ClientWidth:=textextent1.cx+30;
  NOWButton.ClientHeight:=textextent1.cy;
  p1:=Pos(CoWT+CoWSet,s1);
  if p1<>0 then
  begin
    s2:=GetStringBetween(CoWT+CoWSet+CoWProbil,CoWT1,s);
    s3:=FindAndReturnAssigment(CoWAlign,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      Align1:=ConvertStringToAlign(s3);
      MySetAlign(TControl(NOWButton),Align1){)};
      CheckAlignsOfPage(SourcePage);
    end;
    s3:=FindAndReturnAssigment(CoWAlignment,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      s3:=AnsiLowerCase(s3);
      if s3=CoWLeft then NOWButton.Alignment:=taLeftJustify
        else if s3=CoWRight then NOWButton.Alignment:=taRightJustify;
    end;
    s3:=FindAndReturnAssigment(CoWColor,s2);
    if s3<>'' then
    begin
      NOWButton.Color:=ConvertStringToColor(s3);
    end;
  end;
  MMakeRadioButton:=NOWButton;
end;
function MMakeCheckBox(SourcePage:TMyPage;TextOfObject:string):TControl;
var NOWCheckBox:TCheckBox;
    s,s1,s2,s3:string;
    p1:integer;
    textextent1:tagSize;
    Align1:TAlign;
begin
  NOWCheckBox:=TCheckBox.Create(SourcePage);
  NOWCheckBox.Parent:=SourcePage;
  s:=GetStringBetween('[',']',TextOfObject);
  if s<>'' then
  begin
    s:=DeleteWords(s,CoWProbil);
    NOWCheckBox.Name:=MakeNewName(NOWCheckBox,s);
  end;
  s:=GetStringBetween(']',';',TextOfObject);
  s1:=ansilowercase(s);
  s2:=DecodeCaption(s);
  NOWCheckBox.Caption:=s2;
  p1:=Pos(CoWT+CoWFont,s1);
  if p1<>0 then
    NOWCheckBox.Font:=DecodeFontString(GetStringBetween(CoWT+CoWFont+CoWProbil,CoWT1,
      s),NOWCheckBox.Font);
  if NOWCheckBox.Caption<>'' then s2:=NOWCheckBox.Caption
    else s2:=CoWProbil;
  textextent1:=GetTextExtent(NOWCheckBox.Font,s2);
  NOWCheckBox.Width:=textextent1.cx+30;
  NOWCheckBox.Height:=textextent1.cy;
  p1:=Pos(CoWT+CoWSet,s1);
  if p1<>0 then
  begin
    s2:=GetStringBetween(CoWT+CoWSet+CoWProbil,CoWT1,s);
    s3:=FindAndReturnAssigment(CoWAlign,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      Align1:=ConvertStringToAlign(s3);
      MySetAlign(TControl(NOWCheckBox),Align1){)};
      CheckAlignsOfPage(SourcePage);
    end;
    s3:=FindAndReturnAssigment(CoWAlignment,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      s3:=AnsiLowerCase(s3);
      if s3=CoWLeft then NOWCheckBox.Alignment:=taLeftJustify
        else if s3=CoWRight then NOWCheckBox.Alignment:=taRightJustify;
    end;
    s3:=FindAndReturnAssigment(CoWColor,s2);
    if s3<>'' then
    begin
      NOWCheckBox.Color:=ConvertStringToColor(s3);
    end;
  end;
  MMakeCheckBox:=NOWCheckBox;
end;
function MMakeLabel(SourcePage:TMyPage;TextOfObject:string):TControl;
var NOWLabel:TLabel;
    s,s1,s2,s3:string;
    p1:integer;
    TextExtent1:tagSize;
    Align1:TAlign;
begin
  NOWLabel:=TLabel.Create(SourcePage);
  NOWLabel.Parent:=SourcePage;
  s:=GetStringBetween('[',']',TextOfObject);
  if s<>'' then
  begin
    s:=DeleteWords(s,CoWProbil);
    NOWLabel.Name:=MakeNewName(NOWLabel,s);
  end;
  s:=GetStringBetween(']',';',TextOfObject);
  s1:=DecodeCaption(s);
  NOWLabel.Caption:=s1;
  s1:=ansilowercase(s);
  p1:=pos(CoWT+CoWFont,s1);
  if p1<>0 then
    NOWLabel.Font:=DecodeFontString(GetStringBetween(CoWT+CoWFont,CoWT1,
      s),NOWLabel.Font);
  if NOWLabel.Caption<>'' then s2:=NOWLabel.Caption
    else s2:=CoWProbil;
  TextExtent1:=GetTextExtent(NOWLabel.Font,s2);
  NOWLabel.Width:=TextExtent1.cx;
  NOWLabel.Height:=TextExtent1.cy;
  p1:=Pos(CoWT+CoWSet,s1);
  if p1<>0 then
  begin
    s2:=GetStringBetween(CoWT+CoWSet,CoWT1,s);
    s3:=FindAndReturnAssigment(CoWTransparent,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      s3:=AnsiLowerCase(s3);
      if s3=CoWTrue then NOWLabel.Transparent:=true
        else NOWLabel.Transparent:=false;
    end;
    s3:=FindAndReturnAssigment(CoWColor,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      s3:=AnsiLowerCase(s3);
      NOWLabel.Color:=ConvertStringToColor(s3);
    end;
    s3:=FindAndReturnAssigment(CoWAlign,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      Align1:=ConvertStringToAlign(s3);
      MySetAlign(TLabel(NOWLabel),Align1);
      CheCkAlignsOfPage(SourcePage);
    end;
  end;
  MMakeLabel:=NOWLabel;
end;
function MMakeEdit(SourcePage:TMyPage;TextOfObject:string):TControl;
var NOWEdit:TEdit;
    s,s1,s2,s3,s4:string;
    p1,p2,dx1,dy1:integer;
    TextExtent1:tagSize;
    words1:mwords;
    Align1:TAlign;
begin
  words1:=nil;
  NOWEdit:=TEdit.Create(SourcePage);
  NOWEdit.Parent:=SourcePage;
  s:=GetStringBetween('[',']',TextOfObject);
  if s<>'' then
  begin
    s:=DeleteWords(s,CoWProbil);
    NOWEdit.Name:=MakeNewName(NOWEdit,s);
  end;
  s:=GetStringBetween(']',';',TextOfObject);
  s1:=DecodeCaption(s);
  NOWEdit.Text:=s1;
  s1:=ansilowercase(s);
  p1:=pos(CoWT+CoWFont,s1);
  if p1<>0 then
    NOWEdit.Font:=DecodeFontString(GetStringBetween(CoWT+CoWFont,CoWT1,
      s),NOWEdit.Font);
  p1:=Pos(CoWT+CoWSet,s1);
  if p1<>0 then
  begin
    s2:=GetStringBetween(CoWT+CoWSet,CoWT1,s);
    s3:=FindAndReturnAssigment(CoWColor,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      s3:=AnsiLowerCase(s3);
      NOWEdit.Color:=ConvertStringToColor(s3);
    end;
    s3:=FindAndReturnAssigment(CoWAutoSize,s2);
    s3:=DeleteWords(s3,CoWProbil);
    if (s3=CoWTrue) or (s3='') then
    begin
      s4:='';
      s3:=NOWEdit.Text;
      while s3<>'' do
      begin
        p2:=pos(CoWEnter,s3);
        if p2=0 then p2:=Length(s3)+1;
        if (p2-1)>Length(s4) then
        begin
          s4:=Copy(s3,1,p2-1);
        end;
        Delete(s3,1,p2+Length(CoWEnter)-1);
      end;
      TextExtent1:=GetTextExtent(NOWEdit.Font,s4);
      NOWEdit.Width:=TextExtent1.cx;
      if s4<>'' then
        NOWEdit.Width:=NOWEdit.Width+GetTextExtent(NOWEdit.Font,s4[Length(s4)]).cx+7;
      if NOWEdit.Text<>'' then s3:=NOWEdit.Text
        else s3:=CoWProbil;
      s4:='';
      p1:=0;
      while s3<>'' do
      begin
        p2:=pos(CoWEnter,s3);
        if p2=0 then p2:=Length(s3)+1;
        s4:=Copy(s3,1,p2-1);
        TextExtent1:=GetTextExtent(NOWEdit.Font,s4);
        p1:=p1+TextExtent1.cy;
        Delete(s3,1,p2+Length(CoWEnter)-1);
      end;
      NOWEdit.Height:=p1+
        Trunc(GetTextExtent(NOWEdit.Font,s4).cy*0.10)+5;
    end
    else
    begin
      NOWEdit.Width:=0;
      NOWEdit.Height:=0;
    end;
    s3:=FindAndReturnAssigment(CoWSize,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      s3:=AnsiLowerCase(s3);
      words1:=GetWords(s3,CoWKoma);
      if High(words1)>=1 then
      begin
        dx1:=StrToInt(words1[0]);
        dy1:=StrToInt(words1[1]);
        if NOWEdit.Width<dx1 then NOWEdit.Width:=dx1;
        if NOWEdit.Height<dy1 then NOWEdit.Height:=dy1;
      end;
    end;
    s3:=FindAndReturnAssigment(CoWAlign,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      Align1:=ConvertStringToAlign(s3);
      MySetAlign(TControl(NOWEdit),Align1);
      CheckAlignsOfPage(SourcePage);
    end;
  end;
  MMakeEdit:=NOWEdit;
end;
function MMakeMemo(SourcePage:TMyPage;TextOfObject:string):TControl;
var NOWMemo:TMemo;
    s,s1,s2,s3,s4:string;
    p1,p2,dx1,dy1:integer;
    TextExtent1:tagSize;
    words1:mwords;
    Align1:TAlign;
begin
  words1:=nil;
  NOWMemo:=TMemo.Create(SourcePage);
  NOWMemo.Parent:=SourcePage;
  s:=GetStringBetween('[',']',TextOfObject);
  if s<>'' then
  begin
    s:=DeleteWords(s,CoWProbil);
    NOWMemo.Name:=MakeNewName(NOWMemo,s);
  end;
  s:=GetStringBetween(']',';',TextOfObject);
  s1:=DecodeCaption(s);
  NOWMemo.Text:=s1;
  s1:=ansilowercase(s);
  p1:=pos(CoWT+CoWFont,s1);
  if p1<>0 then
    NOWMemo.Font:=DecodeFontString(GetStringBetween(CoWT+CoWFont,CoWT1,
      s),NOWMemo.Font);
  p1:=Pos(CoWT+CoWSet,s1);
  if p1<>0 then
  begin
    s2:=GetStringBetween(CoWT+CoWSet,CoWT1,s);
    s3:=FindAndReturnAssigment(CoWColor,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      s3:=AnsiLowerCase(s3);
      NOWMemo.Color:=ConvertStringToColor(s3);
    end;
    s3:=FindAndReturnAssigment(CoWAutoSize,s2);
    s3:=DeleteWords(s3,CoWProbil);
      if (s3=CoWTrue) or (s3='') then
      begin
        s3:=NOWMemo.Text;
        s4:='';
        while s3<>'' do
        begin
          p2:=pos(CoWEnter,s3);
          if p2=0 then p2:=Length(s3)+1;
          if (p2-1)>Length(s4) then
          begin
            s4:=Copy(s3,1,p2-1);
          end;
          Delete(s3,1,p2+Length(CoWEnter)-1);
        end;
        TextExtent1:=GetTextExtent(NOWMemo.Font,s4);
        NOWMemo.Width:=TextExtent1.cx;
        if s4<>'' then
          NOWMemo.Width:=NOWMemo.Width+GetTextExtent(NOWMemo.Font,s4[Length(s4)]).cx+7;
        if NOWMemo.Text<>'' then s3:=NOWMemo.Text
          else s3:=CoWProbil;
        s4:='';
        p1:=0;
        while s3<>'' do
        begin
          p2:=pos(CoWEnter,s3);
          if p2=0 then p2:=Length(s3)+1;
          s4:=Copy(s3,1,p2-1);
          TextExtent1:=GetTextExtent(NOWMemo.Font,s4);
          p1:=p1+TextExtent1.cy;
          Delete(s3,1,p2+Length(CoWEnter)-1);
        end;
        NOWMemo.Height:=p1+
          Trunc(GetTextExtent(NOWMemo.Font,s4).cy*0.10)+5;
      end
      else
      begin
        NOWMemo.Width:=0;
        NOWMemo.Height:=0;
      end;
    s3:=FindAndReturnAssigment(CoWSize,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      s3:=AnsiLowerCase(s3);
      words1:=GetWords(s3,CoWKoma);
      if High(words1)>=1 then
      begin
        dx1:=StrToInt(words1[0]);
        dy1:=StrToInt(words1[1]);
        if NOWMemo.Width<dx1 then NOWMemo.Width:=dx1;
        if NOWMemo.Height<dy1 then NOWMemo.Height:=dy1;
      end;
    end;
    s3:=FindAndReturnAssigment(CoWAlign,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      Align1:=ConvertStringToAlign(s3);
      MySetAlign(TControl(NOWMemo),Align1);
      CheckAlignsOfPage(SourcePage);
    end;
  end;
  MMakeMemo:=NOWMemo;
end;
{function FontToTextAttributes(SourceFont:TFont):TTextAttributes;
var NOWTextAttributes:TTextAttributes;
begin
  NOWTextAttributes:=TTextAttributes.Create(nil,atSelected);
end;}
function GetRichEditTextExtent(SourceRichEdit:TRichEdit):tagSize;
var p1,p2,ppos,tx1,ty1,txall,tyall,tabs,tabpos:integer;
    s,s1,s2:string;
    NOWFont:TFont;
    Size1:tagSize;
begin
  s:=SourceRichEdit.Text;
  ppos:=0;
  txall:=0;
  tyall:=0;
  NOWFont:=TFont.Create;
  while s<>'' do
  begin
    p1:=pos(CoWEnter,s);
    if p1=0 then p1:=Length(s)+1-Length(CoWEnter);
    p1:=p1-1+Length(CoWEnter);
    SourceRichEdit.SelStart:=ppos;
        with SourceRichEdit.SelAttributes do
        begin
          NOWFont.Name:=Name;
          NOWFont.Size:=Size;
          NOWFont.Color:=Color;
          NOWFont.Style:=Style;
          NOWFont.Pitch:=Pitch;
          NOWFont.Charset:=Charset;
        end;
    s1:='';
    tx1:=0;
    tabs:=0;
    p2:=1;
    while p2<=p1 do
    begin
      SourceRichEdit.SelStart:=p2+ppos-1;
      SourceRichEdit.SelLength:=1;
      if (NOWFont.Name=SourceRichEdit.SelAttributes.Name) and
        (NOWFont.Size=SourceRichEdit.SelAttributes.Size) and
        (NOWFont.Color=SourceRichEdit.SelAttributes.Color) and
        (NOWFont.Style=SourceRichEdit.SelAttributes.Style) and
        (NOWFont.Pitch=SourceRichEdit.SelAttributes.Pitch) and
        (NOWFont.Charset=SourceRichEdit.SelAttributes.Charset)
        then
      begin
        s1:=s1+SourceRichEdit.Text[p2+ppos];
        p2:=p2+1;
      end
      else
      begin
        tabpos:=Pos(CoWTabSymb,s1);
        if tabpos<>0 then
        begin
          while tabpos<>0 do
          begin
            if tabs<=SourceRichEdit.Paragraph.TabCount-1 then
            begin
              tx1:=SourceRichEdit.Paragraph.Tab[tabs];
              tabs:=tabs+1;
            end
            else tx1:=tx1+50;
            Delete(s1,tabpos,Length(CoWTabSymb));
            tabpos:=Pos(CoWTabSymb,s1);
          end;
        end;
        tx1:=tx1+
          GetTextExtent(NOWFont,s1).cx;
        with SourceRichEdit.SelAttributes do
        begin
          NOWFont.Name:=Name;
          NOWFont.Size:=Size;
          NOWFont.Color:=Color;
          NOWFont.Style:=Style;
          NOWFont.Pitch:=Pitch;
          NOWFont.Charset:=Charset;
        end;
        s1:='';
      end;
    end;
    with SourceRichEdit.SelAttributes do
    begin
      NOWFont.Name:=Name;
      NOWFont.Size:=Size;
      NOWFont.Color:=Color;
      NOWFont.Style:=Style;
      NOWFont.Pitch:=Pitch;
      NOWFont.Charset:=Charset;
    end;
    SourceRichEdit.SelStart:=ppos;
    SourceRichEdit.SelLength:=p1;
    ty1:=SourceRichEdit.SelAttributes.Height;
    s1:=DeleteWords(s1,CoWEnter);
    if SourceRichEdit.Paragraph.FirstIndent>SourceRichEdit.Paragraph.LeftIndent then
      p2:=SourceRichEdit.Paragraph.FirstIndent
      else
      p2:=SourceRichEdit.Paragraph.LeftIndent;
    tx1:=tx1+p2+
      GetTextExtent(NOWFont,s1).cx+SourceRichEdit.Paragraph.RightIndent;
    if s1='' then s2:='' else s2:=Copy(s1,Length(s1),1);
    tx1:=tx1+(GetTextExtent(NOWFont,s2).cx)+10;
    SourceRichEdit.SelStart:=0;
    if tx1>txall then txall:=tx1;
    tyall:=tyall+trunc(ty1+(ty1/1.7));
    ppos:=ppos+p1;
    Delete(s,1,p1);
  end;
  tyall:=tyall+1;
  NOWFont.Free;
  Size1.cx:=txall;
  Size1.cy:=tyall;
  GetRichEditTextExtent:=Size1;
end;
function MMakeRichEdit(SourcePage:TMyPage;TextOfObject:string):TControl;
type
   MyParagraphAttributes=record
       Alignment:TAlignment;
       LeftIndent:longint;
       FirstIndent:longint;
       RightIndent:longint;
       Tab:array of integer;
       Numbering:TNumberingStyle;
     end;
var NOWRichEdit:TRichEdit;
    NOWFont:TFont;
    s,s1,s2,s3,s4,s5:string;
    p1,p2,dx1,dy1:integer;
    words1:mwords;
    Size1:tagSize;
    ParagraphAttributes1:MyParagraphAttributes;
    Align1:TAlign;
begin
  words1:=nil;
  NOWRichEdit:=TRichEdit.Create(SourcePage);
  NOWRichEdit.Parent:=SourcePage;
  NOWRichEdit.SetFocus;
  s:=GetStringBetween('[',']',TextOfObject);
  if s<>'' then
  begin
    s:=DeleteWords(s,CoWProbil);
    NOWRichEdit.Name:=MakeNewName(NOWRichEdit,s);
  end;
  NOWRichEdit.Text:='';
  NOWRichEdit.ScrollBars:=ssBoth;
  NOWRichEdit.BorderStyle:=bsNone;
  NOWRichEdit.WantTabs:=true;
  s:=GetStringBetween(']',';',TextOfObject);
  s1:=ansilowercase(s);
  GetStringBetweenAndRemained(CoWT+CoWCaption+CoWT1,CoWT+CoWR+CoWCaption+CoWT1,s1,s1,false);
  p1:=pos(CoWT+CoWFont,s1);
  if p1<>0 then
  begin
    NOWFont:=DecodeFontString(GetStringBetween(CoWT+CoWFont,CoWT1,s));
    with NOWRichEdit.DefAttributes do
    begin
      Name:=NOWFont.Name;
      Size:=NOWFont.Size;
      Color:=NOWFont.Color;
      Style:=NOWFont.Style;
      Pitch:=NOWFont.Pitch;
      Charset:=NOWFont.Charset;
    end;
    NOWFont.Free;
  end;
  s1:=ansilowercase(s);
  p1:=pos(CoWT+CoWCaption+CoWt1,s1);
  if p1<>0 then
  begin
    s2:=GetStringBetween(CoWT+CoWCaption+CoWT1,CoWT+CoWR+CoWCaption+CoWT1,s);
    s2:=GetStringBetween(CoWApostrof,CoWApostrof,s2,true,false,true);
    s1:=s2;
    if s1<>'' then
    begin
      s3:=s1;
      NOWRichEdit.SelStart:=0;
      repeat
        p1:=Pos(CoWT,s3);
        if p1=0 then p1:=Length(s3)+1;
        s4:=Copy(s3,1,p1-1);
        Delete(s3,1,p1-1);
        if s4<>'' then
        begin
          s4:=DecodeTextString(s4);
          p2:=Length(NOWRichEdit.Text);
          NOWRichEdit.SelStart:=p2;
          NOWRichEdit.SelText:=s4;
          NOWRichEdit.SelStart:=p2;
          NOWRichEdit.SelLength:=length(s4);
          NOWRichEdit.SelStart:=Length(NOWRichEdit.Text);
        end;
        s4:=ansilowercase(s3);
        p1:=pos(CoWT,s4);
        if p1=1 then
        begin
          s2:=GetStringBetweenAndRemained(CoWT,CoWT1,s3,s1);
          s4:=AnsiLowerCase(s2);
          p1:=Pos(CoWR,s4);
          if p1=1 then
          begin
            s2:=Copy(s2,2,Length(s2));
            s4:=AnsiLowerCase(s2);
            p1:=PosWord(CoWFont,s4);
            if p1=1 then
            begin
              NOWRichEdit.SelStart:=Length(NOWRichEdit.Text);
              NOWRichEdit.SelAttributes:=NOWRichEdit.DefAttributes;
            end;
            p1:=PosWord(CoWBoldC,s4);
            if p1=1 then
            begin
              with NOWRichEdit do
              begin
                if not(fsBold in DefAttributes.Style) then
                  SelAttributes.Style:=SelAttributes.Style-[fsBold];
              end;
            end;
            p1:=PosWord(CoWItalicC,s4);
            if p1=1 then
            begin
              with NOWRichEdit do
              begin
                if not(fsItalic in DefAttributes.Style) then
                  SelAttributes.Style:=SelAttributes.Style-[fsItalic];
              end;
            end;
            p1:=PosWord(CoWUnderlineC,s4);
            if p1=1 then
            begin
              with NOWRichEdit do
              begin
                if not(fsUnderline in DefAttributes.Style) then
                  SelAttributes.Style:=SelAttributes.Style-[fsUnderline];
              end;
            end;
            p1:=PosWord(CoWStrikeOutC,s4);
            if p1=1 then
            begin
              with NOWRichEdit do
              begin
                if not(fsStrikeOut in DefAttributes.Style) then
                  SelAttributes.Style:=SelAttributes.Style-[fsStrikeOut];
              end;
            end;
            p1:=PosWord(CoWParagraph,s4,CoWProbil);
            if p1=1 then
            begin
              NOWRichEdit.SelStart:=Length(NOWRichEdit.Text);
              NOWRichEdit.SelText:=CoWEnter;
              NOWRichEdit.SelStart:=Length(NOWRichEdit.Text);
              with NOWRichEdit.Paragraph do
              begin
                Alignment:=ParagraphAttributes1.Alignment;
                LeftIndent:=ParagraphAttributes1.LeftIndent;
                FirstIndent:=ParagraphAttributes1.FirstIndent;
                RightIndent:=ParagraphAttributes1.RightIndent;
                TabCount:=0;
                TabCount:=High(ParagraphAttributes1.Tab)+1;
                for p1:=0 to High(ParagraphAttributes1.Tab) do
                begin
                  {ParagraphAttributes1.Tab[p1]:=Tab[p1];}
                  Tab[p1]:=ParagraphAttributes1.Tab[p1];
                end;
                Numbering:=ParagraphAttributes1.Numbering;
              end;
            end;
          end
          else
          begin
            p1:=PosWord(CoWFont,s4,CoWProbil);
            if p1=1 then
            begin
              s5:=GetStringBetween(CoWFont,CoWT1,s2,false);
              if s5<>'' then
              begin
                NOWFont:=TFont.Create;
                with NOWRichEdit.DefAttributes do
                begin
                  NOWFont.Name:=Name;
                  NOWFont.Size:=Size;
                  NOWFont.Color:=Color;
                  NOWFont.Style:=Style;
                  NOWFont.Pitch:=Pitch;
                  NOWFont.Charset:=Charset;
                end;
                NOWFont:=DecodeFontString(s5,NOWFont);
                with NOWRichEdit.SelAttributes do
                begin
                  Name:=NOWFont.Name;
                  Size:=NOWFont.Size;
                  Color:=NOWFont.Color;
                  Style:=NOWFont.Style;
                  Pitch:=NOWFont.Pitch;
                  Charset:=NOWFont.Charset;
                end;
                NOWFont.Free;
              end;
            end;
            p1:=PosWord(CoWBoldC,s4);
            if p1=1 then
            begin
              with NOWRichEdit.SelAttributes do
                Style:=Style+[fsBold];
            end;
            p1:=PosWord(CoWItalicC,s4);
            if p1=1 then
            begin
              with NOWRichEdit.SelAttributes do
                Style:=Style+[fsItalic];
            end;
            p1:=PosWord(CoWUnderlineC,s4);
            if p1=1 then
            begin
              with NOWRichEdit.SelAttributes do
                Style:=Style+[fsUnderline];
            end;
            p1:=PosWord(CoWStrikeOutC,s4);
            if p1=1 then
            begin
              with NOWRichEdit.SelAttributes do
                Style:=Style+[fsStrikeOut];
            end;
            p1:=PosWord(CoWParagraph,s4);
            if p1=1 then
            begin
              with NOWRichEdit.Paragraph do
              begin
                ParagraphAttributes1.Alignment:=Alignment;
                ParagraphAttributes1.LeftIndent:=LeftIndent;
                ParagraphAttributes1.FirstIndent:=FirstIndent;
                ParagraphAttributes1.RightIndent:=RightIndent;
                SetLength(ParagraphAttributes1.Tab,TabCount);
                for p1:=0 to High(ParagraphAttributes1.Tab) do
                begin
                  ParagraphAttributes1.Tab[p1]:=Tab[p1];
                end;
                ParagraphAttributes1.Numbering:=Numbering;
              end;
              if Length(NOWRichEdit.Text)>=Length(CoWEnter) then
                s5:=copy(NOWRichEdit.Text,Length(NOWRichEdit.Text)-(Length(CoWEnter)-1),Length(CoWEnter))
                else s5:='';
              NOWRichEdit.SelStart:=Length(NOWRichEdit.Text);
              if (s5<>CoWEnter) and (s5<>'') then
              begin
                NOWRichEdit.SelText:=CoWEnter;
                NOWRichEdit.SelStart:=Length(NOWRichEdit.Text);
              end;
              s5:=GetStringBetween(CoWParagraph,CoWT1,s2,false);
              DecodeParagraphString(s5,NOWRichEdit.Paragraph);
            end;
          end;
          s3:=s1;
        end;
      until s3='';
    end
    else NOWRichEdit.Text:='';
  end;
  s1:=ansilowercase(s);
  p1:=Pos(CoWT+CoWSet+CoWProbil,s1);
  if p1<>0 then
  begin
    s2:=GetStringBetween(CoWT+CoWSet,CoWT1,s);
    s3:=FindAndReturnAssigment(CoWColor,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      s3:=AnsiLowerCase(s3);
      NOWRichEdit.ParentColor:=false;
      NOWRichEdit.Color:=ConvertStringToColor(s3);
    end;
    s3:=FindAndReturnAssigment(CoWAutoSize,s2);
    s3:=DeleteWords(s3,CoWProbil);
    s3:=ansilowercase(s3);
    if s3=CoWTrue then
      begin
        Size1:=GetRichEditTextExtent(NOWRichEdit);
        NOWRichEdit.ClientWidth:=Size1.cx;
        NOWRichEdit.ClientHeight:=Size1.cy;
      end
      else
      begin
        NOWRichEdit.ClientWidth:=0;
        NOWRichEdit.ClientHeight:=0;
      end;
    s3:=FindAndReturnAssigment(CoWSize,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      s3:=AnsiLowerCase(s3);
      words1:=GetWords(s3,CoWKoma);
      if High(words1)>=1 then
      begin
        dx1:=StrToInt(words1[0]);
        dy1:=StrToInt(words1[1]);
        if NOWRichEdit.Width<dx1 then NOWRichEdit.Width:=dx1;
        if NOWRichEdit.Height<dy1 then NOWRichEdit.Height:=dy1;
      end;
    end;
    s3:=FindAndReturnAssigment(CoWAlign,s2);
    if s3<>'' then
    begin
      s3:=DeleteWords(s3,CoWProbil);
      Align1:=ConvertStringToAlign(s3);
      MySetAlign(TControl(NOWRichEdit),Align1);
      CheckAlignsOfPage(SourcePage);
    end;
  end;
  MMakeRichEdit:=NOWRichEdit;
end;
procedure MyTiles;
var p1,p2,p3:integer;
    NOWForm:TForm;
    FormsVertical:array of TForm;
    FormsHorizontal:array of TForm;
begin
  p2:=0;
  p3:=0;
  for p1:=0 to Application.ComponentCount-1 do
  begin
    if Application.Components[p1] is TForm then
    begin
      NOWForm:=TForm(Application.Components[p1]);
      if NOWForm.FormStyle<>fsMDIChild then
      begin
        if (NOWForm.Align=alLeft) or (NOWForm.Align=alRight) then
        begin
          SetLength(FormsVertical,p2+1);
          FormsVertical[p2]:=NOWForm;
          p2:=p2+1;
        end
        else
        if (NOWForm.Align=alTop) or (NOWForm.Align=alBottom) then
        begin
          SetLength(FormsHorizontal,p3+1);
          FormsHorizontal[p3]:=NOWForm;
          p3:=p3+1;
        end;
      end;
    end;
  end;
  p2:=Screen.Width;
  for p1:=0 to High(FormsVertical) do
  begin
    if FormsVertical[p1].Width>p2 then FormsVertical[p1].Width:=p2;
    p2:=p2-FormsVertical[p1].Width;
  end;
  p2:=Screen.Height;
  for p1:=0 to High(FormsHorizontal) do
  begin
    if FormsHorizontal[p1].Height>p2 then FormsHorizontal[p1].Height:=p2;
    p2:=p2-FormsHorizontal[p1].Height;
  end;
end;
function MDoAlign(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
var NOWPage:TMyPage;
    s:string;
begin
  NOWPage:=SourcePage;
  s:=GetStringBetween(']',';',TextOfDirective);
  s:=DeleteWords(s,CoWProbil);
  NOWPage.Parent.Align:=ConvertStringToAlign(s);
  MyTiles;
  MDoAlign:=NOWPage;
end;
function MDoNewLine(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
var NOWPage:TMyPage;
begin
  NOWPage:=SourcePage;
  NOWPage.NewY:=NOWPage.NewY+NOWPage.MLineHeight+NOWPage.StepY;
  NOWPage.NewX:=0;
  NOWPage.MLineHeight:=0;
  MDoNewLine:=NOWPage;
end;
function MDoSetX(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
var NOWPage:TMyPage;
    s:string;
begin
  s:=GetStringBetween(']',';',TextOfDirective);
  s:=DeleteWords(s,CoWProbil);
  NOWPage:=SourcePage;
  NOWPage.MLineHeight:=0;
  NOWPage.NewX:=StrToInt(s);
  MDoSetX:=NOWPage;
end;
function MDoSetY(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
var NOWPage:TMyPage;
    s:string;
begin
  s:=GetStringBetween(']',';',TextOfDirective);
  s:=DeleteWords(s,CoWProbil);
  NOWPage:=SourcePage;
  NOWPage.MLineHeight:=0;
  NOWPage.NewY:=StrToInt(s);
  MDoSetY:=NOWPage;
end;
function MDoSetStepX(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
var NOWPage:TMyPage;
    s:string;
begin
  s:=GetStringBetween(']',';',TextOfDirective);
  s:=DeleteWords(s,CoWProbil);
  NOWPage:=SourcePage;
  NOWPage.StepX:=StrToInt(s);
  MDoSetStepX:=NOWPage;
end;
function MDoSetStepY(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
var NOWPage:TMyPage;
    s:string;
begin
  s:=GetStringBetween(']',';',TextOfDirective);
  s:=DeleteWords(s,CoWProbil);
  NOWPage:=SourcePage;
  NOWPage.StepY:=StrToInt(s);
  MDoSetStepY:=NOWPage;
end;
function ConvertStringToColor(SourceString:string):integer;
var s:string;
    words1:mwords;
    p1,p2,p3,p4:integer;
begin
  s:=DeleteWords(SourceString,CoWProbil);
  words1:=GetWords(s,CoWKoma);
  p1:=High(words1);
  if p1>2 then p1:=2;
  p4:=0;
  for p2:=0 to p1 do
  begin
    p3:=StrToInt(words1[p2]);
    p4:=p4+((p3)shl(8*p2));
  end;
  ConvertStringToColor:=p4;
end;
function MDoSetColor(SourcePage:TMyPage;TextOfDirective:string):TMyPage;
var NOWPage:TMyPage;
    s:string;
    p1:integer;
begin
  s:=GetStringBetween(']',';',TextOfDirective);
  p1:=ConvertStringToColor(s);
  NOWPage:=SourcePage;
  NOWPage.Color:=p1;
  MDoSetColor:=NOWPage;
end;
function MakeNewName(Component:TComponent;FirstName:string):string;
var sname1:string;
    cnumber:integer;
begin
  sname1:=FirstName;
  cnumber:=0;
  while Component.Owner.FindComponent(sname1)<>nil do
  begin
    cnumber:=cnumber+1;
    sname1:=FirstName+'_'+inttostr(cnumber);
  end;
  MakeNewName:=sname1;
end;

function GetTextExtent(TextFont:TFont;TestText:string):tagSize;
var MyTextSize:tagSize;
begin
  if UsingControl=nil then UsingControl:=TForm.Create(application);
  with UsingControl do
  begin
    Canvas.Font:=TextFont;
    MyTextSize:=Canvas.TextExtent(TestText);
  end;
  GetTextExtent:=MyTextSize;
end;

function GetSubjects(SourseText:string):mwords;
var msubjects:mwords;
    mpos,mpos1,lentext,lensubjects:longint;
    s,s1:string;
begin
  s:=SourseText;
  lentext:=length(s);
  lensubjects:=0;
  msubjects:=nil;
  while lentext>0 do
  begin
    s1:=GetStringBetween('[',';',s,true);
    mpos:=pos(s1,s);
    if mpos=1 then mpos:=2;
    mpos1:=length(s1)+2;
    delete(s,mpos-1,mpos1);
    setlength(msubjects,lensubjects+1);
    msubjects[lensubjects]:=s1;
    lensubjects:=lensubjects+1;
    lentext:=length(s);
  end;
  GetSubjects:=msubjects;
end;
function OpenFile(mfile:string):boolean;
var mresult:integer;
    Opened1:boolean;
begin
  system.Assign(fil1,mfile);
  {$I-}
  reset(fil1);
  mresult:=system.IOResult;
  {$I+}
  if mresult<>0 then Opened1:=false
    else Opened1:=true;
  {$I-}
  close(fil1);
  system.IOResult;
  {$I+}
  NameOfMainPage:='';
  NameOfBook:='';
  OpenFile:=Opened1;
end;

function GetWords(s,SubstringMarker:string):mwords;
var s1,thisword:string;
    p,nsymb,nword,CountRemainedMarker:integer;
    words:mwords;
begin
  s1:=s;
  p:=length(s1);
  nword:=0;
  while p>0 do
  begin
    nsymb:=pos(SubstringMarker{' '},s1);
    if nsymb=0 then
    begin
      nsymb:=p;
      thisword:=copy(s1,1,nsymb);
    end
    else thisword:=copy(s1,1,nsymb-1);
    if length(thisword)>0 then
    begin
      setlength(words,nword+1);
      words[nword]:=thisword;
      nword:=nword+1;
    end;
    CountRemainedMarker:=p-nsymb;
    if CountRemainedMarker>length(SubstringMarker)-1 then
      CountRemainedMarker:=length(SubstringMarker)-1;
    delete(s1,1,nsymb+CountRemainedMarker);
    p:=length(s1);
  end;
  GetWords:=words;
end;
function DeleteWords(SourceString,SubstringMarker:string):string;
var p1:integer;
    s:string;
begin
  s:=SourceString;
  p1:=pos(SubstringMarker,s);
  while p1<>0 do
  begin
    delete(s,p1,length(SubstringMarker));
    p1:=pos(SubstringMarker,s);
  end;
  DeleteWords:=s;
end;
function GetStringBetweenAndRemained(BeforeSymbols,AfterSymbols,
  SourceString:string;var RemainedString:string;IfNotFoundThenWholeString:boolean=true;
  BeforeLast:boolean=false;AfterLast:boolean=false;
  BeforeAfterCaseIgnore:boolean=true):string;
var p1,p2,p3,p4,lenbefore,lenafter:integer;
    s,s1,st,sremained,s2,BeforeSymbols1,AfterSymbols1:string;
begin
  s:=SourceString;
  sremained:=s;
  s2:=s;
  BeforeSymbols1:=BeforeSymbols;
  AfterSymbols1:=AfterSymbols;
  if BeforeAfterCaseIgnore=true then
  begin
    s:=ansilowercase(s);
    BeforeSymbols1:=ansilowercase(BeforeSymbols1);
    AfterSymbols1:=ansilowercase(AfterSymbols1);
  end;
  p1:=pos(BeforeSymbols1,s);
  if p1<>0 then s1:=copy(s,p1+length(BeforeSymbols),length(s)-(p1+length(BeforeSymbols)-1))
    else s1:=s;
  p2:=pos(AfterSymbols1,s1);
  if (p2<>0) and (p1<>0) then p2:=p2+p1+length(BeforeSymbols)-1;
  s1:='';
  if (IfNotFoundThenWholeString=true) or (p1>0) or (p2>0) then
  begin
    if p1=0 then
    begin
      p1:=1;
      lenbefore:=0;
    end
    else
    begin
      lenbefore:=length(BeforeSymbols1);
      if BeforeLast=true then
      begin
        p3:=p1;
        st:=s;
        while p3<>0 do
        begin
          for p4:=1 to lenbefore do
          begin
            st[p3+p4-1]:=chr(ord(BeforeSymbols[1])+1);
          end;
          p3:=pos(BeforeSymbols1,st);
          if p3<>0 then p1:=p3;
        end;
      end;
    end;
    if p2=0 then
    begin
      p2:=length(s);
      lenafter:=0;
    end
    else
    begin
      lenafter:=length(AfterSymbols1);
      if AfterLast=true then
      begin
        p3:=p2;
        st:=s;
        while p3<>0 do
        begin
          for p4:=1 to lenafter do
          begin
            st[p3+p4-1]:=chr(ord(AfterSymbols[1])+1);
          end;
          p3:=pos(AfterSymbols1,st);
          if (p3<>0) and (p2<p3) then p2:=p3;
        end;
      end;
    end;
    delete(sremained,p1,p2+lenafter-1-(p1-1));
    if lenafter>0 then lenafter:=1;
    s1:=copy(s2,p1+lenbefore,p2-lenafter-(p1+lenbefore-1));
  end;
  RemainedString:=sremained;
  GetStringBetweenAndRemained:=s1;
end;

function GetStringBetween(BeforeSymbols,AfterSymbols,
    SourceString:string;IfNotFoundThenWholeString:boolean=true;
    BeforeLast:boolean=false;AfterLast:boolean=false;
    BeforeAfterCaseIgnore:boolean=true):string;
var sremained:string;
begin
  GetStringBetween:=GetStringBetweenAndRemained(BeforeSymbols,
    AfterSymbols,SourceString,sremained,IfNotFoundThenWholeString,
    BeforeLast,AfterLast,BeforeAfterCaseIgnore);
end;

function ReplaceInString(SourceString,StringToFound,StringToSet:string;
  RegistrIgnore:boolean=true):string;
var p1:integer;
    s1,s2,s3:string;
begin
  s1:=StringToFound;
  s2:=SourceString;
  s3:=s2;
  if RegistrIgnore=true then
  begin
    s1:=ansilowercase(s1);
    s2:=ansilowercase(s2);
  end;
  p1:=pos(s1,s2);
  while p1<>0 do
  begin
    delete(s3,p1,length(s1));
    insert(StringToSet,s3,p1);
    if RegistrIgnore=true then s2:=ansilowercase(s3)
      else s2:=s3;
    p1:=pos(s1,s2);
  end;
  ReplaceInString:=s3;
end;

function FindPages:mzagolovky;
var s,s1:string;
    nsymb1,nsymb2,posstr,pcount:longint;
    words:mwords;
    pages1:mzagolovky;
begin
  words:=nil;
  system.Reset(fil1);
  posstr:=0;
  pcount:=posstr;
  repeat
    readln(fil1,s);
    posstr:=posstr+1;
    nsymb1:=pos('[',s);
    if nsymb1<>0 then
    begin
      s1:='';
      s:=copy(s,nsymb1+1,length(s)-nsymb1);
      repeat
        nsymb2:=pos(']',s);
        if nsymb2=0 then
        begin
          s1:=s1+s;
          readln(fil1,s);
          posstr:=posstr+1;
        end
        else s1:=s1+copy(s,1,nsymb2-1);
      until nsymb2<>0;
      words:=GetWords(s1,' ');
      if AnsiLowerCase(words[0])=AnsiLowerCase(CoWSetMainPage) then
      begin
        NameOfMainPage:=GetStringBetween(words[0]+CoWProbil,CoWKDuzshka2,s1);
      end;
      if AnsiLowerCase(words[0])=AnsiLowerCase(CoWTitle) then
      begin
        NameOfBook:=GetStringBetween(words[0]+CoWProbil,CoWKDuzshka2,s1);
      end;
      nsymb1:=high(words);
      nsymb2:=0;
      while (nsymb2<nsymb1) and (ansilowercase(words[nsymb2])<>CoWPage) do
        nsymb2:=nsymb2+1;
        if ansilowercase(words[nsymb2])=CoWPage then
        begin
          pcount:=pcount+1;
          SetLength(ShowedPages,pcount);
          ShowedPages[pcount-1]:=false;
          setlength(pages1,pcount);
          s:='';
          s:=GetStringBetween(words[nsymb2]+CoWProbil,CoWKduzshka2,s1);
          pages1[pcount-1].Caption:=s;
          pages1[pcount-1].Place:=posstr;
        end;
    end;
  until eof(fil1);
  system.Close(fil1);
  if NameOfMainPage='' then NameOfMainPage:=pages1[0].Caption;
  FindPages:=pages1;
end;

function CountPages(PagesZagolovky:mzagolovky):longint;
begin
  CountPages:=high(PagesZagolovky)+1;
end;

function GetNumbersOfPages(NameOfPage:string;PagesZagolovky:mzagolovky):MIntegers;
var npage,kilkpages:longint;
    FoundNumbers:MIntegers;
begin
  FoundNumbers:=nil;
  kilkpages:=0;
  if PagesZagolovky<>nil then
  begin
    for npage:=0 to High(PagesZagolovky) do
    begin
      if AnsiLowerCase(NameOfPage)=AnsiLowerCase(PagesZagolovky[npage].Caption) then
      begin
        SetLength(FoundNumbers,kilkpages+1);
        FoundNumbers[kilkpages]:=npage;
        kilkpages:=kilkpages+1;
      end;
    end;
  end;
  GetNumbersOfPages:=FoundNumbers;
end;

function ReadTextOfPage(Zagolovok:mzagolovok):string;
var placepage,nstr:longint;
    s,s1,stest:string;
begin
  placepage:=Zagolovok.Place;
  reset(fil1);
  nstr:=0;
  repeat
    nstr:=nstr+1;
    readln(fil1);
  until (nstr+1>=placepage) or (eof(fil1));
  s1:='';
  if not(eof(fil1)) then
  begin
    readln(fil1,s);
    nstr:=pos(']',s);
    s:=copy(s,nstr+1,length(s)-nstr);
    s1:=s;
    nstr:=0;
    while (not(eof(fil1))) and (nstr=0) do
    begin
      readln(fil1,s);
      stest:=ansilowercase(s);
      nstr:=pos('['+CoWPage,stest);
      if nstr<>0 then s1:=s1+copy(s,1,nstr-1)
        else s1:=s1+s;
    end;
  end;
  close(fil1);
  ReadTextOfPage:=s1;
end;

function SubBuildPage(FormToPlace:TForm;MSubjects:mwords):TMyPage;
var NOWPage:TMyPage;
    numsubject,kilksubjects,i1,p1:integer;
    subwords:mwords;
    s,s1,s2,subwords1:string;
    NOWControl:TControl;
begin
  subwords:=nil;
  NOWPage:=TMyPage.Create(application);
  NOWPage.Parent:=FormToPlace;
  with NOWPage do
  begin
    NewX:=0;
    NewY:=0;
    StepX:=10;
    StepY:=StepX;
    MLineHeight:=0;
  end;
  kilksubjects:=high(MSubjects);
  for numsubject:=0 to kilksubjects do
  begin
    subwords1:=MSubjects[numsubject];
    subwords1:=GetStringBetween('[',']',subwords1,true);
    subwords:=GetWords(subwords1,' ');
    if high(subwords)>=0 then s:=subwords[0] else s:='';
    s1:='';
    for i1:=1 to length(s) do
    begin
      s1:=s1+ansilowercase(s[i1]);
      for p1:=0 to high(namesofsubjects) do
      begin
        if s1=ansilowercase(namesofsubjects[p1]) then
        begin
          s2:=MSubjects[numsubject];
          NOWControl:=GenerationFunctions[p1](NOWPage,s2);
          NOWControl.Parent:=NOWPage;
          if NOWControl.Name='' then NOWControl.Name:=MakeNewName(NOWControl,s);
          NOWControl.Left:=NOWPage.NewX;
          NOWControl.Top:=NOWPage.NewY;
          NOWPage.NewX:=NOWPage.NewX+NOWPage.StepX+NOWControl.Width;
          if NOWControl.Height>NOWPage.MLineHeight then
            NOWPage.MLineHeight:=NOWControl.Height;
          if NOWPage.Width<NowPage.NewX then
          begin
            NOWPage.Parent.ClientWidth:=NOWPage.NewX;
            if NOWPage.Parent.Width+NOWPage.Parent.Left>Screen.Width then
              NOWpage.Parent.Width:=Screen.Width-NOWPage.Parent.Left;
            NOWPage.Width:=NOWPage.NewX;
          end;
          if (NOWPage.Height<(NOWPage.NewY+NOWPage.MLineHeight+NOWPage.StepY)) then
          begin
            NOWPage.Parent.ClientHeight:=NOWPage.NewY+NOWPage.MLineHeight+NOWPage.StepY;
            NOWPage.Height:=NOWPage.NewY+NOWPage.MLineHeight+NOWPage.StepY;
            if NOWPage.Parent.Height+NOWPage.Parent.Top>Screen.Height then
              NOWPage.Parent.Height:=Screen.Height-NOWPage.Parent.Top;
          end;
        end;
      end;
      for p1:=0 to High(NamesOfDirectives) do
      begin
        if s1=ansilowercase(NamesOfDirectives[p1]) then
        begin
          s2:=MSubjects[numsubject];
          NOWPage:=DirectivesFunctions[p1](NOWPage,s2);
        end;
      end;
    end;
  end;
  SubBuildPage:=NOWPage;
end;
function BuildPage(FormToPlace:TForm;Zagolovok:mzagolovok):TMyPage;
var pagetext:string;
    NOWPage:TMyPage;
    msubjects:mwords;
begin
  pagetext:=ReadTextOfPage(Zagolovok);
  msubjects:=GetSubjects(pagetext);
  NOWPage:=SubBuildPage(FormToPlace,msubjects);
  NOWPage.Caption:=Zagolovok.Caption;
  NOWPage.place:=Zagolovok.Place;
  BuildPage:=NOWPage;
end;
procedure TFormPage.FormCreate(Sender: TObject);
begin
  ClientWidth:=0;
  ClientHeight:=0;
  Maximized:=false;
end;
procedure TFormPage.FormResize1(var Msg:TMessage);
var NOWForm:TForm;
    p1,p2,p3,p4,pmax:integer;
begin
  if Msg.WParam=SC_MAXIMIZE then
  begin
    if Maximized=true then
    begin
      Maximized:=False;
      Left:=WindowNormalRectangle.Left;
      Top:=WindowNormalRectangle.Top;
      Width:=WindowNormalRectangle.Right;
      Height:=WindowNormalRectangle.Bottom;
    end
    else
    begin
    {SetForegroundWindow}
    {ShowWindow(Handle,SW_Maximize);}
    {FindWindow}
    Maximized:=true;
    WindowNormalRectangle.Left:=Left;
    WindowNormalRectangle.Top:=Top;
    WindowNormalRectangle.Right:=Width;
    WindowNormalRectangle.Bottom:=Height;
        NOWForm:=Application.MainForm;
        p1:=NOWForm.Top*Screen.Width;
        p2:=(Screen.Height-NOWForm.Top-NOWForm.Height)*Screen.Width;
        p3:=NOWForm.Left*Screen.Height;
        p4:=(Screen.Width-NOWForm.Top-NOWForm.Width)*Screen.Height;
        pmax:=MaxIntValue([p1,p2,p3,p4]);
        if pmax=p1 then
        begin
          Top:=0;
          Height:=NOWForm.Top-1;
          Left:=0;
          Width:=Screen.Width;
        end
        else if pmax=p2 then
        begin
          Top:=NOWForm.Top+NOWForm.Height;
          Height:=Screen.Height-NOWForm.Top-NOWForm.Height;
          Left:=0;
          Width:=Screen.Width;
        end
        else if pmax=p3 then
        begin
          Left:=0;
          Width:=NOWForm.Left-1;
          Top:=0;
          Height:=Screen.Height;
        end
        else if pmax=p4 then
        begin
          Left:=NOWForm.Left+NOWForm.Width;
          Width:=Screen.Width-NOWForm.Left-NOWForm.Width;
          Top:=0;
          Height:=Screen.Height;
        end;
    end;
  end
  else Inherited;
end;
end.
