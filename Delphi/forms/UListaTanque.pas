unit UListaTanque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ULista, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, UTanque, DBClient, IBX.IBQuery;

type
  TFrmListaTanque = class(TFrmLista)
    LbCodigo: TLabel;
    LbDescricao: TLabel;
    LbCombustivel: TLabel;
    EdCodigo: TEdit;
    EdDescricao: TEdit;
    EdCombustivel: TEdit;
    BtPesqCombustivel: TSpeedButton;
    EdNomeCombustivel: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtEditarClick(Sender: TObject);
    procedure BtNovoClick(Sender: TObject);
    procedure EdCombustivelExit(Sender: TObject);
    procedure BtPesqCombustivelClick(Sender: TObject);
  private
    { Private declarations }
    Tanque : TTanque;
  public
    { Public declarations }
    function ExcluirRegistro(): boolean; override;
    procedure Pesquisar; override;
  end;

var
  FrmListaTanque: TFrmListaTanque;

implementation

{$R *.dfm}

uses UFachadaTanque, UConexao, ULib, UCadTanque, UFachadaCombustivel,
  UCombustivel, UListaCombustivel;

procedure TFrmListaTanque.BtEditarClick(Sender: TObject);
var FormCadTanque : TFrmCadTanque;
begin
  inherited;
  if LDataSet.RecordCount > 0 then
  begin
    try
      FormCadTanque := TFrmCadTanque.Create(self);
      FormCadTanque.Tanque := TFachadaTanque.ObterTanquePeloId(LDataSet.Fields[0].AsInteger);
      FormCadTanque.ShowModal;
      self.Pesquisar;
    finally
      FreeAndNil(FormCadTanque);
    end;
  end;
end;

procedure TFrmListaTanque.BtNovoClick(Sender: TObject);
var FormCadTanque : TFrmCadTanque;
begin
  inherited;
  try
    FormCadTanque := TFrmCadTanque.Create(self);
    FormCadTanque.Tanque := nil;
    FormCadTanque.ShowModal;
    self.Pesquisar;
  finally
    FreeAndNil(FormCadTanque);
  end;
end;

procedure TFrmListaTanque.BtPesqCombustivelClick(Sender: TObject);
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

procedure TFrmListaTanque.EdCombustivelExit(Sender: TObject);
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
        Abort;
      end;
    finally
      FreeAndNil(Combustivel);
    end;
  end;
end;

function TFrmListaTanque.ExcluirRegistro: boolean;
begin
  result := false;
  if TFachadaTanque.ExisteDependencia(LDataSet.Fields[0].AsInteger) then
  begin
    Application.MessageBox('Não é possivel excluido o tanque enquanto houver referencia de abastecimento.', 'Atenção', MB_OK);
  end
  else
    result := TFachadaTanque.excluir(LDataSet.Fields[0].AsInteger);
end;

procedure TFrmListaTanque.FormCreate(Sender: TObject);
begin
  inherited;
  Tanque := TTanque.Create;
end;

procedure TFrmListaTanque.FormShow(Sender: TObject);
begin
  inherited;
  EdCodigo.SetFocus;
  self.Caption := 'Lista de Tanque';
end;

procedure TFrmListaTanque.Pesquisar;
begin
  inherited;
  Tanque.limpar;
  if EdCodigo.text <> '' then
    Tanque.id := strtoint(edCodigo.text);
  if trim(EdCombustivel.text) <> '' then
    Tanque.Combustivel := TFachadaCombustivel.getInstance.ObterCombustivelPeloId(StrToInt(EdCombustivel.Text));
  if trim(EdDescricao.Text) <> '' then
    Tanque.Descricao := trim(EdDescricao.Text);

  LDataSet := TFachadaTanque.GetInstance.ObterListaTanque(Tanque);

end;


end.
