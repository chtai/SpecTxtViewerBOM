object Fmtodb: TFmtodb
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Fmtodb'
  ClientHeight = 395
  ClientWidth = 531
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 531
    Height = 309
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Caption = 'Source'
    TabOrder = 0
    object cklist1: TCheckListBox
      Left = 2
      Top = 15
      Width = 527
      Height = 292
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 376
    Width = 531
    Height = 19
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Panels = <
      item
        Width = 500
      end
      item
        Width = 50
      end>
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 309
    Width = 531
    Height = 67
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 2
    object cb1: TCheckBox
      Left = 12
      Top = 15
      Width = 97
      Height = 16
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Select All/not'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = cb1Click
    end
    object cb_trunctbl: TCheckBox
      Left = 12
      Top = 35
      Width = 97
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Truncate table'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object lbet: TLabeledEdit
      Left = 233
      Top = 17
      Width = 121
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Margins.Left = 2
      EditLabel.Margins.Top = 2
      EditLabel.Margins.Right = 2
      EditLabel.Margins.Bottom = 2
      EditLabel.Caption = 'Prefix'
      LabelPosition = lpLeft
      TabOrder = 2
    end
    object btn_ok: TBitBtn
      Left = 378
      Top = 18
      Width = 103
      Height = 45
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'OK'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
        333333333333337FF3333333333333903333333333333377FF33333333333399
        03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
        99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
        99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
        03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
        33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
        33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
        3333777777333333333333333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btn_okClick
    end
    object cbx_ignore: TCheckBox
      Left = 12
      Top = 46
      Width = 123
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #24573#30053#37679#35492','#36895#24230#26371#21152#24555
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
      Visible = False
    end
    object LabeledEdit1: TLabeledEdit
      Left = 233
      Top = 42
      Width = 24
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      EditLabel.Width = 72
      EditLabel.Height = 13
      EditLabel.Margins.Left = 2
      EditLabel.Margins.Top = 2
      EditLabel.Margins.Right = 2
      EditLabel.Margins.Bottom = 2
      EditLabel.Caption = #26085#26399#20998#38548#31526#34399
      LabelPosition = lpLeft
      TabOrder = 5
      Text = '/'
      Visible = False
    end
  end
  object cds1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 136
    Top = 192
  end
  object DataSource1: TDataSource
    DataSet = cds1
    Left = 32
    Top = 376
  end
end
