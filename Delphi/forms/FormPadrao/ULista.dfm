inherited FrmLista: TFrmLista
  Caption = 'FrmLista'
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object PnlClient: TPanel
    Left = 0
    Top = 89
    Width = 622
    Height = 303
    Align = alClient
    TabOrder = 0
    object DBGridDados: TDBGrid
      Left = 1
      Top = 1
      Width = 620
      Height = 301
      Hint = 'Duplo clique no grid para selecionar o registro'
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = DBGridDadosDblClick
    end
  end
  object PnlBotton: TPanel
    Left = 0
    Top = 392
    Width = 622
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BtNovo: TBitBtn
      Left = 0
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Novo'
      TabOrder = 0
    end
    object BtEditar: TBitBtn
      Left = 81
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Editar'
      TabOrder = 1
      OnClick = BtEditarClick
    end
    object BtExcluir: TBitBtn
      Left = 162
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Excluir'
      TabOrder = 2
      OnClick = BtExcluirClick
    end
    object BtSair: TBitBtn
      Left = 536
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Sair'
      TabOrder = 3
      OnClick = BtSairClick
    end
  end
  object PnlCima: TPanel
    Left = 0
    Top = 0
    Width = 622
    Height = 89
    Align = alTop
    TabOrder = 2
    object GbPesquisa: TGroupBox
      Left = 1
      Top = 1
      Width = 620
      Height = 87
      Align = alClient
      Caption = '  Pesquisar por '
      TabOrder = 0
      object BtnPesquisa: TBitBtn
        Left = 536
        Top = 33
        Width = 75
        Height = 25
        Caption = '&Pesquisa'
        TabOrder = 0
        OnClick = BtnPesquisaClick
      end
    end
  end
end
