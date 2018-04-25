unit Func;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  StdCtrls, FileCtrl, ExtCtrls,
  ComCtrls, math, DB, DBClient, Grids, DBGrids, menus;


type
  TUTF8NoBOMEncoding = class(TUTF8Encoding)
  public
    function GetPreamble: TBytes; override;
  end;




type
  TTextFormat = (tfAnsi, tfUnicode, tfUnicodeBigEndian, tfUtf8);

const
  TextFormatFlag: array [tfAnsi .. tfUtf8] of word = ($0000, $FFFE,
    $FEFF, $EFBB);

procedure AdjustColumnWidths(DBGrid: TDBGrid);

function StrExtract(sStr: string; const sSep: string = ';';
  const nOccur: integer = 1): string;
function iif(lFlag: boolean; var1, var2: variant): variant;

function ReadTxtToCds(stxtfile: string; cds: TclientDataSet): integer;
procedure ReadTxt(txtfile: string; scds: TclientDataSet);
function GetSepc(stable: string): string;
function GetOutSepc(stable: string): string;
function StrToList(s: string; sSep: string = ';'; lSort: boolean = True)
  : TStringList;
function StrTran(sStr, sSearch: string; sReplace: string = '';
  lCaseSense: boolean = False): string;
procedure SortTStrings(Strings: TStrings);
function AA(CONST v: variant): string;
// Add Apostrophe(') before and after for string
function GetFileType(const FileName: string): TTextFormat;
procedure SaveStringGrid(StringGrid: TStringGrid; const FileName: TFileName);
procedure LoadStringGrid(StringGrid: TStringGrid; const FileName: TFileName;cols:string);


var
  specfile, specoutfile: string;
  ifieldcount: integer;
  Fcolnm: string;
  popupMenu: TpopupMenu;
  is_output: integer;
  file_encode:string;
  start_idx,end_idx:integer;

implementation

function TUTF8NoBOMEncoding.GetPreamble: TBytes;
begin
  SetLength(Result, 0);
end;

function StrExtract(sStr: string; const sSep: string = ';';
  const nOccur: integer = 1): string;
var
  n, npos: integer;
begin
  n := abs(nOccur);
  Result := sStr;
  while n > 0 do
  begin
    // while ((n > 0) and (Result<>'')) do begin
    npos := pos(UpperCase(sSep), UpperCase(sStr));
    if npos > 0 then
    begin
      Result := copy(sStr, 1, npos - 1);
      sStr := copy(sStr, npos + length(sSep), length(sStr) - npos -
        length(sSep) + 1);
    end
    else
    begin
      Result := sStr;
      sStr := '';
    end;
    n := n - 1;
  end;
  if nOccur < 0 then // 若為負值, 取剩餘部分
    Result := sStr;
end;

// **************************************************************
// 函數名稱: iif
// 目的:  依條件運算lflag之值, 決定傳回值
// 例: i := iif( a > 0 , i, -i);
// s := iif(Button1.Enabled, 'True', 'False');
// **************************************************************

function iif(lFlag: boolean; var1, var2: variant): variant;
begin
  if lFlag then
    Result := var1
  else
    Result := var2;
end;

function GetSepc(stable: string): string;
var
  SL: TStringList;
  i: integer;
begin
  try
    SL := TStringList.Create;
    SL.LoadFromFile(specfile);
    for i := 0 to SL.Count - 1 do
    begin
      if UpperCase(stable) = UpperCase(StrExtract(SL.Strings[i], ',', 1)) then
      begin
        Result := SL.Strings[i];
        exit;
      end;
    end;
  finally
    SL.Free;
  end;
end;

function GetOutSepc(stable: string): string;
var
  SL: TStringList;
  i, j: integer;
  tmp_txt: string;
