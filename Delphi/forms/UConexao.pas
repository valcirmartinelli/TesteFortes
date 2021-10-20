unit UConexao;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBDatabase, IBX.IBCustomDataSet,
  IBX.IBQuery;

type
  TDmConexao = class(TDataModule)
    IBDatabase: TIBDatabase;
    Qry: TIBQuery;
    DS: TDataSource;
    IBTransaction: TIBTransaction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmConexao: TDmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
