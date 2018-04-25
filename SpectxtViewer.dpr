program SpectxtViewer;

uses
  Forms,
  main in 'main.pas' {Form1},
  Todb in 'Todb.pas' {Fmtodb},
  DM in 'DM.pas' {DataModule1: TDataModule},
  XLSFile in 'XLSFile.pas',
  FilterForm in 'FilterForm.pas' {TFilterForm},
  Func in 'Func.pas',
  FormBomShow in 'FormBomShow.pas' {frFormBomShow},
  FormItemTotalSupply in 'FormItemTotalSupply.pas' {frFormItemTotalSupply},
  FormHint in 'FormHint.pas' {Form2},
  FormMOPeggingView in 'FormMOPeggingView.pas' {frMOPeggingView},
  FormBomShowItemSupply in 'FormBomShowItemSupply.pas' {frFormBomShowItemSupply},
  FormQuery in 'FormQuery.pas' {frFormQuery},
  FormHardPeggingView in 'FormHardPeggingView.pas' {frHardPeggingView},
  Hasher in 'Hasher.pas',
  FormSetRowsCount in 'FormSetRowsCount.pas' {FrmSetRowscount};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFrmSetRowscount, FrmSetRowscount);
  Application.Run;
end.
