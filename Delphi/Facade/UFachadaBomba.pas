unit UFachadaBomba;

interface

uses
  SysUtils, Classes, DBClient, URepositorioBomba, UBomba, Ibx.IBQuery;

type
  TFachadaBomba = class
  private
    class var FInstance : TFachadaBomba;
  public
     class function getInstance : TFachadaBomba;
     class function ObterListaBomba(Bomba : TBomba) : TIBQuery;overload;
     class function ObterListaBomba() : TList; overload;
     class function ObterBombaPeloId(Id : integer): TBomba;
     class function ExisteDependencia(Id : integer): Boolean;
     class function Excluir(id : Integer): Boolean;
     class function Incluir(Bomba : TBomba): Boolean;
     class function Alterar(Bomba : TBomba): Boolean;
  end;
implementation

{ TFachadaPessoa }

class function TFachadaBomba.Alterar(Bomba: TBomba): Boolean;
begin
  Result := TRepositorioBomba.getInstance.Alterar(Bomba);
end;

class function TFachadaBomba.Excluir(id: Integer): Boolean;
begin
  Result := TRepositorioBomba.getInstance.Excluir(id);
end;

class function TFachadaBomba.ExisteDependencia(Id: integer): Boolean;
begin
  Result := TRepositorioBomba.getInstance.ExisteDependencia(id);
end;

class function TFachadaBomba.getInstance: TFachadaBomba;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TFachadaBomba.Create;
  end;
  Result := FInstance;
end;

class function TFachadaBomba.Incluir(Bomba: TBomba): Boolean;
begin
  Result := TRepositorioBomba.getInstance.Incluir(Bomba);
end;

class function TFachadaBomba.ObterListaBomba(Bomba: TBomba): TIBQuery;
begin
  Result := TRepositorioBomba.getInstance.ObterListaBomba(Bomba);
end;

class function TFachadaBomba.ObterListaBomba: TList;
begin
  result := TRepositorioBomba.ObterListaBomba();
end;

class function TFachadaBomba.ObterBombaPeloId(Id: integer): TBomba;
begin
  Result := TRepositorioBomba.getInstance.ObterBombaPeloId(Id);
end;

end.
