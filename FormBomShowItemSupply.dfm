object frFormBomShowItemSupply: TfrFormBomShowItemSupply
  Left = 0
  Top = 0
  Width = 642
  Height = 382
  Caption = 'frFormBomShowItemSupply'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 634
    Height = 57
    Align = alTop
    TabOrder = 0
    object btn_Exp: TBitBtn
      Left = 24
      Top = 19
      Width = 105
      Height = 25
      Caption = 'Export to Text'
      TabOrder = 0
      OnClick = btn_ExpClick
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 57
    Width = 634
    Height = 286
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
    WantReturns = False
    WordWrap = False
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Files (*.txt)|*.txt'
    Left = 104
    Top = 232
  end
end
