unit UCadTanque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadastro, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, UTanque;

type
  TFrmCadTanque = class(TFrmCadastro)
    EdCombustivel: TEdit;
    LbSigla: TLabel;
    EdDescricao: TEdit;
    LbDescricao: TLabel;
    BtPesqCombustivel: TSpeedButton;
    EdNomeCombustivel: TEdit;
    procedure FormShow(Sender: TObject);
    procedure EdCombustivelExit(Sender: TObject);
    procedure BtPesqCombustivelClick(Sender: TObject);
  private
    { Private declarations }
   function Atualizar(): boolean; override;
   function Incluir(): boolean; override;
   function ValidaDados(): boolean; override;
   procedure ControleParaObjeto; override;
   procedure ObjetoParaControle; override;
  public
    { Public declarations }
    Tanque : TTanque;
  end;

var
  FrmCadTanque: TFrmCadTanque;

implementation

{$R *.dfm}

uses UFachadaTanque, ULib, UFachadaCombustivel, UListaCombustivel, UCombustivel;


function TFrmCadTanque.Atualizar: boolean;
begin
  Result := TFachadaTanque.Alterar(Self.Tanque);
end;

procedure TFrmCadTanque.BtPesqCombustivelClick(Sender: TObject);
var FormListCombustivel : TFrmListaCombustivel;
begin
  inherited;
  try
    FormListCombustivel := TFrmListaCombustivel.Create(self);
    FormListCombustivel.ShowModal;
    if FormListCombustivel.ACodigoId > 0 then
    begin
      EdCombustivel.Text := IntToStr(FormListCombustivel.ACodigoId);
      EdCombustivel.OnExit(self);
    end;
  finally
    FreeAndNil(FormListCombustivel);
  end;
end;

procedure TFrmCadTanque.ControleParaObjeto;
begin
  inherited;
  Tanque.Combustivel := TFachadaCombustivel.getInstance.ObterCombustivelPeloId(StrToInt(EdCombustivel.Text));
  Tanque.Descricao   := trim(EdDescricao.Text);
end;

procedure TFrmCadTanque.EdCombustivelExit(Sender: TObject);
var Combustivel : TCombustivel;
begin
  inherited;
  EdNomeCombustivel.Clear;
  if trim(EdCombustivel.Text) <> '' then
  begin
    try
      Combustivel := TFachadaCombustivel.getInstance.ObterCombustivelPeloId(StrToInt(EdCombustivel.Text));
      if Combustivel.Descricao <> '' then
        EdNomeCombustivel.Text := Combustivel.Descricao
      else
      begin
        Application.MessageBox('Combustivel não encontrado .', 'Atenção', MB_OK);
        EdCombustivel.Clear;
        EdNomeCombustivel.Clear;
        abort;
      end;
    finally
      FreeAndNil(Combustivel);
    end;
  end;
end;

procedure TFrmCadTanque.FormShow(Sender: TObject);
begin
  inherited;
  self.Caption := 'Cadastro de Tanque';
  if self.Tanque <> nil then
  begin
    self.Acao := acAlterar;
    ObjetoParaControle;
  end
  else
  begin
    Tanque := TTanque.Create;
    Tanque.Limpar;
    Self.Acao := acIncluir;
  end;
  self.EdCombustivel.SetFocus;
end;

function TFrmCadTanque.Incluir: boolean;
begin
  result := TFachadaTanque.Incluir(Self.Tanque);
end;

procedure TFrmCadTanque.ObjetoParaControle;
begin
  inherited;
  EdCombustivel.Text := IntToStr(Tanque.Combustivel.Id);
  EdDescricao.Text   := Tanque.Descricao;
  EdNomeCombustivel.Text := Tanque.Combustivel.Descricao;
end;

function TFrmCadTanque.ValidaDados: boolean;
begin
  result := true;

  if trim(EdCombustivel.Text) = '' then
  begin
    Application.MessageBox('O combustivel deve ser informado.', 'Atenção', MB_OK);
    result := false;
  end
  else if trim(EdDescricao.Text) = '' then
  begin
    Application.MessageBox('A descrição deve ser informado.', 'Atenção', MB_OK);
    result := false;
  end;
end;

end.
