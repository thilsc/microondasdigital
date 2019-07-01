unit UProgramaMicroOndasValidador;

interface

uses Classes, SysUtils, UValidador;

type
  TProgramaMicroOndasValidador = class(TValidador)
  private
    function ValidarAlimento(AObj: TObject): string;
    function ValidarPotencia(const Value: Integer): string;
    function ValidarTempoCozimento(const Value: Integer): string;
  public
    procedure Validar(AObj: TObject); override;
  end;

implementation

uses UProgramaMicroOndas;

{ TProgramaMicroOndasValidador }

procedure TProgramaMicroOndasValidador.Validar(AObj: TObject);
begin
  ClearListaErros;
  AddToListaErros(ValidarAlimento(AObj));
  AddToListaErros(ValidarTempoCozimento((AObj as TProgramaMicroOndas).TempoCozimento));
  AddToListaErros(ValidarPotencia((AObj as TProgramaMicroOndas).Potencia));
  ShowListaErros;
end;

function TProgramaMicroOndasValidador.ValidarAlimento(AObj: TObject): string;
begin
  Result := EmptyStr;
  if (AObj is TProgramaMicroOndasSelecionado) and ((AObj as TProgramaMicroOndasSelecionado).Nome <> DefaultNomePrograma) then
  begin
    if (AObj as TProgramaMicroOndasSelecionado).AlimentosCompativeis.IndexOf((AObj as TProgramaMicroOndasSelecionado).Alimento) < 0 then
      Result := 'Alimento incompatível com o programa ajustado.';
  end;
end;

function TProgramaMicroOndasValidador.ValidarPotencia(const Value: Integer): string;
begin
  Result := EmptyStr;
  if ((Value < 1) or (Value > 10)) then
    Result := 'Informe a potência de 1 a 10.';
end;

function TProgramaMicroOndasValidador.ValidarTempoCozimento(const Value: Integer): string;
begin
  Result := EmptyStr;
  if (Value = 0) then
      Result := 'O tempo de cozimento precisa ser informado.'
  else
    if ((Value < 1) or (Value > 120)) then
      Result := 'Informe o tempo de cozimento de 1 a 120 segundos.';
end;

end.
