unit FormBomShow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, DB, DBClient, ImgList, Menus, FormHint,
  ExtCtrls;

type
  TfrFormBomShow = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    btn_show: TBitBtn;
    ImageList1: TImageList;
    btn_Exp: TBitBtn;
    SaveDialog1: TSaveDialog;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    ShowMO: TMenuItem;
    ShowPO: TMenuItem;
    ShowInv: TMenuItem;
    ed_Item: TEdit;
    Label6: TLabel;
    btn_Find: TBitBtn;
    cbx1: TCheckBox;
    ShowItemSupply: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TWBom: TTreeView;
    Memo1: TMemo;
    Panel1: TPanel;
    lbe1: TLabeledEdit;
    lbe2: TLabeledEdit;
    BitBtn1: TBitBtn;
    Memo2: TMemo;
    procedure BitBtn1Click(Sender: TObject);
    procedure ShowItemSupplyClick(Sender: TObject);
    procedure btn_FindClick(Sender: TObject);
    procedure TWBomMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShowInvClick(Sender: TObject);
    procedure ShowPOClick(Sender: TObject);
    procedure ShowMOClick(Sender: TObject);
    procedure TWBomCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btn_ExpClick(Sender: TObject);
    procedure btn_showClick(Sender: TObject);
  private
    { Private declarations }
    miHint: TMyHint;
  public
    { Public declarations }
    function GetSiteAltList(sItemId: string): string;
    function GetItemOfSupply(sItemId, sSiteId, sDemandAttribute, sMatType: string): string;
  end;

var
  frFormBomShow: TfrFormBomShow;
  cdsBom, cdsSubBom, cdsGlobalSubBom,
    cdsItem, cdsItemSupplyRule, cdsSupplyRule_Line,
    cdsInvAllocRule_Line, cdsWarehouse, cdsInv, cdsMO, cdsPO: TclientDataSet;

procedure CallTfrFormBomShow(sItemId: string);

implementation
uses dm, main, func, FormQuery, FormBomShowItemSupply;
{$R *.dfm}

procedure CallTfrFormBomShow(sItemId: string);
begin
  try
    frFormBomShow := TfrFormBomShow.Create(application);
    frFormBomShow.Edit1.Text := sItemId;
    frFormBomShow.ShowModal;
  finally
    frFormBomShow.free;
  end;
end;

