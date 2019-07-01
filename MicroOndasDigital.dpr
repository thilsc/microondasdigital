program MicroOndasDigital;

uses
  Forms,
  UFrmMicroOndasDigital in 'UFrmMicroOndasDigital.pas' {FrmMicroOndasDigital},
  UMicroOndasDigital in 'UMicroOndasDigital.pas',
  UInterfaceValidador in 'UInterfaceValidador.pas',
  UValidador in 'UValidador.pas',
  UInterfaceObserver in 'UInterfaceObserver.pas',
  UObserver in 'UObserver.pas',
  UProgramaMicroOndas in 'UProgramaMicroOndas.pas',
  UProgramaMicroOndasValidador in 'UProgramaMicroOndasValidador.pas',
  UFrmProgramaMicroOndas in 'UFrmProgramaMicroOndas.pas' {FrmProgramaMicroOndas},
  UInterfaceProgramaMicroOndas in 'UInterfaceProgramaMicroOndas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMicroOndasDigital, FrmMicroOndasDigital);
  Application.Run;
end.
