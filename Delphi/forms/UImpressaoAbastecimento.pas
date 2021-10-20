unit UImpressaoAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLPreviewForm, RLReport, Data.DB,
  Datasnap.DBClient;

type
  TFrmImpressaoAbastecimento = class(TForm)
    RLReport1: TRLReport;
    RLGroup1: TRLGroup;
    DsAbastecimento: TDataSource;
    CdsAbastecimento: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmImpressaoAbastecimento: TFrmImpressaoAbastecimento;

implementation

{$R *.dfm}

end.
