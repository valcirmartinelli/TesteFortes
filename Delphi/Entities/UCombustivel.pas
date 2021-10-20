unit UCombustivel;

interface

uses
  SysUtils, Classes;

Type
  TCombustivel = class(TObject)
  private
    FID : integer;
    FSIGLA : String;
    FDESCRICAO : String;
    FVALOR : Double;
  public
    procedure Limpar;
  published
    property  Id : integer         read FID         write FID ;
    property  Sigla : string       read FSIGLA      write FSIGLA ;
    property  Descricao : string   read FDESCRICAO  write FDESCRICAO ;
    property  Valor : Double       read FVALOR      write FVALOR ;
  end;

implementation

{ TProduto }

procedure TCombustivel.Limpar;
begin
  self.id        := 0;
  self.Sigla     := '';
  self.Descricao := '';
  Self.Valor     := 0;
end;

end.
