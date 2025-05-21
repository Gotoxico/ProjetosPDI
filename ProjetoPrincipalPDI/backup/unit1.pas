unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, Windows, LCLIntf, LCLType, LCLProc, PopupNotifier, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Limiar: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    PopupNotifier1: TPopupNotifier;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Label1Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure LimiarClick(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure PopupNotifier1Close(Sender: TObject; var CloseAction: TCloseAction
      );
  private

  public

  end;

var
  Form1: TForm1;
  r, g, b, c, i, j, tamanho, quantidadeRuido, x, y, soma, media, u, d, e, mediana, temp: integer;
  ime, ims, mag, dir: array[0..511, 0..511] of integer;
  cor: TColor;
  mascara : array[0..2, 0..2] of integer;
  vetorTonsMediana : array[0..8] of integer;
  matrizC, matrizF: array [0..127, 0..127] of integer;

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

(*Evento para adicionar Ruído em Espectro DCT*)
procedure TForm1.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Canvas.Pixels[X, Y] := RGBToColor(255, 255, 255);
  if X and Y <= 127 then
  begin
    MatrizC[X,Y] := 255;
  end;
end;

{*Evento ao mover o mouse por cima da imagem 2*}
procedure TForm1.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Edit1.Text:= IntToStr(Mag[x,y]);
  Edit2.Text:= IntToStr(dir[x,y]);
end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Label5Click(Sender: TObject);
begin

end;

procedure TForm1.Label6Click(Sender: TObject);
begin

end;

procedure TForm1.LimiarClick(Sender: TObject);
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
                     soma := soma + (ime[i + x, j + y] * mascara[x + 1, y + 1]);
                 end;

             media := Round(soma/9);

             ims[i,j] := media;
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
                     vetorTonsMediana[u] := ime[i + x, j + y] * mascara[x + 1, y + 1];
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

             ims[i,j] := mediana;
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
{*Magnitude de sobel*}
procedure TForm1.MenuItem14Click(Sender: TObject);
var
  gx, gy, min, max,theta: Integer;
  i, j: Integer;
begin

  for j := 1 to Image1.Height - 2 do
    for i := 1 to Image1.Width - 2 do
    begin
      gx := (-1 * Ime[i-1, j-1]) + (1 * Ime[i+1, j-1]) +
            (-2 * Ime[i-1, j])   + (2 * Ime[i+1, j]) +
            (-1 * Ime[i-1, j+1]) + (1 * Ime[i+1, j+1]);

      gy := (-1 * Ime[i-1, j-1]) + (-2 * Ime[i, j-1]) + (-1 * Ime[i+1, j-1]) +
            (1 * Ime[i-1, j+1]) + (2 * Ime[i, j+1]) + (1 * Ime[i+1, j+1]);

      mag[i, j] := round(sqrt(gx * gx + gy * gy));
      if gx = 0 then
      begin
        if gy > 0 then
          theta := 90
        else if gy < 0 then
          theta := -90
        else
          theta := 0; // gx = 0 e gy = 0 → sem borda, direção indefinida
      end
      else
      begin
        theta := round(arctan(gy / gx) * 180 / pi);
      end;
      dir[i,j] := theta;


    end;


  min := mag[1, 1];
  max := mag[1, 1];


  for j := 1 to Image1.Height - 2 do
    for i := 1 to Image1.Width - 2 do
    begin
      if min > mag[i, j] then min := mag[i, j];
      if max < mag[i, j] then max := mag[i, j];
    end;


  if max = min then max := min + 1;


  for j := 1 to Image1.Height - 2 do
    for i := 1 to Image1.Width - 2 do

    begin
      Ims[i, j] := round((mag[i, j] - min) / (max - min) * 255);
      Image2.Canvas.Pixels[i, j] := RGB(Ims[i, j], Ims[i, j], Ims[i, j]);
    end;
end;
{*Binarização da imagem*}
procedure TForm1.MenuItem15Click(Sender: TObject);
var
  lim : LongInt;
  cor:Integer;
begin
   lim := StrToInt(Edit5.Text);
   for i:=0 to (Image1.Height-2)do
     for j:=0 to (Image1.Width-2)do
     begin
       cor:= GetRValue(Image1.canvas.Pixels[i,j]);
       if cor>=lim then
         Image2.Canvas.Pixels[i,j]:=RGB(255, 255, 255)
       else
           Image2.Canvas.Pixels[i,j] := RGB(0,0,0);
     end;
end;
{*Equalização da Imagem*}
procedure TForm1.MenuItem16Click(Sender: TObject);
var
  nColunas, nLinhas:Integer;
  hist, histAcu: array[0 .. 255] of Integer;
  novoValor: array[0..255] of Byte;
  cor : TColor;
  cinza: Byte;
begin
  nColunas := Image1.Width;
  nLinhas := Image1.Height;


  for i:=0 to 255 do
  begin
    hist[i] := 0;
    histAcu[i] := 0;
    novoValor[i]:= 0;
  end;

  for i:= 0 to nColunas-1 do
   for j:= 0 to nLinhas-1 do
   begin
     cor := Image1.Canvas.Pixels[i,j];
     cinza:= GetRValue(cor);
     Inc(hist[cinza]);
   end;

  for i:=1 to 255 do
  begin
    histAcu[i]:= histAcu[i-1] + hist[i];
  end;

  for i:= 0 to 255 do
  begin
    novoValor[i] := max(0, round((255*histAcu[i])/(nColunas*nLinhas))-1);
  end;

  for i:=0 to nColunas-1 do
    for j:=0 to nLinhas-1 do
    begin
      cinza := GetRValue(Image1.Canvas.pixels[i,j]);

      Image2.Canvas.Pixels[i,j] := RGB(novoValor[cinza],novoValor[cinza],novoValor[cinza]);
    end;


end;

(*Compressão*)
procedure TForm1.MenuItem17Click(Sender: TObject);
var C, Y, RNormalizado, Intermediario: Double;
var i, j, R, S: Integer;
begin
  C := StrToFloat(Edit3.Text);
  Y := StrToFloat(Edit4.Text);

  for i := 0 to Image1.Width - 1 do
      for j := 0 to Image1.Height - 1 do
      begin
           R := GetRValue(Image1.Canvas.pixels[i,j]);
           RNormalizado := R / 255;
           Intermediario := C * power(RNormalizado, Y);
           S := Round(Intermediario * 255);
           if S > 255 then S := 255;
           if S < 0 then S := 0;
           Image2.Canvas.pixels[i,j] := RGB(S, S, S);
      end;
end;
{*Laplaciano Vizinhança 4*}
procedure TForm1.MenuItem18Click(Sender: TObject);
var
  i, j, corEq, min, max: integer;
  cor: array[0..511, 0..511] of integer;
begin

  for i := 0 to 511 do
    for j := 0 to 511 do
      cor[i, j] := 0;

  min := 2147483647;
  max := -2147483648;


  for i := 1 to Image1.Height - 2 do
    for j := 1 to Image1.Width - 2 do
    begin
      cor[i, j] :=
        -1 * (Image1.Canvas.Pixels[j - 1, i] +
              Image1.Canvas.Pixels[j + 1, i] +
              Image1.Canvas.Pixels[j, i - 1] +
              Image1.Canvas.Pixels[j, i + 1]) +
         4 * Image1.Canvas.Pixels[j, i];


      if cor[i, j] < min then min := cor[i, j];
      if cor[i, j] > max then max := cor[i, j];
    end;


  if max = min then max := min + 1;


  for i := 1 to Image1.Height - 2 do
    for j := 1 to Image1.Width - 2 do
    begin
      corEq := Round(((cor[i, j] - min) / (max - min)) * 255);


      if corEq < 0 then corEq := 0;
      if corEq > 255 then corEq := 255;

      Image2.Canvas.Pixels[j, i] := RGB(corEq, corEq, corEq);
    end;
end;

{*limiarização*}
procedure TForm1.MenuItem19Click(Sender: TObject);
var
  lim, cor: Integer ;
  i, j: Integer;
begin
  lim := StrToInt(Edit5.Text);

  for i := 0 to (Image1.Height - 2) do
    for j := 0 to (Image1.Width - 2) do
    begin
      cor := GetRValue(Image1.Canvas.Pixels[j, i]);
      if cor >= lim then
        Image2.Canvas.Pixels[j, i] := Image1.Canvas.Pixels[j, i]
      else
        Image2.Canvas.Pixels[j, i] := RGB(0, 0, 0);
    end;
end;
 {*Somar duas imagens*}
procedure TForm1.MenuItem20Click(Sender: TObject);
var
  soma, cor1, normal, cor2: Integer;

begin
  for i:= 0 to Image1.Height-1 do
   for j:= 0  to Image1.Width-1 do
   begin

     cor1 := GetRValue(Image1.Canvas.Pixels[i,j]);
     cor2 := GetRValue(Image2.Canvas.Pixels[i,j]);

     soma := cor1 + cor2;
     normal := round((soma-255)/255*255);
     Image3.Canvas.Pixels[i,j]:=RGB(normal,normal,normal);
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
{*Magnitude*}
procedure TForm1.Edit1Change(Sender: TObject);
begin

end;
{*Direção*}
procedure TForm1.Edit2Change(Sender: TObject);
begin

end;
{*C para Compressão*}
procedure TForm1.Edit3Change(Sender: TObject);
begin

end;
{*Y para Compressão*}
procedure TForm1.Edit4Change(Sender: TObject);
begin

end;

{*Limiar*}
procedure TForm1.Edit5Change(Sender: TObject);
begin

end;

procedure TForm1.Edit6Change(Sender: TObject);
begin

end;


(*Sub-Menu 1*)
procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem21Click(Sender: TObject);
begin

end;

(*Discrete Cosine Transformation*)
procedure TForm1.MenuItem22Click(Sender: TObject);
var i, j, u, v, cor: integer;
var alphaU, alphaV, Somatorios, CUV: double;
begin
  for i:= 0 to 127 do
      for j := 0 to 127 do
      begin
        if i = 0 then
        begin
          alphaU := sqrt(1/128);
        end
        else
        begin
          alphaU := sqrt(2/128);
        end;

        if j = 0 then
        begin
          alphaV := sqrt(1/128);
        end
        else
        begin
          alphaV := sqrt(2/128);
        end;

        Somatorios := 0;
        for u := 0 to 127 do
            for v := 0 to 127 do
            begin
              cor := getRValue(Image1.Canvas.Pixels[u,v]);
              Somatorios := Somatorios + cor * Cos(((2 * u + 1) * i * Pi) / (2 * 128)) * Cos(((2 * v + 1) * j * Pi) / (2 * 128));
            end;

        CUV := alphaU * alphaV * Somatorios;
        matrizC[i,j] := Round(CUV);
      end;

  for i := 0 to 127 do
      for j := 0 to 127 do
      begin
        if matrizC[i,j] > 255 then
        begin
           Image2.Canvas.Pixels[i,j] := RGB(255, 255, 255);
        end
        else
        begin
          if matrizC[i,j] < 0 then
          begin
            Image2.Canvas.Pixels[i,j] := RGB(0, 0, 0);
          end
          else
          begin
            Image2.Canvas.Pixels[i,j] := RGB(matrizC[i,j], matrizC[i,j], matrizC[i,j]);
          end;
        end;
      end;
end;

(*Inverse Discrete Cosine Transform*)
procedure TForm1.MenuItem23Click(Sender: TObject);
var i, j, u, v, cor: integer;
var alphaU, alphaV, CUV: double;
begin
  PopupNotifier1.Title := 'Opcional';
  PopupNotifier1.Text := 'Após Finalização DCT opcionalmente pode adicionar ruído branco à imagem adicionando pixels RGB(255, 255, 255) ao espectro DCT em canvas 2';
  PopupNotifier1.Show();

  for i:= 0 to 127 do
      for j := 0 to 127 do
      begin
        CUV := 0;
        for u := 0 to 127 do
            for v := 0 to 127 do
            begin
              if u = 0 then
              begin
                alphaU := sqrt(1/128);
              end
              else
              begin
                alphaU := sqrt(2/128);
              end;

              if v = 0 then
              begin
                alphaV := sqrt(1/128);
              end
              else
              begin
                alphaV := sqrt(2/128);
              end;

              cor := matrizC[u, v];
              CUV := CUV + alphaU * alphaV * cor * Cos(((2 * i + 1) * u * Pi) / (2 * 128)) * Cos(((2 * j + 1) * v * Pi) / (2 * 128));
            end;

        matrizF[i,j] := Round(CUV);
      end;

  for i := 0 to 127 do
      for j := 0 to 127 do
      begin
        Image2.Canvas.Pixels[i,j] := RGB(matrizF[i,j], matrizF[i,j], matrizF[i,j]);
      end;
end;

(*Inverse DCT Filtro Passa Baixa*)
procedure TForm1.MenuItem24Click(Sender: TObject);
var i, j, u, v, cor: integer;
var alphaU, alphaV, CUV: double;
var matrizCopia, matrizResultado: array [0..127, 0..127] of integer;
begin
  for i := 0 to 127 do
      for j := 0 to 127 do
      begin
        if Sqrt(i*i + j*j) >= StrToFloat(Edit6.Text) then
        begin
          matrizCopia[i,j] := 0;
        end
        else
        begin
          matrizCopia[i,j] := matrizC[i,j];
        end;
      end;


  for i:= 0 to 127 do
      for j := 0 to 127 do
      begin
        CUV := 0;
        for u := 0 to 127 do
            for v := 0 to 127 do
            begin
              if u = 0 then
              begin
                alphaU := sqrt(1/128);
              end
              else
              begin
                alphaU := sqrt(2/128);
              end;

              if v = 0 then
              begin
                alphaV := sqrt(1/128);
              end
              else
              begin
                alphaV := sqrt(2/128);
              end;

              cor := matrizCopia[u, v];
              CUV := CUV + alphaU * alphaV * cor * Cos(((2 * i + 1) * u * Pi) / (2 * 128)) * Cos(((2 * j + 1) * v * Pi) / (2 * 128));
            end;

        matrizResultado[i,j] := Round(CUV);
      end;

  for i := 0 to 127 do
      for j := 0 to 127 do
      begin
      Image2.Canvas.Pixels[i, j] := RGB(matrizResultado[i, j], matrizResultado[i, j], matrizResultado[i, j]);
      end;
end;

(*Inverse DCT Filtro Passa Alta*)
procedure TForm1.MenuItem25Click(Sender: TObject);
var i, j, u, v, cor: integer;
var alphaU, alphaV, CUV: double;
var matrizCopia, matrizResultado: array [0..127, 0..127] of integer;
begin
  for i := 0 to 127 do
      for j := 0 to 127 do
      begin
        if Sqrt(i*i + j*j) <= StrToFloat(Edit6.Text) then
        begin
          matrizCopia[i,j] := 0;
        end
        else
        begin
          matrizCopia[i,j] := matrizC[i,j];
        end;
      end;


  for i:= 0 to 127 do
      for j := 0 to 127 do
      begin
        CUV := 0;
        for u := 0 to 127 do
            for v := 0 to 127 do
            begin
              if u = 0 then
              begin
                alphaU := sqrt(1/128);
              end
              else
              begin
                alphaU := sqrt(2/128);
              end;

              if v = 0 then
              begin
                alphaV := sqrt(1/128);
              end
              else
              begin
                alphaV := sqrt(2/128);
              end;

              cor := matrizCopia[u, v];
              CUV := CUV + alphaU * alphaV * cor * Cos(((2 * i + 1) * u * Pi) / (2 * 128)) * Cos(((2 * j + 1) * v * Pi) / (2 * 128));
            end;

        matrizResultado[i,j] := Max(0, Min(255, Round(CUV)));
      end;

  for i := 0 to 127 do
      for j := 0 to 127 do
      begin
      Image2.Canvas.Pixels[i, j] := RGB(matrizResultado[i, j], matrizResultado[i, j], matrizResultado[i, j]);
      end;
end;

(*Pseudo Cores*)
procedure TForm1.MenuItem26Click(Sender: TObject);
var i, j, tomDeCinza: integer;
var matriz: array [0..913, 0..457] of integer;
var tabelaCores: array[0..255, 0..2] of integer;
var matrizColorida: array [0..913, 0..457] of TColor;
begin
  if (OpenDialog1.Execute)
     then Image3.Picture.LoadFromFile(OpenDialog1.FileName);

  for i := 0 to 913 do
      for j := 0 to 457 do
      begin
           matriz[i,j] := GetRValue(Image3.Canvas.Pixels[i,j]);
      end;

  (*Montando Tabela de Cores*)
  for i := 0 to 255 do
  begin
    if i < 64 then
    begin
      tabelaCores[i,0] := 0;
      tabelaCores[i,1] := 0;
      tabelaCores[i,2] := i * 4;
    end;

    if (i >= 64) and (i < 128) then
    begin
      tabelaCores[i,0] := 0;
      tabelaCores[i,1] := (i - 64) * 4;
      tabelaCores[i,2] := 255;
    end;

    if (i >= 128) and (i < 192) then
    begin
      tabelaCores[i,0] := 0;
      tabelaCores[i,1] := 255;
      tabelaCores[i,2] := 255 - (i - 128) * 4;
    end;

    if i >= 192 then
    begin
      tabelaCores[i,0] := (i - 192) * 4;
      tabelaCores[i,1] := 255;
      tabelaCores[i,2] := 0;
    end;
  end;

  for i := 0 to 913 do
      for j := 0 to 457 do
      begin
        tomDeCinza := matriz[i,j];
        matrizColorida[i,j] := RGB(tabelaCores[tomDeCinza, 0], tabelaCores[tomDeCinza, 1], tabelaCores[tomDeCinza, 2]);
      end;

  for i := 0 to 913 do
      for j := 0 to 457 do
      begin
        Image3.Canvas.Pixels[i,j] := matrizColorida[i,j];
      end;
end;

(*Abrir Imagem*)
procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if (OpenDialog1.Execute)
     then Image1.Picture.LoadFromFile(OpenDialog1.FileName);
     for i:= 0 to Image1.Height do
       for j:= 0 to Image1.Width do
         begin
              ime[i,j] := GetRValue(Image1.Canvas.Pixels[i,j]);
         end;
end;
{*Salvar Imagem 2*}
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
var
  i, j: Integer;
  cor, r, g, b, c: Integer;
begin

  for i := 0 to 511 do
    for j := 0 to 511 do
      ime[i, j] := Image1.Canvas.Pixels[i, j];


  for i := 0 to 511 do
    for j := 0 to 511 do
    begin
      cor := ime[i, j];
      r := GetRValue(cor);
      g := GetGValue(cor);
      b := GetBValue(cor);
      c := Round(0.299 * r + 0.587 * g + 0.114 * b);
      ims[i, j] := c;
    end;


  for i := 0 to 511 do
    for j := 0 to 511 do
      Image2.Canvas.Pixels[i, j] := RGB(ims[i, j], ims[i, j], ims[i, j]);
end;


(*Negativa Cinza*)
procedure TForm1.MenuItem7Click(Sender: TObject);
begin

  for i:=0 to Image1.Width - 1 do
      for j:= 0 to Image1.Height - 1 do
          begin
            ims[i, j] := 255 - Image1.Canvas.Pixels[i,j];
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

procedure TForm1.MenuItem9Click(Sender: TObject);
begin

end;

(*Comentado devido a necessidade de pseudo cores
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
*)

procedure TForm1.PopupNotifier1Close(Sender: TObject;
  var CloseAction: TCloseAction);
begin

end;

end.

