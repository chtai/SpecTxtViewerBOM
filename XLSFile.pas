unit XLSFile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Grids, Forms, Dialogs, db, dbctrls, comctrls;

const
    {BOF}
  CBOF = $0009;
  BIT_BIFF5 = $0800;
  BOF_BIFF5 = CBOF or BIT_BIFF5;
    {EOF}
  BIFF_EOF = $000A;
    {Document types}
  DOCTYPE_XLS = $0010;
    {Dimensions}
  DIMENSIONS = $0000;

type
  TAtributCell = (acHidden, acLocked, acShaded, acBottomBorder, acTopBorder,
    acRightBorder, acLeftBorder, acLeft, acCenter, acRight, acFill);

  TSetOfAtribut = set of TatributCell;

  TXLSWriter = class(Tobject)
  private
    fstream: TFileStream;
    procedure WriteWord(w: word);
  protected
    procedure WriteBOF;
    procedure WriteEOF;
    procedure WriteDimension;
  public
    maxCols, maxRows: Word;
    procedure CellWord(vCol, vRow: word; aValue: word; vAtribut: TSetOfAtribut = []);
    procedure CellDouble(vCol, vRow: word; aValue: double; vAtribut: TSetOfAtribut = []);
    procedure CellStr(vCol, vRow: word; aValue: string; vAtribut: TSetOfAtribut = []);
    procedure WriteField(vCol, vRow: word; Field: TField);
    constructor create(vFileName: string);
    destructor destroy; override;
  end;

procedure SetCellAtribut(value: TSetOfAtribut; var FAtribut: array of byte);
procedure DataSetToXLS(ds: TDataSet; fname: string);
procedure StringGridToXLS(grid: TStringGrid; fname: string);

implementation

procedure DataSetToXLS(ds: TDataSet; fname: string);
var
  c, r: Integer;
  xls: TXLSWriter;
begin
  xls := TXLSWriter.create(fname);
  if ds.FieldCount > xls.maxcols then
    xls.maxcols := ds.fieldcount + 1;
  try
    xls.writeBOF;
    xls.WriteDimension;
    for c := 0 to ds.FieldCount - 1 do
      xls.Cellstr(0, c, ds.Fields[c].FieldName);
    r := 1;
    ds.first;
    while (not ds.eof) and (r <= xls.maxrows) do
    begin
      for c := 0 to ds.FieldCount - 1 do
        xls.WriteField(r, c, ds.Fields[c]);
      inc(r);
      ds.next;
    end;
    xls.writeEOF;

        // <2002-11-17> dllee
        // if r > xls.maxrows then begin
        // xls.maxrows:=r+1;
        // xls.fstream.Seek(10,soFromBeginning);
        // xls.WriteDimension;
        // end;

  finally
    xls.free;
  end;
end;

procedure StringGridToXLS(grid: TStringGrid; fname: string);
var
  c, r, rMax: Integer;
  xls: TXLSWriter;
begin
  xls := TXLSWriter.create(fname);
  rMax := grid.RowCount;
  if grid.ColCount > xls.maxcols then
    xls.maxcols := grid.ColCount + 1;
  if rMax > xls.maxrows then // •iüå£Dµ{”O“»ý~”Z 65535 Rows
    rMax := xls.maxrows;
  try
    xls.writeBOF;
    xls.WriteDimension;
    for c := 0 to grid.ColCount - 1 do
      for r := 0 to rMax - 1 do
        xls.Cellstr(r, c, grid.Cells[c, r]);
    xls.writeEOF;
  finally
    xls.free;
  end;
end;

{ TXLSWriter }

constructor TXLSWriter.create(vFileName: string);
begin
  inherited create;
  if FileExists(vFilename) then
    fStream := TFileStream.Create(vFilename, fmOpenWrite)
  else
    fStream := TFileStream.Create(vFilename, fmCreate);

  maxCols := 100; //
  maxRows := 65535; //
end;

destructor TXLSWriter.destroy;
begin
  if fStream <> nil then
    fStream.free;
  inherited;
end;

procedure TXLSWriter.WriteBOF;
begin
  Writeword(BOF_BIFF5);
  Writeword(6); // count of bytes
  Writeword(0);
  Writeword(DOCTYPE_XLS);
  Writeword(0);
end;

procedure TXLSWriter.WriteDimension;
begin
  Writeword(DIMENSIONS); // dimension OP Code
  Writeword(8); // count of bytes
  Writeword(0); // min cols
  Writeword(maxRows); // max rows
  Writeword(0); // min rowss
  Writeword(maxcols); // max cols
end;

