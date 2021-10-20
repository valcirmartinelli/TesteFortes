unit UBomba;

interface

uses
  SysUtils, Classes, UTanque;

Type
  TBomba = class(TObject)
  private
    FID : integer;
    FTANQUE : TTanque;
    FDESCRICAO : String;
  public
    procedure Limpar;
  published
    property  Id : integer         read FID         write FID ;
    property  Tanque : TTanque     read FTANQUE     write FTANQUE ;
    property  Descricao : string   read FDESCRICAO  write FDESCRICAO ;
  end;

implementation

{ TProduto }



procedure TBomba.Limpar;
begin
  self.id         := 0;
  self.Tanque     := TTanque.Create();
  self.Descricao  := '';
end;

end.
