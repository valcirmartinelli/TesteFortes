object FrmImpressaoAbastecimento: TFrmImpressaoAbastecimento
  Left = 0
  Top = 0
  Caption = 'FrmImpressaoAbastecimento'
  ClientHeight = 687
  ClientWidth = 1171
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object RLReport1: TRLReport
    Left = 108
    Top = 78
    Width = 794
    Height = 1123
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = []
    object RLGroup1: TRLGroup
      Left = 38
      Top = 38
      Width = 718
      Height = 64
    end
  end
  object DsAbastecimento: TDataSource
    DataSet = CdsAbastecimento
    Left = 232
    Top = 8
  end
  object CdsAbastecimento: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 8
  end
end
