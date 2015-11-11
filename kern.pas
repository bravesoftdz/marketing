unit kern;


interface


uses QDialogs, SysUtils, Controls, Windows;

const
BASE_REPO         = '\\HERCULES\Base$\departments\newdep.exe';
MARK_REPO         = '\\HERCULES\Base$\marketing\marketing.exe';
DIR_REPO          = '\\HERCULES\Base$\director\director.exe';
ID_LENGTH         = 38; // ����� �������������� MS SQL
MAXWEEK           = 5; // ������������ ���-�� ������ � ������
MAXWORK           = 70; // ������������ ������� �������� � ������
NA                = 10; // �� ����������
NN                = 11; // ����������
NS                = 12; // �� ������ ������ �������
ZC                = 13; // ����� ��� ������
MINAVG            = 4.75; // ������� ���� ����������������

ACADEM            = 1; // � �������
ADD_COURSE        = 2; // ��������� ����
DEL_ERR           = 4; // ������ �� ������
DEL_LEG           = 8; // ������ �� �������
ARCH              = 128; // ��������
LINESCOUNT        = 30; // ����� ����� �� �������

MAX_PK_WEEK       = 100; // �������� ������ �������� (255 ����)
MIN_PK_WEEK       = 1; // ������� ������ ��������
DELETE_REQ        = '������������� ������� ��������� ������?';
ARCHIVE_REQ       = '��������� ��������� ������ � �����?';
RESTORE_REQ       = '������� �������� � ������ �� ������� �� ��� ������?';
DEPMODULE_CAPTION = '������ ���������';
NEW_STUDENT       = '����� ������� ������ ';
EX_STUDENT        = '������ �������� ������ ';
SKILLS            = '������������ ';
NEW_GROUP         = '����� ������ ';
EX_GROUP          = '��������� ������ ';
GROUPMAN_CAPTION  = '������ ������������� ';
NONE_STUDENTS     = '� ������ ��� �� ������ ��������';
NEW_SPEC          = '����� �������������';
WEEK_MISSINGS     = '�������� �� ������ ';
NOPE              = '�� �������������';
PARAMSFILENAME    = 'params.dat';
OP_ERROR          = '��� ���������� �������� ��������� ������!';
ST_ERROR          = '��������� �� ��� ����������� ������ ��������!';
filename          = 'connection.udl';
UPD_FILE          = 'updater.exe';
NO_COURSE         = '��� �������� �������� �� ������� ��������. ������� ������� ���������.';
ALL_PRINT         = '��������! '+#$D+'��������� ��� ���� ����� ����� ���������� �� ������ �������������!'+#$D+'�����������?';

procedure NotYet;
procedure NotForYou;
function FileInfo(NameApp: string): extended;
function GetMounthStr(const mounth: word): string;
function GetRMounthStr(const mounth: word): string;
function GetYears(const BMounth, BYear : word): string;
function GetYearsNum(const BMounth, BYear : word): string;
function GetStr(const value: word): string;
function GetDateStr(const date: TDate): string;
function GetWeekPrefix(const nweeks: double): string;
function GetCourse(const semester: integer):string;
function MarkToStr(const mark: integer): string;
function Roof(const a, b: word): word;
function GetDottedFloat(const fstr: string): string;

type
TContainer = class(TObject)
private
AName : string;
AKey  : string;
AValue: integer;
public
property Name: string read AName write AName;
property Key: string read AKey write AKey;
property Value: integer read AValue write AValue;
end;




implementation

function FileInfo(NameApp: string): extended;
var
  dump: DWORD;
  size: integer;
  buffer: PChar;
  VersionPointer, TransBuffer: PChar;
  Temp: integer;
  CalcLangCharSet: string;
  res   : string;
  x     : integer;

