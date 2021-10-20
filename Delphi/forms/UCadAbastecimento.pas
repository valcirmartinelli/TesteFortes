unit UCadAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadastro, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, UAbastecimento;

type
  TFrmCadAbastecimento = class(TFrmCadastro)
    EdBomba: TEdit;
    LbBomba: TLabel;
    EdLitro: TEdit;
    LbLitro: TLabel;
    BtPesqBomba: TSpeedButton;
    EdNomeBomba: TEdit;
    LbValorUnit: TLabel;
    EdValorUnit: TEdit;
    LbValorTotal: TLabel;
    EdValorTotal: TEdit;
    EdValorImposto: TEdit;
    LbImposto: TLabel;
    procedure FormShow(Sender: TObject);
    procedure EdBombaExit(Sender: TObject);
    procedure BtPesqBombaClick(Sender: TObject);
    procedure EdLitroExit(Sender: TObject);
    procedure EdLitroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
   function Incluir(): boolean; override;
   function ValidaDados(): boolean; override;
   procedure ControleParaObjeto; override;
   procedure ObjetoParaControle; override;
  public
    { Public declarations }
    Abastecimento : TAbastecimento;
  end;

var
  FrmCadAbastecimento: TFrmCadAbastecimento;

implementation

{$R *.dfm}

uses UFachadaBomba, ULib, UListaBomba, UBomba, UFachadaAbastecimento;

procedure TFrmCadAbastecimento.BtPesqBombaClick(Sender: TObject);
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

procedure TFrmCadAbastecimento.ControleParaObjeto;
begin
  inherited;
  Abastecimento.Bomba         := TFachadaBomba.getInstance.ObterBombaPeloId(StrToInt(EdBomba.Text));
  Abastecimento.QtdeLitro     := StrToFloatDef(EdLitro.Text,0);
  Abastecimento.ValorUnit     := StrToFloatDef(EdValorUnit.Text,0);
  Abastecimento.ValorImposto  := StrToFloatDef(EdValorImposto.Text,0);
  Abastecimento.ValorTotal    := StrToFloatDef(EdValorTotal.Text,0);

end;

procedure TFrmCadAbastecimento.EdBombaExit(Sender: TObject);
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

procedure TFrmCadAbastecimento.EdLitroExit(Sender: TObject);
var Bomba : TBomba;
    vvalorTotal : Double;
    vvalorImposto : Double;
begin
  inherited;
  if StrToFloatDef(EdLitro.Text,0) > 0 then
  begin
    Bomba := TFachadaBomba.ObterBombaPeloId(StrToInt(EdBomba.Text));
    try
      vvalorTotal         := Bomba.Tanque.Combustivel.Valor * StrToFloat(EdLitro.Text);
      vvalorImposto       := vvalorTotal * 0.13;
      EdValorUnit.Text    := FloatToStr(Bomba.Tanque.Combustivel.Valor);
      EdValorTotal.Text   := FloatToStr(vvalorTotal);
      EdValorImposto.Text := FloatToStr(vvalorImposto);
    finally
      FreeAndNil(Bomba);
    end;
  end
  else
  begin
    EdValorUnit.Clear;
    EdValorUnit.Clear;
    EdValorTotal.Clear;
    EdValorImposto.Clear;
  end;
end;

procedure TFrmCadAbastecimento.EdLitroKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if trim(EdBomba.Text) = '' then
  begin
    key := 0;
    EdLitro.Clear;
    ShowMessage('Informe a bomba.');
    EdBomba.SetFocus;
  end;
end;

procedure TFrmCadAbastecimento.FormShow(Sender: TObject);
begin
  inherited;
  self.Caption := 'Cadastro de Tanque';
  if self.Abastecimento <> nil then
  begin
    self.Acao := acVisualizar;
    ObjetoParaControle;
  end
  else
  begin
    Abastecimento := TAbastecimento.Create;
    Abastecimento.Limpar;
    Self.Acao := acIncluir;
  end;
  self.EdBomba.SetFocus;
end;

function TFrmCadAbastecimento.Incluir: boolean;
begin
  result := TFachadaAbastecimento.Incluir(Self.Abastecimento);
end;

procedure TFrmCadAbastecimento.ObjetoParaControle;
begin
  inherited;
  EdBomba.Text        := IntToStr(Abastecimento.Bomba.Id);
  EdNomeBomba.Text    := Abastecimento.Bomba.Descricao;
  EdLitro.Text        := FloatToStr(Abastecimento.QtdeLitro);
  EdValorUnit.Text    := FloatToStr(Abastecimento.ValorUnit);
  EdValorTotal.Text   := FloatToStr(Abastecimento.ValorTotal);
  EdValorImposto.Text := FloatToStr(Abastecimento.ValorImposto);

  if self.Acao = acVisualizar then
  begin
    EdBomba.ReadOnly          := true;
    BtPesqBomba.Enabled       := false;
    EdLitro.ReadOnly          := true;
    EdValorUnit.ReadOnly      := true;
    EdValorTotal.ReadOnly     := true;
    EdValorImposto.ReadOnly   := true;
  end;

end;

function TFrmCadAbastecimento.ValidaDados: boolean;
begin
  result := true;

  if trim(EdBomba.Text) = '' then
  begin
    Application.MessageBox('A bomba deve ser informada.', 'Atenção', MB_OK);
    result := false;
  end
  else if trim(EdLitro.Text) = '' then
  begin
    Application.MessageBox('A quantidade de combustivel deve ser informado.', 'Atenção', MB_OK);
    result := false;
  end
  else if StrToFloatDef(trim(EdValorUnit.Text),0) <= 0 then
  begin
    Application.MessageBox('O valor deve ser maior que zero.', 'Atenção', MB_OK);
    result := false;
  end;
end;

end.
