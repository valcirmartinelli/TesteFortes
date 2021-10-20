unit URepositorioAbastecimento;

interface

uses
   DBClient,  Classes, UAbastecimento, SysUtils, DB, Ibx.IBDatabase, Ibx.IBCustomDataSet, Ibx.IBQuery;

Type
  TRepositorioAbastecimento = class
  private
   class var AQuery : TIBQuery;
   class var FRepository : TRepositorioAbastecimento;
  public
    class function getInstance : TRepositorioAbastecimento;
    class function getAtributoAbastecimento : string;
    class function getFiltroAbastecimento(Abastecimento : TAbastecimento) : string;
    class function ObterListaAbastecimento(Abastecimento : TAbastecimento) : TIBQuery; overload;
    class function ObterAbastecimentoPeloId(Id : integer): TAbastecimento;
    class function ObterListaAbastecimento(): TList; overload;
    class function AtribuirAbastecimento(Qry : TIBQuery): TAbastecimento;
    class function ExisteDependencia(Id : integer): Boolean;
    class function Excluir(id : Integer): Boolean;
    class function Incluir(Abastecimento : TAbastecimento): Boolean;
    class function Relatorio(Abastecimento : TAbastecimento): TIBQuery;
  end;

implementation

{ TRepositorioPessoa }

uses UConexao, URepositorioBomba;

class function TRepositorioAbastecimento.AtribuirAbastecimento(Qry: TIBQuery): TAbastecimento;
var Abastecimento : TAbastecimento;
begin
  Abastecimento := TAbastecimento.Create;
  Abastecimento.Limpar;
  Result := Abastecimento;
  if Qry.IsEmpty then
    Exit;

  Abastecimento.Id           := Qry.FieldByName('ID').AsInteger;
  Abastecimento.Bomba        := TRepositorioBomba.getInstance.ObterBombaPeloId(Qry.FieldByName('ID_BOMBA').AsInteger);
  Abastecimento.QtdeLitro    := Qry.FieldByName('QTDE_LITRO').AsFloat;
  Abastecimento.ValorUnit    := Qry.FieldByName('VALOR_UNIT').AsFloat;
  Abastecimento.ValorImposto := Qry.FieldByName('VALOR_IMPOSTO').AsFloat;
  Abastecimento.ValorTotal   := Qry.FieldByName('VALOR_TOTAL').AsFloat;
  Abastecimento.Data         := Qry.FieldByName('DATA').AsDateTime;

  Result := Abastecimento;
end;

class function TRepositorioAbastecimento.Excluir(id: Integer): Boolean;
var AQry : TIBQuery;
begin
  try
    try
      AQry := TIBQuery.Create(nil);
      AQry.Database := DmConexao.IBDatabase;
      AQry.Transaction := DmConexao.IBTransaction;
      AQry.SQL.Text := 'DELETE FROM Abastecimento WHERE ID = ' + IntToStr(Id);
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

class function TRepositorioAbastecimento.ExisteDependencia(Id: integer): Boolean;
var AQry : TIBQuery;
begin
  Result := FALSE;
end;

class function TRepositorioAbastecimento.getAtributoAbastecimento: string;
begin
  result := ' Abastecimento.ID, Abastecimento.ID_BOMBA, Abastecimento.QTDE_LITRO, '+
            ' Abastecimento.VALOR_UNIT, Abastecimento.VALOR_IMPOSTO, Abastecimento.VALOR_TOTAL, Abastecimento.DATA ';
end;

class function TRepositorioAbastecimento.getFiltroAbastecimento(Abastecimento: TAbastecimento): string;
var sResult : string;
begin
  sResult := ' where 1 = 1 ';
  if Abastecimento.Id > 0 then
    sResult := sResult +' AND Abastecimento.ID = ' + IntToStr(Abastecimento.Id);
  if Abastecimento.Bomba.Id > 0 then
    sResult := sResult +' AND Abastecimento.ID_BOMBA = ' + IntToStr(Abastecimento.Bomba.Id);

  if Abastecimento.Data > 0 then
    sResult := sResult + ' AND ABASTECIMENTO.DATA BETWEEN ' + QuotedStr(FormatDateTime('dd.MM.yyyy 00:00:00', Abastecimento.Data)) +
                         '                       AND ' + QuotedStr(FormatDateTime('dd.MM.yyyy 23:59:59', Abastecimento.Data));

  Result := sResult;
end;

class function TRepositorioAbastecimento.getInstance: TRepositorioAbastecimento;
begin
  if not Assigned(FRepository) then
  begin
    FRepository := TRepositorioAbastecimento.Create;
    AQuery := TIBQuery.Create(nil);
    AQuery.Database := DmConexao.IBDatabase;
  end;
  Result := FRepository;
end;

class function TRepositorioAbastecimento.Incluir(Abastecimento: TAbastecimento): Boolean;
var AQry : TIBQuery;
    sSql :  string;
