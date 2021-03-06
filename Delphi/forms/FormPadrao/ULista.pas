unit ULista;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UBase, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids, DBClient, IBX.IBQuery;

type
  TFrmLista = class(TFrmBase)
    PnlClient: TPanel;
    PnlBotton: TPanel;
    PnlCima: TPanel;
    BtNovo: TBitBtn;
    BtEditar: TBitBtn;
    BtExcluir: TBitBtn;
    BtSair: TBitBtn;
    DBGridDados: TDBGrid;
    GbPesquisa: TGroupBox;
    BtnPesquisa: TBitBtn;
    procedure BtExcluirClick(Sender: TObject);
    procedure BtnPesquisaClick(Sender: TObject);
    procedure BtSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridDadosDblClick(Sender: TObject);
    procedure BtEditarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    LDataSet : TIBQuery;
    LDataSource : TDataSource;
    ACodigoId : integer;
    function ExcluirRegistro(): boolean; virtual;
    procedure Pesquisar; virtual;
  end;

var
  FrmLista: TFrmLista;

implementation

{$R *.dfm}

procedure TFrmLista.BtEditarClick(Sender: TObject);
begin
  inherited;
  if LDataSet.RecordCount = 0 then
  begin
    Application.MessageBox('N?o h? registros para alterar.', 'Aten??o', MB_OK);
    exit;
  end;
end;

procedure TFrmLista.BtExcluirClick(Sender: TObject);
begin
  inherited;
  if LDataSet.RecordCount > 0 then
  begin
    if Application.MessageBox('Deseja excluir o registro?', 'Aten??o', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      if self.ExcluirRegistro then
      begin
        Self.Pesquisar;
        Application.MessageBox('Registro Excluido com sucesso.', 'Aten??o', MB_OK);
      end;
    end;
  end
  else
    Application.MessageBox('N?o h? registros para excluir.', 'Aten??o', MB_OK);
end;

procedure TFrmLista.BtnPesquisaClick(Sender: TObject);
begin
  inherited;
  Self.Pesquisar;
  LDataSource.DataSet := LDataSet;
  DBGridDados.DataSource := LDataSource;
end;

procedure TFrmLista.BtSairClick(Sender: TObject);
begin
  inherited;
  self.Close;
end;

procedure TFrmLista.DBGridDadosDblClick(Sender: TObject);
begin
  inherited;
  if not LDataSet.IsEmpty then
  begin
    ACodigoId := LDataSet.Fields[0].AsInteger;
    self.Close;
  end;
end;

function TFrmLista.ExcluirRegistro: boolean;
begin
//
end;

procedure TFrmLista.FormCreate(Sender: TObject);
begin
  inherited;
  LDataSet := TIBQuery.Create(self);
  LDataSource := TDataSource.Create(Self);
end;

procedure TFrmLista.FormShow(Sender: TObject);
begin
  inherited;
  self.BtnPesquisa.OnClick(self);
end;

procedure TFrmLista.Pesquisar;
begin
//
end;

end.
