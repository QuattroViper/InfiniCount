object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 341
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=C:\Us' +
      'ers\QuattroViper\Dropbox\IT PAT\Project delphi 10\InfiniCount - ' +
      'Copy.mdb;Mode=ReadWrite;Persist Security Info=False;Jet OLEDB:Sy' +
      'stem database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database P' +
      'assword="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mo' +
      'de=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk T' +
      'ransactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Creat' +
      'e System Database=False;Jet OLEDB:Encrypt Database=False;Jet OLE' +
      'DB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact Without ' +
      'Replica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 24
    Top = 112
  end
  object ADODataSetSavings: TADODataSet
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    Left = 120
    Top = 112
  end
  object ADODataSetCredit: TADODataSet
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    Left = 120
    Top = 64
  end
  object ADODataSetChecking: TADODataSet
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    Left = 120
    Top = 16
  end
  object ADODataSourceSavings: TDataSource
    DataSet = ADODataSetSavings
    Left = 240
    Top = 112
  end
  object ADODataSourceCredit: TDataSource
    DataSet = ADODataSetCredit
    Left = 240
    Top = 64
  end
  object ADODataSourceChecking: TDataSource
    DataSet = ADODataSetChecking
    Left = 240
    Top = 16
  end
  object ADODataSourceRun: TDataSource
    DataSet = ADODataSetRun
    Left = 240
    Top = 240
  end
  object ADODataSetRun: TADODataSet
    Connection = ADOConnection
    CursorType = ctStatic
    CommandText = 'select * from Accounts'
    Parameters = <>
    Left = 120
    Top = 240
  end
  object ADODataSetTime: TADODataSet
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    Left = 120
    Top = 288
  end
  object ADODataSourceTime: TDataSource
    DataSet = ADODataSetTime
    Left = 240
    Top = 288
  end
  object tblChecking: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'Checking Account'
    Left = 344
    Top = 16
  end
  object tblCredit: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'Credit Account'
    Left = 344
    Top = 64
  end
  object tblSavings: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'Savings Account'
    Left = 344
    Top = 112
  end
  object ADODataSetPMD: TADODataSet
    Connection = ADOConnection
    Parameters = <>
    Left = 120
    Top = 160
  end
  object ADODataSourcePMD: TDataSource
    DataSet = ADODataSetPMD
    Left = 240
    Top = 160
  end
  object tblPMD: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'PerMonthDetails'
    Left = 344
    Top = 160
  end
end
