unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, Windows, LCLIntf, LCLType, LCLProc;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  r, g, b, c, i, j, tamanho, quantidadeRuido, x, y, soma, media, u, d, e, mediana, temp: integer;
  ime, ims, mag: array[0..511, 0..511] of integer;
  cor: TColor;
  mascara : array[0..2, 0..2] of integer;
  vetorTonsMediana : array[0..8] of integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Image2Click(Sender: TObject);
begin

end;

(*Filtro Convolucional Média Vizinhança 8*)
procedure TForm1.MenuItem10Click(Sender: TObject);
begin
     for i:= 0 to 2 do
         for j := 0 to 2 do
             begin
                  mascara[i, j] := 1;
             end;

     for i := 1 to Image1.Width - 2 do
         for j := 1 to Image1.Height - 2 do
         begin
             soma := 0;

             for x := -1 to 1 do
                 for y := -1 to 1 do
                 begin
                     cor := Image1.Canvas.Pixels[i + x, j + y];
                     soma := soma + (GetRValue(cor) * mascara[x + 1, y + 1]);
                 end;

             media := Round(soma/9);

             Image2.Canvas.Pixels[i, j] := RGB(media, media, media);
         end;
end;

(*Filtro Convolucional Mediana Vizinhança 8*)
procedure TForm1.MenuItem11Click(Sender: TObject);
begin
     for i:= 0 to 2 do
         for j := 0 to 2 do
             begin
                  mascara[i, j] := 1;
             end;

     for i := 1 to Image1.Width - 2 do
         for j := 1 to Image1.Height - 2 do
         begin

             for u := 0 to 8 do
             begin
                 vetorTonsMediana[u] := 0;
             end;

             u := 0;

             for x := -1 to 1 do
                 for y := -1 to 1 do
                 begin
                     cor := Image1.Canvas.Pixels[i + x, j + y];
                     vetorTonsMediana[u] := GetRValue(cor) * mascara[x + 1, y + 1];
                     Inc(u);
                 end;

             for d := 0 to 7 do
                for e := 0 to 7 - d do
                begin
                  if vetorTonsMediana[e] > vetorTonsMediana[e + 1] then
                  begin
                    temp := vetorTonsMediana[e];
                    vetorTonsMediana[e] := vetorTonsMediana[e + 1];
                    vetorTonsMediana[e + 1] := temp;
                  end;
                end;
             mediana := vetorTonsMediana[4];

             Image2.Canvas.Pixels[i, j] := RGB(mediana, mediana, mediana);
         end;


end;

(*Aplicar Ruído Sal e Pimenta*)
procedure TForm1.MenuItem12Click(Sender: TObject);
begin
     tamanho := Image1.Width * Image1.Height;
     quantidadeRuido := Round(tamanho/10);
     Image2.Canvas.Draw(0, 0, Image1.Picture.Graphic);

     for i:= 0 to quantidadeRuido do
         begin
              x := Random(Image1.Width+1);
              y := Random(Image1.Height+1);
              c := Random(2);
              if c = 1 then c := 255;
              Image2.Canvas.Pixels[x, y] := RGB(c, c, c);
         end;
end;

(*Filtragem Baseada na Média de 10 Imagens*)
procedure TForm1.MenuItem13Click(Sender: TObject);
var im: array[1..10] of Graphics.TBitmap;
var i, j, x, y, r, g, b, largura, altura, tamanho, quantidadeRuido, somaR, somaG, somaB, mediaR, mediaG, mediaB : Integer;
var cor: TColor;
begin
     largura := Image1.Width;
     altura := Image1.Height;
     tamanho := largura * altura;
     quantidadeRuido := Round(tamanho/10);

     for i := 1 to 10 do
        begin
            im[i] := Graphics.TBitmap.Create;
            im[i].SetSize(largura, altura);
            im[i].Canvas.Draw(0, 0, Image1.Picture.Bitmap);

            for j := 0 to quantidadeRuido do
               begin
                   x := Random(largura+1);
                   y := Random(altura+1);
                   r := Random(256);
                   g := Random(256);
                   b := Random(256);

                   im[i].Canvas.Pixels[x,y] := RGB(r, g, b);
               end;
        end;

     for x := 0 to largura - 1 do
        for y := 0 to altura - 1 do
           begin
               somaR := 0;
               somaG := 0;
               somaB := 0;

               for i := 1 to 10 do
                  begin
                      cor := im[i].Canvas.Pixels[x, y];
                      r := Integer(cor and $FF);
                      g := Integer((cor shr 8) and $FF);
                      b := Integer((cor shr 16) and $FF);

                      somaR := somaR + r;
                      somaB := somaB + b;
                      somaG := somaG + g;
                  end;

               mediaR := Round(somaR / 10);
               mediaG := Round(somaG / 10);
               mediaB := Round(somaB / 10);

               Image2.Canvas.Pixels[x,y] := RGB(mediaR, mediaG, mediaB);
           end;

     for i := 1 to 10 do
        im[i].Free;
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
var
  gx, gy, min, max: Integer;

