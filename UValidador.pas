unit UValidador;

interface

uses Classes, SysUtils, UInterfaceValidador;

type
  TValidador = class(TInterfacedObject, IValidador)
  private
    FListaErros: TStringList;
    function GetListaErros: TStringList;
  protected
    procedure AddToListaErros(AStr: string);
    procedure ClearListaErros;
    procedure ShowListaErros;
  public
    property ListaErros: TStringList read GetListaErros;
    procedure Validar(AObj: TObject); virtual; abstract;
    constructor Create; overload;
    destructor Destroy; override;
  end;

implementation

{ TValidador }

constructor TValidador.Create;
begin
  inherited Create;
  FListaErros := TStringList.Create;
end;

function TValidador.GetListaErros: TStringList;
begin
  Result := FListaErros;
end;

procedure TValidador.AddToListaErros(AStr: string);
begin
  if (Trim(AStr) <> EmptyStr) then
    FListaErros.Add(AStr);
end;

procedure TValidador.ClearListaErros;
begin
  FListaErros.Clear;
end;

procedure TValidador.ShowListaErros;
begin
  if (FListaErros.Count > 0) then
    raise Exception.Create('O sistema retornou o(s) seguinte(s) erro(s): '+sLineBreak+FListaErros.Text);
end;

destructor TValidador.Destroy;
begin
  if Assigned(FListaErros) then
    FreeAndNil(FListaErros);
  inherited Destroy;
end;

end.