procedure TfrFormBomShow.btn_showClick(Sender: TObject);
var
  swhere, sOutputItemId, sItemId, sAltItemId, sAltType: string;
  root, node, node1: TtreeNode;
  StrList: TStringList;
  i, bomi, subbomi, globalsubbomi: integer;
  ComYield:double;

  procedure AddTreeNode(tvNode: TtreeNode; LvL: integer);
  var
    tmpStrList, tmpStrList1: TStringList;
    j, k: integer;
  begin
    try
      tmpStrList := TStringList.Create;
      tmpStrList1 := TStringList.Create;

      sOutputItemId := StrExtract(tvNode.Text, ':', 1);
      swhere := ' OutputItemId = ' + #39 + sOutputItemId + #39 +
        ' and ItemAltId= ' + #39 + edit2.text + #39;

      //get all bomrec itemId
      cdsBom.Filtered := false;
      cdsBom.Filter := swhere;
      cdsBom.Filtered := true;

      if cdsBom.Eof then exit;

      tmpStrList.Clear;
      while not cdsBom.Eof do begin
        sItemId := cdsBom.FieldByName('ItemId').AsString;
        if not cbx1.Checked then begin
          if tmpStrList.indexof(sItemId) < 0 then
            tmpStrList.Add(sItemId);
        end
        else begin
          if cdsItem.Locate('ItemId', sItemId, []) then
            if cdsItem.FieldByName('ItemType').AsString = 'M' then
              if tmpStrList.indexof(sItemId) < 0 then
                tmpStrList.Add(sItemId);
        end;
        cdsBom.Next;
      end;

      for j := 0 to tmpStrList.count - 1 do begin
        //BomRec
        sItemId := tmpStrList.Strings[j];
        node := TWBom.Items.AddChild(tvNode, sItemId + ':' + IntToStr(LvL) + '[' + GetSiteAltList(sItemId) + ']');
        node.ImageIndex := 1;
        inc(bomi);
        MEMO1.Lines.Append(IntToStr(LvL) + ' ' + sItemId + ' ' + sItemId + ' 主料');

        //SubstituteBOM------------------------------------------------------
        swhere := ' OutputItemId = ' + #39 + sOutputItemId + #39 +
          ' and ItemAltId= ' + #39 + edit2.text + #39 +
          ' and ItemId= ' + #39 + sItemId + #39;
        cdsSubBom.Filtered := false;
        cdsSubBom.Filter := swhere;
        cdsSubBom.Filtered := true;
        tmpStrList1.Clear;
        while not cdsSubBom.Eof do begin
          sAltItemId := cdsSubBom.FieldByName('AltItemId').AsString + ':' +
            cdsSubBom.FieldByName('AltType').AsString;
          if not cbx1.Checked then begin
            if tmpStrList1.indexof(sAltItemId) < 0 then
              tmpStrList1.Add(sAltItemId);
          end
          else begin
            if cdsItem.Locate('ItemId', StrExtract(sAltItemId, ':', 1), []) then
              if cdsItem.FieldByName('ItemType').AsString = 'M' then
                if tmpStrList1.indexof(StrExtract(sAltItemId, ':', 1)) < 0 then
                  tmpStrList1.Add(StrExtract(sAltItemId, ':', 1));
          end;
          cdsSubBom.Next;
        end;
        for k := 0 to tmpStrList1.count - 1 do begin
          sAltItemId := StrExtract(tmpStrList1.Strings[k], ':', 1);
          sAltType := StrExtract(tmpStrList1.Strings[k], ':', 2);
          node1 := TWBom.Items.AddChild(tvNode, sAltItemId + ':'
            + '(ItemId=' + sItemId + ')' + ':'
            + iif(sAltType = 'S', '(代用料)', '(耗盡料)') + ':'
            + IntToStr(LvL)
            + '[' + GetSiteAltList(sAltItemId) + ']');
          node1.ImageIndex := 4;
          inc(subbomi);
          MEMO1.Lines.Append(IntToStr(LvL) + ' ' + sAltItemId + ' ' + sItemId + iif(sAltType = 'S', ' 代用料', ' 耗盡料'));
        end;
        //SubstituteItem------------------------------------------------------
        if tmpStrList1.Count = 0 then begin
          swhere := 'ItemId= ' + #39 + sItemId + #39;
          cdsGlobalSubBom.Filtered := false;
          cdsGlobalSubBom.Filter := swhere;
          cdsGlobalSubBom.Filtered := true;
          while not cdsGlobalSubBom.Eof do begin
            sAltItemId := cdsGlobalSubBom.FieldByName('AltItemId').AsString + ':' +
              cdsGlobalSubBom.FieldByName('AltType').AsString;
            if not cbx1.Checked then begin
              if tmpStrList1.indexof(sAltItemId) < 0 then
                tmpStrList1.Add(sAltItemId);
            end
            else begin
              if cdsItem.Locate('ItemId', StrExtract(sAltItemId, ':', 1), []) then
                if cdsItem.FieldByName('ItemType').AsString = 'M' then
                  if tmpStrList1.indexof(StrExtract(sAltItemId, ':', 1)) < 0 then
                    tmpStrList1.Add(StrExtract(sAltItemId, ':', 1));
            end;
            cdsGlobalSubBom.Next;
          end;
          for k := 0 to tmpStrList1.count - 1 do begin
            sAltItemId := StrExtract(tmpStrList1.Strings[k], ':', 1);
            sAltType := StrExtract(tmpStrList1.Strings[k], ':', 2);
            node1 := TWBom.Items.AddChild(tvNode, sAltItemId + ':'
              + '(ItemId=' + sItemId + ')' + ':'
              + iif(sAltType = 'S', '(全域代用料)', '(全域耗盡料)') + ':'
              + IntToStr(LvL)
              + '[' + GetSiteAltList(sAltItemId) + ']');
            node1.ImageIndex :=4;
            inc(globalsubbomi);
            MEMO1.Lines.Append(IntToStr(LvL) + ' ' + sAltItemId + ' ' + sItemId + iif(sAltType = 'S', ' 全域代用料', ' 全域耗盡料'));
          end;
        end;

      end;

      //Create child
      for j := 0 to tvNode.count - 1 do
        AddTreeNode(tvNode.Item[j], LvL + 1);

    finally
      tmpStrList.Free;
      tmpStrList1.Free;
    end;
  end;

