object Dlg_PesquisaCliente: TDlg_PesquisaCliente
  Left = 0
  Top = 0
  Caption = 'Pesquisa de Clientes'
  ClientHeight = 412
  ClientWidth = 747
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object label60: TLabel
    Left = 8
    Top = 318
    Width = 82
    Height = 15
    Caption = 'Pesquisa Por :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Lbl_QtdeReg: TLabel
    Left = 613
    Top = 316
    Width = 126
    Height = 15
    AutoSize = False
    Caption = 'Qtde Registro : 9999'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dbgrd1: TDBGrid
    Left = 0
    Top = 45
    Width = 728
    Height = 265
    Color = clCream
    DataSource = dm.DS_PesCliente
    FixedColor = clGray
    Font.Charset = ANSI_CHARSET
    Font.Color = clNone
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbgrd1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'COD_CLIENTE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMenuText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clGray
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 68
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMenuText
        Font.Height = -12
        Font.Name = 'Terminal'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clGray
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 528
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO_PESSOA'
        Title.Caption = 'Tipo de Pessoa'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clGray
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 108
        Visible = True
      end>
  end
  object RG_Situacao: TRadioGroup
    Left = 335
    Top = 318
    Width = 90
    Height = 66
    Caption = 'Situa'#231#227'o'
    ItemIndex = 1
    Items.Strings = (
      'Todos '
      'Ativos'
      'Inativos')
    TabOrder = 1
    OnClick = RG_SituacaoClick
  end
  object RG_Ordem: TRadioGroup
    Left = 431
    Top = 318
    Width = 82
    Height = 66
    Caption = 'Ordenar'
    ItemIndex = 1
    Items.Strings = (
      'C'#243'digo'
      'Nome ')
    TabOrder = 2
    OnClick = RG_OrdemClick
  end
  object EdPesq: TEdit
    Left = 96
    Top = 333
    Width = 233
    Height = 22
    CharCase = ecUpperCase
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnChange = EdPesqChange
  end
  object CB_Pesquisa: TComboBox
    Left = 5
    Top = 333
    Width = 85
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    Text = 'Nome'
    OnChange = CB_PesquisaChange
    Items.Strings = (
      'C'#243'digo'
      'Nome')
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 747
    Height = 39
    Align = alTop
    Alignment = taLeftJustify
    BevelInner = bvLowered
    Caption = '  Pesquisa de Clientes'
    Color = clNavy
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 5
    ExplicitWidth = 610
  end
  object Rg_Tipo: TRadioGroup
    Left = 519
    Top = 316
    Width = 90
    Height = 66
    Caption = 'Tipo'
    ItemIndex = 2
    Items.Strings = (
      'F'#237'sica'
      'Juridica'
      'Todos')
    TabOrder = 6
    OnClick = RG_SituacaoClick
  end
end
