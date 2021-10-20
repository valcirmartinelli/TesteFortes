unit URepositorioCombustivel;

interface

uses
   DBClient,  Classes, UCombustivel, SysUtils, DB, Ibx.IBDatabase, Ibx.IBCustomDataSet, Ibx.IBQuery;

Type
  TRepositorioCombustivel = class
  private
   class var AQuery : TIBQuery;
   class var FRepository : TRepositorioCombustivel;
  public
    class function getInstance : TRepositorioCombustivel;
    class function getAtributoCombustivel : string;
    class function getFiltroCombustivel(Combustivel : TCombustivel) : string;
    class function ObterListaCombustivel(Combustivel : TCombustivel) : TIBQuery; overload;
    class function ObterCombustivelPeloId(Id : integer): TCombustivel;
    class function ObterListaCombustivel(): TList; overload;
    class function AtribuirCombustivel(Qry : TIBQuery): TCombustivel;
    class function ExisteDependencia(Id : integer): Boolean;
    class function Excluir(id : Integer): Boolean;
    class function Incluir(Combustivel : TCombustivel): Boolean;
    class function Alterar(Combustivel : TCombustivel): Boolean;
  end;

implementation

{ TRepositorioPessoa }

uses UConexao;


class function TRepositorioCombustivel.Alterar(Combustivel: TCombustivel): Boolean;
var AQry : TIBQuery;
  sSql :  string;
begin
  try
    try
      sSql := ' UPDATE COMBUSTIVEL '+
              ' SET SIGLA = ' + QuotedStr(Combustivel.Sigla) +
              ' , DESCRICAO = ' + QuotedStr(Combustivel.Descricao) +
              ' , VALOR =  ' + QuotedStr(StringReplace(FloatToStr(Combustivel.Valor),',','.', [rfReplaceAll])) +
              ' WHERE ID = ' + IntToStr(Combustivel.Id);

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

class function TRepositorioCombustivel.AtribuirCombustivel(Qry: TIBQuery): TCombustivel;
var Combustivel : TCombustivel;
begin
  Combustivel := TCombustivel.Create;
  Combustivel.Limpar;
  Result := Combustivel;
  if Qry.IsEmpty then
    Exit;

  Combustivel.Id        := Qry.FieldByName('ID').AsInteger;
  Combustivel.Sigla     := Qry.FieldByName('SIGLA').AsString;
  Combustivel.Descricao := Qry.FieldByName('DESCRICAO').AsString;
  Combustivel.Valor     := Qry.FieldByName('valor').AsFloat;
  Result := Combustivel;
end;

class function TRepositorioCombustivel.Excluir(id: Integer): Boolean;
var AQry : TIBQuery;
begin
  try
    try
      AQry := TIBQuery.Create(nil);
      AQry.Database := DmConexao.IBDatabase;
      AQry.Transaction := DmConexao.IBTransaction;
      AQry.SQL.Text := 'DELETE FROM COMBUSTIVEL WHERE ID = ' + IntToStr(Id);
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

class function TRepositorioCombustivel.ExisteDependencia(Id: integer): Boolean;
var AQry : TIBQuery;
begin
  // REESCREVER

  try
    AQry := TIBQuery.Create(nil);
    AQry.Database := DmConexao.IBDatabase;
    AQry.SQL.Text := 'SELECT COUNT(ID) QTDE FROM TANQUE WHERE ID_COMBUSTIVEL = ' + IntToStr(Id);
    AQry.Open;
    Result := AQry.FieldByName('QTDE').AsInteger > 0;
  finally
    freeandnil(AQry);
  end;
end;

class function TRepositorioCombustivel.getAtributoCombustivel: string;
begin
  result := ' ID, SIGLA, DESCRICAO, VALOR ';
end;

class function TRepositorioCombustivel.getFiltroCombustivel(Combustivel: TCombustivel): string;
var sResult : string;
begin
  sResult := ' where 1 = 1 ';
  if Combustivel.Id > 0 then
    sResult := sResult +' AND COMBUSTIVEL.ID = ' + IntToStr(Combustivel.Id);
  if Combustivel.Sigla <> '' then
  begin
    if Pos('%', Combustivel.Sigla) > 0 then
      sResult := sResult +'AND UPPER(COMBUSTIVEL.SIGLA) LIKE ' + QuotedStr(UpperCase(Combustivel.Sigla))
    else
      sResult := sResult +' AND UPPER(COMBUSTIVEL.SIGLA) = ' + QuotedStr(UpperCase(Combustivel.Sigla))
  end;

  if Combustivel.Descricao <> '' then
  begin
    if Pos('%', Combustivel.Descricao) > 0 then
      sResult := sResult +' AND UPPER(COMBUSTIVEL.DESCRICAO) LIKE ' + QuotedStr(UpperCase(Combustivel.Descricao))
    else
      sResult := sResult +' AND UPPER(COMBUSTIVEL.DESCRICAO) = ' + QuotedStr(UpperCase(Combustivel.Descricao))
  end;

  Result := sResult;
end;

class function TRepositorioCombustivel.getInstance: TRepositorioCombustivel;
begin
  if not Assigned(FRepository) then
  begin
    FRepository := TRepositorioCombustivel.Create;
    AQuery := TIBQuery.Create(nil);
    AQuery.Database := DmConexao.IBDatabase;
  end;
  Result := FRepository;
end;

class function TRepositorioCombustivel.Incluir(Combustivel: TCombustivel): Boolean;
var AQry : TIBQuery;
    sSql :  string;
begin
  try
    try
      sSql := ' INSERT INTO COMBUSTIVEL (SIGLA, DESCRICAO, VALOR) '+
              ' values (' + QuotedStr(Combustivel.Sigla) + ', ' +
                            QuotedStr(Combustivel.Descricao) + ', ' +
                            QuotedStr(StringReplace(FloatToStr(Combustivel.Valor),',','.', [rfReplaceAll])) + ' )';
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

class function TRepositorioCombustivel.ObterListaCombustivel(Combustivel: TCombustivel): TIBQuery;
var SSql : string;
begin
  SSql := ' SELECT ' + getAtributoCombustivel + ' FROM COMBUSTIVEL' + getFiltroCombustivel(Combustivel);
  AQuery.Close;
  AQuery.SQL.Text := SSql;
  AQuery.Open;
  Result := AQuery;
end;

class function TRepositorioCombustivel.ObterListaCombustivel: TList;
var SSql : string;
  ListCombustivel : TList;
  AQry : TIBQuery;
begin
  SSql := ' SELECT ' + getAtributoCombustivel + ' FROM COMBUSTIVEL';

  AQry := TIBQuery.Create(nil);
  AQry.Database := DmConexao.IBDatabase;
  AQry.Transaction := DmConexao.IBTransaction;
  AQry.SQL.Text := sSql;
  AQry.Open;
  AQry.First;

  ListCombustivel := TList.Create;
  while not AQry.Eof do
  begin
    ListCombustivel.Add(AtribuirCombustivel(AQry));
    AQry.Next;
  end;
  Result := ListCombustivel;
end;

class function TRepositorioCombustivel.ObterCombustivelPeloId(Id: integer): TCombustivel;
var SSql : string;
begin
  SSql := ' SELECT ' + getAtributoCombustivel + ' FROM COMBUSTIVEL WHERE ID = ' + inttoStr(Id);
  AQuery.Close;
  AQuery.SQL.Text := SSql;
  AQuery.Open;
  Result := AtribuirCombustivel(AQuery);
end;

end.
