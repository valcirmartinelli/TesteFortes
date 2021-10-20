unit UMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UBase, Vcl.Menus;

type
  TFrmMenu = class(TFrmBase)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Vendas1: TMenuItem;
    Pessoa1: TMenuItem;
    produto1: TMenuItem;
    Vendas2: TMenuItem;
    OpenDialog1: TOpenDialog;
    Bomba1: TMenuItem;
    Relatrio1: TMenuItem;
    Abastecimentoporperodo1: TMenuItem;
    procedure produto1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Pessoa1Click(Sender: TObject);
    procedure Bomba1Click(Sender: TObject);
    procedure Vendas2Click(Sender: TObject);
    procedure Abastecimentoporperodo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

uses  UConexao, UListaCombustivel, UListaTanque, UListaBomba, UAbastecimento,
  UListaAbastecimento, URelatorioAbastecimento;

procedure TFrmMenu.Abastecimentoporperodo1Click(Sender: TObject);
var FormRelatorio : TFrmRelatorio;
begin
  inherited;
  try
    FormRelatorio := TFrmRelatorio.Create(self);
    FormRelatorio.ShowModal;
  finally
    FreeAndNil(FormRelatorio);
  end;
end;

procedure TFrmMenu.Bomba1Click(Sender: TObject);
var FormListBomba : TFrmListaBomba;
begin
  inherited;
  try
    FormListBomba := TFrmListaBomba.Create(self);
    FormListBomba.ShowModal;
  finally
    FreeAndNil(FormListBomba);
  end;

end;

procedure TFrmMenu.FormCreate(Sender: TObject);
var sDir : string;
begin
  inherited;
  if DmConexao.IBDatabase.DatabaseName = '' then
  begin
    try
      Application.MessageBox('Informe o banco de dados.', 'Atenção', MB_OK);
      OpenDialog1.Execute();
      sDir := OpenDialog1.FileName;
      DmConexao.IBDatabase.DatabaseName := sDir;
      DmConexao.IBDatabase.Connected := true;
      DmConexao.IBTransaction.Active := true;
    Except
      Application.MessageBox('Erro ao conectar com o banco de dados', 'Atenção', MB_OK);
      Application.Terminate;
    end;
  end;
end;

procedure TFrmMenu.Pessoa1Click(Sender: TObject);
var FormListTanque : TFrmListaTanque;
begin
  inherited;
  try
    FormListTanque := TFrmListaTanque.Create(self);
    FormListTanque.ShowModal;
  finally
    FreeAndNil(FormListTanque);
  end;

end;

procedure TFrmMenu.produto1Click(Sender: TObject);
var FormListCombustivel : TFrmListaCombustivel;
begin
  inherited;
  try
    FormListCombustivel := TFrmListaCombustivel.Create(self);
    FormListCombustivel.ShowModal;
  finally
    FreeAndNil(FormListCombustivel);
  end;
end;


procedure TFrmMenu.Vendas2Click(Sender: TObject);
var FormListAbastecimento : TFrmListaAbastecimento;
begin
  inherited;
  try
    FormListAbastecimento := TFrmListaAbastecimento.Create(self);
    FormListAbastecimento.ShowModal;
  finally
    FreeAndNil(FormListAbastecimento);
  end;
end;

end.
