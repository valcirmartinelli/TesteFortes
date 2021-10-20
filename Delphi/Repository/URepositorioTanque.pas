unit URepositorioTanque;

interface

uses
   DBClient,  Classes, UTanque, UCombustivel, SysUtils, DB, Ibx.IBDatabase, Ibx.IBCustomDataSet, Ibx.IBQuery;

Type
  TRepositorioTanque = class
  private
   class var AQuery : TIBQuery;
   class var FRepository : TRepositorioTanque;
  public
    class function getInstance : TRepositorioTanque;
    class function getAtributoTanque : string;
    class function getFiltroTanque(Tanque : TTanque) : string;
    class function ObterListaTanque(Tanque : TTanque) : TIBQuery; overload;
    class function ObterTanquePeloId(Id : integer): TTanque;
    class function ObterListaTanque(): TList; overload;
    class function AtribuirTanque(Qry : TIBQuery): TTanque;
    class function ExisteDependencia(Id : integer): Boolean;
    class function Excluir(id : Integer): Boolean;
    class function Incluir(Tanque : TTanque): Boolean;
    class function Alterar(Tanque : TTanque): Boolean;
  end;

implementation

{ TRepositorioPessoa }

uses UConexao, URepositorioCombustivel;


class function TRepositorioTanque.Alterar(Tanque: TTanque): Boolean;
var AQry : TIBQuery;
  sSql :  string;
begin
  try
    try
      sSql := ' UPDATE Tanque '+
              ' SET ID_COMBUSTIVEL = ' + IntToStr(Tanque.Combustivel.Id) +
              ' , DESCRICAO = ' + QuotedStr(Tanque.Descricao) +
              ' WHERE ID = ' + IntToStr(Tanque.Id);

      AQry := TIBQuery.Create(nil);
      AQry.Database := DmConexao.IBDatabase;
      AQry.Transaction := DmConexao.IBTransaction;
      AQry.SQL.Text := sSql;
      AQry.ExecSQL;
      AQry.Transaction.CommitRetaining;
      result := true;
    except
      AQry.Transaction.RollbackRetaining;
      Result := false;
    end;
  finally
    freeandnil(AQry);
  end;
end;

class function TRepositorioTanque.AtribuirTanque(Qry: TIBQuery): TTanque;
var Tanque : TTanque;
begin
  Tanque := TTanque.Create;
  Tanque.Limpar;
  Result := Tanque;
  if Qry.IsEmpty then
    Exit;

  Tanque.Id          := Qry.FieldByName('ID').AsInteger;
  Tanque.Combustivel := TRepositorioCombustivel.getInstance.ObterCombustivelPeloId(Qry.FieldByName('ID_COMBUSTIVEL').AsInteger);
  Tanque.Descricao   := Qry.FieldByName('DESCRICAO').AsString;
  Result := Tanque;
end;

class function TRepositorioTanque.Excluir(id: Integer): Boolean;
var AQry : TIBQuery;
begin
  try
    try
      AQry := TIBQuery.Create(nil);
      AQry.Database := DmConexao.IBDatabase;
      AQry.Transaction := DmConexao.IBTransaction;
      AQry.SQL.Text := 'DELETE FROM Tanque WHERE ID = ' + IntToStr(Id);
      AQry.ExecSQL;
      AQry.Transaction.CommitRetaining;
      result := true;
    except
      AQry.Transaction.RollbackRetaining;
      Result := false;
    end;
  finally
    freeandnil(AQry);
  end;
end;

class function TRepositorioTanque.ExisteDependencia(Id: integer): Boolean;
var AQry : TIBQuery;
begin
  // REESCREVER

  try
    AQry := TIBQuery.Create(nil);
    AQry.Database := DmConexao.IBDatabase;
    AQry.SQL.Text := 'SELECT COUNT(ID) QTDE FROM ABASTECIMENTO WHERE ID_TANQUE = ' + IntToStr(Id);
    AQry.Open;
    Result := AQry.FieldByName('QTDE').AsInteger > 0;
  finally
    freeandnil(AQry);
  end;
