object frmBegin: TfrmBegin
  Left = 0
  Top = 0
  Caption = 'Begin'
  ClientHeight = 83
  ClientWidth = 233
  Color = 3504979
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnToLogin: TButton
    Left = 8
    Top = 24
    Width = 89
    Height = 33
    Caption = 'Sign-in'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Resurrection'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnToLoginClick
  end
  object btnToRegister: TButton
    Left = 112
    Top = 24
    Width = 113
    Height = 33
    Caption = 'Register'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Resurrection'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnToRegisterClick
  end
end
