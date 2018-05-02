unit Todb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, DB, DBClient, Grids, DBGrids, ExtCtrls,
  ComCtrls;

type
  TFmtodb = class(TForm)
    GroupBox1: TGroupBox;
    cklist1: TCheckListBox;
    cds1: TClientDataSet;
    DataSource1: TDataSource;
    StatusBar1: TStatusBar;
    GroupBox2: TGroupBox;
    cb1: TCheckBox;
    cb_trunctbl: TCheckBox;
    lbet: TLabeledEdit;
    btn_ok: TBitBtn;
    cbx_ignore: TCheckBox;
    LabeledEdit1: TLabeledEdit;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cb1Click(Sender: TObject);
  private
        { Private declarations }
  public
        { Public declarations }
    SL, errlog: TstringList;
    txtfile: string;
    function ReadTxtToCds(stxtfile: string): string;
    procedure CdstoDb(tcds: TClientDataSet);
    procedure TruncateTables;
    function ReadTxtToDB(stxtfile: string): string;
  end;

procedure call_fmtodb(lSL: TstringList);

var
  Fmtodb: TFmtodb;

implementation
uses DM, main, Func,DBXMsSql,hasher;
{$R *.dfm}

procedure call_fmtodb(lSL: TstringList);
begin
  try
    Fmtodb := TFmtodb.Create(application);
    Fmtodb.SL.AddStrings(Tstrings(lSL));
    Fmtodb.Showmodal;
  finally
    Fmtodb.Free;
  end;

end;

procedure TFmtodb.cb1Click(Sender: TObject);
var
  i: integer;
begin
  for I := 0 to cklist1.Count - 1 do
  begin
    cklist1.Checked[i] := cb1.Checked;
  end;
end;

procedure TFmtodb.CdstoDb(tcds: TClientDataSet);
var
  i, j, iErrnum, iToken, icount, Rcount,mm: integer;
  sPrefix, tmpstring, tblnm: string;
  is_go: boolean;
  mydataType: TFieldType ;
  FmtStngs: TFormatSettings;
begin

  GetLocaleFormatSettings( GetThreadLocale, FmtStngs );
  FmtStngs.DateSeparator := labelededit1.text[1];
  FmtStngs.ShortDateFormat := 'yyyy/M/d';
  FmtStngs.TimeSeparator := ':';
  FmtStngs.LongTimeFormat := 'hh:mm:ss';

  if lbet.Text = '' then
    sPrefix := ''
  else
    sPrefix := (lbet.Text) + '.';

  tblnm := (StrExtract(txtfile, '.', 1));

  try
    gmqy.Close;
    gmqy.CommandText := 'select * from ' + sPrefix + tblnm + ' where 1=2 ';
    gmqy.open;
    statusbar1.Panels[0].Text := '目前進度:' + sPrefix + tblnm + ' Insert Starting..';
    Application.ProcessMessages;
  except
    EXIT;
  end;

  try
    tcds.first; icount := 0;
    Rcount := tcds.RecordCount;

    while not tcds.eof do
    begin
      gmqy.Append;
      is_go := true;
      try
        for I := 0 to tcds.FieldCount - 1 do
        begin

           if tblnm='OMP_Suggest_Mfg_Order' then
              mm:=1;

          mydataType:=gmqy.FieldByName(tcds.Fields[i].FieldName).DataType;
          if (mydataType = fttimestamp) and (tcds.Fields[i].AsString<>'') then
             gmqy.FieldByName(tcds.Fields[i].FieldName).AsDateTime := StrToDateTime(tcds.Fields[i].AsString,FmtStngs)
          else
             gmqy.FieldByName(tcds.Fields[i].FieldName).AsString := tcds.Fields[i].AsString;
        end;
      except on e: Exception do begin
          tmpstring := ' ';
          for j := 0 to tcds.FieldCount - 1 do
            tmpstring := tmpstring + tcds.Fields[j].FieldName + ':' + tcds.Fields[j].AsString + ',';
          errlog.Add(sPrefix + tblnm + ' ' + E.Message + tmpstring);
          gmqy.Cancel;
          is_go := false;
        end;
      end;

      if is_go then begin
