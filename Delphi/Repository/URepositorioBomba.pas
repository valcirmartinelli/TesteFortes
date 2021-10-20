unit URepositorioBomba;

interface

uses
   DBClient,  Classes, UBomba, SysUtils, DB, Ibx.IBDatabase, Ibx.IBCustomDataSet, Ibx.IBQuery;

Type
  TRepositorioBomba = class
  private
   class var AQuery : TIBQuery;
   class var FRepository : TRepositorioBomba;
  public
    class function getInstance : TRepositorioBomba;
    class function getAtributoBomba : string;
    class function getFiltroBomba(Bomba : TBomba) : string;
    class function ObterListaBomba(Bomba : TBomba) : TIBQuery; overload;
    class function ObterBombaPeloId(Id : integer): TBomba;
    class function ObterListaBomba(): TList; overload;
    class function AtribuirBomba(Qry : TIBQuery): TBomba;
    class function ExisteDependencia(Id : integer): Boolean;
    class function Excluir(id : Integer): Boolean;
    class function Incluir(Bomba : TBomba): Boolean;
    class function Alterar(Bomba : TBomba): Boolean;
  end;

implementation

{ TRepositorioPessoa }

uses UConexao, URepositorioTanque;


class function TRepositorioBomba.Alterar(Bomba: TBomba): Boolean;
var AQry : TIBQuery;
  sSql :  string;
begin
  try
    try
      sSql := ' UPDATE Bomba '+
              ' SET ID_TANQUE = ' + IntToStr(Bomba.Tanque.Id) +
              ' , DESCRICAO = ' + QuotedStr(Bomba.Descricao) +
              ' WHERE ID = ' + IntToStr(Bomba.Id);

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

class function TRepositorioBomba.AtribuirBomba(Qry: TIBQuery): TBomba;
var Bomba : TBomba;
begin
  Bomba := TBomba.Create;
  Bomba.Limpar;
  Result := Bomba;
  if Qry.IsEmpty then
    Exit;

  Bomba.Id          := Qry.FieldByName('ID').AsInteger;
  Bomba.Tanque      := TRepositorioTanque.getInstance.ObterTanquePeloId(Qry.FieldByName('ID_TANQUE').AsInteger);
  Bomba.Descricao   := Qry.FieldByName('DESCRICAO').AsString;
  Result := Bomba;
end;

class function TRepositorioBomba.Excluir(id: Integer): Boolean;
var AQry : TIBQuery;
begin
  try
    try
      AQry := TIBQuery.Create(nil);
      AQry.Database := DmConexao.IBDatabase;
      AQry.Transaction := DmConexao.IBTransaction;
      AQry.SQL.Text := 'DELETE FROM Bomba WHERE ID = ' + IntToStr(Id);
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

class function TRepositorioBomba.ExisteDependencia(Id: integer): Boolean;
var AQry : TIBQuery;
begin
  // REESCREVER

  try
    AQry := TIBQuery.Create(nil);
    AQry.Database := DmConexao.IBDatabase;
    AQry.SQL.Text := 'SELECT COUNT(ID) QTDE FROM ABASTECIMENTO WHERE ID_BOMBA = ' + IntToStr(Id);
    AQry.Open;
    Result := AQry.FieldByName('QTDE').AsInteger > 0;
  finally
    freeandnil(AQry);
  end;
end;

class function TRepositorioBomba.getAtributoBomba: string;
begin
  result := ' ID, ID_TANQUE, DESCRICAO ';
end;

class function TRepositorioBomba.getFiltroBomba(Bomba: TBomba): string;
var sResult : string;
begin
  sResult := ' where 1 = 1 ';
  if Bomba.Id > 0 then
    sResult := sResult +' AND Bomba.ID = ' + IntToStr(Bomba.Id);
  if Bomba.Tanque.Id > 0 then
    sResult := sResult +'AND Bomba.ID_TANQUE = ' + IntToStr(Bomba.Tanque.Id);

  if Bomba.Descricao <> '' then
  begin
    if Pos('%', Bomba.Descricao) > 0 then
      sResult := sResult +' AND UPPER(Bomba.DESCRICAO) LIKE ' + QuotedStr(UpperCase(Bomba.Descricao))
    else
      sResult := sResult +' AND UPPER(Bomba.DESCRICAO) = ' + QuotedStr(UpperCase(Bomba.Descricao))
  end;

  Result := sResult;
end;

class function TRepositorioBomba.getInstance: TRepositorioBomba;
begin
  if not Assigned(FRepository) then
  begin
    FRepository := TRepositorioBomba.Create;
    AQuery := TIBQuery.Create(nil);
    AQuery.Database := DmConexao.IBDatabase;
  end;
  Result := FRepository;
end;

class function TRepositorioBomba.Incluir(Bomba: TBomba): Boolean;
var AQry : TIBQuery;
    sSql :  string;
begin
  try
    try
      sSql := ' INSERT INTO Bomba (ID_TANQUE, DESCRICAO) '+
              ' values (' + IntToStr(Bomba.Tanque.Id) + ', ' +
                            QuotedStr(Bomba.Descricao) + ' )';
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

class function TRepositorioBomba.ObterListaBomba(Bomba: TBomba): TIBQuery;
var SSql : string;
begin
  SSql := ' SELECT ' + getAtributoBomba + ' FROM Bomba' + getFiltroBomba(Bomba);
  AQuery.Close;
  AQuery.SQL.Text := SSql;
  AQuery.Open;
  Result := AQuery;
end;

class function TRepositorioBomba.ObterListaBomba: TList;
var SSql : string;
  ListBomba : TList;
  AQry : TIBQuery;
begin
  SSql := ' SELECT ' + getAtributoBomba + ' FROM Bomba';

  AQry := TIBQuery.Create(nil);
  AQry.Database := DmConexao.IBDatabase;
  AQry.Transaction := DmConexao.IBTransaction;
  AQry.SQL.Text := sSql;
  AQry.Open;
  AQry.First;

  ListBomba := TList.Create;
  while not AQry.Eof do
  begin
    ListBomba.Add(AtribuirBomba(AQry));
    AQry.Next;
  end;
  Result := ListBomba;
end;

class function TRepositorioBomba.ObterBombaPeloId(Id: integer): TBomba;
var SSql : string;
begin
  SSql := ' SELECT ' + getAtributoBomba + ' FROM Bomba WHERE ID = ' + inttoStr(Id);
  AQuery.Close;
  AQuery.SQL.Text := SSql;
  AQuery.Open;
  Result := AtribuirBomba(AQuery);
end;

end.
