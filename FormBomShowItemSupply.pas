unit FormBomShowItemSupply;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrFormBomShowItemSupply = class(TForm)
    GroupBox1: TGroupBox;
    btn_Exp: TBitBtn;
    Memo1: TMemo;
    SaveDialog1: TSaveDialog;
    procedure btn_ExpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure CallTfrFormBomShowItemSupply(txt: string);
  
var
  frFormBomShowItemSupply: TfrFormBomShowItemSupply;

implementation

{$R *.dfm}
procedure CallTfrFormBomShowItemSupply(txt: string);
begin
  try
    frFormBomShowItemSupply := TfrFormBomShowItemSupply.Create(application);
    frFormBomShowItemSupply.Memo1.Text := txt;
    frFormBomShowItemSupply.ShowModal;
  finally
    frFormBomShowItemSupply.free;
  end;
end;

procedure TfrFormBomShowItemSupply.btn_ExpClick(Sender: TObject);
begin
  if SaveDialog1.Execute() then
    memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

end.
