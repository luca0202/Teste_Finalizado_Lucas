program TESTE_DELPHI_MKDATA;

uses
  Vcl.Forms,
  REFEI0000 in 'REFEI0000.pas' {REFEI_0000},
  REFEI0001 in 'REFEI0001.pas' {REFEI_0001},
  DataModule in 'DataModule.pas' {dm: TDataModule},
  DlgPesquisaCliente in 'DlgPesquisaCliente.pas' {Dlg_PesquisaCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
