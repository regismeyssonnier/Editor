unit Pass;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls, Aproposform;

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
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure trouver1Click(Sender: TObject);
    procedure Ouvrir1Click(Sender: TObject);
    procedure Apropos1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Apropos1Click(Sender: TObject);
var
  Aproposf: TApropos;
begin
    Aproposf.ShowModal();
end;

procedure TForm1.Fermer1Click(Sender: TObject);
begin
    self.Close();
end;

procedure TForm1.FindDialog1Find(Sender: TObject);
var
  FoundAt: LongInt;
  StartPos, ToEnd: Integer;
  mySearchTypes : TSearchTypes;
  myFindOptions : TFindOptions;
begin
  mySearchTypes := [];
  with RichEdit1 do
  begin
    if frMatchCase in FindDialog1.Options then
       mySearchTypes := mySearchTypes + [stMatchCase];
    if frWholeWord in FindDialog1.Options then
       mySearchTypes := mySearchTypes + [stWholeWord];
    { Begin the search after the current selection, if there is one. }
    { Otherwise, begin at the start of the text. }
    if SelLength <> 0 then
      StartPos := SelStart + SelLength
    else
      StartPos := 0;
    { ToEnd is the length from StartPos through the end of the
      text in the rich edit control. }
    ToEnd := Length(Text) - StartPos;
    FoundAt := FindText(FindDialog1.FindText, StartPos, ToEnd, mySearchTypes);
    if FoundAt <> -1 then
    begin
      SetFocus;
      SelStart := FoundAt;
      SelLength := Length(FindDialog1.FindText);
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

procedure TForm1.Ouvrir1Click(Sender: TObject);
begin
    RichEdit1.Text := '';
    RichEdit1.PlainText := False;
    RichEdit1.Lines.LoadFromFile('D:/code.txt');
    RichEdit1.ScrollBars := ssBoth;
end;

procedure TForm1.trouver1Click(Sender: TObject);
begin
    findDialog1.Execute;
end;

end.
