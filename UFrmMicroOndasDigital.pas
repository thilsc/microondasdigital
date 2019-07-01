unit UFrmMicroOndasDigital;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UMicroOndasDigital, UObserver, StrUtils, Buttons;

type
  TFrmMicroOndasDigital = class(TObserverForm)
    Label1: TLabel;
    edtAlimento: TEdit;
    lblTempoCozimento: TLabel;
    edtTempoCozimento: TEdit;
    Label3: TLabel;
    edtPotencia: TEdit;
    btnStart: TButton;
    btnAquecimentoRapido: TButton;
    Label4: TLabel;
    memOutput: TMemo;
    lblInstrucoes: TLabel;
    btnCancelar: TButton;
    memInstrucoes: TMemo;
    lstPrograma: TListBox;
    btnAddPrograma: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStartClick(Sender: TObject);
    procedure NumberKeyPress(Sender: TObject; var Key: Char);
    procedure btnAquecimentoRapidoClick(Sender: TObject);
    procedure lstProgramaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAddProgramaClick(Sender: TObject);
    procedure btnRemoverProgramaClick(Sender: TObject);
  private
    { Private declarations }
    FMicroOndasDigital: TMicroOndasDigital;
    procedure BloquearDesbloquearControles(AEnable: Boolean);
    procedure Pausar;
    procedure Cancelar;
    procedure ErroExecucao(E: Exception);
    procedure FimExecucao(AAlimento: string);
  public
    { Public declarations }
    procedure Aquecer;
    procedure Update; override;
  end;

var
  FrmMicroOndasDigital: TFrmMicroOndasDigital;

implementation

uses
  UProgramaMicroOndas, UFrmProgramaMicroOndas;

{$R *.dfm}

procedure TFrmMicroOndasDigital.FormCreate(Sender: TObject);
begin
  FMicroOndasDigital := TMicroOndasDigital.Create();
  FMicroOndasDigital.OnFimExecucao  := Self.FimExecucao;
  FMicroOndasDigital.OnErroExecucao := Self.ErroExecucao;

  lstPrograma.Items.Clear;
  lstPrograma.Items.AddStrings(FMicroOndasDigital.GetListaProgramasStr);
  lstPrograma.ItemIndex := 0;
end;

procedure TFrmMicroOndasDigital.FimExecucao(AAlimento: string);
begin
  ShowMessage('O alimento '+AAlimento+' foi aquecido e está pronto para consumo.');
end;

procedure TFrmMicroOndasDigital.ErroExecucao(E: Exception);
begin
  ShowMessage(E.Message);
end;

procedure TFrmMicroOndasDigital.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FMicroOndasDigital) then
    FreeAndNil(FMicroOndasDigital);
end;

procedure TFrmMicroOndasDigital.NumberKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9',#8]) then
    Key := #0;
end;

procedure TFrmMicroOndasDigital.lstProgramaClick(Sender: TObject);
var
  Programa: TProgramaMicroOndas;
begin
  edtTempoCozimento.Enabled    := (lstPrograma.ItemIndex = 0);
  edtPotencia.Enabled          := (lstPrograma.ItemIndex = 0);
  memInstrucoes.Lines.Clear;
  if (lstPrograma.ItemIndex > 0) then
  begin
    Programa := FMicroOndasDigital.ListaProgramas[Pred(lstPrograma.ItemIndex)];
    memInstrucoes.Lines.Text := Programa.GetInstrucoesCompletas;
    edtTempoCozimento.Text := IntToStr(Programa.TempoCozimento);
    edtPotencia.Text       := IntToStr(Programa.Potencia);
  end;
end;

procedure TFrmMicroOndasDigital.btnAquecimentoRapidoClick(Sender: TObject);
begin
  lstPrograma.ItemIndex   := 0;
  edtTempoCozimento.Text := '30';
  edtPotencia.Text       := '8';
  Self.Aquecer;
end;

procedure TFrmMicroOndasDigital.btnStartClick(Sender: TObject);
begin
  if (not FMicroOndasDigital.EmExecucao) then
    Self.Aquecer
  else
    Self.Pausar;
end;

