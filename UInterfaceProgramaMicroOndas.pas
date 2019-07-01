unit UInterfaceProgramaMicroOndas;

interface

uses Classes;

type
  IProgramaMicroOndas = interface
    ['{09CF2BC5-3B16-49CE-8EC9-9066E034B634}']
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
    property Nome: string read GetNome write SetNome;
    property Instrucao: string read GetInstrucao write SetInstrucao;
    property AlimentosCompativeis: TStringList read GetAlimentosCompativeis write SetAlimentosCompativeis;
    property TempoCozimento: Integer read GetTempoCozimento write SetTempoCozimento;
    property Potencia: Integer read GetPotencia write SetPotencia;
    property CharAquecimento: Char read GetCharAquecimento write SetCharAquecimento;
  end;

implementation

end.
