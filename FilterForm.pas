unit FilterForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, DBClient;

type
  TTFilterForm = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    cbx1: TComboBox;
    lb_col: TLabel;
    rb1: TRadioButton;
    rb2: TRadioButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cdsf: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
        { Private declarations }
  public
        { Public declarations }
    Fcolname: string;
  end;
procedure call_fmFilterForm(colname: string; cds: TclientdataSet);
var
  TFilterForm: TTFilterForm;

implementation

{$R *.dfm}

procedure call_fmFilterForm(colname: string; cds: TclientdataSet);
begin
  try
    TFilterForm := TTFilterForm.Create(application);
    TFilterForm.Fcolname := colname;
    TFilterForm.cdsf := cds;
    TFilterForm.Showmodal;
  finally
    TFilterForm.Free;
  end;
end;

procedure TTFilterForm.BitBtn1Click(Sender: TObject);
var
  swhere: string;
begin

  if cbx1.Text = '<=' then
    swhere := Fcolname + ' <= ' + #39 + edit1.Text + #39;
  if cbx1.Text = '>=' then
    swhere := Fcolname + ' >= ' + #39 + edit1.Text + #39;
  if cbx1.Text = '=' then
    swhere := Fcolname + ' = ' + #39 + edit1.Text + #39;
  if cbx1.Text = 'like' then
    swhere := Fcolname + ' like ' + #39 + '%' + edit1.Text + '%' + #39;

  if rb1.Checked then
  begin
    cdsf.Locate(Fcolname, VarArrayOf([edit1.Text]), [loPartialKey]);
  end
  else
  begin
    cdsf.Filtered := false;
    cdsf.Filter := swhere;
    cdsf.Filtered := true;
  end;
end;

procedure TTFilterForm.FormShow(Sender: TObject);
begin
  lb_col.Caption := '目前選取的欄位:' + Fcolname;
end;

end.
