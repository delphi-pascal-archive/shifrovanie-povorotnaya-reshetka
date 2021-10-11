{*****************************************************************

Author: Dennis Malkoff
Copyrights: Dennis Malkoff
E-mail: info@sminstall.com
WEB: http://www.sminstall.com/

******************************************************************}
unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, XPMan, Math;

type
  TMainForm = class(TForm)
    XSizeEdit: TEdit;
    StatusBar: TStatusBar;
    SizeLabel: TLabel;
    TextLabel: TLabel;
    TextEdit: TEdit;
    Cliche: TStringGrid;
    Table: TStringGrid;
    XUpDown: TUpDown;
    XPManifest: TXPManifest;
    CryptButton: TButton;
    DecryptButton: TButton;
    ClicheLabel: TLabel;
    LatticeLabel: TLabel;
    CloseButton: TButton;
    DecryptText: TEdit;
    ResetButton: TButton;
    XLabel: TLabel;
    YSizeEdit: TEdit;
    YUpDown: TUpDown;
    MaxLabel: TLabel;
    Speed: TTrackBar;
    DecryptLabel: TLabel;
    SpeedLabel: TLabel;
    procedure XUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure CloseButtonClick(Sender: TObject);
    procedure CryptButtonClick(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
    procedure ClicheDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure TableDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure DecryptButtonClick(Sender: TObject);
  end;

var
  MainForm: TMainForm;
  ClicheMatrix:array of array of Boolean;
  TableMatrix:array of array of Char;
  xSize,ySize,AnimatePos,ClichePosX:Byte;

implementation

{$R *.dfm}

procedure TMainForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ResetButtonClick(nil);
end;

procedure TMainForm.XUpDownClick(Sender: TObject; Button: TUDBtnType);
begin
  ResetButtonClick(nil);
end;

procedure TMainForm.ResetButtonClick(Sender: TObject);
var
  i,j:Integer;
begin
  AnimatePos:=0;
  ClichePosX:=0;
  xSize:=XUpDown.Position;
  ySize:=YUpDown.Position;
  Cliche.ColCount:=xSize;
  Cliche.RowCount:=ySize;
  Table.ColCount:=xSize;
  Table.RowCount:=ySize;

  MaxLabel.Caption:='Максимум '+IntToStr(xSize*ySize)+' символов, всего '+IntToStr(Length(TextEdit.Text))+' символов';

  SetLength(ClicheMatrix,xSize);
  SetLength(TableMatrix,xSize);
  for i:=0 to xSize-1 do
  begin
    SetLength(ClicheMatrix[i],ySize);
    SetLength(TableMatrix[i],ySize);
    for j:=0 to ySize-1 do
    begin
      ClicheMatrix[i][j]:=False;
      TableMatrix[i][j]:=#0;
    end;
  end;
  
  DecryptText.Text:='';
  Cliche.Repaint;
  Table.Repaint;
end;

procedure GetCoords(Position,MaxX,MaxY,x,y:Integer;var dx,dy:Integer);
begin
  case Position of
  1:begin
      dx:=x;
      dy:=y;
    end;
  2:begin
      dx:=x;
      dy:=MaxY-y-1;
    end;
  3:begin
      dx:=MaxX-x-1;
      dy:=y;
    end;
  4:begin
      dx:=MaxX-x-1;
      dy:=MaxY-y-1;
    end;
  end;
end;

procedure TMainForm.CryptButtonClick(Sender: TObject);
var
  i,a,m,c,x,y,dx,dy:Integer;
  Text:String;
  b:Boolean;
  Coords:array of TPoint;
  t:TPoint;
begin
  ResetButtonClick(nil);
  CryptButton.Enabled:=False;

  Text:=TextEdit.Text;
  m:=Length(Text);
  if m>xSize*ySize then
  begin
    MessageBox(Handle,'Слишком длинный текст - увеличьте матрицу!','Ошибка',MB_ICONWARNING);
    CryptButton.Enabled:=True;
    Exit;
  end;
  a:=Ceil(m/4);
  for i:=1 to a*4-m do Text:=Text+' ';

  c:=0;
  repeat
    Randomize;
    x:=Random(xSize);
    y:=Random(ySize);
    b:=True;
    for i:=1 to 4 do
    begin
      GetCoords(i,xSize,ySize,x,y,dx,dy);
      if ClicheMatrix[dx][dy] then
      begin
        b:=False;
        Break
      end;
    end;
    if b then
    begin
      ClicheMatrix[x][y]:=True;
      Inc(c);
    end;
  until c=a;
  Cliche.Repaint;

  for i:=1 to 4 do
  begin
    SetLength(Coords,a);
    c:=0;
    for y:=0 to ySize-1 do
    for x:=0 to xSize-1 do if (c<a) and ClicheMatrix[x][y] then
    begin
      GetCoords(i,xSize,ySize,x,y,dx,dy);
      Coords[c].X:=dx;
      Coords[c].Y:=dy;
      Inc(c);
    end;

    for x:=1 to a-1 do
    for y:=a-1 downto x do
    if (Coords[y-1].Y>Coords[y].Y) or ((Coords[y-1].Y=Coords[y].Y) and (Coords[y-1].X>Coords[y].X)) then
    begin
      t:=Coords[y-1];
      Coords[y-1]:=Coords[y];
      Coords[y]:=t;
    end;

    for x:=0 to a-1 do TableMatrix[Coords[x].X][Coords[x].Y]:=Text[a*(i-1)+x+1];
  end;

  for y:=0 to ySize-1 do
  for x:=0 to xSize-1 do if TableMatrix[x][y]=#0 then
  begin
    Randomize;
    c:=192+Random(65);
    if c=256 then c:=32;
    TableMatrix[x][y]:=Char(c);
  end;
  Table.Repaint;
  CryptButton.Enabled:=True;
end;

procedure TMainForm.ClicheDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Color:TColor;
  ShiftX:Integer;
begin
  Color:=clBlack;
  if Length(ClicheMatrix)>0 then
  begin
    ShiftX:=ACol-ClichePosX;
    if ((ShiftX>=0) and ClicheMatrix[ShiftX][ARow]) or (ClichePosX>ACol) then Color:=clWhite;
  end;
  Cliche.Canvas.Brush.Color:=Color;
  Cliche.Canvas.FillRect(Rect);
end;

procedure TMainForm.TableDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Color:TColor;
  c:Char;
  s:array[0..1] of Char;
  dx,dy:Integer;
  ShiftX:Integer;
begin
  Color:=clWhite;
  if AnimatePos>0 then
  begin
    Color:=clBlack;
    ShiftX:=xSize-ClichePosX+ACol;
    if (ShiftX>=0) and (ShiftX<xSize) then
    begin
      GetCoords(AnimatePos,xSize,ySize,ShiftX,ARow,dx,dy);
      if ClicheMatrix[dx][dy] then Color:=clWhite;
    end;
    if (ACol>=ClichePosX) then Color:=clWhite;
  end;

  Table.Canvas.Brush.Color:=Color;
  Table.Canvas.FillRect(Rect);
  if Length(TableMatrix)>0 then
  begin
    c:=TableMatrix[ACol][ARow];
    if c<>#0 then ExtTextOut(Table.Canvas.Handle,Rect.Left+(Rect.Right-Rect.Left-Table.Canvas.TextWidth(c)) div 2,Rect.Top+2,ETO_OPAQUE or ETO_CLIPPED,@Rect,StrPCopy(s,c),1,nil);
  end;
end;

procedure TMainForm.DecryptButtonClick(Sender: TObject);
var
  i,x,y,dx,dy:Integer;
begin
  DecryptButton.Enabled:=False;
  DecryptText.Text:='';

  AnimatePos:=1;
  for i:=0 to xSize do
  begin
    ClichePosX:=i;
    Cliche.Repaint;
    Table.Repaint;
    Application.ProcessMessages;
    Sleep(50*Speed.Position);
  end;

  for i:=1 to 4 do
  begin
    AnimatePos:=i;
    Cliche.Repaint;
    Table.Repaint;
    Application.ProcessMessages;
    Sleep(200*Speed.Position);
    for y:=0 to ySize-1 do
    for x:=0 to xSize-1 do
    begin
      GetCoords(i,xSize,ySize,x,y,dx,dy);
      if ClicheMatrix[dx][dy] then
      begin
        DecryptText.Text:=DecryptText.Text+TableMatrix[x][y];
        Application.ProcessMessages;
        Sleep(5*Speed.Position);
      end;
    end;
    Application.ProcessMessages;
    Sleep(200*Speed.Position);
  end;

  DecryptText.Text:=Trim(DecryptText.Text);

  AnimatePos:=1;
  for i:=xSize downto 0 do
  begin
    ClichePosX:=i;
    if ClichePosX=0 then AnimatePos:=0;
    Cliche.Repaint;
    Table.Repaint;
    if ClichePosX>0 then
    begin
      Application.ProcessMessages;
      Sleep(50*Speed.Position);
    end;
  end;
  DecryptButton.Enabled:=True;
end;

end.
