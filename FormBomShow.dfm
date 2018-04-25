object frFormBomShow: TfrFormBomShow
  Left = 0
  Top = 0
  Width = 868
  Height = 573
  Caption = 'fFormBomShow'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 860
    Height = 137
    Align = alTop
    Caption = 'Input'
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 19
      Width = 37
      Height = 16
      Caption = 'ItemId'
    end
    object Label2: TLabel
      Left = 304
      Top = 19
      Width = 52
      Height = 16
      Caption = 'ItemAltId'
    end
    object Label3: TLabel
      Left = 619
      Top = 16
      Width = 128
      Height = 16
      Caption = 'BOM'#20013#20849#26377'%'#31558#20027#26009
    end
    object Label4: TLabel
      Left = 619
      Top = 32
      Width = 178
      Height = 16
      Caption = 'BOM'#20013#20849#26377'%'#31558#20195#29992#26009'/'#32791#30433
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 619
      Top = 48
      Width = 193
      Height = 16
      Caption = 'BOM'#20013#20849#26377'%'#31558#20840#22495#20195#29992'/'#32791#30433
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 32
      Top = 64
      Width = 50
      Height = 16
      Caption = 'FindItem'
    end
    object Edit1: TEdit
      Left = 32
      Top = 35
      Width = 273
      Height = 24
      TabOrder = 0
    end
    object btn_show: TBitBtn
      Left = 394
      Top = 35
      Width = 75
      Height = 25
      Caption = 'Show'
      TabOrder = 1
      OnClick = btn_showClick
    end
    object btn_Exp: TBitBtn
      Left = 472
      Top = 35
      Width = 105
      Height = 25
      Caption = 'Export to Text'
      TabOrder = 2
      OnClick = btn_ExpClick
    end
    object Edit2: TEdit
      Left = 304
      Top = 35
      Width = 89
      Height = 24
      TabOrder = 3
    end
    object btn_Find: TBitBtn
      Left = 306
      Top = 82
      Width = 75
      Height = 25
      Caption = 'Find'
      TabOrder = 4
      OnClick = btn_FindClick
    end
    object cbx1: TCheckBox
      Left = 396
      Top = 64
      Width = 237
      Height = 17
      Caption = #35069#36896#20214'+'#29983#29986#24288#21029'(ItemNetwork)'
      TabOrder = 5
    end
    object lbe1: TLabeledEdit
      Left = 396
      Top = 104
      Width = 92
      Height = 24
      EditLabel.Width = 33
      EditLabel.Height = 16
      EditLabel.Caption = 'SiteId'
      TabOrder = 6
    end
    object lbe2: TLabeledEdit
      Left = 494
      Top = 104
      Width = 92
      Height = 24
      EditLabel.Width = 96
      EditLabel.Height = 16
      EditLabel.Caption = 'DemandAttribute'
      TabOrder = 7
    end
    object BitBtn1: TBitBtn
      Left = 586
      Top = 103
      Width = 183
      Height = 25
      Caption = 'Export all Supply to Text'
      TabOrder = 8
      Visible = False
      OnClick = BitBtn1Click
    end
  end
  object ed_Item: TEdit
    Left = 32
    Top = 83
    Width = 273
    Height = 24
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 137
    Width = 860
    Height = 404
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    TabPosition = tpBottom
    object TabSheet1: TTabSheet
      Caption = 'BOM'
      object TWBom: TTreeView
        Left = 0
        Top = 0
        Width = 852
        Height = 375
        Align = alClient
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = []
        HotTrack = True
        Images = ImageList1
        Indent = 26
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 0
        OnCustomDrawItem = TWBomCustomDrawItem
        OnMouseDown = TWBomMouseDown
      end
      object Memo2: TMemo
        Left = 472
        Top = 112
        Width = 185
        Height = 89
        Lines.Strings = (
          'Memo2')
        TabOrder = 1
        Visible = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'BomItemList'
      ImageIndex = 1
      object Memo1: TMemo
        Left = 0
        Top = 33
        Width = 852
        Height = 342
        Align = alClient
        Lines.Strings = (
          '')
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 852
        Height = 33
        Align = alTop
        Caption = 'Levelcode'#9'ItemId  '#20027#26009#9#26009#21029
        TabOrder = 1
      end
    end
  end
  object ImageList1: TImageList
    Left = 144
    Top = 232
    Bitmap = {
      494C010105000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000317B5A00317B5A00317B5A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000031845A00298C5A00317B5A00317B5A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000317B5A0029845A00298C5A00298C5A0029845A00317B
      5A00317B5A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000317B5A00317B5A002984
      5A0029845A00298C5A00298C5A0029945A0029945A0029945A0029945A00298C
      5A00317B5A00317B5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000317B5A0029945A00299C
      6300299C6300299C6300299C6300299C6300299C6300299C5A00299C5A002994
      5A0029945A00317B5A00317B5A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005AA5840063BD8C0031A5
      630031A5630031A5630031A5630031A5630031A5630031A5630031A5630031A5
      630031A56300319C6300317B5A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000317B5A007BBD9C0073C69C0031A5
      6B0031A56B0031A56B0031A56B0031A56B0031A56B0031A56B0031A56B0031A5
      6B0031A56B0031A56B0031846300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005A9C8400EFF7EF0031B5
      6B0031B56B0031B56B0031B56B0031B56B0031B56B0031B56B0031AD6B0039B5
      73006BC6940031846300317B5A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000317B6300CEEFDE00CEEF
      D600CEEFDE00C6E7D600BDE7D6009CD6B50031B56B0031B56B0031B56B0094D6
      B50084CEA500317B5A00317B5A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000317B5A00317B5A00317B
      5A00317B5A00317B5A00317B5A00EFF7F70073C69C0094D6B50000000000317B
      5A00317B5A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000317B5A00ADD6C600CEEFDE00EFF7F70063AD8C00317B
      5A00317B5A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000317B5A00318C6300317B5A00317B5A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000317B5A00317B5A00317B5A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000393939006B6B6B004A4A4A00424242003939390039393900393939003939
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000042A5730039A5730039A5730000000000000000000000
      00000000000000000000000000000000000000000000000000004242AD003939
      AD003939AD000000000000000000000000000000000000000000000000003939
      AD003939AD000000000000000000000000000000000000000000000000008CA5
      B500738494005A7384005A7384005A6B7B006B8CA5006B8CA5006B8CA5006B8C
      A5006B8CA500425A730000000000000000000000000000000000000000000000
      0000393939006363630000000000000000003939390039393900393939003939
      3900000000000000000000000000000000000000000000000000000000000000
      00000000000039A5730039A5730042AD7B0039A5730000000000000000000000
      000000000000000000000000000000000000000000004242AD003939AD004242
      AD003939AD0000000000000000000000000000000000000000005252AD003939
      AD004242AD003939AD0000000000000000000000000000000000000000007394
      A50073849400637B8C00637B8C005A7384007394A5007394A5007394A5007394
      A5007394A5004A63730000000000000000000000000000000000000000000000
      0000393939006363630000000000000000003939390039393900393939003939
      3900000000000000000000000000000000000000000000000000000000000000
      000039A5730063BD940052C6940052C694004ABD840039A57300000000000000
      000000000000000000000000000000000000000000004242AD005252BD005A5A
      C6005A5AC6003939AD003939AD0000000000000000003939AD003939AD005A5A
      C6005A5AC6004242B5003939AD00000000000000000000000000000000007B94
      AD007B949C00637B8C00637B8C005A7384007B94AD007B94A5007B94A5007B94
      A5007B94AD004A63730000000000000000000000000000000000000000000000
      0000393939006363630039393900424242003939390039393900393939003939
      39000000000000000000000000000000000000000000000000000000000039A5
      73005AB584005ACE9C0052C6940052C6940052C6940039A5730029AD84000000
      000000000000000000000000000000000000000000004242AD006363BD005A5A
      C6005A5AC6004242B5003939AD00000000005252AD003939AD004A4ABD005A5A
      C6005A5AC6003939AD003939AD00000000000000000000000000000000007B9C
      B5008494A500637B8C00637B8C005A7384007B9CAD00C6A55200C6B56B00DED6
      AD00949C9C004A63730000000000000000000000000000000000000000000000
      0000393939006363630042424200393939003939390039393900393939003939
      39000000000000000000000000000000000000000000319C630039A57300C6EF
      DE005ACE940052C694006BCE9C0052C6940052C6940042AD7B0039A573000000
      00000000000000000000000000000000000000000000000000003939AD006B6B
      C6005A5AC6005A5AC6005A5AC6003939AD003939AD005A5AC6005A5AC6005252
      BD003939AD003939AD00000000000000000000000000313194003131940084A5
      BD008C9CAD00637B8C00637B8C006B7B8C0084A5B500CEB57300D6BD8400D6C6
      8400949C9C0031398C0031319400000000000000000000000000000000000000
      000039393900636363004A4A4A00393939003939390039393900393939003939
      3900000000000000000000000000000000000000000039A573004AAD7B0052C6
      940052C6940094DEBD00ADDEC6007BCEAD0052C6940052C68C0039A573000000
      0000000000000000000000000000000000000000000000000000000000004A4A
      AD007373C6005A5AC6005A5AC6004A4AB5004A4ABD005A5AC6005A5AC6003939
      AD003939AD00000000000000000000000000000000004242A5004242AD0084A5
      BD00849CAD0094A5AD00849CA5007384940084A5B500D6BD7B00D6C68C00CEBD
      7B0094A59C004242AD003939A500000000000000000000000000000000000000
      000039393900636363004A4A4A00393939003939390039393900393939003939
      390000000000000000000000000000000000000000000000000039A57300DEF7
      E700D6EFE70039A5730039A57B005AB58C009CDEBD0052C6940052C6940039A5
      730000FF00000000000000000000000000000000000000000000000000000000
      00003939AD008484CE006363CE006363CE005A5ACE005252C6003939AD003939
      AD0000000000000000000000000000000000000000006363BD004242B5004242
      AD006373AD008CADC6008CADC6008CADC6008CADC6008CADC6008CADC6006373
      AD004242AD004242B5004242B500000000000000000000000000000000000000
      000039393900636363004A4A4A00393939003939390039393900393939003939
      39000000000000000000000000000000000000000000000000000000000042A5
      7B004AAD7B00319C63000000000039A57300A5D6C60052C6940052C6940042A5
      730039A573000000000000000000000000000000000000000000000000000000
      00004242BD008484CE007B7BD6006B6BCE006363CE006363C6003939AD000000
      000000000000000000000000000000000000000000006B6BBD006363BD004242
      B5004242AD007B9CB5008CADC6008CADC6008CADC6008CADBD007B9CB5004242
      AD004242B5004242B50031319C00000000000000000000000000000000000000
      000039393900636363004A4A4A00393939003939390039393900393939003939
      3900000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000039A573008CD6B50052C694006BCE
      9C005AB584000000000000000000000000000000000000000000000000003939
      AD00A5A5D6007B7BD6007B7BD6008484D6007B7BD6007373D6007373CE004242
      AD003939AD000000000000000000000000000000000000000000313194006363
      BD004242B5004A4AB5005263940084A5BD0084A5BD00526394004242AD004242
      B5004242B5003131940000000000000000000000000000000000000000000000
      0000393939007373730042424200393939003939390039393900393939003939
      3900000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000042A57B00D6EFE7005ACE940052C6
      940084CEAD0042A57300000000000000000000000000000000004242BD00A5A5
      D600B5B5E7008484D6008484D600ADADDE00A5A5DE007B7BD6007B7BD6007373
      C6004242AD000000000000000000000000000000000000000000000000007B7B
      BD006363BD004242B5004A4AB500637B8C00637B8C004242AD004242B5004242
      B50031319C000000000000000000000000000000000000000000000000000000
      0000393939008484840039393900424242003939390042424200393939003939
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000042A57300D6EFDE0052C6
      940052C6940052AD840042A5730000000000000000003939AD00A5A5D6009C9C
      DE009494DE00ADADDE00C6C6E7004242AD003939AD00B5B5E7009494DE008C8C
      D6008C8CD6004A4AB5003939AD00000000000000000000000000000000000000
      0000313194006B6BC6004242B5005252B5004242AD004242B5004242B5003131
      9400000000000000000000000000000000000000000000000000000000000000
      0000393939008C8C8C0000000000000000000000000000000000393939003939
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000039A573006BBD940052C6
      940052C694008CCEAD0039A5730000000000000000005A5AB500CECEEF00A5A5
      DE00A5A5DE00C6C6E7004A4AAD0000000000000000006363BD00BDBDE7009494
      DE009494DE008C8CCE003939AD00000000000000000000000000000000000000
      0000000000007B7BC6006B6BC6004242B5004242B5004242B5003939A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000424242007B7B7B004A4A4A00424242004A4A4A00393939004A4A
      4A00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000042A57300C6E7
      D600ADDEC60039A5730052AD520000000000000000003939AD007373C600C6C6
      EF00CECEE7004242AD00000000000000000000000000000000003939AD00CECE
      EF00BDBDE7004A4AB5004242AD00000000000000000000000000000000000000
      00000000000000000000313194006B6BC6006363BD0031319400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004A4A4A006B6B6B005A5A5A004A4A4A004A4A4A000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000039A5
      730039A5730000000000000000000000000000000000000000003939AD009494
      D6004A4AAD000000000000000000000000000000000000000000000000005A5A
      B5007373C6003939AD0000000000000000000000000000000000000000000000
      00000000000000000000000000008484C6008C8CC60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFF000000000000FFFF000000000000
      FE3F000000000000FE1F000000000000FC070000000000008003000000000000
      8001000000000000800100000000000000010000000000008001000000000000
      80010000000000008027000000000000FC07000000000000FE1F000000000000
      FE3F000000000000FFFF000000000000FFFFFFFFFFFFE007F00FFC7FC7E7E003
      F30FF87F87C3E003F30FF03F8181E003F00FE01F8101E003F00F801FC0038001
      F00F801FE0078001F00FC007F00F8001F00FE207F01F8001F00FFF07E007C003
      F00FFF03C007E007F00FFF818001F00FF3CFFF818181F81FF80FFFC183C1FC3F
      FC1FFFE7C7E3FE7FFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'BomRec Files (*.txt)|*.txt'
    Left = 104
    Top = 232
  end
  object PopupMenu1: TPopupMenu
    Left = 56
    Top = 232
    object ShowMO: TMenuItem
      Caption = 'ShowMO'
      OnClick = ShowMOClick
    end
    object ShowPO: TMenuItem
      Caption = 'ShowPO'
      OnClick = ShowPOClick
    end
    object ShowInv: TMenuItem
      Caption = 'ShowInv'
      OnClick = ShowInvClick
    end
    object ShowItemSupply: TMenuItem
      Caption = 'ShowItemSupply'
      OnClick = ShowItemSupplyClick
    end
  end
end
