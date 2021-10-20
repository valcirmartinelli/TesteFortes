unit UFachadaCombustivel;

interface

uses
  SysUtils, Classes, DBClient, URepositorioCombustivel, UCombustivel, Ibx.IBQuery;

type
  TFachadaCombustivel = class
  private
    class var FInstance : TFachadaCombustivel;
  public
     class function getInstance : TFachadaCombustivel;
     class function ObterListaCombustivel(Combustivel : TCombustivel) : TIBQuery;overload;
     class function ObterListaCombustivel() : TList; overload;
     class function ObterCombustivelPeloId(Id : integer): TCombustivel;
     class function ExisteDependencia(Id : integer): Boolean;
     class function Excluir(id : Integer): Boolean;
     class function Incluir(Combustivel : TCombustivel): Boolean;
     class function Alterar(Combustivel : TCombustivel): Boolean;
  end;
implementation

{ TFachadaPessoa }

class function TFachadaCombustivel.Alterar(Combustivel: TCombustivel): Boolean;
begin
  Result := TRepositorioCombustivel.getInstance.Alterar(Combustivel);
end;

class function TFachadaCombustivel.Excluir(id: Integer): Boolean;
begin
  Result := TRepositorioCombustivel.getInstance.Excluir(id);
end;

class function TFachadaCombustivel.ExisteDependencia(Id: integer): Boolean;
begin
  Result := TRepositorioCombustivel.getInstance.ExisteDependencia(id);
end;

class function TFachadaCombustivel.getInstance: TFachadaCombustivel;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TFachadaCombustivel.Create;
  end;
  Result := FInstance;
end;

class function TFachadaCombustivel.Incluir(Combustivel: TCombustivel): Boolean;
begin
  Result := TRepositorioCombustivel.getInstance.Incluir(Combustivel);
end;

class function TFachadaCombustivel.ObterListaCombustivel(Combustivel: TCombustivel): TIBQuery;
begin
  Result := TRepositorioCombustivel.getInstance.ObterListaCombustivel(Combustivel);
end;

class function TFachadaCombustivel.ObterListaCombustivel: TList;
begin
  result := TRepositorioCombustivel.ObterListaCombustivel();
end;

class function TFachadaCombustivel.ObterCombustivelPeloId(Id: integer): TCombustivel;
begin
  Result := TRepositorioCombustivel.getInstance.ObterCombustivelPeloId(Id);
end;

end.