procedure TXLSWriter.CellDouble(vCol, vRow: word; aValue: double;
  vAtribut: TSetOfAtribut);
var
  FAtribut: array[0..2] of byte;
begin
  Writeword(3); // opcode for double
  Writeword(15); // count of byte
  Writeword(vCol);
  Writeword(vRow);
  SetCellAtribut(vAtribut, fAtribut);
  fStream.Write(fAtribut, 3);
  fStream.Write(aValue, 8);
end;

procedure TXLSWriter.CellWord(vCol, vRow: word; aValue: word; vAtribut: TSetOfAtribut = []);
var
  FAtribut: array[0..2] of byte;
begin
  Writeword(2); // opcode for word
  Writeword(9); // count of byte
  Writeword(vCol);
  Writeword(vRow);
  SetCellAtribut(vAtribut, fAtribut);
  fStream.Write(fAtribut, 3);
  Writeword(aValue);
end;

procedure TXLSWriter.CellStr(vCol, vRow: word; aValue: string;
  vAtribut: TSetOfAtribut);
var
  FAtribut: array[0..2] of byte;
  slen: byte;
begin
  Writeword(4); // opcode for string
  slen := length(avalue);
  Writeword(slen + 8); // count of byte
  Writeword(vCol);
  Writeword(vRow);
  SetCellAtribut(vAtribut, fAtribut);
  fStream.Write(fAtribut, 3);
  fStream.Write(slen, 1);
  fStream.Write(aValue[1], slen);
end;

procedure SetCellAtribut(value: TSetOfAtribut; var FAtribut: array of byte);
var
  i: integer;
begin
    //reset
  for i := 0 to High(FAtribut) do
    FAtribut[i] := 0;

    {Byte Offset Bit Description Contents
    0 7 Cell is not hidden 0b
    Cell is hidden 1b
    6 Cell is not locked 0b
    Cell is locked 1b
    5-0 Reserved, must be 0 000000b
    1 7-6 Font number (4 possible)
    5-0 Cell format code
    2 7 Cell is not shaded 0b
    Cell is shaded 1b
    6 Cell has no bottom border 0b
    Cell has a bottom border 1b
    5 Cell has no top border 0b
    Cell has a top border 1b
    4 Cell has no right border 0b
    Cell has a right border 1b
    3 Cell has no left border 0b
    Cell has a left border 1b
    2-0 Cell alignment code
    general 000b
    left 001b
    center 010b
    right 011b
    fill 100b
    Multiplan default align. 111b
    }

    // bit sequence 76543210

  if acHidden in value then //byte 0 bit 7:
    FAtribut[0] := FAtribut[0] + 128;

  if acLocked in value then //byte 0 bit 6:
    FAtribut[0] := FAtribut[0] + 64;

  if acShaded in value then //byte 2 bit 7:
    FAtribut[2] := FAtribut[2] + 128;

  if acBottomBorder in value then //byte 2 bit 6
    FAtribut[2] := FAtribut[2] + 64;

  if acTopBorder in value then //byte 2 bit 5
    FAtribut[2] := FAtribut[2] + 32;

  if acRightBorder in value then //byte 2 bit 4
    FAtribut[2] := FAtribut[2] + 16;

  if acLeftBorder in value then //byte 2 bit 3
    FAtribut[2] := FAtribut[2] + 8;

    // <2002-11-17> dllee µ{ûA 3 bit µÜ“»£V 1 ¶P¦J©Ú
  if acLeft in value then //byte 2 bit 1
    FAtribut[2] := FAtribut[2] + 1
  else if acCenter in value then //byte 2 bit 1
    FAtribut[2] := FAtribut[2] + 2
  else if acRight in value then //byte 2, bit 0 dan bit 1
    FAtribut[2] := FAtribut[2] + 3
  else if acFill in value then //byte 2, bit 0
    FAtribut[2] := FAtribut[2] + 4;
end;

procedure TXLSWriter.WriteWord(w: word);
begin
  fstream.Write(w, 2);
end;

procedure TXLSWriter.WriteEOF;
begin
  Writeword(BIFF_EOF);
  Writeword(0);
end;

procedure TXLSWriter.WriteField(vCol, vRow: word; Field: TField);
begin
  case field.DataType of
    ftString, ftWideString, ftBoolean, ftDate, ftDateTime, ftTime:
      Cellstr(vcol, vrow, field.asstring);
    ftAutoInc, ftSmallint, ftInteger, ftWord:
      CellWord(vcol, vRow, field.AsInteger);
    ftFloat, ftBCD:
      CellDouble(vcol, vrow, field.AsFloat);
  else
    Cellstr(vcol, vrow, EmptyStr); //
  end;
end;

end.
