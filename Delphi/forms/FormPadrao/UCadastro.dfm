inherited FrmCadastro: TFrmCadastro
  Caption = 'FrmCadastro'
  PixelsPerInch = 96
  TextHeight = 15
  object PnlBotton: TPanel
    Left = 0
    Top = 392
    Width = 622
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BtCancelar: TBitBtn
      Left = 313
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = BtCancelarClick
    end
    object BtConfirmar: TBitBtn
      Left = 232
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Confirmar'
      TabOrder = 0
      OnClick = BtConfirmarClick
    end
  end
  object PnlClient: TPanel
    Left = 0
    Top = 0
    Width = 622
    Height = 392
    Align = alClient
    TabOrder = 1
  end
end
