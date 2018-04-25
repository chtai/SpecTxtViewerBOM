object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 230
  Width = 335
  object gsDB: TSQLConnection
    ConnectionName = 'wintek_10.40.200.10'
    DriverName = 'Oracle'
    KeepConnection = False
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Oracle'
      'DataBase=10.40.200.10'
      'User_Name=wintek'
      'Password=wintek'
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Oracle TransIsolation=ReadCommited'
      'RowsetSize=20'
      'OS Authentication=False'
      'Multiple Transaction=False'
      'Trim Char=False')
    Left = 24
    Top = 32
  end
  object mqy1: TSQLQuery
    GetMetadata = True
    MaxBlobSize = -1
    Params = <>
    SQLConnection = gsdb_mssql
    Left = 56
    Top = 72
  end
  object Mqy: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'pv1'
    Left = 136
    Top = 88
  end
  object pv1: TDataSetProvider
    DataSet = mqy1
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 88
    Top = 88
  end
  object qry: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = gsDB
    Left = 136
    Top = 32
  end
  object gsdb_mssql: TSQLConnection
    ConnectionName = 'MSSQL'
    DriverName = 'MSSQL'
    KeepConnection = False
    LoginPrompt = False
    Params.Strings = (
      'DriverName=MSSQL'
      'HostName=10.40.200.228'
      'DataBase=HTC'
      'User_Name=sa'
      'Password=dsc'
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'MSSQL TransIsolation=ReadCommited'
      'OS Authentication=False'
      'Prepare SQL=True')
    Left = 24
    Top = 104
  end
end
