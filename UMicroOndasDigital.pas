unit UMicroOndasDigital;

interface

uses Classes, SysUtils, UProgramaMicroOndas, UInterfaceValidador, ExtCtrls, UObserver;

type
  TFimExecucaoMicroOndasDigitalEvent = procedure(AAlimento: string) of object;
  TErroExecucaoMicroOndasDigitalEvent = procedure(E: Exception) of object;

  TMicroOndasDigital = class(TSubject)
  private
    FOutput: string;
    FListaProgramas: TListaProgramas;
    FContaSegundos: Cardinal;
    FPontosPotencia: string;
    FValidador: IValidador;
    FAlimentoAtual: string;
    FArquivoString: string;
    FEmExecucao: Boolean;
    FPausado: Boolean;
    FTimer: TTimer;
    FOnFimExecucao: TFimExecucaoMicroOndasDigitalEvent;
    FOnErroExecucao: TErroExecucaoMicroOndasDigitalEvent;
    function GetOutput: string;
    procedure OnTimer(Sender: TObject);
    function GetListaProgramas: TListaProgramas;
    function GetEmExecucao: Boolean;
    function GetPausado: Boolean;
    procedure SetPausado(const Value: Boolean);
    procedure DoOnFimExecucao;
    procedure DoOnErroExecucao(E: Exception);
    procedure IncrementaPontosPotenciaArquivo;
  public
    property EmExecucao: Boolean read GetEmExecucao;
    property ListaProgramas: TListaProgramas read GetListaProgramas;
    property Output: string read GetOutput;
    property Pausado: Boolean read GetPausado write SetPausado;

    property OnFimExecucao: TFimExecucaoMicroOndasDigitalEvent read FOnFimExecucao write FOnFimExecucao;
    property OnErroExecucao: TErroExecucaoMicroOndasDigitalEvent read FOnErroExecucao write FOnErroExecucao;

    function GetListaProgramasStr: TStringList;
    procedure AddNovoPrograma(APrograma: TProgramaMicroOndas);
    procedure Start(APrograma: TProgramaMicroOndasSelecionado);
    procedure CancelarExecucao;

    constructor Create(); overload;
    destructor Destroy; override;
  end;

const
  MsgAquecimentoFinalizado = 'AQUECIDA';

implementation

uses UFrmMicroOndasDigital, UProgramaMicroOndasValidador, MaskUtils, IniFiles;

{ TMicroOndasDigital }

constructor TMicroOndasDigital.Create;
begin
  inherited Create;
  FValidador := TProgramaMicroOndasValidador.Create;
  FTimer := TTimer.Create(nil);
  FTimer.Enabled  := False;
  FTimer.OnTimer  := Self.OnTimer;
  FTimer.Interval := 1000;

  FListaProgramas := TListaProgramas.Create(ExtractFilePath(ParamStr(0)) + 'programas.ini');

  Self.Attach(FrmMicroOndasDigital);
end;

function TMicroOndasDigital.GetOutput: string;
begin
  Result := FOutput;
end;

procedure TMicroOndasDigital.AddNovoPrograma(APrograma: TProgramaMicroOndas);
begin
  FListaProgramas.Add(APrograma);
  FListaProgramas.SaveToINIFile;
end;

procedure TMicroOndasDigital.Start(APrograma: TProgramaMicroOndasSelecionado);
begin
  try
    FValidador.Validar(APrograma);

    FContaSegundos := APrograma.TempoCozimento + 1;
    FPontosPotencia:= StringOfChar(APrograma.CharAquecimento, APrograma.Potencia);

    if FileExists(APrograma.Alimento) then
    begin
      FArquivoString := APrograma.Alimento;
      FAlimentoAtual := '(ALTERAÇÃO FEITA NO ARQUIVO)';
    end
    else
    begin
      FArquivoString := EmptyStr;
      FAlimentoAtual := APrograma.Alimento;
    end;

    FOutput := FAlimentoAtual;
    FEmExecucao := True;
    Self.Notify;
    FTimer.Enabled := True;
  except
    on E: Exception do
    begin
      Self.CancelarExecucao;
      Self.DoOnErroExecucao(E);
    end;
  end;
end;

procedure TMicroOndasDigital.CancelarExecucao;
begin
  FEmExecucao := False;
  FTimer.Enabled := False;
  //Self.DoOnFimExecucao;
  Self.Notify;
end;

procedure TMicroOndasDigital.IncrementaPontosPotenciaArquivo;
begin
  with TStringList.Create do
    try
      LoadFromFile(FArquivoString);
      Text := Text + FPontosPotencia;
      SaveToFile(FArquivoString);
    finally
      Free;
    end;
end;

procedure TMicroOndasDigital.OnTimer(Sender: TObject);
begin
  if (not FPausado) then
  begin
    Dec(FContaSegundos);
    if (FContaSegundos > 0) then
    begin
      if (FArquivoString <> EmptyStr) then
        IncrementaPontosPotenciaArquivo;

      FOutput := FOutput + FPontosPotencia;
    end
    else
    begin
      FOutput := FOutput + MsgAquecimentoFinalizado;
      FTimer.Enabled := False;
      FEmExecucao := False;
      DoOnFimExecucao;
    end;
  end;
  Self.Notify;
end;

destructor TMicroOndasDigital.Destroy;
begin
  FTimer.Enabled := False;
  FreeAndNil(FTimer);
  inherited Destroy;
end;

function TMicroOndasDigital.GetListaProgramasStr: TStringList;
var
  I: Integer;
begin
  Result := TStringList.Create;
  Result.Add('(Padrão)');

  for I := 0 to Pred(FListaProgramas.Count) do
    Result.Add(FListaProgramas[I].Nome);
end;

function TMicroOndasDigital.GetListaProgramas: TListaProgramas;
begin
  Result := FListaProgramas;
end;

function TMicroOndasDigital.GetEmExecucao: Boolean;
begin
  Result := FEmExecucao;
end;

function TMicroOndasDigital.GetPausado: Boolean;
begin
  Result := FPausado;
end;

procedure TMicroOndasDigital.SetPausado(const Value: Boolean);
begin
  FPausado := Value;
end;

procedure TMicroOndasDigital.DoOnFimExecucao;
begin
  if Assigned(FOnFimExecucao) then
    FOnFimExecucao(Self.FAlimentoAtual);
end;

procedure TMicroOndasDigital.DoOnErroExecucao(E: Exception);
begin
  if Assigned(FOnErroExecucao) then
    FOnErroExecucao(E);
end;

end.

