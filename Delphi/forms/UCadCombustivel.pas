unit UCadCombustivel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadastro, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, UCombustivel;

type
  TFrmCadCombustivel = class(TFrmCadastro)
    EdSigla: TEdit;
    LbSigla: TLabel;
    EdDescricao: TEdit;
    LbDescricao: TLabel;
    LbValor: TLabel;
    EdValor: TEdit;
    procedure FormShow(Sender: TObject);
    procedure EdValorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
   function Atualizar(): boolean; override;
   function Incluir(): boolean; override;
   function ValidaDados(): boolean; override;
   procedure ControleParaObjeto; override;
   procedure ObjetoParaControle; override;
  public
    { Public declarations }
    Combustivel : TCombustivel;
  end;

var
  FrmCadCombustivel: TFrmCadCombustivel;

implementation

{$R *.dfm}

uses UFachadaCombustivel, ULib;


function TFrmCadCombustivel.Atualizar: boolean;
begin
  Result := TFachadaCombustivel.Alterar(Self.Combustivel);
end;

procedure TFrmCadCombustivel.ControleParaObjeto;
begin
  inherited;
  Combustivel.Sigla     := trim(EdSigla.Text);
  Combustivel.Descricao := trim(EdDescricao.Text);
  Combustivel.Valor     := StrToFloat(EdValor.Text);
end;


procedure TFrmCadCombustivel.EdValorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  DigitarApenasNumero(true, Key);
end;

procedure TFrmCadCombustivel.FormShow(Sender: TObject);
begin
  inherited;
  self.Caption := 'Cadastro de combustivel';
  if self.Combustivel <> nil then
  begin
    self.Acao := acAlterar;
    ObjetoParaControle;
  end
  else
  begin
    Combustivel := TCombustivel.Create;
    Combustivel.Limpar;
    Self.Acao := acIncluir;
  end;
  self.EdSigla.SetFocus;
end;

function TFrmCadCombustivel.Incluir: boolean;
begin
  result := TFachadaCombustivel.Incluir(Self.Combustivel);
end;

procedure TFrmCadCombustivel.ObjetoParaControle;
begin
  inherited;
  EdSigla.Text      := Combustivel.Sigla;
  EdDescricao.Text  := Combustivel.Descricao;
  EdValor.Text      := FloatToStr(Combustivel.Valor);
end;

function TFrmCadCombustivel.ValidaDados: boolean;
begin
  result := true;

  if trim(EdSigla.Text) = '' then
  begin
    Application.MessageBox('A sigla deve ser informada.', 'Atenção', MB_OK);
    result := false;
  end
  else if trim(EdDescricao.Text) = '' then
  begin
    Application.MessageBox('A descrição deve ser informado.', 'Atenção', MB_OK);
    result := false;
  end;
end;

end.
