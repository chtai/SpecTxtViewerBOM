object TFilterForm: TTFilterForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'TFilterForm'
  ClientHeight = 216
  ClientWidth = 429
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 17
  object Label1: TLabel
    Left = 31
    Top = 105
    Width = 56
    Height = 17
    Caption = #36942#28670#26781#20214
  end
  object lb_col: TLabel
    Left = 31
    Top = 21
    Width = 103
    Height = 17
    Caption = #30446#21069#36984#21462#30340#27396#20301':'
  end
  object Edit1: TEdit
    Left = 205
    Top = 101
    Width = 159
    Height = 21
    TabOrder = 0
  end
  object cbx1: TComboBox
    Left = 102
    Top = 101
    Width = 95
    Height = 25
    ItemHeight = 17
    ItemIndex = 0
    TabOrder = 1
    Text = 'like'
    Items.Strings = (
      'like'
      '>='
      '<='
      '=')
  end
  object rb1: TRadioButton
    Left = 31
    Top = 59
    Width = 63
    Height = 22
    Caption = #25214
    TabOrder = 2
  end
  object rb2: TRadioButton
    Left = 84
    Top = 59
    Width = 74
    Height = 22
    Caption = #31721#36984
    Checked = True
    TabOrder = 3
    TabStop = True
  end
  object BitBtn1: TBitBtn
    Left = 256
    Top = 170
    Width = 98
    Height = 33
    TabOrder = 4
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 150
    Top = 170
    Width = 98
    Height = 33
    TabOrder = 5
    Kind = bkCancel
  end
  object cdsf: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 216
    Top = 32
  end
end
