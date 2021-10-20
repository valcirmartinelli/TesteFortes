object FrmMenu: TFrmMenu
  Left = 0
  Top = 0
  Caption = 'FrmMenu'
  ClientHeight = 433
  ClientWidth = 622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object MainMenu1: TMainMenu
    Left = 320
    Top = 120
    object Cadastro1: TMenuItem
      Caption = '&Cadastro'
      object produto1: TMenuItem
        Caption = '&Combustivel'
        OnClick = produto1Click
      end
      object Pessoa1: TMenuItem
        Caption = '&Tanque'
        OnClick = Pessoa1Click
      end
      object Bomba1: TMenuItem
        Caption = '&Bomba'
        OnClick = Bomba1Click
      end
    end
    object Vendas1: TMenuItem
      Caption = '&Abastecimento'
      object Vendas2: TMenuItem
        Caption = '&Abastecer'
        OnClick = Vendas2Click
      end
    end
    object Relatrio1: TMenuItem
      Caption = '&Relat'#243'rio'
      object Abastecimentoporperodo1: TMenuItem
        Caption = '&Abastecimento por per'#237'odo'
        OnClick = Abastecimentoporperodo1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 464
    Top = 256
  end
end