begin
  try
    SL := TStringList.Create;
    SL.LoadFromFile(specoutfile);

    for i := 0 to SL.Count - 1 do
    begin

      if copy(SL.Strings[i], 2, 1) = 'd' then // 第2碼d的忽略
        continue;

      // %h{Out_Demand},s_Out_Demand,demand_source_id,demand_source_type,
      j := pos('}', SL.Strings[i]);
      tmp_txt := copy(SL.Strings[i], 4, j - 4);
      if UpperCase(stable) = UpperCase(tmp_txt + '.txt') then
      begin
        Result := SL.Strings[i];
        Result := stringreplace(Result,',s_',',',[rfReplaceAll, rfIgnoreCase]);
        // copy(SL.Strings[i],pos('}',SL.Strings[i])+length(tmp_txt) +5 ,10000);
        exit;
      end;
    end;
  finally
    SL.Free;
  end;
end;

procedure ReadTxt(txtfile: string; scds: TclientDataSet);
var
  stblname, sfieldname: string;
  SL: TStringList;
  i, k: integer;

begin

  try
    SL := TStringList.Create;
    SL.Delimiter := ',';
    SL.DelimitedText := GetSepc(txtfile);
    stblname := SL.Strings[1];
    ifieldcount := SL.Count - 2;
    scds.Filter := '';
    scds.Filtered := False;
    scds.Close;
    scds.FieldDefs.Clear;
    for i := 2 to SL.Count - 1 do
    begin
      sfieldname := SL.Strings[i];
      if sfieldname <> '' then
        scds.FieldDefs.Add(sfieldname, ftstring, 80);
    end;

    scds.CreateDataSet;
    ReadTxtToCds(txtfile, scds);
  finally
    SL.Free;
  end;
end;

function ReadTxtToCds(stxtfile: string; cds: TclientDataSet): integer;
var
  SL: TStringList;
  i, j,row_limit: integer;
  fileencode: string;

begin
  if not cds.Active then
    exit;

  // flashform.Visible := true;
  cds.DisableControls;
  try

    SL := TStringList.Create;

    if file_encode = 'ANSI' then
    begin
      SL.LoadFromFile(stxtfile, TEncoding.ANSI);
    end;
    if file_encode = 'UTF8' then
    begin
      //SL.LoadFromFile(stxtfile, (TEncoding.UTF8 as TUTF8NoBOMEncoding));
      SL.LoadFromFile(stxtfile, TEncoding.UTF8 );
    end;

    if end_idx > SL.Count then
      row_limit :=  SL.Count
    else
      row_limit := end_idx;

    for i := start_idx-1 to row_limit - 1 do
    begin

      //if i=50000 then
      //    break;

      cds.Append;
      for j := 0 to ifieldcount - 1 do
      begin
        cds.Fields[j].AsString := StrExtract(SL.Strings[i], chr(11), j + 1);
      end;
      cds.Post;
      // flashform.Caption := '處理筆數：' + intToStr(I);
      // Application.ProcessMessages;
    end;
    // for I := 0 to dbgrid1.Columns.Count - 1 do
    // begin
    // dbgrid1.Columns[i].Width := 50;
    // end;
    Result := cds.RecordCount;
  finally
    SL.Free;
    // flashform.Visible := FALSE;
    cds.First;
    cds.EnableControls;
  end;
end;

// *******************************************
// 函數名稱: StrToList
// 目的: 將s字串轉成 StringList(以 ssep 為分行依據)
// 傳入參數:
// s: string;       //要轉成 StringList 之原始字串
// ssep: string;    //分行符號(; 或 : ..)
// 傳回值: TStringList;    //傳回轉成之 StringList
// *******************************************
function StrToList(s: string; sSep: string = ';'; lSort: boolean = True)
  : TStringList;
