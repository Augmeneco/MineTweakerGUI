unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  utils, jsonparser, fpjson;

type

  { TForm1 }

  TForm1 = class(TForm)
    Cell1: TButton;
    Cell2: TButton;
    Cell3: TButton;
    Cell4: TButton;
    Cell5: TButton;
    Cell6: TButton;
    Cell7: TButton;
    Cell8: TButton;
    Cell9: TButton;
    ResultComboBox: TComboBox;
    OutPutMemo: TMemo;
    SearchEdit: TEdit;
    ItemsListBox: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ItemsListBoxClick(Sender: TObject);
    procedure SearchEditChange(Sender: TObject);
    procedure ReNameButton(Sender: TObject);
    procedure NullifyButton(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

  private

  public

  end;

var
  Form1: TForm1;
  last_clicked_id: string;
  arritems: TMCItemArray;
  arrnames: TJSONObject;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  if not FileExists('minetweaker.log') then
  begin
    ShowMessage('Файл minetweaker.log должен лежать рядом с .exe');
    Halt;
  end;

  arritems := ReadTweakerLog();
  arrnames := TJSONObject.Create;
  for i:=0 to Length(arritems) do
  begin
    arrnames.Add(arritems[i].name,arritems[i].id);
    ItemsListBox.Items.Add(arritems[i].name);
    ResultComboBox.Items.Add(arritems[i].name);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  OutPutMemo.Lines.Add(Format('recipces.addShaped(%s,',[arrnames[ResultComboBox.Caption].AsString]));
  OutPutMemo.Lines.Add(Format('  [[%s,%s,%s],',[Cell1.Caption,Cell2.Caption,Cell3.Caption]));
  OutPutMemo.Lines.Add(Format('   [%s,%s,%s],',[Cell4.Caption,Cell5.Caption,Cell6.Caption]));
  OutPutMemo.Lines.Add(Format('   [%s,%s,%s]]);'+LineEnding,[Cell7.Caption,Cell8.Caption,Cell9.Caption]));
end;

procedure TForm1.ItemsListBoxClick(Sender: TObject);
begin
  last_clicked_id := arrnames[ItemsListBox.GetSelectedText].AsString;
end;

procedure TForm1.SearchEditChange(Sender: TObject);
var
  i: Integer;
begin
  if SearchEdit.text = '' then
  begin
    for i:=0 to Length(arritems) do
    begin
      ItemsListBox.Items.Add(arritems[i].name);
    end;
    Exit;
  end;

  ItemsListBox.Clear;
  for i:=0 to Length(arritems)-1 do
    if pos(SearchEdit.text,arritems[i].name) <> 0 then
       ItemsListBox.Items.Add(arritems[i].name);
end;

procedure TForm1.ReNameButton(Sender: TObject);
begin
  (Sender as TButton).Caption := last_clicked_id;
  (Sender as TButton).hint := last_clicked_id;
end;

procedure TForm1.NullifyButton(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if button = mbRight then
     (Sender as TButton).Caption := 'null';
end;

begin

end.