//        try
//          gmqy.FieldByName('LASTMAINTAINUSER').AsString := 'N/A';
//        except
//        end;
//        try
//          gmqy.FieldByName('LASTMAINTAINDATETIME').AsDateTime := date;
//        except
//        end;
//        try
//          gmqy.FieldByName('CHECKMAINTAINNO').AsString := '0';
//        except
//        end;
        try
          gmqy.Post;
          if not cbx_ignore.checked then
            iErrnum := gmqy.ApplyUpdates(0);
          Inc(icount);
          statusbar1.Panels[0].Text := '目前進度:' + sPrefix + tblnm + ' Insert Starting..' + IntToStr(icount) + '/' + IntToStr(Rcount);
          Application.ProcessMessages;
        except on e: Exception do begin
            tmpstring := sPrefix + tblnm + ' ';
            for j := 0 to tcds.FieldCount - 1 do
              tmpstring := tmpstring + tcds.Fields[j].FieldName + ':' + tcds.Fields[j].AsString + ',';
            errlog.Add(sPrefix + tblnm + ' ' + E.Message + tmpstring);
            gmqy.Cancel;
          end;
        end;
      end;
      tcds.Next;
    end;
    if cbx_ignore.checked then iErrnum := gmqy.ApplyUpdates(-1);
  finally
    errlog.SaveToFile(ExtractFilePath(Application.ExeName) + 'ErrUploadLog.txt');
  end;
end;

procedure TFmtodb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    if assigned(SL) then
      FreeAndNil(SL);
    if assigned(errlog) then
      FreeAndNil(errlog);
  finally
    Action := Cafree;
  end;
end;

function TFmtodb.ReadTxtToCds(stxtfile: string): string;
var
  SL: TstringList;
  i, j: integer;
  stblname, sfieldname,txt_line: string;
begin

    if is_output=1 then
    begin
      txt_line :=  GetOutSepc(txtfile) ;
    end
    else
    begin
      txt_line :=  GetSepc(txtfile);
    end;

  try
    SL := TstringList.Create;
    SL.Delimiter := ',';
    SL.DelimitedText := txt_line;
    stblname := SL.Strings[1];
    ifieldcount := SL.Count - 2;


    cds1.Close;
    cds1.FieldDefs.Clear;
    for I := 2 to SL.Count - 1 do
    begin
      sfieldname := SL.Strings[i];
      if sfieldname <> '' then
        cds1.FieldDefs.Add(sfieldname, ftstring, 50);
    end;
    cds1.CreateDataSet;
  finally
    SL.Free;
  end;

  if not cds1.Active then
    exit;
  try
    SL := TstringList.Create;
    SL.LoadFromFile(stxtfile);
    for I := 0 to SL.Count - 1 do
    begin
      cds1.Append;
      for j := 0 to ifieldcount - 1 do
      begin
        cds1.Fields[j].AsString := StrExtract(SL.Strings[i], chr(11), j + 1);
      end;
      cds1.Post;
    end;
  finally
    SL.Free;
  end;
end;

function TFmtodb.ReadTxtToDB(stxtfile: string): string;
var
  SL,insertSQLSL: TstringList;
  i, j: integer;
  stblname, sfieldname,txt_line,sfieldlist,svaluelist,sinsertsql,sPrefix: string;
  tmp_column_is_null_hash,tmp_column_datatype_hash:TStringHash;
  tmp_value:string;

