unit UListaBomba;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ULista, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, UBomba, DBClient, IBX.IBQuery;

type
  TFrmListaBomba = class(TFrmLista)
    LbCodigo: TLabel;
    LbDescricao: TLabel;
    LbTanque: TLabel;
    EdCodigo: TEdit;
    EdDescricao: TEdit;
    EdTanque: TEdit;
    BtPesqTanque: TSpeedButton;
    EdNomeTanque: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtEditarClick(Sender: TObject);
    procedure BtNovoClick(Sender: TObject);
    procedure EdTanqueExit(Sender: TObject);
    procedure BtPesqTanqueClick(Sender: TObject);
  private
    { Private declarations }
    Bomba : TBomba;
  public
    { Public declarations }
    function ExcluirRegistro(): boolean; override;
    procedure Pesquisar; override;
  end;

var
  FrmListaBomba: TFrmListaBomba;

implementation

{$R *.dfm}

uses UFachadaBomba, UConexao, ULib, UCadBomba, UFachadaTanque,
  UTanque, UListaTanque;

procedure TFrmListaBomba.BtEditarClick(Sender: TObject);
var FormCadBomba : TFrmCadBomba;
begin
  inherited;
  if LDataSet.RecordCount > 0 then
  begin
    try
      FormCadBomba := TFrmCadBomba.Create(self);
      FormCadBomba.Bomba := TFachadaBomba.ObterBombaPeloId(LDataSet.Fields[0].AsInteger);
      FormCadBomba.ShowModal;
      self.Pesquisar;
    finally
      FreeAndNil(FormCadBomba);
    end;
  end;
end;

procedure TFrmListaBomba.BtNovoClick(Sender: TObject);
var FormCadBomba : TFrmCadBomba;
begin
  inherited;
  try
    FormCadBomba := TFrmCadBomba.Create(self);
    FormCadBomba.Bomba := nil;
    FormCadBomba.ShowModal;
    self.Pesquisar;
  finally
    FreeAndNil(FormCadBomba);
  end;
end;

procedure TFrmListaBomba.BtPesqTanqueClick(Sender: TObject);
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

procedure TFrmListaBomba.EdTanqueExit(Sender: TObject);
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
        Abort;
      end;
    finally
      FreeAndNil(Tanque);
    end;
  end;
end;

function TFrmListaBomba.ExcluirRegistro: boolean;
begin
  result := false;
  if TFachadaBomba.ExisteDependencia(LDataSet.Fields[0].AsInteger) then
  begin
    Application.MessageBox('Não é possivel excluido a bomba enquanto houver referencia de abastecimento.', 'Atenção', MB_OK);
  end
  else
    result := TFachadaBomba.excluir(LDataSet.Fields[0].AsInteger);
end;

procedure TFrmListaBomba.FormCreate(Sender: TObject);
begin
  inherited;
  Bomba := TBomba.Create;
end;

procedure TFrmListaBomba.FormShow(Sender: TObject);
begin
  inherited;
  EdCodigo.SetFocus;
  self.Caption := 'Lista de Bomba';
end;

procedure TFrmListaBomba.Pesquisar;
begin
  inherited;
  Bomba.limpar;
  if EdCodigo.text <> '' then
    Bomba.id := strtoint(edCodigo.text);
  if trim(EdTanque.text) <> '' then
    Bomba.Tanque := TFachadaTanque.getInstance.ObterTanquePeloId(StrToInt(EdTanque.Text));
  if trim(EdDescricao.Text) <> '' then
    Bomba.Descricao := trim(EdDescricao.Text);

  LDataSet := TFachadaBomba.GetInstance.ObterListaBomba(Bomba);

end;


end.
