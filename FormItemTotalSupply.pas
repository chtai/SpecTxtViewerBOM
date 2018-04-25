unit FormItemTotalSupply;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, ComCtrls,FMTBCD;

type
  TfrFormItemTotalSupply = class(TForm)
    DBGrid1: TDBGrid;
    cds1: TClientDataSet;
    ds1: TDataSource;
    StatusBar1: TStatusBar;
    cdsInv: TClientDataSet;
    cdsPO: TClientDataSet;
    cdsMO: TClientDataSet;
    cdsWarehouse: TClientDataSet;
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

procedure CallFormItemTotalSupply;

var
  frFormItemTotalSupply: TfrFormItemTotalSupply;
  where, txtfile: string;


implementation
uses dm, main, func, math;
{$R *.dfm}


procedure CallFormItemTotalSupply;
begin
  try
    frFormItemTotalSupply := TfrFormItemTotalSupply.Create(application);
    frFormItemTotalSupply.Show;
  finally
    //frFormQuery.free;
  end;
end;

procedure TfrFormItemTotalSupply.FormShow(Sender: TObject);
var
  stblname, sfieldname: string;
  SL: TstringList;
  i, k: integer;

  function Max(A,B:Double):Double;
  begin
      if (A > B) then
        Result:=A
      else
        Result:=B;  
  end;
begin

  cdsMO := Form1.cdsMO;
  cdsPO := Form1.cdsPO;
  cdsINV := Form1.cdsINV;
  cdsWarehouse := form1.cdsWarehouse;

  cds1.FieldDefs.Add('ItemId', ftstring, 30);
  cds1.FieldDefs.Add('SiteId', ftstring, 10);
  cds1.FieldDefs.Add('SupplyAttribute', ftstring, 10);
  cds1.FieldDefs.Add('SupplyQty', ftstring, 10);
  cds1.CreateDataSet;

  try
    while not CdsMO.Eof do begin
      if cds1.Locate('ItemId;SiteId;SupplyAttribute', CdsMO['ItemId;SiteId;SupplyAttribute'], []) then begin
        cds1.edit;
        cds1.FieldByName('SupplyQty').AsFloat :=
          cds1.FieldByName('SupplyQty').AsFloat + Max(0, CdsMO.FieldByName('OriginalQty').AsFloat - CdsMO.FieldByName('CompletedQty').AsFloat);
        cds1.post;
      end
      else begin
        cds1.Append;
        cds1.FieldByName('ItemId').AsString := CdsMO['ItemId'];
        cds1.FieldByName('SiteId').AsString := CdsMO['SiteId'];
        cds1.FieldByName('SupplyAttribute').AsString := CdsMO['SupplyAttribute'];
        cds1.FieldByName('SupplyQty').AsFloat := Max(0, CdsMO.FieldByName('OriginalQty').AsFloat - CdsMO.FieldByName('CompletedQty').AsFloat);
        cds1.Post;
      end;
      cdsMo.Next;
    end;
    
    while not CdsPO.Eof do begin
      if cds1.Locate('ItemId;SiteId;SupplyAttribute', CdsPO['ItemId;SupplyToSiteId;SupplyAttribute'], []) then begin
        cds1.edit;
        cds1.FieldByName('SupplyQty').AsFloat :=
          cds1.FieldByName('SupplyQty').AsFloat + Max(0, CdsPO.FieldByName('PurchaseQty').AsFloat);
        cds1.Post;
      end
      else begin
        cds1.Append;
        cds1.FieldByName('ItemId').AsString := CdsPO['ItemId'];
        cds1.FieldByName('SiteId').AsString := CdsPO['SupplyToSiteId'];
        cds1.FieldByName('SupplyAttribute').AsString := CdsPO['SupplyAttribute'];
        cds1.FieldByName('SupplyQty').AsFloat := Max(0, CdsPO.FieldByName('PurchaseQty').AsFloat);
        cds1.Post;
      end;
      cdspo.Next;
    end;

    while not cdsWarehouse.Eof do begin

      cdsInv.Filtered := False;
      cdsInv.Filter := 'WarehouseId=' + AA(cdsWarehouse['WarehouseId']);
      cdsInv.Filtered := True;

      while not cdsInv.Eof do begin
        if cds1.Locate('ItemId;SiteId;SupplyAttribute',varArrayOf([CdsInv['ItemId'], cdsWarehouse['SiteId'], cdsWarehouse['SupplyAttribute']]), []) then begin
          cds1.edit;
          cds1.FieldByName('SupplyQty').AsFloat :=
            cds1.FieldByName('SupplyQty').AsFloat + Max(0, CdsInv.FieldByName('StockQty').AsFloat );
          cds1.Post;
        end
        else begin
          cds1.Append;
          cds1.FieldByName('ItemId').AsString := CdsInv['ItemId'];
          cds1.FieldByName('SiteId').AsString := CdsWarehouse['SiteId'];
          cds1.FieldByName('SupplyAttribute').AsString := CdsWarehouse['SupplyAttribute'];
          cds1.FieldByName('SupplyQty').AsFloat := Max(0, CdsInv.FieldByName('StockQty').AsFloat );
          cds1.Post;
        end;
        cdsInv.Next;
      end;
      cdsWarehouse.Next;
    end;

    statusbar1.Panels[1].Text := '筆數::' + IntToStr(cds1.RecordCount);

    AdjustColumnWidths(Dbgrid1);

  finally
  end;
end;

procedure TfrFormItemTotalSupply.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (Tdbgrid(sender).DataSource.DataSet.RecNo mod 2) = 0 then
  begin
    DBGrid1.Canvas.Brush.Color := clSkyblue;
  end;
  TDBGrid(sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrFormItemTotalSupply.DBGrid1CellClick(Column: TColumn);
begin
  Fcolnm := Column.FieldName;
end;

procedure TfrFormItemTotalSupply.DBGrid1TitleClick(Column: TColumn);
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

