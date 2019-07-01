object FrmProgramaMicroOndas: TFrmProgramaMicroOndas
  Left = 94
  Top = 140
  BorderStyle = bsDialog
  Caption = 'Micro-Ondas Digital - Adicionar Novo Programa'
  ClientHeight = 263
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblAlimentosCompativeis: TLabel
    Left = 72
    Top = 96
    Width = 107
    Height = 13
    Caption = 'Alimentos Compat'#237'veis'
  end
  object edtNome: TLabeledEdit
    Left = 16
    Top = 32
    Width = 265
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Nome'
    TabOrder = 0
  end
  object edtInstrucao: TLabeledEdit
    Left = 16
    Top = 70
    Width = 265
    Height = 21
    EditLabel.Width = 44
    EditLabel.Height = 13
    EditLabel.Caption = 'Instru'#231#227'o'
    TabOrder = 1
  end
  object edtTempoCozimento: TLabeledEdit
    Left = 16
    Top = 108
    Width = 41
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'Tempo'
    MaxLength = 3
    TabOrder = 2
  end
  object edtPotencia: TLabeledEdit
    Left = 16
    Top = 148
    Width = 41
    Height = 21
    EditLabel.Width = 42
    EditLabel.Height = 13
    EditLabel.Caption = 'Pot'#234'ncia'
    MaxLength = 2
    TabOrder = 3
  end
  object edtCaractere: TLabeledEdit
    Left = 16
    Top = 188
    Width = 41
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Caractere'
    MaxLength = 1
    TabOrder = 4
  end
  object memAlimentosCompativeis: TMemo
    Left = 72
    Top = 112
    Width = 209
    Height = 97
    TabOrder = 5
  end
  object btnOK: TButton
    Left = 48
    Top = 224
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 6
  end
  object btnCancelar: TButton
    Left = 152
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 7
  end
end
