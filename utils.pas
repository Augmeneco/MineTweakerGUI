unit utils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, strutils, fpjson, jsonparser, dateutils, RegExpr;

type
  TMCItem = record
    name: string;
    id: string;
  end;
type
  TMCItemArray = array of TMCItem;

function readfile(fnam: string): string;
function cuterandom(min,max: integer): Integer;
function veryBadToLower(str: String): String;
procedure writefile(fnam: string; txt: string);
procedure logWrite(str: String);
function ReadTweakerLog(): TMCItemArray;

implementation
uses
  main;

function ReadTweakerLog(): TMCItemArray;
var
  id, name: String;
  raw_text: TStringList;
  start_line, i: Integer;
  re: TRegExpr;
  itemarr: TMCItemArray;
  item: TMCItem;
begin
  SetLength(itemarr,1);
  raw_text := TStringList.Create;
  raw_text.LoadFromFile('minetweaker.log');
  re := TRegExpr.Create;                //'<(.*)>'
                                          //,\s(.*)
  for i:=0 to raw_text.Count-1 do
  begin
    if pos('<',raw_text[i]) = 0 then
       Continue;

    re.Expression := '<(.*)>';
    re.Exec(raw_text[i]);
    id := re.Match[0];

    re.Expression := ',\s(.*)';
    re.Exec(raw_text[i]);
    name := re.Match[1];

    item.id := id;
    item.name := name;
    itemarr[Length(itemarr)-1] := item;
    SetLength(itemarr,Length(itemarr)+1);
  end;
  SetLength(itemarr,Length(itemarr)-1);
  Result := itemarr;

end;

procedure logWrite(str: String);
var
  logTime: TDateTime;
begin
  logTime := now();
  writeln(format('[%s] %s',
                 [formatDateTime('hh:nn:ss', logTime),
                  str]));
end;

function readfile(fnam: string): string;
var
  text: TStringList;
begin
  text := TStringList.Create;
  text.LoadFromFile(fnam);
  Result := text.Text;
end;

procedure writefile(fnam: string; txt: string);
var
  strm: TFileStream;
  n: longint;
begin
  strm := TFileStream.Create(fnam, fmCreate);
  n := Length(txt);
  try
    strm.Position := 0;
    strm.Write(txt[1], n);
  finally
    strm.Free;
  end;
end;

function cuterandom(min,max: integer): Integer;
begin
  cuterandom := random(max-min+1)+min;
end;

function veryBadToLower(str: String): String;
const
  convLowers: Array [0..87] of String = ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u',
      'v', 'w', 'x', 'y', 'z', 'à', 'á', 'â', 'ã', 'ä', 'å', 'æ', 'ç', 'è', 'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï',
      'ð', 'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', 'ø', 'ù', 'ú', 'û', 'ü', 'ý', 'а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж',
      'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ъ', 'ы',
      'ь', 'э', 'ю', 'я');
  convUppers: Array [0..87] of String = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
      'V', 'W', 'X', 'Y', 'Z', 'À', 'Á', 'Â', 'Ã', 'Ä', 'Å', 'Æ', 'Ç', 'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï',
      'Ð', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', 'Ø', 'Ù', 'Ú', 'Û', 'Ü', 'Ý', 'А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ё', 'Ж',
      'З', 'И', 'Й', 'К', 'Л', 'М', 'Н', 'О', 'П', 'Р', 'С', 'Т', 'У', 'Ф', 'Х', 'Ц', 'Ч', 'Ш', 'Щ', 'Ъ', 'Ъ',
      'Ь', 'Э', 'Ю', 'Я');
var
  i: Integer;
begin
  result := str;
  for i := 0 to 87 do
    result := stringReplace(result, convUppers[i], convLowers[i], [rfReplaceAll]);
end;


begin

end.














