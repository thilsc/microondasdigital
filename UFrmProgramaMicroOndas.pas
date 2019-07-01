unit UFrmProgramaMicroOndas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UInterfaceProgramaMicroOndas, UProgramaMicroOndas;

type
  TFrmProgramaMicroOndas = class(TForm, IProgramaMicroOndas)
    edtNome: TLabeledEdit;
    edtInstrucao: TLabeledEdit;
    edtTempoCozimento: TLabeledEdit;
    edtPotencia: TLabeledEdit;
    edtCaractere: TLabeledEdit;
    lblAlimentosCompativeis: TLabel;
    memAlimentosCompativeis: TMemo;
    btnOK: TButton;
    btnCancelar: TButton;
  private
    { Private declarations }
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
    { Public declarations }
    property Nome: string read GetNome write SetNome;
    property Instrucao: string read GetInstrucao write SetInstrucao;
    property AlimentosCompativeis: TStringList read GetAlimentosCompativeis write SetAlimentosCompativeis;
    property TempoCozimento: Integer read GetTempoCozimento write SetTempoCozimento;
    property Potencia: Integer read GetPotencia write SetPotencia;
    property CharAquecimento: Char read GetCharAquecimento write SetCharAquecimento;
  end;

implementation

{$R *.dfm}

{ TFrmProgramaMicroOndas }

function TFrmProgramaMicroOndas.GetAlimentosCompativeis: TStringList;
begin
  //StringReplace(memAlimentosCompativeis.Lines.Text, sLineBreak, '|', [rfReplaceAll])
  Result := TStringList(memAlimentosCompativeis.Lines);
end;

function TFrmProgramaMicroOndas.GetCharAquecimento: Char;
var
  str: string;
begin
  str := Trim(edtCaractere.Text);
  if (Length(str) > 0) then
    Result := str[1]
  else
    Result := #0;
end;

function TFrmProgramaMicroOndas.GetInstrucao: string;
begin
  Result := Trim(edtInstrucao.Text);
end;

function TFrmProgramaMicroOndas.GetNome: string;
begin
  Result := Trim(edtNome.Text);
end;

function TFrmProgramaMicroOndas.GetPotencia: Integer;
begin
  Result := StrToIntDef(edtPotencia.Text, 10);
end;

function TFrmProgramaMicroOndas.GetTempoCozimento: Integer;
begin
  Result := StrToIntDef(edtTempoCozimento.Text, 0);
end;

procedure TFrmProgramaMicroOndas.SetAlimentosCompativeis(const Value: TStringList);
begin
  memAlimentosCompativeis.Lines.Assign(Value);
end;

procedure TFrmProgramaMicroOndas.SetCharAquecimento(const Value: Char);
begin
  edtCaractere.Text := Value;
end;

procedure TFrmProgramaMicroOndas.SetInstrucao(const Value: string);
begin
  edtInstrucao.Text := Value;
end;

procedure TFrmProgramaMicroOndas.SetNome(const Value: string);
begin
  edtNome.Text := Value;
end;

procedure TFrmProgramaMicroOndas.SetPotencia(const Value: Integer);
begin
  edtPotencia.Text := IntToStr(Value);
end;

procedure TFrmProgramaMicroOndas.SetTempoCozimento(const Value: Integer);
begin
  edtTempoCozimento.Text := IntToStr(Value);
end;

end.