procedure TFrmMicroOndasDigital.btnCancelarClick(Sender: TObject);
begin
  Self.Cancelar;
end;

procedure TFrmMicroOndasDigital.btnAddProgramaClick(Sender: TObject);
var
  FrmProgramaMicroOndas: TFrmProgramaMicroOndas;
begin
  FrmProgramaMicroOndas := TFrmProgramaMicroOndas.Create(Self);
  try
    FrmProgramaMicroOndas.edtTempoCozimento.OnKeyPress := Self.NumberKeyPress;
    FrmProgramaMicroOndas.edtPotencia.OnKeyPress := Self.NumberKeyPress;
    if (FrmProgramaMicroOndas.ShowModal = mrOk) then
    begin
      FMicroOndasDigital.AddNovoPrograma(TProgramaMicroOndas.Create(FrmProgramaMicroOndas.Nome,
                                                                    FrmProgramaMicroOndas.Instrucao,
                                                                    StringReplace(FrmProgramaMicroOndas.AlimentosCompativeis.Text, sLineBreak, '|', [rfReplaceAll]),
                                                                    FrmProgramaMicroOndas.TempoCozimento,
                                                                    FrmProgramaMicroOndas.Potencia,
                                                                    FrmProgramaMicroOndas.CharAquecimento));
      lstPrograma.Items.Add(FrmProgramaMicroOndas.Nome);
    end;
  finally
    FreeAndNil(FrmProgramaMicroOndas);
  end;
end;

procedure TFrmMicroOndasDigital.btnRemoverProgramaClick(Sender: TObject);
begin
//
end;

procedure TFrmMicroOndasDigital.Aquecer;
var
  ProgramaSelecionado: TProgramaMicroOndasSelecionado;
begin
  Self.BloquearDesbloquearControles(False);
  try
    try
      if (lstPrograma.ItemIndex = 0) then
        ProgramaSelecionado := TProgramaMicroOndasSelecionado.Create(DefaultNomePrograma, EmptyStr, EmptyStr,
                                                                     StrToIntDef(edtTempoCozimento.Text, 0),
                                                                     StrToIntDef(edtPotencia.Text, 10),
                                                                     DefaultCharAquecimento)
      else
        ProgramaSelecionado := TProgramaMicroOndasSelecionado.Clone(FMicroOndasDigital.ListaProgramas[Pred(lstPrograma.ItemIndex)]);

      ProgramaSelecionado.Alimento := Trim(edtAlimento.Text);
      FMicroOndasDigital.Start(ProgramaSelecionado);
    except
      raise;
    end;
  finally
    FreeAndNil(ProgramaSelecionado);
  end;
end;

procedure TFrmMicroOndasDigital.Pausar;
begin
  FMicroOndasDigital.Pausado := not FMicroOndasDigital.Pausado;
end;

procedure TFrmMicroOndasDigital.Cancelar;
begin
  if FMicroOndasDigital.EmExecucao then
    FMicroOndasDigital.CancelarExecucao;
end;

procedure TFrmMicroOndasDigital.BloquearDesbloquearControles(AEnable: Boolean);
begin
  edtTempoCozimento.Enabled    := AEnable and (lstPrograma.ItemIndex = 0);
  edtPotencia.Enabled          := AEnable and (lstPrograma.ItemIndex = 0);
  edtAlimento.Enabled          := AEnable;
  lstPrograma.Enabled          := AEnable;
  btnAquecimentoRapido.Enabled := AEnable;  
  btnCancelar.Enabled          := not AEnable;
end;

procedure TFrmMicroOndasDigital.Update;
begin
  if (Subject is TMicroOndasDigital) then
  begin
    memOutput.Lines.Text := TMicroOndasDigital(Self.Subject).Output;
    if TMicroOndasDigital(Self.Subject).EmExecucao then
      btnStart.Caption := IfThen(TMicroOndasDigital(Self.Subject).Pausado, 'Retomar', 'Pausar')
    else
    begin
      btnStart.Caption := 'Iniciar';
      Self.BloquearDesbloquearControles(True);
    end;
  end;
  Application.ProcessMessages;
end;

end.
