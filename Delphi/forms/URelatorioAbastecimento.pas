unit URelatorioAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UBase, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, RLReport, Ibx.IBQuery;

type
  TFrmRelatorio = class(TFrmBase)
    PnlBotton: TPanel;
    BtCancelar: TBitBtn;
    BtConfirmar: TBitBtn;
    PnlClient: TPanel;
    LbTanque: TLabel;
    EdTanque: TEdit;
    BtPesqTanque: TSpeedButton;
    EdNomeTanque: TEdit;
    LbBomba: TLabel;
    EdBomba: TEdit;
    BtPesqBomba: TSpeedButton;
    EdNomeBomba: TEdit;
    GroupBox1: TGroupBox;
    LbData: TLabel;
    EdDataIni: TEdit;
    EdDataFim: TEdit;
    Label1: TLabel;
    CdsAbastecimento: TClientDataSet;
    DsAbastecimento: TDataSource;
    RLReport1: TRLReport;
    RLBand2: TRLBand;
    CdsAbastecimentoTANQUE: TStringField;
    CdsAbastecimentoBOMBA: TStringField;
    CdsAbastecimentoDATA: TDateTimeField;
    CdsAbastecimentoVALOR_TOTAL: TFloatField;
    RLGroup1: TRLGroup;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLBand3: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel4: TRLLabel;
    RLDBText4: TRLDBText;
    RLBand4: TRLBand;
    RLLabel5: TRLLabel;
    RLBand5: TRLBand;
    RLDraw1: TRLDraw;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDraw2: TRLDraw;
    RLLabel6: TRLLabel;
    procedure EdTanqueExit(Sender: TObject);
    procedure BtPesqTanqueClick(Sender: TObject);
    procedure EdBombaExit(Sender: TObject);
    procedure BtPesqBombaClick(Sender: TObject);
    procedure EdDataIniExit(Sender: TObject);
    procedure EdDataFimExit(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    function ValidarInformacao(): boolean;
    procedure Imprimir;
  public
    { Public declarations }
  end;

var
  FrmRelatorio: TFrmRelatorio;

implementation

{$R *.dfm}

uses UListaBomba, UListaTanque, UBomba, UTanque, UFachadaBomba, UFachadaTanque,
  UAbastecimento, UFachadaAbastecimento;

procedure TFrmRelatorio.BtConfirmarClick(Sender: TObject);
begin
  inherited;
  if Self.ValidarInformacao then
    self.Imprimir;
end;

procedure TFrmRelatorio.BtPesqBombaClick(Sender: TObject);
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

procedure TFrmRelatorio.BtPesqTanqueClick(Sender: TObject);
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

procedure TFrmRelatorio.EdBombaExit(Sender: TObject);
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

procedure TFrmRelatorio.EdDataIniExit(Sender: TObject);
begin
  inherited;
  if Trim(EdDataIni.Text) <> '' then
  begin
    if StrToDateTimeDef(EdDataIni.Text,0) = 0 then
    begin
      ShowMessage('Data inválida');
      EdDataIni.SetFocus;
    end;
  end;
end;

procedure TFrmRelatorio.EdDataFimExit(Sender: TObject);
begin
  inherited;
  if Trim(EdDataFim.Text) <> '' then
  begin
    if StrToDateTimeDef(EdDataFim.Text,0) = 0 then
    begin
      ShowMessage('Data inválida');
      EdDataFim.SetFocus;
    end;
  end;
end;

procedure TFrmRelatorio.EdTanqueExit(Sender: TObject);
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

procedure TFrmRelatorio.Imprimir;
var Abastecimento : TAbastecimento;
    Qry : TIBQuery;
begin
    Abastecimento := TAbastecimento.Create;
    if EdBomba.Text <> '' then
      Abastecimento.Bomba := TFachadaBomba.getInstance.ObterBombaPeloId(StrToInt(EdBomba.Text));

    if EdTanque.Text <> '' then
      Abastecimento.Bomba.Tanque := TFachadaTanque.getInstance.ObterTanquePeloId(StrToInt(EdTanque.Text));

    if StrToDateTimeDef(EdDataIni.Text,0) > 0 then
      Abastecimento.Data := StrToDateTime(EdDataIni.Text);

    if StrToDateTimeDef(EdDataFim.Text,0) > 0 then
      Abastecimento.DataFim := StrToDateTime(EdDataFim.Text);

    Qry := TFachadaAbastecimento.Relatorio(Abastecimento);

    CdsAbastecimento.EmptyDataSet;
    Qry.First;
    while not Qry.Eof do
    begin
      CdsAbastecimento.Insert;
      CdsAbastecimento.FieldByName('TANQUE').AsString        := Qry.FieldByName('TANQUE').AsString;
      CdsAbastecimento.FieldByName('BOMBA').AsString         := Qry.FieldByName('BOMBA').AsString;
      CdsAbastecimento.FieldByName('DATA').AsString          := FormatDateTime('dd/MM/yyyy', Qry.FieldByName('DATA').AsDateTime);
      CdsAbastecimento.FieldByName('VALOR_TOTAL').AsString   := Qry.FieldByName('VALOR_TOTAL').AsString;
      CdsAbastecimento.Post;
      Qry.Next;
    end;
    CdsAbastecimento.IndexFieldNames := 'DATA';
    RLReport1.PreviewModal;
end;

function TFrmRelatorio.ValidarInformacao: boolean;
begin
  result := true;
  if StrToDateDef(EdDataIni.Text,0) < StrToDateDef(EdDataFim.Text,0) then
  begin
    ShowMessage('Data inicial deve ser menor que a data final');
    EdDataIni.SetFocus;
    Result := false;
  end
end;

end.
