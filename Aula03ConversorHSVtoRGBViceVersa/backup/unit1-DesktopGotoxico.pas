unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    procedure HSLtoRGB(H, S, L: Integer; var R, G, B: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit10Change(Sender: TObject);
    procedure Edit11Change(Sender: TObject);
    procedure Edit12Change(Sender: TObject);
    procedure Edit13Change(Sender: TObject);
    procedure Edit14Change(Sender: TObject);
    procedure Edit15Change(Sender: TObject);
    procedure Edit16Change(Sender: TObject);
    procedure Edit17Change(Sender: TObject);
    procedure Edit18Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.HSLtoRGB(H, S, L: Integer; var R, G, B: Integer);
var
  C, X, HLinha, M, R1, G1, B1, H1, S1, L1 : Double;
begin
  H1 := H mod 360;
  S1 := S / 100.0;
  L1 := L / 100.0;

  C := (1 - Abs(2 * L1 - 1)) * S1;

  HLinha := H1 / 60.0;

  X := C * (1 - Abs(fmod(HLinha, 2) - 1));

  if (HLinha >= 0) and (HLinha < 1) then
    begin
      R1 := C;
      G1 := X;
      B1 := 0;
    end;

  if (HLinha >= 1) and (HLinha < 2) then
    begin
      R1 := X;
      G1 := C;
      B1 := 0;
    end;

  if (HLinha >= 2) and (HLinha < 3) then
    begin
      R1 := 0;
      G1 := C;
      B1 := X;
    end;

  if (HLinha >= 3) and (HLinha < 4) then
    begin
      R1 := 0;
      G1 := X;
      B1 := C;
    end;

  if (HLinha >= 4) and (HLinha < 5) then
    begin
      R1 := X;
      G1 := 0;
      B1 := C;
    end;

  if (HLinha >= 5) and (HLinha < 6) then
    begin
      R1 := C;
      G1 := 0;
      B1 := X;
    end;

  M := L1 - C / 2;

  R := Round((R1 + M) * 255);
  G := Round((G1 + M) * 255);
  B := Round((B1 + M) * 255);
end;



procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.Edit10Change(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
var H, S, L, R, G, B : Integer;

begin
  R := 0;
  G := 0;
  B := 0;
  H := StrToInt(Edit1.Text);
  S := StrToInt(Edit2.Text);
  L := StrToInt(Edit3.Text);

  if (H < 0) or (H > 360) then
     begin
       ShowMessage('Hue deve estar entre 0 e 360');
       Exit;
     end;
  if (S < 0) or (S > 100) then
     begin
       ShowMessage('Saturação deve estar entre 0 e 100');
       Exit;
     end;
  if (L < 0) or (L > 100) then
     begin
       ShowMessage('Lightness deve estar entre 0 e 100');
       Exit;
     end;

  HSLtoRGB(H, S, L, R, G, B);
  Edit4.Text := IntToStr(R);
  Edit5.Text := IntToStr(G);
  Edit6.Text := IntToStr(B);
end;

procedure TForm1.Button2Click(Sender: TObject);
var R, G, B : Integer;
begin
  R := StrToInt(Edit7.Text);
  G := StrToInt(Edit8.Text);
  B := StrToInt(Edit9.Text);

  if (R < 0) or (R > 255) then
     begin
       ShowMessage('Red deve estar entre 0 e 255');
     end;
  if (G < 0) or (G > 255) then
     begin
       ShowMessage('Green deve estar entre 0 e 255');
     end;
  if (B < 0) or (B > 255) then
     begin
       ShowMessage('Blue deve estar entre 0 e 255');
     end;



end;

procedure TForm1.Button3Click(Sender: TObject);
begin

end;

procedure TForm1.Edit11Change(Sender: TObject);
begin

end;

procedure TForm1.Edit12Change(Sender: TObject);
begin

end;

procedure TForm1.Edit13Change(Sender: TObject);
begin

end;

procedure TForm1.Edit14Change(Sender: TObject);
begin

end;

procedure TForm1.Edit15Change(Sender: TObject);
begin

end;

procedure TForm1.Edit16Change(Sender: TObject);
begin

end;

procedure TForm1.Edit17Change(Sender: TObject);
begin

end;

procedure TForm1.Edit18Change(Sender: TObject);
begin

end;

procedure TForm1.Edit2Change(Sender: TObject);
begin

end;

procedure TForm1.Edit3Change(Sender: TObject);
begin

end;

procedure TForm1.Edit4Change(Sender: TObject);
begin

end;

procedure TForm1.Edit5Change(Sender: TObject);
begin

end;

procedure TForm1.Edit6Change(Sender: TObject);
begin

end;

procedure TForm1.Edit7Change(Sender: TObject);
begin

end;

procedure TForm1.Edit8Change(Sender: TObject);
begin

end;

procedure TForm1.Edit9Change(Sender: TObject);
begin

end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  Close;
end;

end.

