unit FormHardPeggingView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, DB, DBClient, ImgList;

type
  TfrHardPeggingView = class(TForm)
    GroupBox1: TGroupBox;
    btn_show: TBitBtn;
    btn_Exp: TBitBtn;
    TWHG: TTreeView;
    cdsHardPegging: TClientDataSet;
    ImageList1: TImageList;
    SaveDialog1: TSaveDialog;
    procedure btn_ExpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_showClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frHardPeggingView: TfrHardPeggingView;
  cdsItem, cdsMO, cdsPO, cdsINV, cdsDO: TclientDataSet;

procedure CallTfrHardPeggingView;

implementation
uses dm, main, func, FormQuery;
{$R *.dfm}

procedure CallTfrHardPeggingView;
begin
  try
    frHardPeggingView := TfrHardPeggingView.Create(application);
    frHardPeggingView.ShowModal;
  finally
    frHardPeggingView.free;
  end;
end;

procedure TfrHardPeggingView.btn_showClick(Sender: TObject);
var
  swhere, sDemandId, sItemid, sTYPE: string;
  root, node, node1: TtreeNode;
  StrList: TStringList;
  i, bomi, subbomi, globalsubbomi: integer;

  procedure AddTreeNode(tvNode: TtreeNode);
  var
    tmpStrList, tmpStrList1: TStringList;
    j, k: integer;
    sDId, sDseq: string;
  begin
    try
      tmpStrList := TStringList.Create;
      tmpStrList1 := TStringList.Create;

      sDId := StrExtract(tvNode.Text, ':', 1);
      sDseq := StrExtract(tvNode.Text, ':', 2);
      swhere := ' DemandId = ' + #39 + sDId + #39 +
        ' and DemandSeq= ' + #39 + sDseq + #39;

      cdsHardpegging.Filtered := false;
      cdsHardpegging.Filter := swhere;
      cdsHardpegging.Filtered := true;
      tmpStrList.Clear;
      while not cdsHardpegging.Eof do begin
        sItemid := ''; sTYPE := '';
        sDemandId := cdsHardpegging.FieldByName('SupplyId').AsString + ':' +
          cdsHardpegging.FieldByName('SupplySeq').AsString;

        if cdsHardpegging.FieldByName('SupplyType').AsString = 'M' then begin
          cdsMO.Locate('MOId', StrExtract(sDemandId, ':', 1), [loPartialKey]);
          if not cdsMO.EOF then sItemid := cdsMO.FieldByName('ItemId').AsString+',Qty='+cdsHardpegging.FieldByName('SupplyQty').AsString;
          sTYPE := '工單';
        end;

        if cdsHardpegging.FieldByName('SupplyType').AsString = 'P' then begin
          cdsPO.Locate('POId;POSeq',
            varArrayOf([StrExtract(sDemandId, ':', 1), StrExtract(sDemandId, ':', 2)]),
            [loPartialKey]);
          if not cdsPO.EOF then sItemid := cdsPO.FieldByName('ItemId').AsString+',Qty='+cdsHardpegging.FieldByName('SupplyQty').AsString;
          sTYPE := '採購單';
        end;

        if cdsHardpegging.FieldByName('SupplyType').AsString = 'I' then begin
          sItemid := cdsHardpegging.FieldByName('SupplyItemId').AsString+',Qty='+cdsHardpegging.FieldByName('SupplyQty').AsString;
          sTYPE := '存貨';
        end;

        tmpStrList.Add(sDemandId + ':' + sTYPE + ',ItemId=' + sItemid);

        cdsHardpegging.Next;
      end;

      for j := 0 to tmpStrList.count - 1 do begin
        node := TWHG.Items.AddChild(tvNode, tmpStrList.Strings[j]);
        node.ImageIndex := 1;
      end;

      //Create child
      for j := 0 to tvNode.count - 1 do
        AddTreeNode(tvNode.Item[j]);

    finally
      tmpStrList.Free;
      tmpStrList1.Free;
    end;
  end;

begin

  try
    TWHG.Items.Clear;

    ReadTxt('HardPegging.txt', cdsHardpegging);

    StrList := TStringList.Create;
    swhere := ' DemandType = ' + #39 + 'O' + #39;

    cdsHardpegging.Filtered := false;
    cdsHardpegging.Filter := swhere;
    cdsHardpegging.Filtered := true;
    StrList.Clear;
    while not cdsHardpegging.Eof do begin
      sDemandId := cdsHardpegging.FieldByName('DemandId').AsString + ':' +
        cdsHardpegging.FieldByName('DemandSeq').AsString;
      StrList.Add(sDemandId);
      cdsHardpegging.Next;
    end;

    //root
    Root := TWHG.Items.AddChild(nil, 'Root');
    Root.ImageIndex := 3;
    for i := 0 to StrList.count - 1 do begin
      cdsDO.Locate('DemandOrderId;Seq',
        varArrayOf([StrExtract(sDemandId, ':', 1), StrExtract(sDemandId, ':', 2)]),
        [loPartialKey]);
      if not cdsDO.EOF then sItemid := cdsDO.FieldByName('ItemId').AsString;
      node := TWHG.Items.AddChild(Root, StrList.Strings[i] + ':訂單,ItemId=' + sItemid);
      node.ImageIndex := 1;
      AddTreeNode(node);
    end;
    TWHG.FullExpand;
  finally
    StrList.Free;
  end;

end;

procedure TfrHardPeggingView.FormCreate(Sender: TObject);
begin
  cdsItem := form1.cdsItem;
  cdsMO := form1.cdsMO;
  cdsPO := form1.cdsPO;
  cdsINV := form1.cdsINV;
  cdsDO := form1.cdsDO;
end;

procedure TfrHardPeggingView.btn_ExpClick(Sender: TObject);
begin
  if SaveDialog1.Execute() then
    TWHG.SaveToFile(SaveDialog1.FileName);
end;

end.

