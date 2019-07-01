unit UProgramaMicroOndas;

interface

uses Classes, SysUtils, UInterfaceProgramaMicroOndas;

const
  DefaultNomePrograma = 'custom';
  DefaultCharAquecimento = '.';

type
  TProgramaMicroOndas = class(TInterfacedObject, IProgramaMicroOndas)
  private
    FNome: string;
    FInstrucao: string;
    FAlimentosCompativeis: TStringList;
    FPotencia: Integer;
    FTempoCozimento: Integer;
    FCharAquecimento: Char;
    function GetNome: string;
    function GetInstrucao: string;
    function GetAlimentosCompativeis: TStringList;
    function GetPotencia: Integer;
    function GetTempoCozimento: Integer;
    procedure SetNome(const Value: string);
    procedure SetAlimentosCompativeis(const Value: TStringList);
    procedure SetInstrucao(const Value: string);
    procedure SetPotencia(const Value: Integer);
    procedure SetTempoCozimento(const Value: Integer);
    function GetCharAquecimento: Char;
    procedure SetCharAquecimento(const Value: Char);
  public
    property Nome: string read GetNome write SetNome;
    property Instrucao: string read GetInstrucao write SetInstrucao;
    property AlimentosCompativeis: TStringList read GetAlimentosCompativeis write SetAlimentosCompativeis;
    property TempoCozimento: Integer read GetTempoCozimento write SetTempoCozimento;
    property Potencia: Integer read GetPotencia write SetPotencia;
    property CharAquecimento: Char read GetCharAquecimento write SetCharAquecimento;

    function GetInstrucoesCompletas: string;

    constructor Create(const ANome, AInstrucao, AAlimentosCompativeis: string;
                       const ATempoCozimento,
                             APotencia: Integer;
                       const ACharAquecimento: Char = DefaultCharAquecimento); overload;
  end;

  TProgramaMicroOndasSelecionado = class(TProgramaMicroOndas)
  private
    FAlimento: string;
    function GetAlimento: string;
    procedure SetAlimento(const Value: string);
  public
    property Alimento: string read GetAlimento write SetAlimento;

    class function Clone(AObj: TProgramaMicroOndas): TProgramaMicroOndasSelecionado;
  end;

  TListaProgramas = class(TList)
  private
    FIniFilePath: string;
    procedure LoadFromIniFile;
  protected
    function Get(Index: Integer): TProgramaMicroOndas;
    procedure Put(Index: Integer; Item: TProgramaMicroOndas);
  public
    property Items[Index: Integer]: TProgramaMicroOndas read Get write Put; default;
    function Add(Item: TProgramaMicroOndas): Integer;
    procedure Insert(Index: Integer; Item: TProgramaMicroOndas);
    procedure SaveToIniFile;

    constructor Create(AIniFilePath: string = ''); overload;
    destructor Destroy; override;
  end;

implementation

uses IniFiles;

{ TProgramaMicroOndas }

constructor TProgramaMicroOndas.Create(const ANome, AInstrucao, AAlimentosCompativeis: string;
                                       const ATempoCozimento, APotencia: Integer;
                                       const ACharAquecimento: Char = DefaultCharAquecimento);
begin
  inherited Create;
  FNome := ANome;
  FInstrucao := AInstrucao;
  FAlimentosCompativeis := TStringList.Create;
  FAlimentosCompativeis.Text := StringReplace(AAlimentosCompativeis, '|', sLineBreak, [rfReplaceAll]);
  FTempoCozimento := ATempoCozimento;
  FPotencia := APotencia;
  FCharAquecimento := ACharAquecimento;
end;

function TProgramaMicroOndas.GetAlimentosCompativeis: TStringList;
begin
  Result := FAlimentosCompativeis;
end;

function TProgramaMicroOndas.GetCharAquecimento: Char;
begin
  Result := FCharAquecimento;
end;

function TProgramaMicroOndas.GetInstrucao: string;
begin
  Result := FInstrucao;
end;

function TProgramaMicroOndas.GetNome: string;
begin
  Result := FNome;
end;

function TProgramaMicroOndas.GetPotencia: Integer;
begin
  Result := FPotencia;
end;

function TProgramaMicroOndas.GetTempoCozimento: Integer;
begin
  Result := FTempoCozimento;
end;

procedure TProgramaMicroOndas.SetAlimentosCompativeis(const Value: TStringList);
begin
  FAlimentosCompativeis := Value;
end;

procedure TProgramaMicroOndas.SetCharAquecimento(const Value: Char);
begin
  FCharAquecimento := Value;
end;

procedure TProgramaMicroOndas.SetInstrucao(const Value: string);
begin
  FInstrucao := Value;
end;

procedure TProgramaMicroOndas.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TProgramaMicroOndas.SetPotencia(const Value: Integer);
begin
  FPotencia := Value;
end;

procedure TProgramaMicroOndas.SetTempoCozimento(const Value: Integer);
begin
  FTempoCozimento := Value;
end;