begin

    if is_output=1 then
    begin
      txt_line :=  GetOutSepc(txtfile) ;
    end
    else
    begin
      txt_line :=  GetSepc(txtfile);
    end;

  if lbet.Text = '' then
    sPrefix := ''
  else
    sPrefix := (lbet.Text) + '.';

  insertSQLSL := TstringList.Create;

  try
    SL := TstringList.Create;
    SL.Delimiter := ',';
    SL.DelimitedText := txt_line;
    stblname := SL.Strings[1];
    ifieldcount := SL.Count - 2;

    //取得欄位meta
    tmp_column_is_null_hash := TStringHash.Create;
    tmp_column_datatype_hash := TStringHash.Create;
    gmqy.Close;
    gmqy.CommandText:=' select COLUMN_NAME,IS_NULLABLE,DATA_TYPE from INFORMATION_SCHEMA.COLUMNS '+
                      ' where TABLE_NAME='+AA(stblname);
    gmqy.Open;
    while not gmqy.Eof do
    begin
        tmp_column_is_null_hash[gmqy.Fields[0].AsString]:=  gmqy.Fields[1].AsString;
        tmp_column_datatype_hash[gmqy.Fields[0].AsString]:=  gmqy.Fields[2].AsString;
        gmqy.Next;
    end;
    gmqy.Close;

    //組insert欄位字串
    sfieldlist:='insert into '+stblname+'(';
    for I := 2 to SL.Count - 1 do
    begin
      sfieldname := SL.Strings[i];
      if sfieldname <> '' then
      begin
        //暫存欄位與欄位順序的hash table
        tmp_column_is_null_hash[inttostr(i-2)] := tmp_column_is_null_hash[sfieldname];
        tmp_column_datatype_hash[inttostr(i-2)] := tmp_column_datatype_hash[sfieldname];
        sfieldlist := sfieldlist + sfieldname+',';
      end;
    end;
    sfieldlist := copy(sfieldlist,1,length(sfieldlist)-1)+')';
    SL.Free;
  except
    on E:Exception do
    begin
      ShowMessage(stblname +' error '+E.Message);
      SL.Free;
    end;
  end;

  //組insert value字串
  //try
    SL := TstringList.Create;

    if file_encode = 'ANSI' then
    begin
      SL.LoadFromFile(stxtfile, TEncoding.ANSI);
    end;
    if file_encode = 'UTF8' then
    begin
      SL.LoadFromFile(stxtfile, TEncoding.UTF8);
    end;


    for I := 0 to SL.Count - 1 do
    begin
      svaluelist:=' values(';
      for j := 0 to ifieldcount - 1 do
      begin

        tmp_value := StrExtract(SL.Strings[i], chr(11), j + 1);

        //2018.1.24 字串中有單引號要特別處理
        tmp_value := StringReplace(tmp_value, chr(39) , chr(39)+chr(39),[rfReplaceALl]) ;

        if tmp_value =''  then
          if tmp_column_is_null_hash[inttostr(j)]='YES' then
              svaluelist := svaluelist +'NULL'+','
          else
              svaluelist := svaluelist +AA(' ')+','
        else
        begin
          //2018.5.2 2316.336633663366336633663366336633663366這種超長的字串要先轉成float後,再轉成指定位數的字串
          if (tmp_column_datatype_hash[inttostr(j)]='numeric') or (tmp_column_datatype_hash[inttostr(j)]='decimal') then
            svaluelist := svaluelist + FloattoStrF(strtofloat(tmp_value),ffgeneral,20,8)+','
          else
            svaluelist := svaluelist + AA(tmp_value)+',';

        end;
      end;
      svaluelist := copy(svaluelist,1,length(svaluelist)-1)+');';
      sinsertsql:= sfieldlist+ svaluelist;
      insertSQLSL.Append(sinsertsql);


      if (I mod 3000)=0 then
      begin

        gmqy.Close;
        gmqy.CommandText := insertSQLSL.Text;
        gmqy.Execute;
        insertSQLSL.Clear;

        statusbar1.Panels[0].Text := '目前進度:' + sPrefix + stblname + ' Insert Starting..('+inttostr(I)+')';
        Application.ProcessMessages;
      end;

    end;

    if insertSQLSL.count>0 then
    begin
        gmqy.Close;
        gmqy.CommandText := insertSQLSL.Text;
        gmqy.Execute;
        insertSQLSL.Clear;

        statusbar1.Panels[0].Text := '目前進度:' + sPrefix + stblname + ' Insert Starting..('+inttostr(I)+')';
        Application.ProcessMessages;
    end;


    insertSQLSL.Free;
  //finally
  //  SL.Free;
  //end;





