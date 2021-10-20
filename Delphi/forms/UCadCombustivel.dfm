inherited FrmCadCombustivel: TFrmCadCombustivel
  Caption = 'FrmCadCombustivel'
  ClientHeight = 146
  ClientWidth = 561
  OnShow = FormShow
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 579
  ExplicitHeight = 193
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnlBotton: TPanel
    Top = 105
    Width = 561
    ExplicitTop = 79
    ExplicitWidth = 561
    inherited BtCancelar: TBitBtn
      Left = 276
      ExplicitLeft = 276
    end
    inherited BtConfirmar: TBitBtn
      Left = 195
      ExplicitLeft = 195
    end
  end
  inherited PnlClient: TPanel
    Width = 561
    Height = 105
    ExplicitWidth = 561
    ExplicitHeight = 79
    object LbSigla: TLabel
      Left = 0
      Top = 13
      Width = 25
      Height = 15
      Caption = 'Sigla'
    end
    object LbDescricao: TLabel
      Left = 0
      Top = 42
      Width = 51
      Height = 15
      Caption = 'Descri'#231#227'o'
    end
    object LbValor: TLabel
      Left = 0
      Top = 71
      Width = 26
      Height = 15
      Caption = 'Valor'
    end
    object EdSigla: TEdit
      Left = 66
      Top = 10
      Width = 63
      Height = 23
      MaxLength = 5
      TabOrder = 0
    end
    object EdDescricao: TEdit
      Left = 66
      Top = 39
      Width = 471
      Height = 23
      MaxLength = 60
      TabOrder = 1
    end
    object EdValor: TEdit
      Left = 66
      Top = 68
      Width = 95
      Height = 23
      MaxLength = 5
      TabOrder = 2
      OnKeyPress = EdValorKeyPress
    end
  end
end
