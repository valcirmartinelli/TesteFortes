object DmConexao: TDmConexao
  Height = 251
  Width = 486
  PixelsPerInch = 120
  object IBDatabase: TIBDatabase
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 48
    Top = 56
  end
  object Qry: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 152
    Top = 40
  end
  object DS: TDataSource
    DataSet = Qry
    Left = 208
    Top = 56
  end
  object IBTransaction: TIBTransaction
    DefaultDatabase = IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 384
    Top = 40
  end
end
