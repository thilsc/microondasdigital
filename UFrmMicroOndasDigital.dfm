object FrmMicroOndasDigital: TFrmMicroOndasDigital
  Left = 416
  Top = 138
  Width = 496
  Height = 379
  Caption = 'Micro-Ondas Digital'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    488
    348)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 49
    Height = 13
    Caption = 'Alimento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTempoCozimento: TLabel
    Left = 354
    Top = 15
    Width = 57
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Tempo (s)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 418
    Top = 15
    Width = 51
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Pot'#234'ncia'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 354
    Top = 56
    Width = 54
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Programa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblInstrucoes: TLabel
    Left = 16
    Top = 56
    Width = 60
    Height = 13
    Caption = 'Instru'#231#245'es'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnAddPrograma: TSpeedButton
    Left = 455
    Top = 53
    Width = 18
    Height = 18
    Anchors = [akTop, akRight]
    Caption = '[+]'
    OnClick = btnAddProgramaClick
  end
  object edtAlimento: TEdit
    Left = 16
    Top = 32
    Width = 330
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object edtTempoCozimento: TEdit
    Left = 354
    Top = 31
    Width = 57
    Height = 21
    Anchors = [akTop, akRight]
    MaxLength = 3
    TabOrder = 1
    Text = '30'
    OnKeyPress = NumberKeyPress
  end
  object edtPotencia: TEdit
    Left = 418
    Top = 31
    Width = 57
    Height = 21
    Anchors = [akTop, akRight]
    MaxLength = 2
    TabOrder = 2
    Text = '10'
    OnKeyPress = NumberKeyPress
  end
  object btnStart: TButton
    Left = 88
    Top = 217
    Width = 313
    Height = 33
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Iniciar'
    TabOrder = 6
    OnClick = btnStartClick
  end
  object btnAquecimentoRapido: TButton
    Left = 16
    Top = 217
    Width = 74
    Height = 33
    Anchors = [akLeft, akBottom]
    Caption = 'Aquecimento R'#225'pido'
    TabOrder = 5
    WordWrap = True
    OnClick = btnAquecimentoRapidoClick
  end
  object memOutput: TMemo
    Left = 16
    Top = 252
    Width = 459
    Height = 81
    Anchors = [akLeft, akRight, akBottom]
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = 4144959
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 4227327
    Font.Height = -11
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
  end
  object btnCancelar: TButton
    Left = 401
    Top = 217
    Width = 74
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'Cancelar'
    TabOrder = 7
    WordWrap = True
    OnClick = btnCancelarClick
  end
  object memInstrucoes: TMemo
    Left = 16
    Top = 72
    Width = 327
    Height = 138
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    BevelKind = bkFlat
    BorderStyle = bsNone
    Color = clSilver
    Enabled = False
    TabOrder = 3
  end
  object lstPrograma: TListBox
    Left = 354
    Top = 72
    Width = 121
    Height = 138
    Anchors = [akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 4
    OnClick = lstProgramaClick
  end
end
