unit UTanque;

interface

uses
  SysUtils, Classes, UCombustivel;

Type
  TTanque = class(TObject)
  private
    FID : integer;
    FCOMBUSTIVEL : Tcombustivel;
    FDESCRICAO : String;
  public
    procedure Limpar;
  published
    property  Id : integer         read FID         write FID ;
    property  Combustivel : tcombustivel read FCOMBUSTIVEL  write FCOMBUSTIVEL ;
    property  Descricao : string   read FDESCRICAO  write FDESCRICAO ;
  end;

implementation

{ TProduto }



procedure TTanque.Limpar;
begin
  self.id          := 0;
  self.Combustivel := tcombustivel.Create();
  self.Descricao   := '';
end;

end.
