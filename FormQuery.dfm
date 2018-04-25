object frFormQuery: TfrFormQuery
  Left = 0
  Top = 0
  Width = 794
  Height = 416
  Caption = 'frFormQuery'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 786
    Height = 352
    Align = alClient
    DataSource = ds1
    PopupMenu = Form1.PopupMenu1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnTitleClick = DBGrid1TitleClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 352
    Width = 786
    Height = 19
    Panels = <
      item
        Width = 350
      end
      item
        Width = 50
      end>
  end
  object cds1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 208
  end
  object ds1: TDataSource
    DataSet = cds1
    Left = 16
    Top = 232
  end
end