begin

  ComYield:=1;

  if edit1.Text = '' then begin
    ShowMessage('ItemId不可為空!');
    exit;
  end;

  memo1.Clear;

  try
    cdsBom.DisableControls;
    TWBom.Items.Clear;
    bomi := 0; subbomi := 0; globalsubbomi := 0;

    StrList := TStringList.Create;

    swhere := ' OutputItemId = ' + #39 + edit1.Text + #39 +
      ' and ItemAltId= ' + #39 + edit2.text + #39;
    cdsBom.Filtered := false;
    cdsBom.Filter := swhere;
    cdsBom.Filtered := true;
      //root
    Root := TWBom.Items.AddChild(nil, cdsBom.FieldByName('OutputItemId').AsString);
    Root.ImageIndex := 3;
    AddTreeNode(root, 1);

    label3.caption := Format('BOM中共有%s筆主料', [IntToStr(bomi)]);
    label4.caption := Format('BOM中共有%s筆代用料/耗盡', [IntToStr(subbomi)]);
    label5.caption := Format('BOM中共有%s筆全域代用料/耗盡', [IntToStr(globalsubbomi)]);
    TwBom.FullExpand;
    SortTStrings(MEMO1.Lines);
  finally
    StrList.Free;
    cdsBom.EnableControls;
  end;
end;

procedure TfrFormBomShow.btn_ExpClick(Sender: TObject);
begin
  if SaveDialog1.Execute() then
    TWBom.SaveToFile(SaveDialog1.FileName);
end;

procedure TfrFormBomShow.TWBomCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Node.HasChildren then
    TWBom.Canvas.Font.Color := clGreen;
  if (StrExtract(Node.text, ':', 3) = '(代用料)') or (StrExtract(Node.text, ':', 3) = '(耗盡料)') then
    TWBom.Canvas.Font.Color := clRed;
  if (StrExtract(Node.text, ':', 3) = '(全域代用料)') or (StrExtract(Node.text, ':', 3) = '(全域耗盡料)') then
    TWBom.Canvas.Font.Color := clBlue;
  DefaultDraw := true;

end;

procedure TfrFormBomShow.ShowMOClick(Sender: TObject);
var
  swhere: string;
begin
  if TWBOM.Selected = nil then exit;
  swhere := 'ItemId= ' + #39 + StrExtract(TWBOM.Selected.Text, ':', 1) + #39;
  CallTfrFormQuery('MO.txt', swhere);

end;

procedure TfrFormBomShow.ShowPOClick(Sender: TObject);
var
  swhere: string;
begin
  if TWBOM.Selected = nil then exit;
  swhere := 'ItemId= ' + #39 + StrExtract(TWBOM.Selected.Text, ':', 1) + #39;
  CallTfrFormQuery('PO.txt', swhere);

end;

procedure TfrFormBomShow.ShowInvClick(Sender: TObject);
var
  swhere: string;
begin
  if TWBOM.Selected = nil then exit;
  swhere := 'ItemId= ' + #39 + StrExtract(TWBOM.Selected.Text, ':', 1) + #39;
  CallTfrFormQuery('Inventory.txt', swhere);

end;

procedure TfrFormBomShow.FormCreate(Sender: TObject);
begin
  cdsBom := form1.cdsBom;
  cdsSubBom := form1.cdsSubBom;
  cdsGlobalSubBom := form1.cdsGlobalSubBom;
  cdsItem := form1.cdsItem;
  cdsItemSupplyRule := form1.cdsItemSupplyRule;
  cdsSupplyRule_Line := form1.cdsSupplyRule_Line;
  cdsInvAllocRule_Line := form1.cdsInvAllocRule_Line;
  cdsWarehouse := form1.cdsWarehouse;
  cdsMO := form1.cdsMO;
  cdsInv := form1.cdsInv;
  cdsPO := form1.cdsPO;
  miHint := TMyHint.Create(self);
end;

procedure TfrFormBomShow.FormDestroy(Sender: TObject);
begin
  miHint.Free;
end;

procedure TfrFormBomShow.TWBomMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  node: TtreeNode;
  swhere, sItemId, S: string;
  i: integer;
