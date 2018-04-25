unit DM;

interface

uses
  SysUtils, Classes, WideStrings, FMTBcd, DB, SqlExpr, Provider,
  DBClient, DBXOracle, DBXMsSQL;

type
  TDataModule1 = class(TDataModule)
    gsDB: TSQLConnection;
    mqy1: TSQLQuery;
    Mqy: TClientDataSet;
    pv1: TDataSetProvider;
    qry: TSQLQuery;
    gsdb_mssql: TSQLConnection;
  private
        { Private declarations }
  public
        { Public declarations }
  end;

var
  DataModule1: TDataModule1;
  ggsdb: TSQLConnection;
  gmqy: TClientDataSet;
  gqry: TSQLQuery;

implementation

{$R *.dfm}

end.
