unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, DBClient, Grids, DBGrids, FileCtrl, ExtCtrls,
  ComCtrls, Menus, DBCtrls, math,midaslib, mxExport;

type
  TForm1 = class(TForm)
    ds1: TDataSource;
    cds1: TClientDataSet;
    FileListBox1: TFileListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    StatusBar1: TStatusBar;
    PopupMenu1: TPopupMenu;
    savetoexel1: TMenuItem;
    Savealltoexcel1: TMenuItem;
    filter1: TMenuItem;
    nofilter1: TMenuItem;
    flashform: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    InputRegion: TScrollBox;
    Panel4: TPanel;
    DirList: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    ShowBOM: TMenuItem;
    ShowMO: TMenuItem;
    ShowPO: TMenuItem;
    Panel5: TPanel;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    GroupBox2: TGroupBox;
    cbx1: TComboBox;
    btn_dir: TBitBtn;
    savedata: TBitBtn;
    DBNavigator1: TDBNavigator;
    CheckBox1: TCheckBox;
    btn_BomShow: TBitBtn;
    BitBtn2: TBitBtn;
    lb_pass: TLabeledEdit;
    lb_user: TLabeledEdit;
    lb_dbname: TLabeledEdit;
    rb2: TRadioButton;
    rb1: TRadioButton;
    ShowInv: TMenuItem;
    cdsBom: TClientDataSet;
    cdsSubBom: TClientDataSet;
    cdsGlobalSubBom: TClientDataSet;
    cdsItem: TClientDataSet;
    Splitter1: TSplitter;
    HardPeggingView: TMenuItem;
    cdsINV: TClientDataSet;
    cdsPO: TClientDataSet;
    cdsMO: TClientDataSet;
    cdsDO: TClientDataSet;
    TabSheet5: TTabSheet;
    Memo1: TMemo;
    PgGrid: TPageControl;
    ds: TDataSource;
    cdsItemSupplyRule: TClientDataSet;
    cdsSupplyRule_Line: TClientDataSet;
    cdsInvAllocRule_Line: TClientDataSet;
    cdsWarehouse: TClientDataSet;
    ItemTotalSupply: TMenuItem;
    MO_Pegging: TMenuItem;
    lb_db: TLabeledEdit;
    N12SaveToInsertSql1: TMenuItem;
    N13SaveAllToInsertSql1: TMenuItem;
    btn_saveOneSqlFile: TBitBtn;
    ch_onefile: TCheckBox;
    SaveDialog1: TSaveDialog;
    cb_output: TCheckBox;
    Dirlist2: TDirectoryListBox;
    ra_utf8: TRadioButton;
    ra_ansi: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    mxDataSetExport1: TmxDataSetExport;
    //mxDataSetExport1: TmxDataSetExport;
    procedure N12SaveToInsertSql1Click(Sender: TObject);
    procedure MO_PeggingClick(Sender: TObject);
    procedure ItemTotalSupplyClick(Sender: TObject);
    procedure cds1AfterScroll(DataSet: TDataSet);
    procedure PgGridChange(Sender: TObject);
    procedure HardPeggingViewClick(Sender: TObject);
    procedure ShowInvClick(Sender: TObject);
    procedure ShowPOClick(Sender: TObject);
    procedure ShowMOClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure btn_BomShowClick(Sender: TObject);
    procedure btn_dirClick(Sender: TObject);
    procedure cbx1Change(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure savetoexel1Click(Sender: TObject);
    procedure Savealltoexcel1Click(Sender: TObject);
    procedure filter1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure nofilter1Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure cds1BeforeClose(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure savedataClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure N13SaveAllToInsertSql1Click(Sender: TObject);
    procedure cb_outputClick(Sender: TObject);
    procedure ra_utf8Click(Sender: TObject);
  private
    { Private declarations }
    InitDir: string;
    fxOffSet, fyOffSet, fInputCols: Integer;
    Uploadtables: TstringList;
    CdsList: TstringList;
    cds: TClientDataSet;
    DbGrid: TDBGrid;
  public
    { Public declarations }
    procedure CreateDBControls(Fcds: TClientDataSet);
    function AddGridView(title: string): TDBGrid;
  end;

var
  Form1: TForm1;
  // ifieldcount: integer;
  is_oracle: boolean;

implementation

uses DM, todb, XLSFile, FilterForm, inifiles, Func,
  FormBomShow, FormQuery, FormHardPeggingView, FormItemTotalSupply,
  FormMOPeggingView,FormSetRowsCount,shellapi;


{$R *.dfm}

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  if specfile <> '' then
  begin
    DM.DataModule1.gsDB.Params.Clear;
    DM.DataModule1.gsdb_mssql.Params.Clear;
    DM.DataModule1.gsDB.Close;
    DM.DataModule1.gsdb_mssql.Close;
    if rb1.Checked then // oracle
    begin
      DM.DataModule1.gsDB.ConnectionName := 'ora';
      DM.DataModule1.gsDB.Params.Add('DriverName=ORACLE');
      DM.DataModule1.gsDB.Params.Add('DataBase=' + lb_dbname.Text);
      DM.DataModule1.gsDB.Params.Add('User_Name=' + lb_user.Text);
      DM.DataModule1.gsDB.Params.Add('Password=' + lb_pass.Text);
      DM.DataModule1.gsDB.Open;
    end;
    if rb2.Checked then // sql server
    begin
      DM.DataModule1.gsdb_mssql.ConnectionName := 'MSSQL';
      DM.DataModule1.gsdb_mssql.Params.Add('DriverName=MSSQL');
      DM.DataModule1.gsdb_mssql.Params.Add('HostName=' + lb_dbname.Text);
      DM.DataModule1.gsdb_mssql.Params.Add('DataBase=' + lb_db.Text);
      DM.DataModule1.gsdb_mssql.Params.Add('User_Name=' + lb_user.Text);
      DM.DataModule1.gsdb_mssql.Params.Add('Password=' + lb_pass.Text);
      DM.DataModule1.gsdb_mssql.Open;
    end;
    call_fmtodb(Uploadtables);
  end;
end;

procedure TForm1.btn_dirClick(Sender: TObject);
var
  txtfile,dir_path,exe_path: string;
  i, j: Integer;
  si:Tstartupinfo;
  pi:TprocessInformation;
  handle:THandle;
begin
  cbx1.Clear;
  specfile := DirList.Directory + '\import\spec\Specification.txt';
  specoutfile  := DirList.Directory + '\import\spec\SpecificationOut.txt';
  if cb_output.Checked then
  begin
    Dirlist2.Directory := DirList.Directory + '\output' ;
  end
  else
  begin
    Dirlist2.Directory := DirList.Directory + '\import' ;
  end;

  for i := 0 to Dirlist2.FileList.Items.Count - 1 do
  begin
    txtfile := Dirlist2.FileList.Items.Strings[i];
    if ExtractFileExt(txtfile) = '.txt' then
      cbx1.Items.Add(txtfile);
  end;
  cbx1.ItemIndex := 0;

  if not assigned(Uploadtables) then Uploadtables := TstringList.Create;
  Uploadtables.Clear;
  for i := 0 to cbx1.Items.Count - 1 do
  begin
     Uploadtables.Add(ChangeFileExt(ExtractFileName(cbx1.Items[i]), ''));
  end;

  // For FormBomShow use
  // if FileExists('BOM.txt') then ReadTxt('BOM.txt', cdsBom);
  // if FileExists('SubstituteBOM.txt') then ReadTxt('SubstituteBOM.txt', cdsSubBom);
  // if FileExists('SubstituteItem.txt') then ReadTxt('SubstituteItem.txt', cdsGlobalSubBom);
  // if FileExists('Item.txt') then ReadTxt('Item.txt', cdsItem);
  // if FileExists('ItemSupplyRule.txt') then ReadTxt('ItemSupplyRule.txt', cdsItemSupplyRule);
  // //for query
  // if FileExists('MO.txt') then ReadTxt('MO.txt', cdsMO);
  // if FileExists('PO.txt') then ReadTxt('PO.txt', cdsPO);
  // if FileExists('Inventory.txt') then ReadTxt('Inventory.txt', cdsINV);
  // if FileExists('DemandOrder_Line.txt') then ReadTxt('DemandOrder_Line.txt', cdsDO);
  // if FileExists('SupplyRule_Line.txt') then ReadTxt('SupplyRule_Line.txt', cdsSupplyRule_Line);
  // if FileExists('InvAllocRule_Line.txt') then ReadTxt('InvAllocRule_Line.txt', cdsInvAllocRule_Line);
  // if FileExists('Warehouse.txt') then ReadTxt('Warehouse.txt', cdsWarehouse);

  { DM.DataModule1.gsDB.Params.Clear;
    if rb1.Checked then
    begin
    DM.DataModule1.gsDB.Params.Add('DriverName=ORACLE');
    DM.DataModule1.gsDB.Params.Add('DataBase=' + lb_dbname.Text);
    DM.DataModule1.gsDB.Params.Add('User_Name=' + lb_user.Text);
    DM.DataModule1.gsDB.Params.Add('Password=' + lb_pass.Text);
    is_oracle := true;
    end
    else
    begin
    DM.DataModule1.gsDB.ConnectionName := 'APS';
    DM.DataModule1.gsDB.Params.Add('DriverName=MSSQL');
    DM.DataModule1.gsDB.Params.Add('HostName=' + lb_ip.Text);
    DM.DataModule1.gsDB.Params.Add('DataBase=' + lb_dbname.Text);
    DM.DataModule1.gsDB.Params.Add('User_Name=' + lb_user.Text);
    DM.DataModule1.gsDB.Params.Add('Password=' + lb_pass.Text);
    is_oracle := false;
    end; }

  // Free all open DataSet Components
  j := PgGrid.PageCount;
  for i := 0 to j - 1 do
  begin
    PgGrid.Pages[0].Free;
  end;

  j := CdsList.Count;
  for i := 0 to j - 1 do
  begin
    CdsList.Objects[i].Free;
  end;
  CdsList.Clear;
  j := InputRegion.ControlCount;
  for i := 0 to j - 1 do
  begin
    InputRegion.Controls[0].Free;
  end;
  Memo1.Clear;
  StatusBar1.Panels[1].Text := '';
  StatusBar1.Panels[0].Text := '';

  btn_saveOneSqlFile.Enabled:=true;

  //call ConvertWithoutBOMToUTF8將無BOM的文字檔先轉成UTF8
  if ra_utf8.Checked then
  begin
    dir_path:= Dirlist2.Directory  ;
    dir_path:='  "'+StringReplace(dir_path, '\' , '\\',[rfReplaceALl])+'"' ;
    exe_path:= ExtractFileDir(Application.ExeName)+'\ConvertWithoutBOMToUTF8.exe';

    statusbar1.Panels[0].Text := '文字檔轉成UTF8..';
    Application.ProcessMessages;

    RunProcess(  exe_path + dir_path ,sw_show,true,nil);

    statusbar1.Panels[0].Text := '文字檔轉換UTF8完成';
    Application.ProcessMessages;
  end;

end;

procedure TForm1.cbx1Change(Sender: TObject);
var
  txtfile, stblname, sfieldname,txt_line: string;
  SL: TstringList;
  i, j, k, m: Integer;
  found: boolean;
  Fcds: TClientDataSet;
  FDbGrid: TDBGrid;
  Fds: TDataSource;


begin
  txtfile := cbx1.Text;
  if not fileExists(txtfile) then
  begin
    showmessage('檔案不存在!');
    exit;
  end;

  PageControl1.ActivePage := TabSheet1;

  try

    if cb_output.Checked then
    begin
      txt_line :=  GetOutSepc(txtfile) ;
    end
    else
    begin
      txt_line :=  GetSepc(txtfile);
    end;

    SL := TstringList.Create;
    SL.Delimiter := ',';
    SL.DelimitedText := txt_line;

    //Memo1.Lines.BeginUpdate;
    //Memo1.WordWrap:=false;
    //Memo1.Lines.LoadFromFile(txtfile);
    //Memo1.Lines.EndUpdate;

    try
      stblname := ChangeFileExt(ExtractFileName(txtfile), '');
      found := False;
      for i := 0 to PgGrid.PageCount - 1 do
        if PgGrid.Pages[i].Caption = stblname then
        begin

          PgGrid.ActivePage := PgGrid.Pages[i];
          found := True;

          // 取已存在的Clientdataset
          for j := 0 to CdsList.Count - 1 do
            if CdsList.Strings[j] = stblname then
            begin
              Fcds := TClientDataSet(CdsList.Objects[j]);
              break;
            end;

          // 取得已存在之DbGrid
          for k := 0 to PgGrid.ActivePage.ControlCount - 1 do
            if PgGrid.ActivePage.Controls[k] is TDBGrid then
            begin
              FDbGrid := TDBGrid(PgGrid.ActivePage.Controls[k]);
              break;
            end;

          FDbGrid.DataSource.DataSet := Fcds;
          FDbGrid.PopupMenu := PopupMenu1;
          FDbGrid.oncellclick := DBGrid1CellClick;
          FDbGrid.onDrawColumnCell := DBGrid1DrawColumnCell;
          FDbGrid.onTitleClick := DBGrid1TitleClick;
          Fcds.AfterScroll := cds1AfterScroll;

          // clear all component
          k := InputRegion.ControlCount;
          for m := 0 to k - 1 do
          begin
            InputRegion.Controls[0].Free;
          end;

          ShowFrmSetRowscount();

          StatusBar1.Panels[1].Text := '筆數:' + IntToStr(ReadTxtToCds(txtfile, Fcds));
          StatusBar1.Panels[0].Text := DirList.Directory + '\' + stblname +
            '.txt';

          DBNavigator1.DataSource := FDbGrid.DataSource;

          CreateDBControls(Fcds);

          //Memo1.Lines.Clear;
          //Memo1.Lines.LoadFromFile(stblname + '.txt');

          exit;
        end;

      if not found then
      begin

        // Create
        Fcds := TClientDataSet.Create(Application);
        CdsList.AddObject(stblname, Fcds);

        FDbGrid := AddGridView(stblname);
      end;
      Fds := TDataSource.Create(Self);
      Fds.DataSet := Fcds;
      FDbGrid.DataSource := Fds;
      PgGrid.ActivePageIndex := PgGrid.PageCount - 1;
      FDbGrid.PopupMenu := PopupMenu1;
      FDbGrid.oncellclick := DBGrid1CellClick;
      FDbGrid.onDrawColumnCell := DBGrid1DrawColumnCell;
      FDbGrid.onTitleClick := DBGrid1TitleClick;
      FDbGrid.Hint := 'SpecTxtViewer';
      Fcds.AfterScroll := cds1AfterScroll;
    except
      ShowMessage('1');
      PageControl1.ActivePage := TabSheet5;
      ShowMessage('2');
      Fcds.Close;
      ShowMessage('3');
      exit;
    end;

    try
      cds := Fcds;
      DbGrid := FDbGrid;
      DBNavigator1.DataSource := DbGrid.DataSource;

      ifieldcount := SL.Count - 2;
      Fcds.Filter := '';
      Fcds.Filtered := False;
      Fcds.Close;
      Fcds.FieldDefs.Clear;
      for i := 2 to SL.Count - 1 do
      begin
        sfieldname := SL.Strings[i];
        if sfieldname <> '' then
          Fcds.FieldDefs.Add(sfieldname, ftstring, 80);
      end;
    except
      on E: Exception do ShowMessage(E.Message);
    end;

    try
      // clear all component
      k := InputRegion.ControlCount;
      for i := 0 to k - 1 do
      begin
        InputRegion.Controls[0].Free;
      end;
      Fcds.CreateDataSet;
    except
      ShowMessage('5');
    end;

    ShowFrmSetRowscount();

    StatusBar1.Panels[1].Text := '筆數:' + IntToStr(ReadTxtToCds(txtfile, Fcds));
    StatusBar1.Panels[0].Text := DirList.Directory + '\' + txtfile;

    for i := 0 to DBGrid1.Columns.Count - 1 do
    begin
      FDbGrid.Columns[i].Width := 50;
    end;

    AdjustColumnWidths(FDbGrid);

    CreateDBControls(Fcds);

  finally
    SL.Free;
  end;
end;

procedure TForm1.cb_outputClick(Sender: TObject);
begin
  is_output:=0;
  if cb_output.Checked then  is_output:=1;

end;

procedure TForm1.cds1BeforeClose(DataSet: TDataSet);
begin
  if TClientDataSet(DataSet).IndexName <> '' then
    TClientDataSet(DataSet).DeleteIndex(TClientDataSet(DataSet).IndexName);
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
  Fcolnm := Column.FieldName;
end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  cdstmp: TDataSet;
begin

  TDBGrid(Sender).Canvas.Font.Color := clBlack;
  { Is current cell the focused cell? }
  if (gdFocused in State) then
  begin
    TDBGrid(Sender).Canvas.Brush.Color := clyellow;
  end;

  if (TDBGrid(Sender).DataSource.DataSet.RecNo mod 2) = 0 then
  begin
    TDBGrid(Sender).Canvas.Brush.Color := clSkyblue;
  end;

  TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
var
  i, ii: Integer;
  cStr: string;
  tmDBGrid: TDBGrid;
  ColumnName: string;
  OldIndex, NewIndex: string;
begin
  tmDBGrid := TDBGrid(Column.Grid);
  for ii := 0 to tmDBGrid.Columns.Count - 1 do
  begin
    cStr := tmDBGrid.Columns[ii].title.Caption;
    if (pos('▲', cStr) = 1) or (pos('▼', cStr) = 1) then
    begin
      Delete(cStr, 1, 2);
      tmDBGrid.Columns[ii].title.Caption := cStr;
    end;
  end;

  for i := 1 to tmDBGrid.Columns.Count do
  begin
    // 恢復所有標題字體為默認
    tmDBGrid.Columns[i - 1].title.Font.Color := clWindowText;
    tmDBGrid.Columns[i - 1].title.Font.Style := [];
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
    TClientDataSet(Column.Field.DataSet).AddIndex(NewIndex, ColumnName,
      [ixPrimary]);
    Column.title.Font.Color := clRed; // 改變標題行字體為紅色，表示當前的排序方式為升序
    Column.title.Font.Style := [fsBold];
    Column.title.Caption := '▲' + Column.title.Caption; // 標題加上三角形表示當前排序方式為升序;
  end
  else
  begin
    NewIndex := ColumnName + 'DESC';
    TClientDataSet(Column.Field.DataSet).AddIndex(NewIndex, ColumnName,
      [ixDescending]); // 已經是升序就按降序排列
    Column.title.Font.Color := clBlue; // 改變標題行字體為紅色，表示當前的排序方式為降序
    Column.title.Font.Style := [fsBold];
    Column.title.Caption := '▼' + Column.title.Caption; // 標題加上倒三角形表示當前排序方式為降序;
  end;
  TClientDataSet(Column.Field.DataSet).IndexName := NewIndex;
end;

procedure TForm1.filter1Click(Sender: TObject);
var
  cds_: TClientDataSet;
begin
  cds_ := TClientDataSet(TDBGrid(PopupMenu.PopupComponent).DataSource.DataSet);
  if Fcolnm <> '' then
    call_fmFilterForm(Fcolnm, cds_);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  IniFile: TIniFile;
  i: Integer;
begin
  try
    IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));

    IniFile.WriteString('setting', 'InitDir', DirList.Directory);
    IniFile.WriteString('setting', 'lb_dbname', lb_dbname.Text );
    IniFile.WriteString('setting', 'lb_db', lb_db.Text );
    IniFile.WriteString('setting', 'lb_user',lb_user.Text);
    IniFile.WriteString('setting', 'lb_pass', lb_pass.Text );

    IniFile.Free;

    if Assigned(Uploadtables) then
      Uploadtables.Free;
    if Assigned(CdsList) then
      for i := 0 to CdsList.Count - 1 do
        CdsList.Objects[i].Free;
  except
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  IniFile: TIniFile;
  tablestr: string;
begin

  func.file_encode := 'UTF8';

  fxOffSet := 10;
  fyOffSet := 5;
  fInputCols := 1;
  while (fInputCols * 152 + fxOffSet) <= InputRegion.Width do
    Inc(fInputCols);
  if fInputCols > 2 then
    fInputCols := fInputCols - 2;

  Fcolnm := '';
  PopupMenu := PopupMenu1;

  CdsList := TstringList.Create;

  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    InitDir := IniFile.ReadString('setting', 'InitDir', '');
    lb_dbname.Text := IniFile.ReadString('setting', 'lb_dbname', '');
    lb_db.Text := IniFile.ReadString('setting', 'lb_db', '');
    lb_user.Text := IniFile.ReadString('setting', 'lb_user', '');
    lb_pass.Text := IniFile.ReadString('setting', 'lb_pass', '');
    if DirectoryExists(InitDir) then
      DirList.Directory := InitDir;
  finally
  end;

  try
    tablestr := IniFile.ReadString('Upload', 'tables', '');
    Uploadtables := StrToList(tablestr, ',', False);
  finally
  end;

  IniFile.Free;

  is_output:=0;

end;

procedure TForm1.nofilter1Click(Sender: TObject);
var
  cds_: TClientDataSet;
begin
  cds_ := TClientDataSet(TDBGrid(PopupMenu.PopupComponent).DataSource.DataSet);
  cds_.Filtered := False;
  cds_.FileName := '';
end;

procedure TForm1.Savealltoexcel1Click(Sender: TObject);
var
  i, j: Integer;
  Fcds: TClientDataSet;
begin

  for i := 0 to PgGrid.PageCount - 1 do
  begin
    // 取已存在的Clientdataset
    for j := 0 to CdsList.Count - 1 do
      if CdsList.Strings[j] = PgGrid.Pages[i].Caption then
      begin
        Fcds := TClientDataSet(CdsList.Objects[j]);
        break;
      end;
    Fcds.DisableControls;
    DataSetToXLS(Fcds, PgGrid.Pages[i].Caption + '.xls');
    //mxDataSetExport1.
    Fcds.EnableControls;
  end;

end;

procedure TForm1.savedataClick(Sender: TObject);
var
  s, stblname, sfieldname: string;
  i, ifieldcount: Integer;
  SL, savetxtSL: TstringList;
begin
  try
    SL := TstringList.Create;
    savetxtSL := TstringList.Create;
    SL.Delimiter := ',';
    SL.DelimitedText := GetSepc(PgGrid.ActivePage.Caption + '.txt');
    stblname := SL.Strings[1];
    ifieldcount := SL.Count - 2;
    cds.DisableControls;
    cds.Filtered := False;
    cds.First;
    while not cds.Eof do
    begin
      s := '';
      for i := 2 to SL.Count - 1 do
      begin
        sfieldname := SL.Strings[i];
        if sfieldname <> '' then
          s := s + chr(11) + cds.FieldByName(sfieldname).AsString;
      end;
      s := copy(s, 2, 1000);
      savetxtSL.Add(s);
      cds.Next;
    end;
    savetxtSL.SaveToFile(DirList.Directory + '\' + PgGrid.ActivePage.Caption +
        '.txt');
  finally
    cds.EnableControls;
    cds.First;
    SL.Free;
    savetxtSL.Free;
  end;

end;

procedure TForm1.savetoexel1Click(Sender: TObject);
var
  ds: TDataSource;
  cds_: TDataSet;
begin
  ds := TDBGrid(PopupMenu.PopupComponent).DataSource;
  cds_ := TClientDataSet(TDBGrid(PopupMenu.PopupComponent).DataSource.DataSet);
  ds.DataSet := nil;
  //DataSetToXLS(cds_,
  //  ExtractfilePath(Application.ExeName) + PgGrid.ActivePage.Caption + '.XLS');
  mxDataSetExport1.DataSet:=cds_;
  mxDataSetExport1.Select;
  ds.DataSet := cds_;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Panel1.Visible := not Panel1.Visible;
end;

procedure TForm1.CreateDBControls(Fcds: TClientDataSet);
var
  i, CurrX, CurrY, fWidth, MaxHeight, DetailCount: Integer;
  aLabel: TLabel;
  DBEdit: TDBEdit;
  DBMemo: TDBMemo;
  DBImage: TDBImage;
  DBCombo: TDBComboBox;
  aDBControl: TWinControl;
  PickBtn: TButton;
  C: TComponent;
  DTableName, KeyCodeString: string;
  PickDS: TDataSet;

  procedure AddInputControl(X, Y: Integer; Control: TControl);
  begin
    Control.Parent := InputRegion;
    Control.Left := X;
    Control.Top := Y;
  end;

begin

  CurrX := 0;
  CurrY := 0;
  fWidth := Trunc((InputRegion.Width - fxOffSet) / fInputCols);
  DetailCount := 0;
  MaxHeight := 0;
  for i := 0 to Fcds.FieldCount - 1 do
    if (Fcds.Fields[i].Visible) and (Fcds.Fields[i].FieldKind = fkData) then
    begin

      aLabel := TLabel.Create(InputRegion);
      aLabel.Caption := Fcds.Fields[i].DisplayLabel;
      aLabel.Alignment := taLeftJustify;
      aLabel.Height := 20;
      AddInputControl(CurrX + fxOffSet, CurrY + fyOffSet, aLabel);
      if (Fcds.Fields[i].Size > 80) then
      begin
        DBMemo := TDBMemo.Create(InputRegion);
        aDBControl := DBMemo;
        DBMemo.DataSource := DBNavigator1.DataSource;
        DBMemo.DataField := Fcds.Fields[i].FieldName;
        DBMemo.Enabled := True;
        DBMemo.ReadOnly := Fcds.Fields[i].ReadOnly;
        AddInputControl(CurrX + fxOffSet, CurrY + fyOffSet + aLabel.Height + 1,
          DBMemo);
      end
      else
      begin
        DBEdit := TDBEdit.Create(InputRegion);
        aDBControl := DBEdit;
        DBEdit.DataSource := DBNavigator1.DataSource;
        DBEdit.DataField := Fcds.Fields[i].FieldName;
        DBEdit.ReadOnly := Fcds.Fields[i].ReadOnly;
        AddInputControl(CurrX + fxOffSet, CurrY + fyOffSet + aLabel.Height + 1,
          DBEdit);
      end;

      MaxHeight := Max(MaxHeight, aDBControl.Height);

      CurrX := CurrX + fxOffSet + fWidth;
      if (CurrX + 2 * fxOffSet) >= InputRegion.Width then
      begin
        CurrX := 0;
        CurrY := CurrY + fyOffSet + MaxHeight + aLabel.Height + 1;
        MaxHeight := 0;
      end;
    end;

end;

procedure TForm1.btn_BomShowClick(Sender: TObject);
var
  sOutputItemId: string;
  i: Integer;
  cds_: TClientDataSet;
begin
 // cds_ := TClientDataSet(TDBGrid(PopupMenu.PopupComponent).DataSource.DataSet);
 // sOutputItemId := cds_.FieldByName(Fcolnm).AsString;
 // CallTfrFormBomShow(sOutputItemId);
 //LoadStringGrid(self.StringGrid1,cbx1.Text);
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
var
  sOutputItemId: string;
  i: Integer;
begin
  if not(PopupMenu.PopupComponent is TDBGrid) then
    abort;
  PopupMenu.Items.Find('1.Export').Visible := TDBGrid
    (PopupMenu.PopupComponent).Hint = 'SpecTxtViewer';
  PopupMenu.Items.Find('2.Save all to excel').Visible :=false; //TDBGrid
    //(PopupMenu.PopupComponent).Hint = 'SpecTxtViewer';
  PopupMenu.Items.Find('9.HardPeggingView').Visible :=
    (TDBGrid(PopupMenu.PopupComponent).Hint = 'SpecTxtViewer') and
    (PgGrid.ActivePage.Caption = 'HardPegging');

  PopupMenu.Items.Find('11.MO_Pegging').Visible :=
    (TDBGrid(PopupMenu.PopupComponent).Hint = 'SpecTxtViewer') and
    (PgGrid.ActivePage.Caption = 'MO_Pegging');

  if (Fcolnm = 'ItemId') or (Fcolnm = 'AltItemId') then
    ShowBOM.Visible := True
  else
    ShowBOM.Visible := False;

  if (Fcolnm = 'ItemId') or (Fcolnm = 'MOId') then
    ShowMO.Visible := True
  else
    ShowMO.Visible := False;

  if (Fcolnm = 'ItemId') or (Fcolnm = 'POId') then
    ShowPO.Visible := True
  else
    ShowPO.Visible := False;

  if (Fcolnm = 'ItemId') or (Fcolnm = 'WarehouseId') then
    ShowInv.Visible := True
  else
    ShowInv.Visible := False;

end;

procedure TForm1.ra_utf8Click(Sender: TObject);
begin
 if ra_utf8.Checked then
   func.file_encode := 'UTF8';
 if ra_ansi.Checked then
   func.file_encode := 'ANSI';
end;

procedure TForm1.ShowMOClick(Sender: TObject);
var
  swhere: string;
  cds_: TClientDataSet;
begin
  cds_ := TClientDataSet(TDBGrid(PopupMenu.PopupComponent).DataSource.DataSet);
  swhere := Fcolnm + '= ' + #39 + cds_.FieldByName(Fcolnm).AsString + #39;
  CallTfrFormQuery('MO.txt', swhere);
end;

procedure TForm1.ShowPOClick(Sender: TObject);
var
  swhere: string;
  cds_: TClientDataSet;
begin
  cds_ := TClientDataSet(TDBGrid(PopupMenu.PopupComponent).DataSource.DataSet);
  swhere := Fcolnm + '= ' + #39 + cds_.FieldByName(Fcolnm).AsString + #39;
  CallTfrFormQuery('PO.txt', swhere);

end;

procedure TForm1.ShowInvClick(Sender: TObject);
var
  swhere: string;
  cds_: TClientDataSet;
begin
  cds_ := TClientDataSet(TDBGrid(PopupMenu.PopupComponent).DataSource.DataSet);
  swhere := Fcolnm + '= ' + #39 + cds_.FieldByName(Fcolnm).AsString + #39;
  CallTfrFormQuery('Inventory.txt', swhere);

end;

procedure TForm1.HardPeggingViewClick(Sender: TObject);
begin
  CallTfrHardPeggingView;
end;

function TForm1.AddGridView(title: string): TDBGrid;
var
  TabSheet: TTabSheet;
  tmDBGrid: TDBGrid;
begin
  TabSheet := TTabSheet.Create(PageControl1);
  TabSheet.PageControl := PgGrid;
  TabSheet.Parent := PgGrid;
  TabSheet.Caption := title;
  tmDBGrid := TDBGrid.Create(TabSheet);
  tmDBGrid.Parent := TabSheet;
  tmDBGrid.Align := alClient;
  Result := tmDBGrid;
end;

procedure TForm1.PgGridChange(Sender: TObject);
var
  stblname: string;
  i, j, k: Integer;
begin

  stblname := PgGrid.ActivePage.Caption;

  // 取tabsheet存在的Clientdataset
  for j := 0 to CdsList.Count - 1 do
    if CdsList.Strings[j] = stblname then
    begin
      cds := TClientDataSet(CdsList.Objects[j]);
      break;
    end;

  // 取得tabsheet存在之DbGrid
  for k := 0 to PgGrid.ActivePage.ControlCount - 1 do
    if PgGrid.ActivePage.Controls[k] is TDBGrid then
    begin
      DbGrid := TDBGrid(PgGrid.ActivePage.Controls[k]);
      break;
    end;

  // clear all component
  k := InputRegion.ControlCount;
  for i := 0 to k - 1 do
  begin
    InputRegion.Controls[0].Free;
  end;

  StatusBar1.Panels[1].Text := '筆數:' + IntToStr(cds.RecordCount);
  StatusBar1.Panels[0].Text := DirList.Directory + '\' + stblname + '.txt';

  DBNavigator1.DataSource := DbGrid.DataSource;

  CreateDBControls(cds);

  //Memo1.Lines.Clear;
  //Memo1.Lines.LoadFromFile(stblname + '.txt');
end;

procedure TForm1.cds1AfterScroll(DataSet: TDataSet);
begin
  StatusBar1.Panels[1].Text := '筆數:' + IntToStr(DataSet.RecordCount)
    + '/目前:' + IntToStr(DataSet.RecNo);
end;

procedure TForm1.ItemTotalSupplyClick(Sender: TObject);
begin
  CallFormItemTotalSupply;
end;

procedure TForm1.MO_PeggingClick(Sender: TObject);
begin
  CallTfrMOPeggingView;
end;

procedure TForm1.N12SaveToInsertSql1Click(Sender: TObject);
var
  sfieldSql, sValueSql, stmpvalue: string;
  i, j: Integer;
  ds: TDataSource;
  cds_: TClientDataSet;
  sOutInsertSql: TstringList;
begin
  ds := TDBGrid(PopupMenu.PopupComponent).DataSource;
  cds_ := TClientDataSet(TDBGrid(PopupMenu.PopupComponent).DataSource.DataSet);

  try

    sOutInsertSql := TstringList.Create;
    sOutInsertSql.Add('Truncate table ' + PgGrid.ActivePage.Caption + ';');

    cds_.DisableControls;
    cds_.First;

    sfieldSql := '';
    for i := 0 to cds_.FieldCount - 1 do
    begin
      if sfieldSql = '' then
        sfieldSql := cds_.Fields[i].FieldName
      else
        sfieldSql := sfieldSql + ',' + cds_.Fields[i].FieldName;
    end;

    while not cds_.Eof do
    begin

      sValueSql := '';
      for i := 0 to cds_.FieldCount - 1 do
      begin
        stmpvalue := cds_.Fields[i].AsString;
        if sValueSql = '' then
        begin
          if stmpvalue = '' then
            sValueSql := 'null'
          else
            sValueSql := AA(stmpvalue);
        end
        else
        begin
          if stmpvalue = '' then
            sValueSql := sValueSql + ',' + 'null'
          else
            sValueSql := sValueSql + ',' + AA(stmpvalue);
        end;
      end;
      sOutInsertSql.Add('Insert into ' + PgGrid.ActivePage.Caption + '(' +
          sfieldSql + ') values(' + sValueSql + ');');
      cds_.Next;
    end;
    sOutInsertSql.SaveToFile(ExtractfilePath(Application.ExeName)
        + PgGrid.ActivePage.Caption + '.sql');
  finally
    cds_.EnableControls;
    sOutInsertSql.Free;
  end;
end;

procedure TForm1.N13SaveAllToInsertSql1Click(Sender: TObject);
var
  txtfile, stblname, sfieldname,txt_line,tmp_txt: string;
  SL, SL_values, SL_OutInsertSql, SL_OutInsertSqlOneFile: TstringList;
  i, j, k, m, n: Integer;
  found: boolean;
  Fcds: TClientDataSet;
  FDbGrid: TDBGrid;
  Fds: TDataSource;
  sfieldstring, svaluestring, sonefile,tmp_value: string;
begin

  // 輸出到同一個檔案
  if ch_onefile.Checked then
  begin
    sonefile := 'insert script.sql';
    if SaveDialog1.Execute   then
    begin
      sonefile := SaveDialog1.FileName;
      SL_OutInsertSql := TstringList.Create;
    end
    else
      exit;
  end;



  for n := 0 to cbx1.Items.Count - 1 do
  begin

    txtfile := cbx1.Items[n];


    try
      SL := TstringList.Create;
      SL.Delimiter := ',';

      if cb_output.Checked then
      begin
        txt_line :=  GetOutSepc(txtfile) ;
        tmp_txt:=copy(txt_line,4, pos('}',txt_line )-4 );
        SL.DelimitedText := txt_line;
      end
      else
      begin
        txt_line :=  GetSepc(txtfile);
        SL.DelimitedText := txt_line;
        tmp_txt :=   SL.Strings[1];
      end;

      sfieldstring := '';
      try

        stblname := tmp_txt;
        ifieldcount := SL.Count - 2;

        // get insert fields
        for i := 2 to SL.Count - 1 do
        begin
          sfieldname := SL.Strings[i];
          if sfieldname <> '' then
          begin
            if sfieldstring = '' then
              sfieldstring := sfieldname
            else
              sfieldstring := sfieldstring + ',' + sfieldname;
          end;
        end;

        // gen insert sql
        if Not ch_onefile.Checked then
          SL_OutInsertSql := TstringList.Create;
        SL_OutInsertSql.Add('Truncate table ' + stblname + ';');

        SL_values := TstringList.Create;

        //2018.3.16
        if file_encode = 'ANSI' then
        begin
          SL_values.LoadFromFile(txtfile, TEncoding.ANSI);
        end;
        if file_encode = 'UTF8' then
        begin
          SL_values.LoadFromFile(txtfile, TEncoding.UTF8 );
        end;

        for i := 0 to SL_values.Count - 1 do
        begin
          svaluestring := '';
          for j := 0 to ifieldcount - 1 do
          begin

           if StrExtract(SL_values.Strings[i], chr(11), j + 1)='' then
             tmp_value:='null'
           else
             tmp_value:=AA(StrExtract(SL_values.Strings[i], chr(11), j + 1));

            if svaluestring = '' then
              svaluestring := tmp_value
            else
              svaluestring := svaluestring + ',' +tmp_value;
          end; // tmpfieldcount

          SL_OutInsertSql.Add('insert into ' + stblname + '(' + sfieldstring +
              ') values(' + svaluestring + ')');

        end; // sl_value

        if Not ch_onefile.Checked then
          SL_OutInsertSql.SaveToFile(ExtractfilePath(Application.ExeName)
              + stblname + '.sql');

      finally
        if Not ch_onefile.Checked then
          SL_OutInsertSql.Free;
        SL_values.Free;
      end;
    finally
      SL.Free;
    end; // try

  end; // for
  if ch_onefile.Checked then
  begin
        if file_encode = 'ANSI' then
        begin
          SL_OutInsertSql.SaveToFile(sonefile, TEncoding.ANSI);
        end;
        if file_encode = 'UTF8' then
        begin
          SL_OutInsertSql.SaveToFile(sonefile, TEncoding.UTF8 );
        end;
  end;
    //SL_OutInsertSql.SaveToFile( sonefile);
  showmessage('ok');

end;

end.
