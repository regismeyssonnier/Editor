unit Pass;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Aproposform, Vcl.DBCtrls, Vcl.StdCtrls, richedit;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    Ouvrir1: TMenuItem;
    OuvrirFichier1: TMenuItem;
    N1: TMenuItem;
    Fermer1: TMenuItem;
    Edition1: TMenuItem;
    trouver1: TMenuItem;
    N2: TMenuItem;
    Apropos1: TMenuItem;
    RichEdit1: TRichEdit;
    FindDialog1: TFindDialog;
    OpenDialog1: TOpenDialog;
    N3: TMenuItem;
    gmaildown1: TMenuItem;
    gmailup1: TMenuItem;
    N4: TMenuItem;
    hotmaildown1: TMenuItem;
    hotmailup1: TMenuItem;
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure trouver1Click(Sender: TObject);
    procedure Ouvrir1Click(Sender: TObject);
    procedure Apropos1Click(Sender: TObject);
    procedure OuvrirFichier1Click(Sender: TObject);
    procedure gmaildown1Click(Sender: TObject);
    procedure gmailup1Click(Sender: TObject);
    procedure hotmaildown1Click(Sender: TObject);
    procedure hotmailup1Click(Sender: TObject);
  private
    { Déclarations privées }
    function FindText( const SearchStr: string;
               StartPos, FindLength : LongInt; Options: TSearchTypes;
               SearchDown : Boolean = TRUE ): Integer;
    procedure FindDialogText(__text : String;down : Boolean);
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Apropos1Click(Sender: TObject);
var
  Aproposff: TApropos;
begin
    //Application.CreateForm(TApropos, Aproposf);
    Aproposff := TApropos.Create(self);
    Aproposff.Show();
end;

procedure TForm1.Fermer1Click(Sender: TObject);
begin
    self.Close();
end;

function TForm1.FindText( const SearchStr: string;
               StartPos, FindLength : LongInt; Options: TSearchTypes;
               SearchDown : Boolean = TRUE ): Integer;
var
Find: TFindText;
Flags: Word;

begin
with Find do
   begin
   chrg.cpMin := StartPos;
   chrg.cpMax := StartPos + FindLength;
   lpstrText := PChar(SearchStr);
   end;

Flags := 0;

if stWholeWord in Options then
   Flags := Flags or FT_WHOLEWORD
else
   Flags := Flags and not FT_WHOLEWORD;

if stMatchCase in Options then
   Flags := Flags or FT_MATCHCASE
else
   Flags := Flags and not FT_MATCHCASE;

if SearchDown then
   Flags := Flags OR $01
else
   begin
   Flags := Flags AND not $01;
   end;

Result := -1;

if SearchDown then
   Result := SendMessage(RichEdit1.Handle, EM_FINDTEXT, Flags, LongInt(@Find))
else

   while (StartPos > -1) and (result = -1) do
      begin
      Result := SendMessage(RichEdit1.Handle, EM_FINDTEXT, Flags, LongInt(@Find));
      Dec(StartPos);
      Find.chrg.cpMin := StartPos;
      end;
end;

procedure TForm1.FindDialog1Find(Sender: TObject);
var
  FoundAt: LongInt;
  StartPos, ToEnd: Integer;
  mySearchTypes : TSearchTypes;
  myFindOptions : TFindOptions;
  down : boolean;
begin
  mySearchTypes := [];
  with RichEdit1 do
  begin
    if frMatchCase in FindDialog1.Options then
       mySearchTypes := mySearchTypes + [stMatchCase];
    if frWholeWord in FindDialog1.Options then
       mySearchTypes := mySearchTypes + [stWholeWord];
    down := False;
    if frDown in FindDialog1.Options then
       down := True;
    { Begin the search after the current selection, if there is one. }
    { Otherwise, begin at the start of the text. }
    if SelLength <> 0 then
      if down  then
        StartPos := SelStart + SelLength
      else
        StartPos := SelStart

    else
      StartPos := SelStart;
    { ToEnd is the length from StartPos through the end of the
      text in the rich edit control. }
    //if down  then
    //begin
      if down  then
          ToEnd := Length(Text) - StartPos
      else
          ToEnd := 0;
      FoundAt := self.FindText(FindDialog1.FindText, StartPos, ToEnd, mySearchTypes, down);
      if FoundAt <> -1 then
      begin
        SetFocus;
        SelStart := FoundAt;
        SelLength := Length(FindDialog1.FindText);
      end
      else Beep;
    //end;
  end;
end;

procedure TForm1.FindDialogText(__text : String;down : Boolean);
var
  FoundAt: LongInt;
  StartPos, ToEnd: Integer;
  mySearchTypes : TSearchTypes;
  myFindOptions : TFindOptions;

begin
  mySearchTypes := [];
  with RichEdit1 do
  begin

       mySearchTypes := mySearchTypes + [stMatchCase];

       mySearchTypes := mySearchTypes + [stWholeWord];

    if SelLength <> 0 then
      if down  then
        StartPos := SelStart + SelLength
      else
        StartPos := SelStart

    else
      StartPos := SelStart;

      if down  then
          ToEnd := Length(Text) - StartPos
      else
          ToEnd := 0;
      FoundAt := self.FindText(__text, StartPos, ToEnd, mySearchTypes, down);
      if FoundAt <> -1 then
      begin
        SetFocus;
        SelStart := FoundAt;
        SelLength := Length(__text);
      end
      else Beep;

  end;


end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    RichEdit1.Text := '';
    RichEdit1.PlainText := False;
    RichEdit1.Lines.LoadFromFile('D:/code.txt');
    RichEdit1.ScrollBars := ssBoth;
end;

procedure TForm1.gmaildown1Click(Sender: TObject);
begin
    FindDialogText('gmail', true);
end;

procedure TForm1.gmailup1Click(Sender: TObject);
begin
    FindDialogText('gmail', false);
end;

procedure TForm1.hotmaildown1Click(Sender: TObject);
begin
    FindDialogText('hotmail', true);
end;

procedure TForm1.hotmailup1Click(Sender: TObject);
begin
    FindDialogText('hotmail', false);
end;

procedure TForm1.Ouvrir1Click(Sender: TObject);
begin
    RichEdit1.Text := '';
    RichEdit1.PlainText := False;
    RichEdit1.Lines.LoadFromFile('D:/code.txt');
    RichEdit1.ScrollBars := ssBoth;
end;

procedure TForm1.OuvrirFichier1Click(Sender: TObject);
begin
    if OpenDialog1.Execute then
    { First check if the file exists. }
      if FileExists(OpenDialog1.FileName) then
        { If it exists, load the data into the memo box. }
        RichEdit1.Lines.LoadFromFile(OpenDialog1.FileName)
      else
        { Otherwise, raise an exception. }
        raise Exception.Create('File does not exist.');
end;

procedure TForm1.trouver1Click(Sender: TObject);
begin
    findDialog1.Execute;
end;

end.
