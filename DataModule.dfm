object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 350
  Width = 396
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=MapAcesso;Data Source=DESKTOP-AQ5KVS7\S' +
      'QLEXPRESS;Use Procedure for Prepare=1;Auto Translate=True;Packet' +
      ' Size=4096;Workstation ID=DESKTOP-NBLPJEP;Use Encryption for Dat' +
      'a=False;Tag with column collation when possible=False;'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 72
    Top = 40
  end
  object ADO_Pesquisa: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    SQL.Strings = (
      'SELECT MAX(COD_EMPRESA) AS crescente FROM EMPRESAS')
    Left = 40
    Top = 104
  end
  object ADO_Clientes: TADOTable
    Connection = ADOConnection
    TableName = '[TesteClientes].[dbo].[CLIENTES]'
    Left = 248
    Top = 16
  end
  object DS_Clientes: TDataSource
    DataSet = ADO_Clientes
    Left = 296
    Top = 16
  end
  object DS_Pesquisa: TDataSource
    DataSet = ADO_Pesquisa
    Left = 88
    Top = 105
  end
  object ADO_CELFON: TADOTable
    Connection = ADOConnection
    TableName = '[TesteClientes].[dbo].[TELEFONES]'
    Left = 248
    Top = 64
  end
  object ADO_Auxiliar: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    SQL.Strings = (
      'SELECT MAX(COD_EMPRESA) AS crescente FROM EMPRESAS')
    Left = 40
    Top = 168
  end
  object ADO_Estado: TADOTable
    Connection = ADOConnection
    TableName = '[TesteClientes].[dbo].[ESTADOS]'
    Left = 248
    Top = 112
  end
  object ADO_Cidades: TADOTable
    Connection = ADOConnection
    TableName = '[TesteClientes].[dbo].[CIDADES]'
    Left = 248
    Top = 160
  end
  object ADO_Auxiliar2: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    SQL.Strings = (
      'SELECT MAX(COD_EMPRESA) AS crescente FROM EMPRESAS')
    Left = 40
    Top = 224
  end
  object ADO_BAIRRO: TADOTable
    Connection = ADOConnection
    TableName = '[TesteClientes].[dbo].[BAIRROS]'
    Left = 248
    Top = 208
  end
  object DataSource1: TDataSource
    DataSet = ADO_Pesquisa
    Left = 104
    Top = 225
  end
  object DS_PesquisaCELL: TDataSource
    DataSet = ADO_PesquisaCELL
    Left = 112
    Top = 281
  end
  object ADO_PesquisaCELL: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    SQL.Strings = (
      'SELECT MAX(COD_EMPRESA) AS crescente FROM EMPRESAS')
    Left = 40
    Top = 280
  end
  object ADO_PesCliente: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    SQL.Strings = (
      'SELECT MAX(COD_EMPRESA) AS crescente FROM EMPRESAS')
    Left = 208
    Top = 280
  end
  object DS_PesCliente: TDataSource
    DataSet = ADO_PesCliente
    Left = 264
    Top = 281
  end
end