begin

  for j :=1 to Image1.Height-2 do
      for i :=1 to Image1.Width-1 do
      begin
        gx:= -1*Ime[i-1, j-1] + 1*Ime[i+1, j-1]
            -2*Ime[i-1, j]    + 2*Ime[i+1,j]-
            -1*Ime[i-1, j+1]  + 1*Ime[i+1, j+1];
        gy := -1*Ime[i-1, j-1] - 2*Ime[i,j-1] -1*Ime[i+1, j-1]
              +1*Ime[i-1, j+1] + 2*Ime[i, j+1] + 1*Ime[i+1, j+1];

        mag[i,j] := round(sqrt(gx*gx+gy*gy));
      end;
  min:= 9999999;
  max := -9999999;

  for j:=1 to Image1.Height-2 do
   for i:=1 to Image1.Width-2 do
       begin
         if min > mag[i,j] then min := mag[i,j];
         if max < mag[i,j] then max := mag[i,j];
       end;

   for j:=1 to Image1.Height-2 do
   for i:=1 to Image1.Width-2 do
       begin
           Ims[i,j] := round((mag[i,j] - min) / (max - min) * 255);
           Image2.Canvas.Pixels[i,j] := RGB(Ims[i,j], Ims[i,j], Ims[i,j]);
       end;

end;

(*Passar Imagem da Direita para a Esquerda*)
procedure TForm1.Button1Click(Sender: TObject);
begin
  for i:=0 to Image1.Width - 1 do
      for j:= 0 to Image1.Height - 1 do
          ime[i, j] := ims[i , j];

  Image1.Picture := Image2.Picture;

end;

(*Sub-Menu 1*)
procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

(*Abri Imagem*)
procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if (OpenDialog1.Execute)
     then Image1.Picture.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    Image2.Picture.Bitmap.SaveToFile(SaveDialog1.FileName);
  end;
end;

(*Fechar Formulário*)
procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Close();
end;

(*Sub-Menu 2*)
procedure TForm1.MenuItem5Click(Sender: TObject);
begin

end;

(*Converter para Cinza*)
procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  for i:=0 to Image1.Width - 1 do
      for j:= 0 to Image1.Height - 1 do
          begin
            cor := Image1.Canvas.Pixels[i, j];
            r := GetRValue(cor);
            g := GetGValue(cor);
            b := GetBValue(cor);
            c := round(0.299 * r + 0.587 * g + 0.114 * b);
            ims[i, j] := c;
            Image2.Canvas.Pixels[i, j] := RGB(c,c,c);
          end;
end;

(*Negativa Cinza*)
procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  for i:=0 to Image1.Width - 1 do
      for j:= 0 to Image1.Height - 1 do
          begin
            ims[i, j] := 255 - ime[i, j];
            Image2.Canvas.Pixels[i, j] := RGB(ims[i, j], ims[i, j], ims[i, j]);
          end;
end;

(*Negativa Colorida*)
procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  for i:=0 to Image1.Width - 1 do
      for j:= 0 to Image1.Height - 1 do
          begin
            cor := Image1.Canvas.Pixels[i, j];
            r := GetRValue(cor);
            g := GetGValue(cor);
            b := GetBValue(cor);
            Image2.Canvas.Pixels[i, j] := RGB(255 - r,255 - g,255 - b);
          end;
end;

(*Separar Canais RGB em Três Imagens*)
procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  for i:=0 to Image1.Width - 1 do
      for j:= 0 to Image1.Height - 1 do
          begin
            cor := Image1.Canvas.Pixels[i, j];
            r := GetRValue(cor);
            g := GetGValue(cor);
            b := GetBValue(cor);
            Image3.Canvas.Pixels[i, j] := RGB(r,0,0);
            Image4.Canvas.Pixels[i, j] := RGB(0,g,0);
            Image5.Canvas.Pixels[i, j] := RGB(0,0,b);
          end;

end;

end.

