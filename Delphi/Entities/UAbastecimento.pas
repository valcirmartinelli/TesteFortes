unit UAbastecimento;

interface

uses
  SysUtils, Classes, UBomba;

Type
  TAbastecimento = class(TObject)
  private
    FID : integer;
    FBOMBA : TBomba;
    FQTDE_LITRO : Double;
    FVALOR_UNIT : Double;
    FVALOR_IMPOSTO :Double;
    FVALOR_TOTAL : Double;
    FDATA : TDateTime;
    FDATAFIM : TDateTime;

  public
    procedure Limpar;
  published
    property  Id           : integer    Read FID            write FID ;
    property  Bomba        : Tbomba     Read FBOMBA         write FBOMBA;
    property  QtdeLitro    : Double     Read FQTDE_LITRO    write FQTDE_LITRO;
    property  ValorUnit    : Double     Read FVALOR_UNIT    write FVALOR_UNIT;
    property  ValorImposto : Double     Read FVALOR_IMPOSTO write FVALOR_IMPOSTO;
    property  ValorTotal   : Double     Read FVALOR_TOTAL   write FVALOR_TOTAL;
    property  Data         : TDateTime  Read FDATA          write FDATA;
    property  DataFim      : TDateTime  Read FDATAFIM       write FDATAFIM;
  end;

implementation

{ TProduto }

procedure TAbastecimento.Limpar;
begin
  self.id           := 0;
  self.Bomba        := TBomba.Create();
  self.QtdeLitro    := 0;
  self.ValorUnit    := 0;
  self.ValorImposto := 0;
  self.ValorTotal   := 0;
  self.Data         := 0;
  Self.DataFim      := 0;
end;

end.
