inherited FrmRelatorio: TFrmRelatorio
  ParentCustomHint = False
  Caption = 'Relat'#243'rio'
  ClientHeight = 170
  ClientWidth = 410
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 428
  ExplicitHeight = 217
  PixelsPerInch = 96
  TextHeight = 15
  object PnlBotton: TPanel
    Left = 0
    Top = 129
    Width = 410
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 163
    ExplicitWidth = 417
    object BtCancelar: TBitBtn
      Left = 175
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 1
    end
    object BtConfirmar: TBitBtn
      Left = 94
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Imprimir'
      TabOrder = 0
      OnClick = BtConfirmarClick
    end
  end
  object PnlClient: TPanel
    Left = 0
    Top = 0
    Width = 410
    Height = 129
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 417
    ExplicitHeight = 163
    object LbTanque: TLabel
      Left = 0
      Top = 13
      Width = 38
      Height = 15
      Caption = 'Tanque'
    end
    object BtPesqTanque: TSpeedButton
      Left = 113
      Top = 10
      Width = 23
      Height = 23
      Hint = 'Pesquisar tanque (Duplo clique no grid para selecionar)'
      Glyph.Data = {
        06020000424D0602000000000000760000002800000028000000140000000100
        0400000000009001000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333BFBF
        BFBFBFBF3333333333FF33FF33FF33333333F00FF00FF00F33333333377F377F
        377F33333333B00FB00FB00F3333333337733773377333333333FFFFFFFFFFFF
        3333333333333333333333333333BFBFBFBFBFBF333333333333333333333333
        3333FFFFFFFFFFFF33333333F3333333333333333330BFBFBFBFBFBF33333337
        FF3333333333333333010FFFFFFFFFFF333333777FF3333333333333330170BF
        BFBFBFBF3333337777FF3333333333333301170FFFFFFFFF333333777773F333
        3333333330711190BFBFBFBF3333377777373F3333333333308819990FFFFFFF
        33333733733373F333333333088FF9999033333333337333333FF73333333330
        88FFFF0003333333333733333F777333333333088FFF00333333333333733333
        7733333333333088FFF033333333333337333337333333333333088FFF093333
        333333337F33337333333333333308FFF09333333333333373F3373333333333
        333330FF0333333333333333373F733333333333333333003333333333333333
        33773333333333333333}
      NumGlyphs = 2
      OnClick = BtPesqTanqueClick
    end
    object LbBomba: TLabel
      Left = 0
      Top = 42
      Width = 38
      Height = 15
      Caption = 'Bomba'
    end
    object BtPesqBomba: TSpeedButton
      Left = 113
      Top = 39
      Width = 23
      Height = 23
      Hint = 'Pesquisar combustivel (Duplo clique no grid para selecionar)'
      Glyph.Data = {
        06020000424D0602000000000000760000002800000028000000140000000100
        0400000000009001000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333BFBF
        BFBFBFBF3333333333FF33FF33FF33333333F00FF00FF00F33333333377F377F
        377F33333333B00FB00FB00F3333333337733773377333333333FFFFFFFFFFFF
        3333333333333333333333333333BFBFBFBFBFBF333333333333333333333333
        3333FFFFFFFFFFFF33333333F3333333333333333330BFBFBFBFBFBF33333337
        FF3333333333333333010FFFFFFFFFFF333333777FF3333333333333330170BF
        BFBFBFBF3333337777FF3333333333333301170FFFFFFFFF333333777773F333
        3333333330711190BFBFBFBF3333377777373F3333333333308819990FFFFFFF
        33333733733373F333333333088FF9999033333333337333333FF73333333330
        88FFFF0003333333333733333F777333333333088FFF00333333333333733333
        7733333333333088FFF033333333333337333337333333333333088FFF093333
        333333337F33337333333333333308FFF09333333333333373F3373333333333
        333330FF0333333333333333373F733333333333333333003333333333333333
        33773333333333333333}
      NumGlyphs = 2
      OnClick = BtPesqBombaClick
    end
    object EdTanque: TEdit
      Left = 46
      Top = 10
      Width = 63
      Height = 23
      MaxLength = 5
      NumbersOnly = True
      TabOrder = 0
      OnExit = EdTanqueExit
    end
    object EdNomeTanque: TEdit
      Left = 143
      Top = 10
      Width = 327
      Height = 23
      BorderStyle = bsNone
      Color = clBtnFace
      Ctl3D = True
      Enabled = False
      MaxLength = 128
      ParentCtl3D = False
      TabOrder = 2
    end
    object EdBomba: TEdit
      Left = 46
      Top = 39
      Width = 63
      Height = 23
      MaxLength = 5
      NumbersOnly = True
      TabOrder = 1
      OnExit = EdBombaExit
    end
    object EdNomeBomba: TEdit
      Left = 143
      Top = 39
      Width = 327
      Height = 23
      BorderStyle = bsNone
      Color = clBtnFace
      Ctl3D = True
      Enabled = False
      MaxLength = 128
      ParentCtl3D = False
      TabOrder = 3
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 68
      Width = 330
      Height = 50
      Caption = 'Per'#237'odo'
      TabOrder = 4
      object LbData: TLabel
        Left = 14
        Top = 21
        Width = 14
        Height = 15
        Caption = 'De'
      end
      object Label1: TLabel
        Left = 165
        Top = 21
        Width = 18
        Height = 15
        Caption = 'At'#233
      end
      object EdDataIni: TEdit
        Left = 38
        Top = 18
        Width = 120
        Height = 23
        MaxLength = 60
        TabOrder = 0
        OnExit = EdDataIniExit
      end
      object EdDataFim: TEdit
        Left = 191
        Top = 18
        Width = 120
        Height = 23
        MaxLength = 60
        TabOrder = 1
        OnExit = EdDataFimExit
      end
    end
    object RLReport1: TRLReport
      Left = 94
      Top = 124
      Width = 794
      Height = 1123
      DataSource = DsAbastecimento
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = []
      Visible = False
      object RLBand2: TRLBand
        Left = 38
        Top = 193
        Width = 718
        Height = 25
        BandType = btSummary
        object RLDBResult2: TRLDBResult
          Left = 419
          Top = 5
          Width = 168
          Height = 19
          DataField = 'VALOR_TOTAL'
          DataSource = DsAbastecimento
          Info = riSum
          Text = ''
        end
        object RLDraw2: TRLDraw
          Left = 421
          Top = 3
          Width = 130
          Height = 1
        end
        object RLLabel6: TRLLabel
          Left = 324
          Top = 5
          Width = 82
          Height = 19
          Caption = 'Valor Total'
        end
      end
      object RLGroup1: TRLGroup
        Left = 38
        Top = 81
        Width = 718
        Height = 112
        DataFields = 'DATA'
        object RLBand1: TRLBand
          Left = 0
          Top = 57
          Width = 718
          Height = 25
          object RLDBText1: TRLDBText
            Left = 10
            Top = 1
            Width = 70
            Height = 19
            DataField = 'TANQUE'
            DataSource = DsAbastecimento
            Text = ''
          end
          object RLDBText2: TRLDBText
            Left = 196
            Top = 2
            Width = 63
            Height = 19
            DataField = 'BOMBA'
            DataSource = DsAbastecimento
            Text = ''
          end
          object RLDBText3: TRLDBText
            Left = 419
            Top = 3
            Width = 118
            Height = 19
            DataField = 'VALOR_TOTAL'
            DataSource = DsAbastecimento
            Text = ''
          end
        end
        object RLBand3: TRLBand
          Left = 0
          Top = 0
          Width = 718
          Height = 57
          BandType = btHeader
          object RLLabel3: TRLLabel
            Left = 419
            Top = 35
            Width = 43
            Height = 19
            Caption = 'Valor'
          end
          object RLLabel2: TRLLabel
            Left = 196
            Top = 34
            Width = 56
            Height = 19
            Caption = 'Bomba'
          end
          object RLLabel1: TRLLabel
            Left = 9
            Top = 35
            Width = 59
            Height = 19
            Caption = 'Tanque'
          end
          object RLLabel4: TRLLabel
            Left = 3
            Top = 14
            Width = 44
            Height = 19
            Caption = 'Data:'
          end
          object RLDBText4: TRLDBText
            Left = 53
            Top = 14
            Width = 48
            Height = 19
            DataField = 'DATA'
            DataSource = DsAbastecimento
            Text = ''
          end
        end
        object RLBand5: TRLBand
          Left = 0
          Top = 82
          Width = 718
          Height = 30
          BandType = btSummary
          object RLDraw1: TRLDraw
            Left = 414
            Top = 2
            Width = 130
            Height = 1
          end
          object RLDBResult1: TRLDBResult
            Left = 419
            Top = 5
            Width = 168
            Height = 19
            DataField = 'VALOR_TOTAL'
            DataSource = DsAbastecimento
            Info = riSum
            Text = ''
          end
        end
      end
      object RLBand4: TRLBand
        Left = 38
        Top = 38
        Width = 718
        Height = 43
        BandType = btTitle
        object RLLabel5: TRLLabel
          Left = 0
          Top = 0
          Width = 718
          Height = 43
          Align = faClient
          Alignment = taCenter
          Caption = 'Relat'#243'rio de abastecimento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -23
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
  object CdsAbastecimento: TClientDataSet
    PersistDataPacket.Data = {
      700000009619E0BD01000000180000000400000000000300000070000654414E
      5155450100490000000100055749445448020002003C0005424F4D4241010049
      0000000100055749445448020002003C00044441544108000800000000000B56
      414C4F525F544F54414C08000400000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 8
    object CdsAbastecimentoTANQUE: TStringField
      FieldName = 'TANQUE'
      Size = 60
    end
    object CdsAbastecimentoBOMBA: TStringField
      FieldName = 'BOMBA'
      Size = 60
    end
    object CdsAbastecimentoDATA: TDateTimeField
      FieldName = 'DATA'
    end
    object CdsAbastecimentoVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
    end
  end
  object DsAbastecimento: TDataSource
    DataSet = CdsAbastecimento
    Left = 272
    Top = 8
  end
end
