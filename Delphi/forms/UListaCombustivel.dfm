inherited FrmListaCombustivel: TFrmListaCombustivel
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
          FieldName = 'sigla'
          Title.Caption = 'Sigla'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Caption = 'Descri'#231#227'o'
          Width = 445
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'valor'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor'
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
      object Label2: TLabel [1]
        Left = 24
        Top = 61
        Width = 51
        Height = 15
        Caption = 'Descri'#231#227'o'
      end
      object Label3: TLabel [2]
        Left = 161
        Top = 32
        Width = 25
        Height = 15
        Caption = 'Sigla'
      end
      inherited BtnPesquisa: TBitBtn
        Left = 492
        Top = 57
        TabOrder = 2
        ExplicitLeft = 492
        ExplicitTop = 57
      end
      object EdCodigo: TEdit
        Left = 89
        Top = 29
        Width = 60
        Height = 23
        Hint = 'C'#243'digo do cliente'
        NumbersOnly = True
        TabOrder = 0
      end
      object EdDescricao: TEdit
        Left = 89
        Top = 58
        Width = 400
        Height = 23
        MaxLength = 60
        TabOrder = 1
      end
      object EdSigla: TEdit
        Left = 192
        Top = 29
        Width = 60
        Height = 23
        MaxLength = 5
        TabOrder = 3
      end
    end
  end
end
