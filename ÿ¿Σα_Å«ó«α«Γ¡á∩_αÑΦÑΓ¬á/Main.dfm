object MainForm: TMainForm
  Left = 247
  Top = 112
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1064#1080#1092#1088' "'#1055#1086#1074#1086#1088#1086#1090#1085#1072#1103' '#1088#1077#1096#1077#1090#1082#1072'"'
  ClientHeight = 436
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SizeLabel: TLabel
    Left = 16
    Top = 16
    Width = 39
    Height = 13
    Caption = #1056#1072#1079#1084#1077#1088':'
  end
  object TextLabel: TLabel
    Left = 16
    Top = 44
    Width = 33
    Height = 13
    Caption = #1058#1077#1082#1089#1090':'
  end
  object ClicheLabel: TLabel
    Left = 16
    Top = 76
    Width = 54
    Height = 13
    Caption = #1058#1088#1072#1092#1072#1088#1077#1090':'
  end
  object LatticeLabel: TLabel
    Left = 272
    Top = 76
    Width = 46
    Height = 13
    Caption = #1058#1072#1073#1083#1080#1094#1072':'
  end
  object XLabel: TLabel
    Left = 130
    Top = 16
    Width = 6
    Height = 13
    Caption = 'X'
  end
  object MaxLabel: TLabel
    Left = 511
    Top = 24
    Width = 6
    Height = 13
    Alignment = taRightJustify
    Caption = '*'
  end
  object DecryptLabel: TLabel
    Left = 16
    Top = 320
    Width = 122
    Height = 13
    Caption = #1044#1077#1096#1080#1092#1088#1086#1074#1072#1085#1085#1099#1081' '#1090#1077#1082#1089#1090':'
  end
  object SpeedLabel: TLabel
    Left = 456
    Top = 320
    Width = 52
    Height = 13
    Caption = #1057#1082#1086#1088#1086#1089#1090#1100':'
  end
  object XSizeEdit: TEdit
    Left = 64
    Top = 12
    Width = 41
    Height = 21
    TabOrder = 0
    Text = '10'
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 417
    Width = 530
    Height = 19
    Panels = <>
  end
  object TextEdit: TEdit
    Left = 64
    Top = 40
    Width = 452
    Height = 21
    TabOrder = 2
    Text = #1052#1077#1090#1086#1076#1099' '#1080' '#1089#1088#1077#1076#1089#1090#1074#1072' '#1079#1072#1097#1080#1090#1099' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' - '#1096#1080#1092#1088' '#1055#1086#1074#1086#1088#1086#1090#1085#1072#1103' '#1088#1077#1096#1077#1090#1082#1072
    OnChange = ResetButtonClick
  end
  object Cliche: TStringGrid
    Left = 16
    Top = 96
    Width = 243
    Height = 213
    ColCount = 10
    DefaultColWidth = 23
    DefaultRowHeight = 20
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 10
    FixedRows = 0
    TabOrder = 3
    OnDrawCell = ClicheDrawCell
  end
  object Table: TStringGrid
    Left = 272
    Top = 96
    Width = 243
    Height = 213
    ColCount = 10
    DefaultColWidth = 23
    DefaultRowHeight = 20
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 10
    FixedRows = 0
    TabOrder = 4
    OnDrawCell = TableDrawCell
  end
  object XUpDown: TUpDown
    Left = 105
    Top = 12
    Width = 16
    Height = 21
    Associate = XSizeEdit
    Min = 4
    Max = 10
    Increment = 2
    Position = 10
    TabOrder = 5
    OnClick = XUpDownClick
  end
  object CryptButton: TButton
    Left = 16
    Top = 378
    Width = 85
    Height = 25
    Caption = #1064#1080#1092#1088#1086#1074#1072#1090#1100
    Default = True
    TabOrder = 6
    OnClick = CryptButtonClick
  end
  object DecryptButton: TButton
    Left = 108
    Top = 378
    Width = 85
    Height = 25
    Caption = #1044#1077#1096#1080#1092#1088#1086#1074#1072#1090#1100
    TabOrder = 7
    OnClick = DecryptButtonClick
  end
  object CloseButton: TButton
    Left = 431
    Top = 378
    Width = 85
    Height = 25
    Cancel = True
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 8
    OnClick = CloseButtonClick
  end
  object DecryptText: TEdit
    Left = 16
    Top = 340
    Width = 425
    Height = 21
    Cursor = crArrow
    ReadOnly = True
    TabOrder = 9
  end
  object ResetButton: TButton
    Left = 200
    Top = 378
    Width = 85
    Height = 25
    Caption = #1057#1073#1088#1086#1089
    TabOrder = 10
    OnClick = ResetButtonClick
  end
  object YSizeEdit: TEdit
    Left = 144
    Top = 12
    Width = 41
    Height = 21
    TabOrder = 11
    Text = '10'
  end
  object YUpDown: TUpDown
    Left = 185
    Top = 12
    Width = 16
    Height = 21
    Associate = YSizeEdit
    Min = 4
    Max = 10
    Increment = 2
    Position = 10
    TabOrder = 12
    OnClick = XUpDownClick
  end
  object Speed: TTrackBar
    Left = 448
    Top = 338
    Width = 74
    Height = 33
    Min = 1
    Position = 2
    TabOrder = 13
  end
  object XPManifest: TXPManifest
    Left = 328
    Top = 8
  end
end