begin

  if Button = mbRight then exit;

  node := TWBom.GetNodeAt(X, Y);
  if (node = nil) or (node.Text <> TWBom.Selected.text) then exit;

  sItemId := StrExtract(node.Text, ':', 1);

  cdsItem.Locate('ItemId', sItemId, [loPartialKey]);

  if cdsItem.Eof then exit;

  for i := 0 to cdsitem.FieldCount - 1 do
    S := S + IntToStr(i + 1) + '.' + cdsItem.Fields[i].FieldName + ':' + trim(cdsitem.Fields[i].AsString) + #13;
  miHint.DoActivateHint(S);

end;

procedure TfrFormBomShow.btn_FindClick(Sender: TObject);
var
  i: integer;
  itemid: string;
begin
  for i := 0 to TWBom.Items.Count - 1 do begin
    itemid := StrExtract(TWBom.Items[i].Text, ':', 1);
    if itemid = ed_item.Text then begin
      TWBom.Items[i].Selected := true;
      exit;
    end;
  end;
end;

function TfrFormBomShow.GetSiteAltList(sItemId: string): string;
var
  s, swhere: string;
begin
  result := '';
  if not cbx1.Checked then exit;

  swhere := ' ItemId=' + #39 + sItemId + #39;
  cdsItemSupplyRule.Filtered := false;
  cdsItemSupplyRule.Filter := swhere;
  cdsItemSupplyRule.Filtered := true;
  cdsItemSupplyRule.IndexFieldNames:='ItemId;Priority';
  s := '';
  while not cdsItemSupplyRule.Eof do begin
    if cdsItemSupplyRule.FieldByName('IsProduce').AsString = '1' then
      if s = '' then
        s := cdsItemSupplyRule.FieldByName('Siteid').AsString
      else
        s := s + ',' + cdsItemSupplyRule.FieldByName('Siteid').AsString;
    cdsItemSupplyRule.Next;
  end;
  result := s;
end;

function TfrFormBomShow.GetItemOfSupply(sItemId, sSiteId, sDemandAttribute, sMatType: string): string;
var
  SupplyRuleId, swhere, s, sSupplyType, sAllocRuleId, SupplySeq: string;
  Sl: TstringList;
  function GetFieldsNameAndValue(da: TdataSet): string;
  var
    i: integer;
  begin
    Result := '';
    for i := 0 to da.FieldCount - 1 do
      if Result = '' then
        Result := '(' + da.Fields[i].FieldName + '=' + da.Fields[i].AsString
      else
        Result := Result + ',' + da.Fields[i].FieldName + '=' + da.Fields[i].AsString;
    Result := Result + ')';
  end;