end;







procedure TFmtodb.btn_okClick(Sender: TObject);
var
  i: integer;
  tblname:string;
begin

  if cb_trunctbl.checked then self.TruncateTables;

  ggsdb.Close;
  ggsdb.open;
  try

    gmqy.Close;
    gmqy.CommandText:='if object_id(''AltGroup'') is not null   ' +
                      ' drop table [dbo].[AltGroup]  ' +
                      'CREATE TABLE [dbo].[AltGroup]    ' +
                      '(     ' +
                      '  [output_part_id] [nvarchar](60) NOT NULL,      ' +
                      '  [group_altcode] [nvarchar](60) NOT NULL,   ' +
                      '  group_code [nvarchar](60)  NULL,  ' +
                      '  orig_group_code [nvarchar](60)  NULL,  ' +
                      '  sub_type nvarchar(3) null,     ' +
                      '  is_substitute nvarchar(3) null,   ' +
                      '  [input_part_id] [nvarchar](60) NOT NULL,   ' +
                      '  [is_including] [numeric](1, 0) NULL,  ' +
                      '  [output_part_qty] [numeric](16, 8) NULL,  ' +
                      '  [input_part_qty] [numeric](16, 8) NULL,  ' +
                      '  [sequence_txt] [nvarchar](60) NOT NULL,  ' +
                      '  [bonded_rule_id] [nvarchar](60) NULL,  ' +
                      '  [position] [nvarchar](60) NULL,  ' +
                      '  [sequ_num] [nvarchar](60) NULL,   ' +
                      '  effective_start_date datetime NULL, '+
                      '  effective_end_date datetime NULL '+
                      ')        ' ;
    gmqy.Execute;

    for I := 0 to cklist1.Count - 1 do
    begin
      if cklist1.Checked[i] = true then
      begin

        tblname:=cklist1.Items[i];

        gmqy.Close;
        gmqy.CommandText:= 'if object_id('+AA(tblname)+') is not null select 1 as cc else  select 0 as cc'  ;
        gmqy.Open;

        if gmqy.FieldByName('cc').AsInteger = 1  then
        begin

          statusbar1.Panels[0].Text := '目前進度:' + tblname+ ' 匯入開始';
          Application.ProcessMessages;

          txtfile := cklist1.Items[i] + '.txt';
          self.ReadTxtToDB(txtfile);

          statusbar1.Panels[0].Text := '目前進度:' + tblname+ ' 匯入結束';
          Application.ProcessMessages;
        end;
        gmqy.Close;


        if cklist1.Items[i]='AltGroup' then
        begin

          gmqy.Close;
          gmqy.CommandText:=
                            'truncate table Alt_Group_Master ' + #13#10 +
                            'truncate table Alt_Group ' + #13#10 +
                            '' + #13#10 +
                            'insert into Alt_Group_Master' + #13#10 +
                            '(' + #13#10 +
                            '  output_part_id,' + #13#10 +
                            '  group_altcode,' + #13#10 +
                            '  group_code,' + #13#10 +
                            '  group_altpriority,' + #13#10 +
                            '  sub_type,' + #13#10 +
                            '  is_substitute' + #13#10 +
                            ')' + #13#10 +
                            'select distinct' + #13#10 +
                            '  output_part_id,' + #13#10 +
                            '  group_altcode,' + #13#10 +
                            '  group_code,' + #13#10 +
                            '  0 group_altpriority,' + #13#10 +
                            '  sub_type,' + #13#10 +
                            '  is_substitute' + #13#10 +
                            'from AltGroup' + #13#10 +
                            '' + #13#10 +
                            'insert into Alt_Group' + #13#10 +
                            '(' + #13#10 +
                            '  output_part_id, group_altcode, input_part_id, group_altpriority, input_part_qty, output_part_qty,' + #13#10 +
                            '  effective_start_date, effective_end_date, shrinkage, group_code, is_including, sequence_txt, bonded_rule_id,' + #13#10 +
                            '  position, sequ_num' + #13#10 +
                            ')' + #13#10 +
                            'select distinct' + #13#10 +
                            '  output_part_id, group_altcode, input_part_id, 0 group_altpriority, input_part_qty, output_part_qty,' + #13#10 +
                            '  effective_start_date, effective_end_date, 0 shrinkage, group_code, is_including, sequence_txt, bonded_rule_id,' + #13#10 +
                            '  position, sequ_num' + #13#10 +
                            'from AltGroup';

          gmqy.Execute;

        end;

      end;
    end;
  finally
    ggsdb.Close;
  end;

