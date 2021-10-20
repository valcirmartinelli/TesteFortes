program Fortes;

uses
  Vcl.Forms,
  UBase in '..\forms\FormPadrao\UBase.pas' {FrmBase},
  UCadastro in '..\forms\FormPadrao\UCadastro.pas' {FrmCadastro},
  ULib in '..\forms\FormPadrao\ULib.pas',
  ULista in '..\forms\FormPadrao\ULista.pas' {FrmLista},
  UConexao in '..\forms\UConexao.pas' {DmConexao: TDataModule},
  UMenu in '..\forms\UMenu.pas' {FrmMenu},
  UAbastecimento in '..\Entities\UAbastecimento.pas',
  URepositorioAbastecimento in '..\Repository\URepositorioAbastecimento.pas',
  UCadAbastecimento in '..\forms\UCadAbastecimento.pas' {FrmCadAbastecimento},
  UCombustivel in '..\Entities\UCombustivel.pas',
  URepositorioCombustivel in '..\Repository\URepositorioCombustivel.pas',
  UCadCombustivel in '..\forms\UCadCombustivel.pas' {FrmCadCombustivel},
  UListaCombustivel in '..\forms\UListaCombustivel.pas' {FrmListaCombustivel},
  UBomba in '..\Entities\UBomba.pas',
  URepositorioBomba in '..\Repository\URepositorioBomba.pas',
  UFachadaAbastecimento in '..\Facade\UFachadaAbastecimento.pas',
  UCadBomba in '..\forms\UCadBomba.pas' {FrmCadBomba},
  UFachadaBomba in '..\Facade\UFachadaBomba.pas',
  UTanque in '..\Entities\UTanque.pas',
  URepositorioTanque in '..\Repository\URepositorioTanque.pas',
  UFachadaCombustivel in '..\Facade\UFachadaCombustivel.pas',
  UFachadaTanque in '..\Facade\UFachadaTanque.pas',
  UCadTanque in '..\forms\UCadTanque.pas' {FrmCadTanque},
  UListaBomba in '..\forms\UListaBomba.pas' {FrmListaBomba},
  UListaAbastecimento in '..\forms\UListaAbastecimento.pas' {FrmListaAbastecimento},
  UListaTanque in '..\forms\UListaTanque.pas' {FrmListaTanque},
  URelatorioAbastecimento in '..\forms\URelatorioAbastecimento.pas' {FrmRelatorio},
  UImpressaoAbastecimento in '..\forms\UImpressaoAbastecimento.pas' {FrmImpressaoAbastecimento};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.CreateForm(TFrmCadAbastecimento, FrmCadAbastecimento);
  Application.CreateForm(TFrmCadCombustivel, FrmCadCombustivel);
  Application.CreateForm(TFrmListaCombustivel, FrmListaCombustivel);
  Application.CreateForm(TFrmCadBomba, FrmCadBomba);
  Application.CreateForm(TFrmListaBomba, FrmListaBomba);
  Application.CreateForm(TFrmCadTanque, FrmCadTanque);
  Application.CreateForm(TFrmListaAbastecimento, FrmListaAbastecimento);
  Application.CreateForm(TFrmListaBomba, FrmListaBomba);
  Application.CreateForm(TFrmListaBomba, FrmListaBomba);
  Application.CreateForm(TFrmListaTanque, FrmListaTanque);
  Application.CreateForm(TFrmListaTanque, FrmListaTanque);
  Application.CreateForm(TFrmRelatorio, FrmRelatorio);
  Application.CreateForm(TFrmImpressaoAbastecimento, FrmImpressaoAbastecimento);
  Application.Run;
end.