end;

class function TRepositorioTanque.getAtributoTanque: string;
begin
  result := ' ID, ID_COMBUSTIVEL, DESCRICAO ';
end;

class function TRepositorioTanque.getFiltroTanque(Tanque: TTanque): string;
var sResult : string;
begin
  sResult := ' where 1 = 1 ';
  if Tanque.Id > 0 then
    sResult := sResult +' AND Tanque.ID = ' + IntToStr(Tanque.Id);
  if Tanque.Combustivel.Id > 0 then
    sResult := sResult +'AND Tanque.ID_COMBUSTIVEL = ' + IntToStr(Tanque.Combustivel.Id);

  if Tanque.Descricao <> '' then
  begin
    if Pos('%', Tanque.Descricao) > 0 then
      sResult := sResult +' AND UPPER(Tanque.DESCRICAO) LIKE ' + QuotedStr(UpperCase(Tanque.Descricao))
    else
      sResult := sResult +' AND UPPER(Tanque.DESCRICAO) = ' + QuotedStr(UpperCase(Tanque.Descricao))
  end;

  Result := sResult;
end;

class function TRepositorioTanque.getInstance: TRepositorioTanque;
begin
  if not Assigned(FRepository) then
  begin
    FRepository := TRepositorioTanque.Create;
    AQuery := TIBQuery.Create(nil);
    AQuery.Database := DmConexao.IBDatabase;
  end;
  Result := FRepository;
end;

class function TRepositorioTanque.Incluir(Tanque: TTanque): Boolean;
var AQry : TIBQuery;
    sSql :  string;
begin
  try
    try
      sSql := ' INSERT INTO Tanque (ID_COMBUSTIVEL, DESCRICAO) '+
              ' values (' + IntToStr(Tanque.Combustivel.Id) + ', ' +
                            QuotedStr(Tanque.Descricao) + ' )';
      AQry := TIBQuery.Create(nil);
      AQry.Database := DmConexao.IBDatabase;
      AQry.Transaction := DmConexao.IBTransaction;
      AQry.SQL.Text := sSql;
      AQry.ExecSQL;
      AQry.Transaction.CommitRetaining;
      result := true;
    except
      AQry.Transaction.RollbackRetaining;
      Result := false;
    end;
  finally
    freeandnil(AQry);
  end;

end;

class function TRepositorioTanque.ObterListaTanque(Tanque: TTanque): TIBQuery;
var SSql : string;
begin
  SSql := ' SELECT ' + getAtributoTanque + ' FROM Tanque' + getFiltroTanque(Tanque);
  AQuery.Close;
  AQuery.SQL.Text := SSql;
  AQuery.Open;
  Result := AQuery;
end;

class function TRepositorioTanque.ObterListaTanque: TList;
var SSql : string;
  ListTanque : TList;
  AQry : TIBQuery;
begin
  SSql := ' SELECT ' + getAtributoTanque + ' FROM Tanque';

  AQry := TIBQuery.Create(nil);
  AQry.Database := DmConexao.IBDatabase;
  AQry.Transaction := DmConexao.IBTransaction;
  AQry.SQL.Text := sSql;
  AQry.Open;
  AQry.First;

  ListTanque := TList.Create;
  while not AQry.Eof do
  begin
    ListTanque.Add(AtribuirTanque(AQry));
    AQry.Next;
  end;
  Result := ListTanque;
end;

class function TRepositorioTanque.ObterTanquePeloId(Id: integer): TTanque;
var SSql : string;
begin
  SSql := ' SELECT ' + getAtributoTanque + ' FROM Tanque WHERE ID = ' + inttoStr(Id);
  AQuery.Close;
  AQuery.SQL.Text := SSql;
  AQuery.Open;
  Result := AtribuirTanque(AQuery);
end;

end.