function TProgramaMicroOndas.GetInstrucoesCompletas: string;
begin
  Result := 'PROGRAMA SELECIONADO: '+Self.Nome + sLineBreak +
            StringOfChar('-', 60) + sLineBreak +
            'Instruções: ' + FInstrucao + sLineBreak +
            StringOfChar('-', 60) + sLineBreak +
            'Alimentos Compatíveis: ' + FAlimentosCompativeis.Text + sLineBreak +
            StringOfChar('-', 60) + sLineBreak +
            'Caractere de Aquecimento: '+ FCharAquecimento;
end;

{ TProgramaMicroOndasSelecionado }

function TProgramaMicroOndasSelecionado.GetAlimento: string;
begin
  Result := FAlimento;
end;

procedure TProgramaMicroOndasSelecionado.SetAlimento(const Value: string);
begin
  FAlimento := Value;
end;

class function TProgramaMicroOndasSelecionado.Clone(AObj: TProgramaMicroOndas): TProgramaMicroOndasSelecionado;
begin
  Result := TProgramaMicroOndasSelecionado.Create(AObj.Nome,
                                                  AObj.Instrucao,
                                                  StringReplace(AObj.AlimentosCompativeis.Text, sLineBreak, '|', [rfReplaceAll]),
                                                  AObj.TempoCozimento,
                                                  AObj.Potencia,
                                                  AObj.CharAquecimento);
end;

{ TListaProgramas }

constructor TListaProgramas.Create(AIniFilePath: string = '');
begin
  inherited Create;
  FIniFilePath := AIniFilePath;
  if FileExists(FIniFilePath) then
    Self.LoadFromIniFile;
end;

procedure TListaProgramas.LoadFromIniFile;
var
  ini: TIniFile;
  I, k: Integer;
  lstSections, lstCurrentSection: TStringList;
begin
  ini := TIniFile.Create(FIniFilePath);
  lstSections := TStringList.Create;
  lstCurrentSection := TStringList.Create;
  try
    ini.ReadSections(lstSections);
    for I := 0 to Pred(lstSections.Count) do
    begin
      ini.ReadSection(lstSections[I], lstCurrentSection);
      for k := 0 to Pred(lstCurrentSection.Count) do
        lstCurrentSection.Values[lstCurrentSection[k]] := ini.ReadString(lstSections[I], lstCurrentSection[k], '');

      Self.Add(TProgramaMicroOndas.Create(lstCurrentSection.Values['Nome'],
                                          lstCurrentSection.Values['Instrucao'],
                                          lstCurrentSection.Values['AlimentosCompativeis'],
                                          StrToIntDef(lstCurrentSection.Values['Tempo'], 0),
                                          StrToIntDef(lstCurrentSection.Values['Potencia'], 0),
                                          lstCurrentSection.Values['CharAquecimento'][1]));
    end;
  finally
    FreeAndNil(lstCurrentSection);
    FreeAndNil(lstSections);
    FreeAndNil(ini);
  end;
end;

procedure TListaProgramas.SaveToIniFile;
var
  ini: TIniFile;
  I: Integer;
  CurrentSection: string;
  lstCurrentSection: TStringList;
begin
  ini := TIniFile.Create(FIniFilePath);
  lstCurrentSection := TStringList.Create;
  try
    for I := 0 to Pred(Self.Count) do
    begin
      CurrentSection := 'Programa'+Format('%.*d',[3, I]);

      ini.ReadSection(CurrentSection, lstCurrentSection);
      if (lstCurrentSection.Count > 0) then
        ini.EraseSection(CurrentSection);
      
      ini.WriteString(CurrentSection, 'Nome',                 Self.Items[I].Nome);
      ini.WriteString(CurrentSection, 'Instrucao',            Self.Items[I].Instrucao);
      ini.WriteString(CurrentSection, 'AlimentosCompativeis', StringReplace(Self.Items[I].AlimentosCompativeis.Text, sLineBreak, '|', [rfReplaceAll]));
      ini.WriteInteger(CurrentSection,'Tempo',                Self.Items[I].TempoCozimento);
      ini.WriteInteger(CurrentSection,'Potencia',             Self.Items[I].Potencia);
      ini.WriteString(CurrentSection, 'CharAquecimento',      Self.Items[I].CharAquecimento);
    end;
    ini.UpdateFile;
  finally
    FreeAndNil(lstCurrentSection);
    FreeAndNil(ini);
  end;
end;

function TListaProgramas.Add(Item: TProgramaMicroOndas): Integer;
begin
  Result := inherited Add(Item);
end;

destructor TListaProgramas.Destroy;
begin
  Self.Clear;
  inherited Destroy;
end;

function TListaProgramas.Get(Index: Integer): TProgramaMicroOndas;
begin
  Result := TProgramaMicroOndas(inherited Get(Index));
end;

procedure TListaProgramas.Insert(Index: Integer; Item: TProgramaMicroOndas);
begin
  inherited Insert(Index, Item);
end;

procedure TListaProgramas.Put(Index: Integer; Item: TProgramaMicroOndas);
begin
  inherited Put(Index, Item);
end;

end.
 