begin
  Result := TStringList.Create;
  try
    Result.Sorted := lSort;
    Result.Text := StrTran(s, sSep, #13 + #10);
  except
    Result.Free;
  end;
end;

// **************************************************************
// 函數名稱: StrTran
// 目的: 將字串中某字串 => 均換成另一字串
// 傳入參數:
// sStr,: string;             //原始字串
// sSearch: string;           //要置換之字串
// sReplace: string='';       //置換後字串
// lCaseSense: boolean=False  //是否要 CaseSense
// 範例:
// s := 'A***B***C**D';
// s := StrTran(s, '***', '%%'); => A%%B%%C**D
// **************************************************************
function StrTran(sStr, sSearch: string; sReplace: string = '';
  lCaseSense: boolean = False): string;
{ s := 'A***B***C**D';
  s := StrTran(s, '***', '%%'); //A%%B%%C**D }
var
  s1, s2: string;
  n, n2: integer;
begin
  if lCaseSense then
    n := pos(sSearch, sStr)
  else
    n := pos(AnsiUpperCase(sSearch), AnsiUpperCase(sStr));
  n2 := length(sSearch);
  if n <> 0 then
  begin
    s1 := copy(sStr, 1, n - 1) + sReplace;
    s2 := copy(sStr, n + n2, length(sStr) - n - n2 + 1);
    if s2 <> '' then
      s2 := StrTran(s2, sSearch, sReplace, lCaseSense);
    Result := s1 + s2;
  end
  else
    Result := sStr;
end;

procedure AdjustColumnWidths(DBGrid: TDBGrid);
var
  i, W: integer;
begin

  for i := 0 to DBGrid.Columns.Count - 1 do
  begin
    W := DBGrid.Canvas.TextWidth(DBGrid.Columns[i].Title.caption);
    DBGrid.Columns[i].Width := W + 5;
  end;

end;

procedure SortTStrings(Strings: TStrings);
var
  tmp: TStringList;
begin
  if Strings is TStringList then
  begin
    TStringList(Strings).Sort;
  end
  else
  begin
    tmp := TStringList.Create;
    try
      // make a copy
      tmp.Assign(Strings);
      // sort the copy
      tmp.Sort;
      //
      Strings.Assign(tmp);
    finally
      tmp.Free;
    end;
  end;
end;

function AA(CONST v: variant): string;
// Add Apostrophe(') before and after for string
begin
  Result := #39 + vartostr(v) + #39;
end;

function WordLoHiExchange(w:Word):Word;register;
  asm
  XCHG AL, AH
end;

function GetFileType(const FileName: string): TTextFormat;
var
  W: word;
  b: Byte;
begin
  with TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone) do
    try
      Read(W, 2);
      w:=WordLoHiExchange(w);//因为是以Word数据类型读取，故高低字节互换
      if W = TextFormatFlag[tfUnicode] then
        Result := TTextFormat.tfUnicode
      else if W = TextFormatFlag[tfUnicodeBigEndian] then
        Result := TTextFormat.tfUnicodeBigEndian
      else if W = TextFormatFlag[tfUtf8] then
        Result := TTextFormat.tfUtf8
      else
        Result := TTextFormat.tfAnsi;
    finally
      Free;
    end;
end;


procedure SaveStringGrid(StringGrid: TStringGrid; const FileName: TFileName);
var
  f:    TextFile;
  i, k: Integer;
begin
  AssignFile(f, FileName);
  Rewrite(f);
  with StringGrid do
  begin
    // Write number of Columns/Rows
    Writeln(f, ColCount);
    Writeln(f, RowCount);
    // loop through cells
    for i := 0 to ColCount - 1 do
      for k := 0 to RowCount - 1 do
        Writeln(F, Cells[i, k]);
  end;
  CloseFile(F);
end;

// Load a TStringGrid from a file

procedure LoadStringGrid(StringGrid: TStringGrid; const FileName: TFileName;cols:string);
var
  LSLRows,SL: TStringList;
  tmp_str:string;
  i,j: Integer;
begin

  //cols
  SL := TstringList.Create;
  SL.Delimiter := ',';
  SL.DelimitedText := cols;

  for i := 0 to SL.Count-1 do
  begin
    StringGrid.Cols[i].CommaText:=SL[i];
  end;

  StringGrid.FixedCols:=0;
  LSLRows := TStringList.Create;
  try
  LSLRows.Delimiter:=chr(11) ;
  LSLRows.LoadFromFile(FileName);
  for i := 0 to LSLRows.Count-1 do
  begin
  StringGrid.RowCount:=StringGrid.RowCount+1;
  StringGrid.Rows[i+1].CommaText := LSLRows[i];
  end;
finally
  LSLRows.Free;
  SL.Free;
end;
end;



end.
