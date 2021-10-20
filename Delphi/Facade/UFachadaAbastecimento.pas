unit UFachadaAbastecimento;

interface

uses
  SysUtils, Classes, DBClient, URepositorioAbastecimento, UAbastecimento, Ibx.IBQuery;

type
  TFachadaAbastecimento = class
  private
    class var FInstance : TFachadaAbastecimento;
  public
     class function getInstance : TFachadaAbastecimento;
     class function ObterListaAbastecimento(Abastecimento : TAbastecimento) : TIBQuery;overload;
     class function ObterListaAbastecimento() : TList; overload;
     class function ObterAbastecimentoPeloId(Id : integer): TAbastecimento;
     class function ExisteDependencia(Id : integer): Boolean;
     class function Excluir(id : Integer): Boolean;
     class function Incluir(Abastecimento : TAbastecimento): Boolean;
     class function Relatorio(Abastecimento : TAbastecimento): TIBQuery;
  end;
implementation

{ TFachadaPessoa }

class function TFachadaAbastecimento.Excluir(id: Integer): Boolean;
begin
  Result := TRepositorioAbastecimento.getInstance.Excluir(id);
end;

class function TFachadaAbastecimento.ExisteDependencia(Id: integer): Boolean;
begin
  Result := TRepositorioAbastecimento.getInstance.ExisteDependencia(id);
end;

class function TFachadaAbastecimento.getInstance: TFachadaAbastecimento;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TFachadaAbastecimento.Create;
  end;
  Result := FInstance;
end;

class function TFachadaAbastecimento.Incluir(Abastecimento: TAbastecimento): Boolean;
begin
  Result := TRepositorioAbastecimento.getInstance.Incluir(Abastecimento);
end;

class function TFachadaAbastecimento.ObterListaAbastecimento(Abastecimento: TAbastecimento): TIBQuery;
begin
  Result := TRepositorioAbastecimento.getInstance.ObterListaAbastecimento(Abastecimento);
end;

class function TFachadaAbastecimento.ObterListaAbastecimento: TList;
begin
  result := TRepositorioAbastecimento.ObterListaAbastecimento();
end;

class function TFachadaAbastecimento.Relatorio(Abastecimento: TAbastecimento): TIBQuery;
begin
  Result := TRepositorioAbastecimento.getInstance.Relatorio(Abastecimento);
end;

class function TFachadaAbastecimento.ObterAbastecimentoPeloId(Id: integer): TAbastecimento;
begin
  Result := TRepositorioAbastecimento.getInstance.ObterAbastecimentoPeloId(Id);
end;

end.