end;

procedure TFmtodb.FormCreate(Sender: TObject);
begin

  if dm.DataModule1.gsDB.Connected = true then
    ggsdb := dm.DataModule1.gsDB
  else
    ggsdb := dm.DataModule1.gsDB_mssql;

  dm.DataModule1.Mqy1.SQLConnection:=ggsdb;

  gmqy := dm.DataModule1.Mqy;
  gqry := dm.DataModule1.qry;
  errlog := TstringList.Create;
  SL := TstringList.Create;
end;

procedure TFmtodb.FormActivate(Sender: TObject);
var
  i: integer;
begin
  if Assigned(SL) then
    cklist1.Items.AddStrings(SL);
  for I := 0 to cklist1.Items.Count - 1 do
  begin
    cklist1.Checked[i] := true;
  end;

end;

procedure TFmtodb.TruncateTables;
var
  i: integer;
  tblnm, sPrefix: string;
begin
  ggsdb.Close;
  ggsdb.open;
  try
    errlog.Clear;
    for I := cklist1.Count - 1 downto 0 do begin
      if cklist1.Checked[i] = true then begin
        tblnm := cklist1.Items[i];
        if lbet.Text = '' then
          sPrefix := ''
        else
          sPrefix := (lbet.Text) + '.';

        try

          statusbar1.Panels[0].Text := '目前進度:' + sPrefix + (tblnm) + ' Delete Starting..';
          Application.ProcessMessages;
          if tblnm<>'AltGroup' then
          begin

            gmqy.Close;
            gmqy.CommandText:= 'if object_id('+AA(sPrefix + (tblnm))+') is not null select 1 as cc else  select 0 as cc'  ;
            gmqy.Open;

            if gmqy.FieldByName('cc').AsInteger=1 then
            begin
              gmqy.Close;
              gmqy.CommandText := 'delete from  ' + sPrefix + (tblnm);
              gmqy.Execute;
            end;

          end
          else
          begin
             gmqy.CommandText := 'delete from  ' + sPrefix + ('Alt_Group');
             gmqy.Execute;
             gmqy.CommandText := 'delete from  ' + sPrefix + ('Alt_Group_Master');
             gmqy.Execute;
          end;
        except on E: Exception do
            errlog.Add(sPrefix + (tblnm) + ': ' + E.Message);
        end;

      end; //if cklist1.Checked[i]

    end; // for I

  finally
    errlog.SaveToFile(ExtractFilePath(Application.ExeName) + 'TruncatetableErr.log');
    ggsdb.Close;
    statusbar1.Panels[0].Text := '';
  end;
end;

end.

