unit UListaCombustivel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ULista, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, UCombustivel, DBClient, IBX.IBQuery;

type
  TFrmListaCombustivel = class(TFrmLista)
    LbCodigo: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EdCodigo: TEdit;
    EdDescricao: TEdit;
    EdSigla: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtEditarClick(Sender: TObject);
    procedure BtNovoClick(Sender: TObject);
  private
    { Private declarations }
    Combustivel : TCombustivel;
  public
    { Public declarations }
    function ExcluirRegistro(): boolean; override;
    procedure Pesquisar; override;
  end;

var
  FrmListaCombustivel: TFrmListaCombustivel;

implementation

{$R *.dfm}

uses UFachadaCombustivel, UConexao, ULib, UCadCombustivel;

procedure TFrmListaCombustivel.BtEditarClick(Sender: TObject);
var FormCadCombustivel : TFrmCadCombustivel;
begin
  inherited;
  if LDataSet.RecordCount > 0 then
  begin
    try
      FormCadCombustivel := TFrmCadCombustivel.Create(self);
      FormCadCombustivel.Combustivel := TFachadaCombustivel.ObterCombustivelPeloId(LDataSet.Fields[0].AsInteger);
      FormCadCombustivel.ShowModal;
      self.Pesquisar;
    finally
      FreeAndNil(FormCadCombustivel);
    end;
  end;
end;

procedure TFrmListaCombustivel.BtNovoClick(Sender: TObject);
var FormCadCombustivel : TFrmCadCombustivel;
begin
  inherited;
  try
    FormCadCombustivel := TFrmCadCombustivel.Create(self);
    FormCadCombustivel.Combustivel := nil;
    FormCadCombustivel.ShowModal;
    self.Pesquisar;
  finally
    FreeAndNil(FormCadCombustivel);
  end;
end;

function TFrmListaCombustivel.ExcluirRegistro: boolean;
begin
  result := false;
  if TFachadaCombustivel.ExisteDependencia(LDataSet.Fields[0].AsInteger) then
  begin
    Application.MessageBox('Não é possivel excluido o combustivel enquanto houver referencia com tanque.', 'Atenção', MB_OK);
  end
  else
    result := TFachadaCombustivel.excluir(LDataSet.Fields[0].AsInteger);
end;

procedure TFrmListaCombustivel.FormCreate(Sender: TObject);
begin
  inherited;
  Combustivel := TCombustivel.Create;
end;

procedure TFrmListaCombustivel.FormShow(Sender: TObject);
begin
  inherited;
  EdCodigo.SetFocus;
  self.Caption := 'Lista de combustivel';
end;

procedure TFrmListaCombustivel.Pesquisar;
begin
  inherited;
  Combustivel.limpar;
  if EdCodigo.text <> '' then
    Combustivel.id := strtoint(edCodigo.text);
  if trim(EdSigla.text) <> '' then
    Combustivel.Sigla := EdSigla.Text;
  if trim(EdDescricao.Text) <> '' then
    Combustivel.Descricao := trim(EdDescricao.Text);

  LDataSet := TFachadaCombustivel.GetInstance.ObterListaCombustivel(Combustivel);

end;


end.
