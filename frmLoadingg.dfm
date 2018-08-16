object frmLoading: TfrmLoading
  Left = 0
  Top = 0
  Caption = 'frmLoading'
  ClientHeight = 257
  ClientWidth = 585
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object mpLoad: TMediaPlayer
    Left = 0
    Top = 227
    Width = 253
    Height = 30
    Display = pnlShow
    FileName = 
      'C:\Users\QuattroViper\Dropbox\IT PAT\Project delphi 10\Animation' +
      '\Loading Screen HD with Sound.avi'
    TabOrder = 0
  end
  object pnlShow: TPanel
    Left = 0
    Top = 0
    Width = 585
    Height = 257
    TabOrder = 1
  end
end
