unit UCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UBase, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons;

type
  TAcao = (acNenhuma,acAlterar, acIncluir, acExcluir, acPesquisar, acVisualizar);

  TFrmCadastro = class(TFrmBase)
    PnlBotton: TPanel;
    PnlClient: TPanel;
    BtCancelar: TBitBtn;
    BtConfirmar: TBitBtn;
    procedure BtConfirmarClick(Sender: TObject);
    procedure BtCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    Acao : TAcao;
   function Atualizar(): boolean; virtual;
   function Incluir(): boolean; virtual;
   function ValidaDados(): boolean; virtual;
   procedure ControleParaObjeto; virtual;
   procedure ObjetoParaControle; virtual;
    { Public declarations }
  end;

var
  FrmCadastro: TFrmCadastro;

implementation

{$R *.dfm}



function TFrmCadastro.Atualizar: boolean;
begin

end;

procedure TFrmCadastro.BtCancelarClick(Sender: TObject);
begin
  inherited;
  if Application.MessageBox('Deseja cancelar as alterações?', 'Atenção', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    self.ModalResult := mrCancel;
  end;
end;

procedure TFrmCadastro.BtConfirmarClick(Sender: TObject);
begin
  inherited;
  self.ModalResult := mrNone;
  if ValidaDados then
  begin
    ControleParaObjeto;
    if ((self.Acao = acAlterar) and (self.Atualizar)) or
       ((Self.Acao = acIncluir) and (self.Incluir)) then
    begin
      Self.ModalResult := mrOk;
      Self.Close;
    end;
  end;
end;

procedure TFrmCadastro.ControleParaObjeto;
begin

end;

function TFrmCadastro.Incluir: boolean;
begin

end;

procedure TFrmCadastro.ObjetoParaControle;
begin

end;

function TFrmCadastro.ValidaDados: boolean;
begin

end;

end.