begin
try
  size := GetFileVersionInfoSize(PChar(NameApp), dump);
  buffer := StrAlloc(size+1);
  try
    GetFileVersionInfo(PChar(NameApp), 0, size, buffer);

    VerQueryValue(buffer, '\VarFileInfo\Translation', pointer(TransBuffer),
    dump);
    if dump >= 4 then
    begin
      temp:=0;
      StrLCopy(@temp, TransBuffer, 2);
      CalcLangCharSet:=IntToHex(temp, 4);
      StrLCopy(@temp, TransBuffer+2, 2);
      CalcLangCharSet := CalcLangCharSet+IntToHex(temp, 4);
    end;

    VerQueryValue(buffer, pchar('\StringFileInfo\'+CalcLangCharSet+
    '\'+'FileVersion'), pointer(VersionPointer), dump);
    if (dump > 1) then
    begin
      SetLength(Res, dump);
      StrLCopy(Pchar(Res), VersionPointer, dump);
    end
    else
      res := '0.0.0.0';
  finally
    StrDispose(Buffer);
  end;
except
res := '0.0.0.0';
end;
res := trim(res);
for x := 1 to length(res) do
  if res[x] = '.' then
    res[x] := '0';
Result := StrToFloatDef(res,0);
end;



function Roof(const a, b: word): word;
var
d  : word;
begin
  d := a div b;
  if (a mod b) > 0 then inc(d);
  Result := d;
end;


function GetMounthStr(const mounth: word): string;
begin
Result := '';
case mounth of
1  : Result := '������';
2  : Result := '�������';
3  : Result := '����';
4  : Result := '������';
5  : Result := '���';
6  : Result := '����';
7  : Result := '����';
8  : Result := '������';
9  : Result := '��������';
10 : Result := '�������';
11 : Result := '������';
12 : Result := '�������';
end;
end;

function GetRMounthStr(const mounth: word): string;
begin
Result := '';
case mounth of
1  : Result := '������';
2  : Result := '�������';
3  : Result := '�����';
4  : Result := '������';
5  : Result := '���';
6  : Result := '����';
7  : Result := '����';
8  : Result := '�������';
9  : Result := '��������';
10 : Result := '�������';
11 : Result := '������';
12 : Result := '�������';
end;
end;


procedure NotYet;
begin
MessageDlg('������ ������� ���� �� �����������',mtInformation,
[mbOk],0);
end;

procedure NotForYou;
begin
MessageDlg('������ ������� ��� ����������',mtError,
[mbOk],0);
end;

function GetYears(const BMounth, BYear : word): string;
const
year = ' �������� ����';
begin
if BMounth >= 9 then
  Result := IntToStr(BYear)+'-'+IntToStr(BYear+1)+year
else
  Result := IntToStr(BYear-1)+'-'+IntToStr(BYear)+year
end;

function GetCourse(const semester: integer): string;
const
course = ' ����';
begin
case semester of
 1,2 : Result := '1'+course;
 3,4 : Result := '2'+course;
 5,6 : Result := '3'+course;
 7,8 : Result := '4'+course;
end; // case
end;

function GetYearsNum(const BMounth, BYear : word): string;
begin
if BMounth >= 9 then
  Result := IntToStr(BYear)+'-'+IntToStr(BYear+1)
else
  Result := IntToStr(BYear-1)+'-'+IntToStr(BYear);
end;


function GetStr(const value: word): string;
begin
if value < 10 then
  Result := '0'+IntToStr(value)
else
  Result := IntToStr(value);
end;


function GetDateStr(const date: TDate): string;
var
d, m, y : word;
mstr    : string;

begin
DecodeDate(date, y, m, d);
case m of
 1  : mstr := ' ������ ';
 2  : mstr := ' ������� ';
 3  : mstr := ' ����� ';
 4  : mstr := ' ������ ';
 5  : mstr := ' ��� ';
 6  : mstr := ' ���� ';
 7  : mstr := ' ���� ';
 8  : mstr := ' ������� ';
 9  : mstr := ' �������� ';
10  : mstr := ' ������� ';
11  : mstr := ' ������ ';
12  : mstr := ' ������� ';
end; // case
if d < 10 then
  Result := '0'+intToStr(d)+mstr+IntToStr(y)
else
  Result := intToStr(d)+mstr+IntToStr(y);
end;


function GetWeekPrefix(const nweeks: double): string;
var
weeks : integer;

begin
weeks := trunc(nweeks);
if (weeks > 20) then
  weeks := weeks mod 10;
 Result := FloatToStr(nweeks);
 case weeks of
 0,5..20 : Result := Result+' ������';
 1       : Result := Result+' ������';
 2..4    : Result := Result+' ������';
 end;
end;

function MarkToStr(const mark: integer): string;
begin
  case mark of
   0..2 : Result := '';
   3    : Result := '�����������������';
   4    : Result := '������';
   5    : Result := '�������';
   13   : Result := '�����';
  end; // case
end;


function GetDottedFloat(const fstr: string): string;
var
str   : string;
x     : integer;
float : real;

begin
str := fstr;
if ('' = trim(str)) then
  str := 'NULL' else
  begin
  for x := 1 to length(str) do
    if str[x] = '.' then str[x] := ',';
    float := StrToFloatDef(str,0);
    str := FloatToStr(float);
    for x := 1 to length(str) do
    if str[x] = ',' then str[x] := '.';
  end;
Result := str;
end;

end.
