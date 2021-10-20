inherited FrmCadBomba: TFrmCadBomba
  Caption = 'FrmCadBomba'
  ClientHeight = 146
  ClientWidth = 561
  OnShow = FormShow
  ExplicitWidth = 579
  ExplicitHeight = 193
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnlBotton: TPanel
    Top = 105
    Width = 561
    ExplicitTop = 105
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
    ExplicitHeight = 105
    object LbTanque: TLabel
      Left = 0
      Top = 13
      Width = 38
      Height = 15
      Caption = 'Tanque'
    end
    object LbDescricao: TLabel
      Left = 0
      Top = 42
      Width = 51
      Height = 15
      Caption = 'Descri'#231#227'o'
    end
    object BtPesqTanque: TSpeedButton
      Left = 139
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
    object EdTanque: TEdit
      Left = 72
      Top = 10
      Width = 63
      Height = 23
      MaxLength = 5
      NumbersOnly = True
      TabOrder = 0
      OnExit = EdTanqueExit
    end
    object EdDescricao: TEdit
      Left = 72
      Top = 39
      Width = 471
      Height = 23
      MaxLength = 60
      TabOrder = 1
    end
    object EdNomeTanque: TEdit
      Left = 169
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
  end
end
