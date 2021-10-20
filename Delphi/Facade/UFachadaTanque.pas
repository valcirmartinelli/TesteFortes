unit UFachadaTanque;

interface

uses
  SysUtils, Classes, DBClient, URepositorioTanque, UTanque, Ibx.IBQuery;

type
  TFachadaTanque = class
  private
    class var FInstance : TFachadaTanque;
  public
     class function getInstance : TFachadaTanque;
     class function ObterListaTanque(Tanque : TTanque) : TIBQuery;overload;
     class function ObterListaTanque() : TList; overload;
     class function ObterTanquePeloId(Id : integer): TTanque;
     class function ExisteDependencia(Id : integer): Boolean;
     class function Excluir(id : Integer): Boolean;
     class function Incluir(Tanque : TTanque): Boolean;
     class function Alterar(Tanque : TTanque): Boolean;
  end;
implementation

{ TFachadaPessoa }

class function TFachadaTanque.Alterar(Tanque: TTanque): Boolean;
begin
  Result := TRepositorioTanque.getInstance.Alterar(Tanque);
end;

class function TFachadaTanque.Excluir(id: Integer): Boolean;
begin
  Result := TRepositorioTanque.getInstance.Excluir(id);
end;

class function TFachadaTanque.ExisteDependencia(Id: integer): Boolean;
begin
  Result := TRepositorioTanque.getInstance.ExisteDependencia(id);
end;

class function TFachadaTanque.getInstance: TFachadaTanque;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TFachadaTanque.Create;
  end;
  Result := FInstance;
end;

class function TFachadaTanque.Incluir(Tanque: TTanque): Boolean;
begin
  Result := TRepositorioTanque.getInstance.Incluir(Tanque);
end;

class function TFachadaTanque.ObterListaTanque(Tanque: TTanque): TIBQuery;
begin
  Result := TRepositorioTanque.getInstance.ObterListaTanque(Tanque);
end;

class function TFachadaTanque.ObterListaTanque: TList;
begin
  result := TRepositorioTanque.ObterListaTanque();
end;

class function TFachadaTanque.ObterTanquePeloId(Id: integer): TTanque;
begin
  Result := TRepositorioTanque.getInstance.ObterTanquePeloId(Id);
end;

end.