begin
  try
    try
      sSql := ' INSERT INTO Abastecimento (ID_BOMBA, QTDE_LITRO, VALOR_UNIT, VALOR_IMPOSTO, VALOR_TOTAL) '+
              ' values (' + IntToStr(Abastecimento.Bomba.Id) + ', ' +
                            QuotedStr(StringReplace(FloatToStr(Abastecimento.QtdeLitro),',','.', [rfReplaceAll])) + ', ' +
                            QuotedStr(StringReplace(FloatToStr(Abastecimento.ValorUnit),',','.', [rfReplaceAll])) + ', ' +
                            QuotedStr(StringReplace(FloatToStr(Abastecimento.ValorImposto),',','.', [rfReplaceAll])) + ', ' +
                            QuotedStr(StringReplace(FloatToStr(Abastecimento.ValorTotal),',','.', [rfReplaceAll])) +
                            ' )';
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

class function TRepositorioAbastecimento.ObterListaAbastecimento(Abastecimento: TAbastecimento): TIBQuery;
var SSql : string;
begin
  SSql := ' SELECT ' + getAtributoAbastecimento + ', BOMBA.DESCRICAO    '+
                                                  '  FROM Abastecimento '+
                                                  '  JOIN BOMBA ON (ABASTECIMENTO.ID_BOMBA = BOMBA.ID) ' +
                                                  getFiltroAbastecimento(Abastecimento);
  AQuery.Close;
  AQuery.SQL.Text := SSql;
  AQuery.Open;
  Result := AQuery;
end;

class function TRepositorioAbastecimento.ObterListaAbastecimento: TList;
var SSql : string;
  ListAbastecimento : TList;
  AQry : TIBQuery;
begin
  SSql := ' SELECT ' + getAtributoAbastecimento + ' FROM Abastecimento';

  AQry := TIBQuery.Create(nil);
  AQry.Database := DmConexao.IBDatabase;
  AQry.Transaction := DmConexao.IBTransaction;
  AQry.SQL.Text := sSql;
  AQry.Open;
  AQry.First;

  ListAbastecimento := TList.Create;
  while not AQry.Eof do
  begin
    ListAbastecimento.Add(AtribuirAbastecimento(AQry));
    AQry.Next;
  end;
  Result := ListAbastecimento;
end;

class function TRepositorioAbastecimento.Relatorio(Abastecimento: TAbastecimento): TIBQuery;
var SSql : string;
begin
  SSql := ' Select ' +
          ' TANQUE.DESCRICAO AS TANQUE,  '+
          ' BOMBA.DESCRICAO AS BOMBA,    '+
          ' ABASTECIMENTO.DATA,          '+
          ' ABASTECIMENTO.VALOR_TOTAL    '+
          ' FROM ABASTECIMENTO           '+
          ' JOIN BOMBA  ON (ABASTECIMENTO.ID_BOMBA = BOMBA.ID) '+
          ' JOIN TANQUE ON (BOMBA.ID_TANQUE = TANQUE.ID) '+
          ' WHERE 1 = 1 ';
  IF (Abastecimento.Data > 0) AND (Abastecimento.DataFim > 0) THEN
  begin
    SSql := SSql + ' AND ABASTECIMENTO.DATA BETWEEN ' + QuotedStr(FormatDateTime('dd.MM.yyyy hh:mm:ss', Abastecimento.Data)) +
                   '                            AND ' + QuotedStr(FormatDateTime('dd.MM.yyyy hh:mm:ss', Abastecimento.DataFim));
  end
  else if Abastecimento.Data > 0 then
    SSql := SSql + ' AND ABASTECIMENTO.DATA = ' + QuotedStr(FormatDateTime('dd.MM.yyyy hh:mm:ss', Abastecimento.Data))
  else if Abastecimento.DataFim > 0 then
    SSql := SSql + ' AND ABASTECIMENTO.DATA = ' + QuotedStr(FormatDateTime('dd.MM.yyyy hh:mm:ss', Abastecimento.DataFim));

  if (Abastecimento.Bomba <> nil) and (Abastecimento.Bomba.Id > 0) then
    SSql := SSql + ' AND ABASTECIMENTO.ID_BOMBA = ' + IntToStr(Abastecimento.Bomba.Id);

  if (Abastecimento.Bomba <> nil) and (Abastecimento.Bomba.Tanque.Id > 0) then
    SSql := SSql + ' AND TANQUE.ID = ' + IntToStr(Abastecimento.Bomba.Tanque.Id);

  AQuery.Close;
  AQuery.SQL.Text := SSql;
  AQuery.Open;
  Result := AQuery;
end;

class function TRepositorioAbastecimento.ObterAbastecimentoPeloId(Id: integer): TAbastecimento;
var SSql : string;
begin
  SSql := ' SELECT ' + getAtributoAbastecimento + ' FROM Abastecimento WHERE ID = ' + inttoStr(Id);
  AQuery.Close;
  AQuery.SQL.Text := SSql;
  AQuery.Open;
  Result := AtribuirAbastecimento(AQuery);
end;

end.
