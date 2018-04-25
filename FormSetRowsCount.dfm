object FrmSetRowscount: TFrmSetRowscount
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Set Rows Limit'
  ClientHeight = 105
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PL_setRowCount: TPanel
    Left = 0
    Top = 0
    Width = 285
    Height = 105
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 275
    ExplicitHeight = 89
    object Label4: TLabel
      Left = 135
      Top = 16
      Width = 4
      Height = 13
      Caption = '-'
    end
    object ed_s: TEdit
      Left = 8
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '1'
    end
    object ed_e: TEdit
      Left = 143
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '9999999'
    end
    object Button1: TButton
      Left = 88
      Top = 51
      Width = 105
      Height = 30
      Caption = 'continue'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
end
