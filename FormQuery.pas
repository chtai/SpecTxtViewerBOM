unit FormQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, ComCtrls;

type
  TfrFormQuery = class(TForm)
    DBGrid1: TDBGrid;
    cds1: TClientDataSet;
    ds1: TDataSource;
    StatusBar1: TStatusBar;
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure CallTfrFormQuery(stxtfile, swhere: string);

var
  frFormQuery: TfrFormQuery;
  where, txtfile: string;


implementation
uses dm, main, func;
{$R *.dfm}


procedure CallTfrFormQuery(stxtfile, swhere: string);
begin
  try
    frFormQuery := TfrFormQuery.Create(application);
    where := swhere;
    txtfile := stxtfile;
    frFormQuery.Show;
  finally
    //frFormQuery.free;
  end;
end;

procedure TfrFormQuery.FormShow(Sender: TObject);
var
  stblname, sfieldname: string;
  SL: TstringList;
  i, k: integer;
  function GetCds(tblnm: string): TclientdataSet;
  begin
    if (stblname = 'MO') then Result := Form1.cdsMO;
    if (stblname = 'PO') then Result := Form1.cdsPO;
    if (stblname = 'Inventory') then Result := Form1.cdsINV;
    if (stblname = 'Item') then Result := Form1.cdsItem;
    if (stblname = 'DemandOrder_Line') then Result := Form1.cdsDO;
    if (stblname = 'BOM') then Result := Form1.cdsBOM;
    if (stblname = 'SubBOM') then Result := Form1.cdsSubBOM;
    if (stblname = 'GlobalSubBOM') then Result := Form1.cdsGlobalSubBOM;
  end;
begin

  if not fileExists(txtfile) then
  begin
    showmessage('檔案不存在!');
    exit;
  end;
  try
    SL := TstringList.Create;

    SL.Delimiter := ',';
    SL.DelimitedText := GetSepc(txtfile);
    stblname := SL.Strings[1];

    if not ((stblname = 'MO') or (stblname = 'PO') or (stblname = 'Inventory') or
      (stblname = 'Item') or (stblname = 'DemandOrder_Line') or (stblname = 'BOM') or
      (stblname = 'SubBOM') or (stblname = 'GlobalSubBOM')) then begin

      ifieldcount := SL.Count - 2;
      cds1.Filter := '';
      cds1.Filtered := false;
      cds1.Close;
      cds1.FieldDefs.Clear;
      for i := 2 to SL.Count - 1 do
      begin
        sfieldname := SL.Strings[i];
        if sfieldname <> '' then
          cds1.FieldDefs.Add(sfieldname, ftstring, 80);
      end;

      cds1.CreateDataSet;
      ReadTxtToCds(txtfile, cds1);
    end;
    cds1 := GetCds(stblname);
    cds1.Filtered := false;
    cds1.Filter := where;
    cds1.Filtered := true;
    ds1.DataSet:=CDS1;

    statusbar1.Panels[1].Text := '筆數::' + IntToStr(cds1.RecordCount);
    statusbar1.Panels[0].Text := txtfile;

    AdjustColumnWidths(Dbgrid1);

    Self.Caption := ExtractfileName(txtfile);
  finally
    Sl.Free;
  end;
end;

procedure TfrFormQuery.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (Tdbgrid(sender).DataSource.DataSet.RecNo mod 2) = 0 then
  begin
    DBGrid1.Canvas.Brush.Color := clSkyblue;
  end;
  TDBGrid(sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrFormQuery.DBGrid1CellClick(Column: TColumn);
begin
  Fcolnm := Column.FieldName;
end;

procedure TfrFormQuery.DBGrid1TitleClick(Column: TColumn);
var
  I, ii: Integer;
  cStr: string;
  tmDBGrid: tDBGrid;
  ColumnName: string;
  OldIndex, NewIndex: string;
begin
  tmDBGrid := tDBGrid(Column.Grid);
  for ii := 0 to tmDBGrid.Columns.Count - 1 do
  begin
    cStr := tmDBGrid.Columns[ii].Title.Caption;
    if (pos('▲', cStr) = 1) or (pos('▼', cStr) = 1) then
    begin
      Delete(cStr, 1, 2);
      tmDBGrid.Columns[ii].Title.Caption := cStr;
    end;
  end;

  for i := 1 to tmDBGrid.Columns.Count do
  begin
        //恢復所有標題字體為默認
    tmDBGrid.Columns[i - 1].Title.Font.Color := clWindowText;
    tmDBGrid.Columns[i - 1].Title.Font.Style := [];
  end;

  OldIndex := TClientDataSet(Column.Field.DataSet).IndexName;
  ColumnName := Column.Field.FieldName;

  if OldIndex <> '' then
  begin
    TClientDataSet(Column.Field.DataSet).IndexName := '';
    TClientDataSet(Column.Field.DataSet).DeleteIndex(OldIndex);
  end;

  if OldIndex <> ColumnName + 'ASC' then
  begin
    NewIndex := ColumnName + 'ASC';
    TClientDataSet(Column.Field.DataSet).AddIndex(NewIndex, ColumnName, [ixPrimary]);
    Column.Title.Font.Color := clRed; //改變標題行字體為紅色，表示當前的排序方式為升序
    Column.Title.Font.Style := [fsBold];
    Column.Title.Caption := '▲' + Column.Title.Caption; //標題加上三角形表示當前排序方式為升序;
  end
  else
  begin
    NewIndex := ColumnName + 'DESC';
    TClientDataSet(Column.Field.DataSet).AddIndex(NewIndex, ColumnName, [ixDescending]); //已經是升序就按降序排列
    Column.Title.Font.Color := clBlue; //改變標題行字體為紅色，表示當前的排序方式為降序
    Column.Title.Font.Style := [fsBold];
    Column.Title.Caption := '▼' + Column.Title.Caption; //標題加上倒三角形表示當前排序方式為降序;
  end;
  TClientDataSet(Column.Field.DataSet).IndexName := NewIndex;

end;

end.

