unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls, LCLIntf, LCLType, LCLProc, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Image2: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Image1.Picture := Image2.Picture;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.Edit2Change(Sender: TObject);
begin

end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
     if SaveDialog1.Execute then
     begin
          Image2.Picture.Bitmap.SaveToFile(SaveDialog1.FileName);
     end;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  if (OpenDialog1.Execute) then
  begin
       Image1.Picture.LoadFromFile(OpenDialog1.FileName);

       Image1.Width := Image1.Picture.Width;
       Image1.Height := Image1.Picture.Height;

  end;

end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin

end;

(*Interpolação Nearest Neighbor*)
procedure TForm1.MenuItem6Click(Sender: TObject);
var x, y, origX, origY, novaLargura, novaAltura: Integer;
var escalaX, escalaY: Double;
var cor: TColor;
begin
  novaLargura := StrToInt(Edit1.Text);
  novaAltura := StrToInt(Edit2.Text);
  Image2.Picture.Bitmap.SetSize(novaLargura, novaAltura);

  escalaX := Image1.Width / novaLargura;
  escalaY := Image1.Height / novaAltura;

  for x := 0 to novaLargura - 1 do
      for y := 0 to novaAltura - 1 do
      begin
        origX := Round(x * escalaX);
        origY := Round(y * escalaY);

        if origX >= Image1.Width then origX := Image1.Width - 1;
        if origY >= Image1.Height then origY := Image1.Height - 1;

        cor := Image1.Canvas.Pixels[origX, origY];

        Image2.Canvas.Pixels[x, y] := cor;
      end;
end;

(*Interpolação Bilinear*)
procedure TForm1.MenuItem7Click(Sender: TObject);
var x, y, novaLargura, novaAltura, x1, x2, y1, y2: Integer;
var escalaX, escalaY, origX, origY: Double;
var r1, r2, r3, r4, g1, g2, g3, g4, b1, b2, b3, b4, r, g, b: Integer;
var fracX, fracY: Double;
var cor: TColor;
begin
  novaLargura := StrToInt(Edit1.Text);
  novaAltura := StrToInt(Edit2.Text);
  Image2.Picture.Bitmap.SetSize(novaLargura, novaAltura);

  escalaX := Image1.Width / novaLargura;
  escalaY := Image1.Height / novaAltura;

  for x := 0 to novaLargura - 1 do
      for y := 0 to novaLargura - 1 do
      begin
           origX := x * escalaX;
           origY := y * escalaY;

           x1 := Floor(origX);
           y1 := Floor(origY);
           x2 := x1 + 1;
           y2 := y1 + 1;

           if x2 >= Image1.Width then x2 := Image1.Width - 1;
           if y2 >= Image1.Width then y2 := Image1.Width - 1;

           fracX := origX - x1;
           fracY := origY - y1;

           cor := Image1.Canvas.Pixels[x1,y1];
           r1 := Integer(GetRValue(cor));
           g1 := Integer(GetGValue(cor));
           b1 := Integer(GetBValue(cor));

           cor := Image1.Canvas.Pixels[x2,y1];
           r2 := Integer(GetRValue(cor));
           g2 := Integer(GetGValue(cor));
           b2 := Integer(GetBValue(cor));

           cor := Image1.Canvas.Pixels[x1,y2];
           r3 := Integer(GetRValue(cor));
           g3 := Integer(GetGValue(cor));
           b3 := Integer(GetBValue(cor));

           cor := Image1.Canvas.Pixels[x2,y2];
           r4 := Integer(GetRValue(cor));
           g4 := Integer(GetGValue(cor));
           b4 := Integer(GetBValue(cor));

           r := Round((1 - fracX) * (1 - fracY) * r1 + fracX * (1 - fracY) * r2 + (1 - fracX) * fracY * r3 + fracX * fracY * r4);
           g := Round((1 - fracX) * (1 - fracY) * g1 + fracX * (1 - fracY) * g2 + (1 - fracX) * fracY * g3 + fracX * fracY * g4);
           b := Round((1 - fracX) * (1 - fracY) * b1 + fracX * (1 - fracY) * b2 + (1 - fracX) * fracY * b3 + fracX * fracY * b4);

           Image2.Canvas.Pixels[x,y] := RGB(r, g, b);
      end;
end;

end.

