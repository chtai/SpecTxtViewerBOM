unit FormSetRowsCount;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmSetRowscount = class(TForm)
    PL_setRowCount: TPanel;
    Label4: TLabel;
    ed_s: TEdit;
    ed_e: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure ShowFrmSetRowscount();

var
  FrmSetRowscount: TFrmSetRowscount;

implementation
uses func;


procedure ShowFrmSetRowscount();
var
  f:TFrmSetRowscount;
begin
  try
    f:=TFrmSetRowscount.Create(nil);
    f.ShowModal();
  finally
    f.Free;
  end;

end;

{$R *.dfm}

procedure TFrmSetRowscount.Button1Click(Sender: TObject);
begin
  start_idx:=strtoint(ed_s.Text);
  end_idx:=strtoint(ed_e.Text);
  self.Close;
end;

end.
