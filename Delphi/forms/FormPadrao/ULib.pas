unit ULib;


interface
uses
   DBClient,  Classes, SysUtils, DB, Ibx.IBDatabase, Ibx.IBCustomDataSet, Ibx.IBQuery;

  procedure DigitarApenasNumero(bPermiteVirgula : boolean; var Key: Char);
implementation

procedure DigitarApenasNumero(bPermiteVirgula : boolean;var Key: Char);
begin
  if bPermiteVirgula then
  begin
    if not (key in ['0'..'9',',', #8]) then
      key := #0;
  end
  else
  begin
    if not (key in ['0'..'9',#8]) then
      key := #0;
  end;
end;

end.
