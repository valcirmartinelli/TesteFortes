inherited FrmListaAbastecimento: TFrmListaAbastecimento
  Caption = ''
  ClientHeight = 515
  ClientWidth = 748
  ExplicitWidth = 766
  ExplicitHeight = 562
  PixelsPerInch = 96
  TextHeight = 15
  inherited PnlClient: TPanel
    Width = 748
    Height = 385
    ExplicitWidth = 748
    ExplicitHeight = 385
    inherited DBGridDados: TDBGrid
      Width = 746
      Height = 383
      Columns = <
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'id'
          Title.Alignment = taRightJustify
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Bomba'
          Width = 274
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'QTDE_LITRO'
          Title.Alignment = taRightJustify
          Title.Caption = 'Litros'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'VALOR_UNIT'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vl Unit'#225'rio'
          Width = 74
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'VALOR_IMPOSTO'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vl Total'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'VALOR_TOTAL'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vl Imposto'
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA'
          Title.Caption = 'Data'
          Visible = True
        end>
    end
  end
  inherited PnlBotton: TPanel
    Top = 474
    Width = 748
    ExplicitTop = 474
    ExplicitWidth = 748
    inherited BtNovo: TBitBtn
      OnClick = BtNovoClick
    end
    inherited BtEditar: TBitBtn
      Caption = '&Visualizar'
    end
    inherited BtExcluir: TBitBtn
      Visible = False
    end
    inherited BtSair: TBitBtn
      Left = 653
      ExplicitLeft = 653
    end
  end
  inherited PnlCima: TPanel
    Width = 748
    ExplicitWidth = 748
    inherited GbPesquisa: TGroupBox
      Width = 746
      ExplicitWidth = 746
      object LbCodigo: TLabel [0]
        Left = 24
        Top = 32
        Width = 39
        Height = 15
        Caption = 'C'#243'digo'
      end
      object LbData: TLabel [1]
        Left = 24
        Top = 61
        Width = 24
        Height = 15
        Caption = 'Data'
      end
      object LbBomba: TLabel [2]
        Left = 140
        Top = 32
        Width = 38
        Height = 15
        Caption = 'Bomba'
      end
      object BtPesqBomba: TSpeedButton [3]
        Left = 276
        Top = 29
        Width = 23
        Height = 23
        Hint = 'Pesquisar bomba (Duplo clique no grid para selecionar)'
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
      inherited BtnPesquisa: TBitBtn
        Left = 492
        Top = 57
        TabOrder = 2
        ExplicitLeft = 492
        ExplicitTop = 57
      end
      object EdCodigo: TEdit
        Left = 68
        Top = 29
        Width = 60
        Height = 23
        Hint = 'C'#243'digo do cliente'
        NumbersOnly = True
        TabOrder = 0
      end
      object EdData: TEdit
        Left = 68
        Top = 58
        Width = 87
        Height = 23
        MaxLength = 60
        TabOrder = 1
        OnExit = EdDataExit
      end
      object EdBomba: TEdit
        Left = 216
        Top = 29
        Width = 60
        Height = 23
        MaxLength = 5
        NumbersOnly = True
        TabOrder = 3
        OnExit = EdBombaExit
      end
      object EdNomeBomba: TEdit
        Left = 305
        Top = 29
        Width = 327
        Height = 23
        BorderStyle = bsNone
        Color = clBtnFace
        Ctl3D = True
        Enabled = False
        MaxLength = 128
        ParentCtl3D = False
        TabOrder = 4
      end
    end
  end
end
