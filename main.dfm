object Form1: TForm1
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'SpectxtViewer (2018.5.2)'
  ClientHeight = 568
  ClientWidth = 918
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 560
    Top = 32
    Width = 20
    Height = 13
    Caption = 'ssss'
  end
  object FileListBox1: TFileListBox
    Left = 32
    Top = 184
    Width = 121
    Height = 49
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ItemHeight = 13
    TabOrder = 0
    Visible = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 918
    Height = 568
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 123
      Top = 93
      Width = 2
      Height = 474
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      ExplicitTop = 75
      ExplicitHeight = 363
    end
    object Label2: TLabel
      Left = 512
      Top = 32
      Width = 37
      Height = 13
      Caption = 'Label22'
    end
    object Label3: TLabel
      Left = 552
      Top = 32
      Width = 31
      Height = 13
      Caption = 'Label3'
    end
    object GroupBox1: TGroupBox
      Left = 125
      Top = 93
      Width = 792
      Height = 474
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 0
      object StatusBar1: TStatusBar
        Left = 2
        Top = 453
        Width = 788
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Panels = <
          item
            Width = 450
          end
          item
            Width = 50
          end>
      end
      object PageControl1: TPageControl
        Left = 2
        Top = 15
        Width = 788
        Height = 438
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ActivePage = TabSheet2
        Align = alClient
        HotTrack = True
        MultiLine = True
        TabOrder = 1
        TabPosition = tpBottom
        object TabSheet1: TTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Grid view'
          object DBGrid1: TDBGrid
            Left = 98
            Top = 12
            Width = 469
            Height = 256
            Hint = 'SpecTxtViewer'
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            PopupMenu = PopupMenu1
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnCellClick = DBGrid1CellClick
            OnDrawColumnCell = DBGrid1DrawColumnCell
            OnTitleClick = DBGrid1TitleClick
          end
          object PgGrid: TPageControl
            Left = 0
            Top = 0
            Width = 780
            Height = 412
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alClient
            HotTrack = True
            MultiLine = True
            TabOrder = 1
            OnChange = PgGridChange
          end
        end
        object TabSheet2: TTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'edit'
          ImageIndex = 1
          object Panel3: TPanel
            Left = 0
            Top = 0
            Width = 780
            Height = 412
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alClient
            Caption = 'Panel3'
            TabOrder = 0
            object InputRegion: TScrollBox
              Left = 1
              Top = 1
              Width = 778
              Height = 410
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              TabOrder = 0
            end
          end
        end
        object TabSheet5: TTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Text view'
          ImageIndex = 2
          TabVisible = False
          object Memo1: TMemo
            Left = 0
            Top = 0
            Width = 780
            Height = 412
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alClient
            Color = clBtnFace
            ScrollBars = ssBoth
            TabOrder = 0
            WantReturns = False
            WordWrap = False
          end
          object Dirlist2: TDirectoryListBox
            Left = 56
            Top = 32
            Width = 219
            Height = 165
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            FileList = FileListBox1
            TabOrder = 1
            Visible = False
          end
        end
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 93
      Width = 122
      Height = 474
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      Caption = 'Panel1'
      TabOrder = 1
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 120
        Height = 18
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        Caption = 'Panel4'
        TabOrder = 0
        object DriveComboBox1: TDriveComboBox
          Left = 0
          Top = 1
          Width = 184
          Height = 19
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          DirList = DirList
          TabOrder = 0
        end
      end
      object DirList: TDirectoryListBox
        Left = 1
        Top = 19
        Width = 120
        Height = 454
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        FileList = FileListBox1
        TabOrder = 1
      end
    end
    object flashform: TPanel
      Left = 333
      Top = 109
      Width = 233
      Height = 65
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'flashform'
      Color = clMoneyGreen
      TabOrder = 2
      Visible = False
    end
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 916
      Height = 92
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel5'
      TabOrder = 3
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 916
        Height = 92
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ActivePage = TabSheet3
        Align = alClient
        MultiLine = True
        TabOrder = 0
        TabPosition = tpRight
        object TabSheet3: TTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'View'
          object GroupBox2: TGroupBox
            Left = 0
            Top = 0
            Width = 888
            Height = 84
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alClient
            Color = clBtnFace
            ParentBackground = False
            ParentColor = False
            TabOrder = 0
            DesignSize = (
              888
              84)
            object Label1: TLabel
              Left = 99
              Top = 24
              Width = 62
              Height = 13
              Caption = '  Select table'
            end
            object cbx1: TComboBox
              Left = 98
              Top = 42
              Width = 165
              Height = 21
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Color = clSkyBlue
              TabOrder = 0
              OnChange = cbx1Change
            end
            object btn_dir: TBitBtn
              Left = 11
              Top = 21
              Width = 83
              Height = 49
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = 'Load'
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                18000000000000030000601D0000601D00000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF4B9CB54B9CB5509CB4509CB4569EB5569EB556
                9EB5509CB4569EB5509CB4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8EB7C252D5EF
                62E5FA72E7FA88EAFA8EEAFA8EEAFA8EEAFA8EEAFA8EEAFA7CE4F6568EA2FFFF
                FFFFFFFFFFFFFFFFFFFF90B9C355D9F265EAFD75ECFE88EAFA8FF0FE95F0FD95
                F0FD8FF0FE8EEAFA7FEDFE5BC9E3FFFFFFFFFFFFFFFFFFFFFFFF90B9C362E5FA
                55D9F269EBFE75ECFE88EAFA88EFFE88EFFE88EAFA78EDFE78EDFE6AE4F8568E
                A2FFFFFFFFFFFFFFFFFF90B9C35EE9FD4ED7F165EAFD69EBFE75ECFE75ECFE7F
                EDFE72ECFE72ECFE69EBFE65EAFD47C6E3FFFFFFFFFFFFFFFFFF8FB9C357E8FE
                55E6FC55D9F265EAFD65EAFD69EBFE65EAFD69EBFE65EAFD5EE9FD57E8FE55E6
                FC518DA2FFFFFFFFFFFF8FB9C35EE9FD5EE9FD55D9F265EAFD65EAFD65EAFD65
                EAFD65EAFD65EAFD5EE9FD57E8FE55E6FC47C6E3FFFFFFFFFFFF90B9C375ECFE
                75ECFE75ECFE65DAF165DAF168DDF468DDF468DDF465DAF165DAF158AABC8FB9
                C38FB9C3FFFFFFFFFFFF90B9C38EEAFA8FF0FE8EEAFA98F0FD98F0FD95F0FD95
                F0FD95F0FD8FF0FE8FF0FE749AA5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9BEAF8
                B5F4FEB5F4FEB5F4FEB5F4FEA2EBF884AFBA98BDC898BDC898BDC8FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB3EDF8CBF7FECBF7FEB6EEF8FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF558764558764FFFFFFFFFFFFFFFFFF
                FFFFFF9FBFC89FBFC8FFFFFFFFFFFFFFFFFFFFFFFF6B8678FFFFFFFFFFFFFFFF
                FF188F1F009A0950865CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF00791032724459836741854700A20018951850865CFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0A8411008E080797
                0979A179FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
              Layout = blGlyphTop
              TabOrder = 1
              OnClick = btn_dirClick
            end
            object savedata: TBitBtn
              Left = 681
              Top = 18
              Width = 79
              Height = 49
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Anchors = [akTop, akRight]
              Caption = 'Save to txt'
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                18000000000000030000601D0000601D00000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCE7535D07737BD7141917670917670C0
                A59FD2B7B1DABFB8DCC1BACB8050D07737C76F3482605CFFFFFFFFFFFFE08331
                EE943EEE943ED28C4F5D5D5D454545D7D7D7F1F1F1FEFEFEFEFEFEE7A164EE94
                3EEE943EC76F34FFFFFFFFFFFFE08331EE943EEE943ED28C4F5D5D5D454545D7
                D7D7F1F1F1FEFEFEFEFEFEE7A164EE943EEE943ECE7535FFFFFFFFFFFFE2822E
                EE943EEE943ED28C4F747474656565D7D7D7F1F1F1FEFEFEFEFEFEE7A164EE94
                3EED8F34CE7535FFFFFFFFFFFFE2822EED8D32ED8F34E28837D28C4FD28C4FDD
                9455E39B5CE39B5CE69D5EE58C3DED8F34ED8F34CF722DFFFFFFFFFFFFE2822E
                ED8D32ED8F34ED8D32ED8D32ED8D32ED8F34ED8F34EE943EED8F34ED8D32ED8F
                34ED8F34CF722DFFFFFFFFFFFFE2822EED8D32ED8D32ED8D32ED8D32ED8F34ED
                8F34EE943EED8F34ED8F34ED8D32ED8D32ED8D32CF722DFFFFFFFFFFFFE2822E
                ED8F34F4F4F4F1F1F1F4F4F4F4F4F4F1F1F1F1F1F1F4F4F4F1F1F1F1F1F1F4F4
                F4ED8F34D07737FFFFFFFFFFFFE28837EE9744F1F1F1E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9F1F1F1EE9744D07939FFFFFFFFFFFFE58C3D
                EF9D4EF1F1F1F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4EF9D4ED07D40FFFFFFFFFFFFE49249EFA55CFEFEFEF1F1F1F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4EFA55CD1824AFFFFFFFFFFFFE39B5C
                F2B376E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9F1F1
                F1F2B376D28C5CFFFFFFFFFFFFE6A46DF4C18FF4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F1F1F1F4F4F4F4C18FD3936BFFFFFFFFFFFFFFFFFF
                E6A874E7CDBBE7CDBBE7CDBBE7CDBBE7CDBBE7CDBBE7CDBBE7CDBBE7CDBBE7CD
                BBE6A874FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
              Layout = blGlyphTop
              TabOrder = 2
              OnClick = savedataClick
            end
            object DBNavigator1: TDBNavigator
              Left = 571
              Top = -20
              Width = 230
              Height = 34
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              Visible = False
            end
            object CheckBox1: TCheckBox
              Left = 384
              Top = 44
              Width = 97
              Height = 17
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = 'Hide TreeView'
              TabOrder = 4
              OnClick = CheckBox1Click
            end
            object btn_BomShow: TBitBtn
              Left = 598
              Top = 59
              Width = 59
              Height = 25
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = 'Show Bom'
              TabOrder = 5
              Visible = False
              OnClick = btn_BomShowClick
            end
            object btn_saveOneSqlFile: TBitBtn
              Left = 764
              Top = 18
              Width = 119
              Height = 49
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Anchors = [akTop, akRight]
              Caption = 'Save txt to insert sql'
              Enabled = False
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                18000000000000030000601D0000601D00000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7167ACFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFA39294A39294A39294A39294A39294A39294A3
                9294A392946F65A42520E43627ACFFFFFFFFFFFFFFFFFFFFFFFFBEAFA5E6E4E6
                E6E4E6E6E4E6E6E4E6E6E4E6E6E4E6E6E4E6D1CFDF2020F4BCBCDB2D29ED8374
                8EFFFFFFFFFFFFFFFFFFC0B2A5EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDED6262EC6767E2EDEDED8684EA4A3DA2FFFFFFFFFFFFFFFFFFBFB1A4EDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDCDCDE9E6E4E6EDEDEDDBDAE82114
                D1FFFFFFFFFFFFFFFFFFBFB1A4EDEDEDE6E4E6EDEDEDE8E6E8EDEDEDE8E6E8ED
                EDEDEDEDEDE8E6E8EDEDEDE6E4E66852B86F65A4FFFFFFFFFFFFBFB1A4EDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE8E6E8EDEDEDE8E6E8EDEDEDE6E4E69382
                8C3C2FC5FFFFFFFFFFFFBFB1A4EDEDEDE8E6E8EDEDEDE8E6E8EDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDE8E6E8E6E4E6A1948F726CC38E84A8FFFFFFBFB1A4EDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE6E4E6A392
                94FFFFFF5C4EB7FFFFFFC0B2A5EDEDEDF0F0F0EDEDEDF0F0F0EDEDEDEDEDEDED
                EDEDEDEDEDF0F0F0EDEDEDE6E4E6A39294FFFFFFFFFFFFFFFFFFC0B2A5F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0E6E4E6A392
                94FFFFFFFFFFFFFFFFFFC0B5A9F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0EDEDEDA39294FFFFFFFFFFFFFFFFFFC0B5A9F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F6F6F6F4DCC7F3DAC2ECCEB7FFFF
                FFFFFFFFFFFFFFFFFFFFC0B5A9F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F3DAC2F3DAC2B5A7A1FFFFFFFFFFFFFFFFFFFFFFFFC5BCB3F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F3DAC2BEAFA5FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFC5BCB3C5BCB3C5BCB3C5BCB3C5BCB3C5BCB3C5
                BCB3C5BCB3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
              Layout = blGlyphTop
              TabOrder = 6
              OnClick = N13SaveAllToInsertSql1Click
            end
            object ch_onefile: TCheckBox
              Left = 534
              Top = 46
              Width = 123
              Height = 17
              Caption = #36664#20986#21040#21516#19968#20491#27284#26696
              Checked = True
              State = cbChecked
              TabOrder = 7
              Visible = False
            end
            object cb_output: TCheckBox
              Left = 283
              Top = 44
              Width = 97
              Height = 17
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = 'Load Output'
              TabOrder = 8
              OnClick = cb_outputClick
            end
            object ra_utf8: TRadioButton
              Left = 283
              Top = 22
              Width = 222
              Height = 17
              Caption = 'UTF8('#22914#26524#26159#28961'BOM'#39318','#35531#36681#25563#27284#26696#26684#24335')'
              Checked = True
              TabOrder = 9
              TabStop = True
              OnClick = ra_utf8Click
            end
            object ra_ansi: TRadioButton
              Left = 511
              Top = 23
              Width = 55
              Height = 17
              Caption = 'ANSI'
              TabOrder = 10
              OnClick = ra_utf8Click
            end
          end
        end
        object TabSheet4: TTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'DB'
          ImageIndex = 1
          object Label4: TLabel
            Left = 544
            Top = 8
            Width = 175
            Height = 13
            Caption = #22914#26524#20986#29694'midas.dll'#37679#35492','#35531#35387#20874#27492'dll'
          end
          object Label6: TLabel
            Left = 544
            Top = 27
            Width = 197
            Height = 13
            Caption = #23559'midas.dll'#35079#35069#21040'c:\windows\system32\'
          end
          object Label7: TLabel
            Left = 544
            Top = 46
            Width = 195
            Height = 13
            Caption = 'regsvr32 c:\windows\system32\midas.dll'
          end
          object Label8: TLabel
            Left = 544
            Top = 65
            Width = 238
            Height = 13
            Caption = #22914#26524#20986#29694'DBX'#37679#35492','#35531#23433#35037'SQL2008 Native Client'
          end
          object BitBtn2: TBitBtn
            Left = 307
            Top = 25
            Width = 74
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Upload to DB'
            TabOrder = 0
            OnClick = BitBtn2Click
          end
          object lb_pass: TLabeledEdit
            Left = 239
            Top = 28
            Width = 67
            Height = 21
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Color = clBtnFace
            EditLabel.Width = 46
            EditLabel.Height = 13
            EditLabel.Margins.Left = 2
            EditLabel.Margins.Top = 2
            EditLabel.Margins.Right = 2
            EditLabel.Margins.Bottom = 2
            EditLabel.Caption = 'password'
            TabOrder = 1
            Text = 'dsc'
          end
          object lb_user: TLabeledEdit
            Left = 180
            Top = 28
            Width = 59
            Height = 21
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Color = clBtnFace
            EditLabel.Width = 47
            EditLabel.Height = 13
            EditLabel.Margins.Left = 2
            EditLabel.Margins.Top = 2
            EditLabel.Margins.Right = 2
            EditLabel.Margins.Bottom = 2
            EditLabel.Caption = 'username'
            TabOrder = 2
            Text = 'sa'
          end
          object lb_dbname: TLabeledEdit
            Left = 15
            Top = 28
            Width = 90
            Height = 21
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Color = clBtnFace
            EditLabel.Width = 49
            EditLabel.Height = 13
            EditLabel.Margins.Left = 2
            EditLabel.Margins.Top = 2
            EditLabel.Margins.Right = 2
            EditLabel.Margins.Bottom = 2
            EditLabel.Caption = 'HostName'
            TabOrder = 3
            Text = '10.40.'
          end
          object rb2: TRadioButton
            Left = 398
            Top = 28
            Width = 44
            Height = 16
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Mssql'
            Checked = True
            TabOrder = 4
            TabStop = True
            Visible = False
          end
          object rb1: TRadioButton
            Left = 444
            Top = 28
            Width = 49
            Height = 16
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Oracle'
            TabOrder = 5
            Visible = False
          end
          object lb_db: TLabeledEdit
            Left = 105
            Top = 28
            Width = 78
            Height = 21
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Color = clBtnFace
            EditLabel.Width = 46
            EditLabel.Height = 13
            EditLabel.Margins.Left = 2
            EditLabel.Margins.Top = 2
            EditLabel.Margins.Right = 2
            EditLabel.Margins.Bottom = 2
            EditLabel.Caption = 'Database'
            TabOrder = 6
          end
        end
      end
    end
  end
  object ds1: TDataSource
    DataSet = cds1
    Left = 16
    Top = 232
  end
  object cds1: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeClose = cds1BeforeClose
    AfterScroll = cds1AfterScroll
    Left = 64
    Top = 208
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 96
    Top = 312
    object savetoexel1: TMenuItem
      Break = mbBreak
      Caption = '1.Export'
      OnClick = savetoexel1Click
    end
    object Savealltoexcel1: TMenuItem
      Caption = '2.Save all to excel'
      OnClick = Savealltoexcel1Click
    end
    object filter1: TMenuItem
      Caption = '3.filter'
      OnClick = filter1Click
    end
    object nofilter1: TMenuItem
      Caption = '4.nofilter'
      OnClick = nofilter1Click
    end
    object ShowBOM: TMenuItem
      Caption = '5.ShowBOM'
      Visible = False
      OnClick = btn_BomShowClick
    end
    object ShowMO: TMenuItem
      Caption = '6.ShowMO'
      Visible = False
      OnClick = ShowMOClick
    end
    object ShowPO: TMenuItem
      Caption = '7.ShowPO'
      Visible = False
      OnClick = ShowPOClick
    end
    object ShowInv: TMenuItem
      Caption = '8.ShowInv'
      Visible = False
      OnClick = ShowInvClick
    end
    object HardPeggingView: TMenuItem
      Caption = '9.HardPeggingView'
      Visible = False
      OnClick = HardPeggingViewClick
    end
    object ItemTotalSupply: TMenuItem
      Caption = '10.ItemTotalSupply'
      RadioItem = True
      Visible = False
      OnClick = ItemTotalSupplyClick
    end
    object MO_Pegging: TMenuItem
      Caption = '11.MO_Pegging'
      Visible = False
      OnClick = MO_PeggingClick
    end
    object N12SaveToInsertSql1: TMenuItem
      Caption = '12.Save  Insert Sql'
      OnClick = N12SaveToInsertSql1Click
    end
    object N13SaveAllToInsertSql1: TMenuItem
      Caption = '13.Save All Insert Sql'
      OnClick = N13SaveAllToInsertSql1Click
    end
  end
  object cdsBom: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 280
    Top = 312
  end
  object cdsSubBom: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 328
    Top = 312
  end
  object cdsGlobalSubBom: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 376
    Top = 312
  end
  object cdsItem: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 416
    Top = 312
  end
  object cdsINV: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 536
    Top = 312
  end
  object cdsPO: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 496
    Top = 312
  end
  object cdsMO: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 456
    Top = 312
  end
  object cdsDO: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 584
    Top = 312
  end
  object ds: TDataSource
    Left = 128
    Top = 200
  end
  object cdsItemSupplyRule: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 200
  end
  object cdsSupplyRule_Line: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 384
    Top = 248
  end
  object cdsInvAllocRule_Line: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 248
  end
  object cdsWarehouse: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 296
  end
  object SaveDialog1: TSaveDialog
    Filter = '*.sql'
    Left = 664
    Top = 232
  end
  object mxDataSetExport1: TmxDataSetExport
    ExportType = xtExcel
    ExportTypes = [xtHTML, xtExcel, xtWord, xtTXT, xtCSV, xtTAB, xtRTF, xtDIF, xtSYLK, xtClipboard]
    ExportStyle = xsView
    HTML.CustomColors.Background = clWhite
    HTML.CustomColors.DefaultLink = clRed
    HTML.CustomColors.DefaultFontFace = 'Arial,Helvetica'
    HTML.CustomColors.VisitedLink = clAqua
    HTML.CustomColors.ActiveLink = clBlue
    HTML.CustomColors.DefaultText = clBlack
    HTML.CustomColors.TableFontColor = clBlack
    HTML.CustomColors.TableFontFace = 'Arial,Helvetica'
    HTML.CustomColors.TableBackground = 16777167
    HTML.CustomColors.TableOddBackground = clWhite
    HTML.CustomColors.HeaderBackground = 3368601
    HTML.CustomColors.HeadersFontColor = clWhite
    HTML.Options = [hoShowGridLines, hoBoldHeaders, hoAutoLink, hoOddRowColoring, hoDisplayTitle]
    HTML.Template = ctStandard
    Messages.Caption = 'Exporting DataSet'
    Messages.CopiedToClipboard = 'Data was copied to clipboard!'
    Messages.CancelCaption = '&Cancel'
    Messages.CreatedText = 'Created:'
    Messages.DocumentFilter.HTML = 'HTML Documents'
    Messages.DocumentFilter.Excel = 'Excel Files'
    Messages.DocumentFilter.Word = 'Word Documents'
    Messages.DocumentFilter.Text = 'Text Files'
    Messages.DocumentFilter.Comma = 'CSV (Comma delimited)'
    Messages.DocumentFilter.Tab = 'Text (Tab delimited)'
    Messages.DocumentFilter.RTF = 'Rich Text Format'
    Messages.DocumentFilter.DIF = 'Data Interchange Format'
    Messages.DocumentFilter.SYLK = 'SYLK Files'
    Messages.ExportCaption = '&Export'
    Messages.ExportToFile = 'Export &to file'
    Messages.FalseText = 'False'
    Messages.Height = 80
    Messages.SaveTitle = 'Save document'
    Messages.SelectFormat = 'E&xport formats:'
    Messages.Text = 'Processing...'
    Messages.TrueText = 'True'
    Messages.Width = 300
    Messages.ViewOnly = '&View only'
    TruncateSymbol = '...'
    RowNumberFormat = '%d'
    DOC_RTF.Template = rtStandard
    DOC_RTF.Options = [roShowGridLines, roOddRowColoring]
    DOC_RTF.CustomSettings.TableBackground = 16777167
    DOC_RTF.CustomSettings.TableOddBackground = clWhite
    DOC_RTF.CustomSettings.HeaderBackground = 3368601
    DOC_RTF.CustomSettings.DefaultFont.Charset = DEFAULT_CHARSET
    DOC_RTF.CustomSettings.DefaultFont.Color = clWindowText
    DOC_RTF.CustomSettings.DefaultFont.Height = -11
    DOC_RTF.CustomSettings.DefaultFont.Name = 'Tahoma'
    DOC_RTF.CustomSettings.DefaultFont.Style = []
    DOC_RTF.CustomSettings.HeaderFont.Charset = DEFAULT_CHARSET
    DOC_RTF.CustomSettings.HeaderFont.Color = clWindowText
    DOC_RTF.CustomSettings.HeaderFont.Height = -11
    DOC_RTF.CustomSettings.HeaderFont.Name = 'Tahoma'
    DOC_RTF.CustomSettings.HeaderFont.Style = [fsBold]
    DOC_RTF.CustomSettings.TableFont.Charset = DEFAULT_CHARSET
    DOC_RTF.CustomSettings.TableFont.Color = clWindowText
    DOC_RTF.CustomSettings.TableFont.Height = -11
    DOC_RTF.CustomSettings.TableFont.Name = 'Tahoma'
    DOC_RTF.CustomSettings.TableFont.Style = []
    DOC_RTF.CellWidth = 1400
    DOC_RTF.TopMargin = 101
    DOC_RTF.BottomMargin = 101
    DOC_RTF.LeftMargin = 461
    DOC_RTF.RightMargin = 562
    EXCEL.Options = [reSetMargins, reUseBorders]
    EXCEL.ColumnWidth = 20
    EXCEL.Protected = False
    EXCEL.Footer = '&P'
    EXCEL.DefaultFont.Charset = DEFAULT_CHARSET
    EXCEL.DefaultFont.Color = clWindowText
    EXCEL.DefaultFont.Height = -11
    EXCEL.DefaultFont.Name = 'Tahoma'
    EXCEL.DefaultFont.Style = []
    EXCEL.HeaderFont.Charset = DEFAULT_CHARSET
    EXCEL.HeaderFont.Color = clWindowText
    EXCEL.HeaderFont.Height = -11
    EXCEL.HeaderFont.Name = 'Tahoma'
    EXCEL.HeaderFont.Style = [fsBold]
    EXCEL.TableFont.Charset = DEFAULT_CHARSET
    EXCEL.TableFont.Color = clWindowText
    EXCEL.TableFont.Height = -11
    EXCEL.TableFont.Name = 'Tahoma'
    EXCEL.TableFont.Style = []
    EXCEL.TopMargin = 0.300000000000000000
    EXCEL.BottomMargin = 0.300000000000000000
    EXCEL.LeftMargin = 0.300000000000000000
    EXCEL.RightMargin = 0.300000000000000000
    Options = [xoClipboardMessage, xoFooterLine, xoHeaderLine, xoShowExportDate, xoShowHeader, xoShowProgress, xoUseAlignments]
    Version = '2.38'
    Left = 456
    Top = 464
  end
end