begin
  Result := '';
  if not cdsItemSupplyRule.Locate('ItemId;SiteId', VarArrayOf([sItemId, sSiteId]), []) then
    exit;
  SupplyRuleId := cdsItemSupplyRule.FieldByName('SupplyRuleId').AsString;

  swhere := ' SupplyRuleId=' + #39 + SupplyRuleId + #39 +
    ' and DemandAttribute=' + #39 + sDemandAttribute + #39 +
    ' and MatType=' + #39 + sMatType + #39;

  cdsSupplyRule_Line.Filtered := false;
  cdsSupplyRule_Line.Filter := swhere;
  cdsSupplyRule_Line.Filtered := true;
  cdsSupplyRule_Line.IndexFieldNames := 'SupplyRuleId;SupplySeq';
  s := '';
  Sl := TstringList.Create;
  while not cdsSupplyRule_Line.Eof do begin

    sSupplyType := cdsSupplyRule_Line.FieldByName('SupplyType').AsString;
    SupplySeq := cdsSupplyRule_Line.FieldByName('SupplySeq').AsString;

    //--------------------------------------------------------------------------
    if sSupplyType = 'I' then begin //存貨
      Sl.Add('存貨:' + GetFieldsNameAndValue(cdsSupplyRule_Line) + '------------------------------------------------------------');
      sAllocRuleId := cdsSupplyRule_Line.FieldByName('AllocRuleId').AsString;
      if sAllocRuleId = '' then begin //site.warehouseList
        swhere := ' SiteId=' + #39 + cdsSupplyRule_Line.FieldByName('SiteId').AsString + #39 +
          ' and IsSupply=' + #39 + '1' + #39;
        cdsWarehouse.Filtered := false;
        cdsWarehouse.Filter := swhere;
        cdsWarehouse.Filtered := true;
        cdsWarehouse.IndexFieldNames := 'SiteId;WarehouseId;Priority';
        while not cdsWarehouse.Eof do begin
          swhere := ' WarehouseId=' + #39 + cdsWarehouse.FieldByName('WarehouseId').AsString + #39 +
            ' and ItemId=' + #39 + sItemId + #39;
          cdsINV.Filtered := false;
          cdsINV.Filter := swhere;
          cdsINV.Filtered := true;
          while not cdsINV.Eof do begin
            Sl.Add(GetFieldsNameAndValue(cdsInv));
            cdsINV.Next;
          end;
          cdsWarehouse.Next;
        end;
      end
      else begin //InvAllocRule_Line
        swhere := ' AllocRuleId=' + #39 + sAllocRuleId + #39;
        cdsInvAllocRule_Line.Filtered := false;
        cdsInvAllocRule_Line.Filter := swhere;
        cdsInvAllocRule_Line.Filtered := true;
        cdsInvAllocRule_Line.IndexFieldNames := 'AllocRuleId;WarehouseId;Priority';
        while not cdsInvAllocRule_Line.Eof do begin
          swhere := ' WarehouseId=' + #39 + cdsInvAllocRule_Line.FieldByName('WarehouseId').AsString + #39 +
            ' and ItemId=' + #39 + sItemId + #39;
          cdsINV.Filtered := false;
          cdsINV.Filter := swhere;
          cdsINV.Filtered := true;
          while not cdsINV.Eof do begin
            Sl.Add(GetFieldsNameAndValue(cdsInv));
            cdsINV.Next;
          end;
          cdsInvAllocRule_Line.Next;
        end;
      end;
    end;
    //--------------------------------------------------------------------------

    if sSupplyType = 'M' then begin //工單
      Sl.Add('工單:' + GetFieldsNameAndValue(cdsSupplyRule_Line) + '------------------------------------------------------------');
      swhere := ' SiteId=' + #39 + cdsSupplyRule_Line.FieldByName('SupplySite').AsString + #39 +
        ' and ItemId=' + #39 + sItemId + #39 +
        ' and SupplyAttribute=' + #39 + cdsSupplyRule_Line.FieldByName('SupplyAttribute').AsString + #39;
      cdsMO.Filtered := false;
      cdsMO.Filter := swhere;
      cdsMO.Filtered := true;
      cdsMO.IndexFieldNames := 'MOId;PlanFinishDate';
      while not cdsMO.Eof do begin
        Sl.Add(GetFieldsNameAndValue(cdsMO));
        cdsMO.Next;
      end;
    end;
    //--------------------------------------------------------------------------

    if sSupplyType = 'P' then begin //採購
      Sl.Add('採購:' + GetFieldsNameAndValue(cdsSupplyRule_Line) + '------------------------------------------------------------');
      swhere := ' SupplyToSiteId=' + #39 + cdsSupplyRule_Line.FieldByName('SupplySite').AsString + #39 +
        ' and ItemId=' + #39 + sItemId + #39 +
        ' and SupplyAttribute=' + #39 + cdsSupplyRule_Line.FieldByName('SupplyAttribute').AsString + #39;
      cdsPO.Filtered := false;
      cdsPO.Filter := swhere;
      cdsPO.Filtered := true;
      cdsPO.IndexFieldNames := 'POId;POSeq;AvailableDate';
      while not cdsPO.Eof do begin
        Sl.Add(GetFieldsNameAndValue(cdsPO));
        cdsPO.Next;
      end;
    end;
    cdsSupplyRule_Line.Next;
  end;
  Result := sl.Text;
  SL.Free;

end;


procedure TfrFormBomShow.ShowItemSupplyClick(Sender: TObject);
var
  sitemId: string;
begin
  if TWBOM.Selected = nil then exit;
  sitemId := StrExtract(TWBOM.Selected.Text, ':', 1);
  CallTfrFormBomShowItemSupply(GetItemOfSupply(sitemId, LBe1.Text, lbe2.Text, 'M'));
end;

procedure TfrFormBomShow.BitBtn1Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to twbom.Items.Count - 1 do begin
    memo2.Text := GetItemOfSupply(StrExtract(twbom.Items[i].Text, ':', 1), LBe1.Text, lbe2.Text, 'M');
    memo2.Lines.SaveToFile(SaveDialog1.FileName);
  end;
end;

end.

