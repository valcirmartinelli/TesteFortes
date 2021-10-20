unit UCadBomba;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadastro, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, UBomba;

type
  TFrmCadBomba = class(TFrmCadastro)
    EdTanque: TEdit;
    LbTanque: TLabel;
    EdDescricao: TEdit;
    LbDescricao: TLabel;
    BtPesqTanque: TSpeedButton;
    EdNomeTanque: TEdit;
    procedure FormShow(Sender: TObject);
    procedure EdTanqueExit(Sender: TObject);
    procedure BtPesqTanqueClick(Sender: TObject);
  private
    { Private declarations }
   function Atualizar(): boolean; override;
   function Incluir(): boolean; override;
   function ValidaDados(): boolean; override;
   procedure ControleParaObjeto; override;
   procedure ObjetoParaControle; override;
  public
    { Public declarations }
    Bomba : TBomba;
  end;

var
  FrmCadBomba: TFrmCadBomba;

implementation

{$R *.dfm}

uses UFachadaTanque, ULib, UFachadaBomba, UListaTanque, UTanque;


function TFrmCadBomba.Atualizar: boolean;
begin
  Result := TFachadaBomba.Alterar(Self.Bomba);
end;

procedure TFrmCadBomba.BtPesqTanqueClick(Sender: TObject);
var FormListTanque : TFrmListaTanque;
begin
  inherited;
  try
    FormListTanque := TFrmListaTanque.Create(self);
    FormListTanque.ShowModal;
    if FormListTanque.ACodigoId > 0 then
    begin
      EdTanque.Text := IntToStr(FormListTanque.ACodigoId);
      EdTanque.OnExit(self);
    end;
  finally
    FreeAndNil(FormListTanque);
  end;
end;

procedure TFrmCadBomba.ControleParaObjeto;
begin
  inherited;
  Bomba.Tanque := TFachadaTanque.getInstance.ObterTanquePeloId(StrToInt(EdTanque.Text));
  Bomba.Descricao   := trim(EdDescricao.Text);
end;

procedure TFrmCadBomba.EdTanqueExit(Sender: TObject);
var Tanque : TTanque;
begin
  inherited;
  EdNomeTanque.Clear;
  if trim(EdTanque.Text) <> '' then
  begin
    try
      Tanque := TFachadaTanque.getInstance.ObterTanquePeloId(StrToInt(EdTanque.Text));
      if Tanque.Descricao <> '' then
        EdNomeTanque.Text := Tanque.Descricao
      else
      begin
        Application.MessageBox('Tanque não encontrado .', 'Atenção', MB_OK);
        EdTanque.Clear;
        EdNomeTanque.Clear;
        abort;
      end;
    finally
      FreeAndNil(Tanque);
    end;
  end;
end;

procedure TFrmCadBomba.FormShow(Sender: TObject);
begin
  inherited;
  self.Caption := 'Cadastro de Bomba';
  if self.Bomba <> nil then
  begin
    self.Acao := acAlterar;
    ObjetoParaControle;
  end
  else
  begin
    Bomba := TBomba.Create;
    Bomba.Limpar;
    Self.Acao := acIncluir;
  end;
  self.EdTanque.SetFocus;
end;

function TFrmCadBomba.Incluir: boolean;
begin
  result := TFachadaBomba.Incluir(Self.Bomba);
end;

procedure TFrmCadBomba.ObjetoParaControle;
begin
  inherited;
  EdTanque.Text := IntToStr(Bomba.Tanque.Id);
  EdDescricao.Text   := Bomba.Descricao;
  EdNomeTanque.Text := Bomba.Tanque.Descricao;
end;

function TFrmCadBomba.ValidaDados: boolean;
begin
  result := true;

  if trim(EdTanque.Text) = '' then
  begin
    Application.MessageBox('O tanque deve ser informado.', 'Atenção', MB_OK);
    result := false;
  end
  else if trim(EdDescricao.Text) = '' then
  begin
    Application.MessageBox('A descrição deve ser informado.', 'Atenção', MB_OK);
    result := false;
  end;
end;

end.
