unit UListaAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ULista, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, UAbastecimento, DBClient, IBX.IBQuery;

type
  TFrmListaAbastecimento = class(TFrmLista)
    LbCodigo: TLabel;
    LbData: TLabel;
    LbBomba: TLabel;
    EdCodigo: TEdit;
    EdData: TEdit;
    EdBomba: TEdit;
    BtPesqBomba: TSpeedButton;
    EdNomeBomba: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtEditarClick(Sender: TObject);
    procedure BtNovoClick(Sender: TObject);
    procedure EdBombaExit(Sender: TObject);
    procedure BtPesqBombaClick(Sender: TObject);
    procedure EdDataExit(Sender: TObject);
  private
    { Private declarations }
    Abastecimento : TAbastecimento;
  public
    { Public declarations }
    function ExcluirRegistro(): boolean; override;
    procedure Pesquisar; override;
  end;

var
  FrmListaAbastecimento: TFrmListaAbastecimento;

implementation

{$R *.dfm}

uses UConexao, ULib, UCadAbastecimento, UFachadaAbastecimento,
   UListaBomba, UBomba, UFachadaBomba;

procedure TFrmListaAbastecimento.BtEditarClick(Sender: TObject);
var FormCadAbastecimento : TFrmCadAbastecimento;
begin
  inherited;
  if LDataSet.RecordCount > 0 then
  begin
    try
      FormCadAbastecimento := TFrmCadAbastecimento.Create(self);
      FormCadAbastecimento.Abastecimento := TFachadaAbastecimento.ObterAbastecimentoPeloId(LDataSet.Fields[0].AsInteger);
      FormCadAbastecimento.ShowModal;
      self.Pesquisar;
    finally
      FreeAndNil(FormCadAbastecimento);
    end;
  end;
end;

procedure TFrmListaAbastecimento.BtNovoClick(Sender: TObject);
var FormCadAbastecimento : TFrmCadAbastecimento;
begin
  inherited;
  try
    FormCadAbastecimento := TFrmCadAbastecimento.Create(self);
    FormCadAbastecimento.Abastecimento := nil;
    FormCadAbastecimento.ShowModal;
    self.Pesquisar;
  finally
    FreeAndNil(FormCadAbastecimento);
  end;
end;

procedure TFrmListaAbastecimento.BtPesqBombaClick(Sender: TObject);
var FormListBomba : TFrmListaBomba;
begin
  inherited;
  try
    FormListBomba := TFrmListaBomba.Create(self);
    FormListBomba.ShowModal;
    if FormListBomba.ACodigoId > 0 then
    begin
      EdBomba.Text := IntToStr(FormListBomba.ACodigoId);
      EdBomba.OnExit(self);
    end;
  finally
    FreeAndNil(FormListBomba);
  end;
end;

procedure TFrmListaAbastecimento.EdBombaExit(Sender: TObject);
var Bomba : TBomba;
begin
  inherited;
  EdNomeBomba.Clear;
  if trim(EdBomba.Text) <> '' then
  begin
    try
      Bomba := TFachadaBomba.getInstance.ObterBombaPeloId(StrToInt(EdBomba.Text));
      if Bomba.Descricao <> '' then
        EdNomeBomba.Text := Bomba.Descricao
      else
      begin
        Application.MessageBox('Bomba não encontrada.', 'Atenção', MB_OK);
        EdBomba.Clear;
        EdNomeBomba.Clear;
        abort;
      end;
    finally
      FreeAndNil(Bomba);
    end;
  end;
end;

procedure TFrmListaAbastecimento.EdDataExit(Sender: TObject);
begin
  inherited;
  if Trim(EdData.Text) <> '' then
  begin
    if StrToDateDef(EdData.Text,0) = 0 then
    begin
      ShowMessage('Data inválida');
      EdData.SetFocus;
    end;
  end;
end;

function TFrmListaAbastecimento.ExcluirRegistro: boolean;
begin
  result := false;
end;

procedure TFrmListaAbastecimento.FormCreate(Sender: TObject);
begin
  inherited;
  Abastecimento := TAbastecimento.Create;
end;

procedure TFrmListaAbastecimento.FormShow(Sender: TObject);
begin
  inherited;
  EdCodigo.SetFocus;
  self.Caption := 'Lista de Abastecimento';
end;

procedure TFrmListaAbastecimento.Pesquisar;
begin
  inherited;
  Abastecimento.limpar;
  if EdCodigo.text <> '' then
    Abastecimento.id := strtoint(edCodigo.text);
  if trim(EdBomba.text) <> '' then
    Abastecimento.Bomba := TFachadaBomba.getInstance.ObterBombaPeloId(StrToInt(EdBomba.Text));
  if trim(EdData.Text) <> '' then
    Abastecimento.Data := StrToDateDef(trim(EdData.Text),0);

  LDataSet := TFachadaAbastecimento.GetInstance.ObterListaAbastecimento(Abastecimento);

end;


end.
