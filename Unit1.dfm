object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1059#1090#1080#1083#1080#1090#1072' '#1087#1088#1086#1074#1077#1088#1082#1080' '#1092#1072#1081#1083#1086#1074' '#1074' '#1073#1072#1079#1077' '#1079#1072#1089#1090#1088#1072#1093#1086#1074#1072#1085#1085#1099#1093
  ClientHeight = 272
  ClientWidth = 672
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 9
    Top = 8
    Width = 156
    Height = 13
    Caption = #1042#1099#1073#1080#1088#1077#1090#1077' '#1092#1072#1081#1083' '#1076#1083#1103' '#1087#1088#1086#1074#1077#1088#1082#1080':'
  end
  object lbl2: TLabel
    Left = 16
    Top = 54
    Width = 149
    Height = 13
    Caption = #1042#1099#1073#1080#1088#1077#1090#1077' '#1103#1095#1077#1081#1082#1080' '#1089' '#1076#1072#1085#1085#1099#1084#1080':'
  end
  object lbl3: TLabel
    Left = 16
    Top = 88
    Width = 48
    Height = 13
    Caption = #1060#1072#1084#1080#1083#1080#1103':'
  end
  object lbl4: TLabel
    Left = 153
    Top = 88
    Width = 23
    Height = 13
    Caption = #1048#1084#1103':'
  end
  object lbl5: TLabel
    Left = 288
    Top = 88
    Width = 53
    Height = 13
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
  end
  object lbl6: TLabel
    Left = 440
    Top = 88
    Width = 84
    Height = 13
    Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103':'
  end
  object lbl7: TLabel
    Left = 16
    Top = 120
    Width = 112
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1089#1090#1088#1086#1082#1080' '#1085#1072#1095#1072#1083#1072':'
  end
  object lbl8: TLabel
    Left = 280
    Top = 120
    Width = 106
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1089#1090#1088#1086#1082#1080' '#1082#1086#1085#1094#1072':'
  end
  object btn4: TSpeedButton
    Left = 544
    Top = 25
    Width = 107
    Height = 23
    AllowAllUp = True
    GroupIndex = -1
    Caption = #1054#1057#1052#1055'_'#1085#1077#1080#1076#1077#1085
    OnClick = btn4Click
  end
  object edt1: TEdit
    Left = 16
    Top = 27
    Width = 441
    Height = 21
    TabOrder = 0
  end
  object btn1: TButton
    Left = 463
    Top = 25
    Width = 75
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = btn1Click
  end
  object edt2: TEdit
    Left = 70
    Top = 85
    Width = 75
    Height = 21
    TabOrder = 2
  end
  object edt3: TEdit
    Left = 192
    Top = 85
    Width = 81
    Height = 21
    TabOrder = 3
  end
  object edt4: TEdit
    Left = 347
    Top = 85
    Width = 78
    Height = 21
    TabOrder = 4
  end
  object edt5: TEdit
    Left = 528
    Top = 85
    Width = 73
    Height = 21
    TabOrder = 5
  end
  object edt6: TEdit
    Left = 137
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 6
  end
  object edt7: TEdit
    Left = 403
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 7
  end
  object btn2: TButton
    Left = 18
    Top = 230
    Width = 75
    Height = 25
    Caption = #1053#1072#1095#1072#1090#1100
    TabOrder = 8
    OnClick = btn2Click
  end
  object chk1: TCheckBox
    Left = 18
    Top = 159
    Width = 147
    Height = 17
    Caption = #1042#1089#1077#1093'('#1054#1090#1078#1072#1090#1072' '#1090#1086#1083#1100#1082#1086' '#1078#1076')'
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
  object pb1: TProgressBar
    Left = 18
    Top = 194
    Width = 638
    Height = 17
    ParentShowHint = False
    Step = 1
    ShowHint = False
    TabOrder = 10
  end
  object dlgOpen1: TOpenDialog
    Left = 245
    Top = 221
  end
  object con1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=TGA378Lm'
      'Protocol=TCPIP'
      'Server=172.31.8.123'
      'Database=C:\NUZService\Sprav.fdb'
      'RoleName=ROOT'
      'CharacterSet=WIN1251'
      'DriverID=FB')
    LoginPrompt = False
    Left = 381
    Top = 228
  end
  object fdphysfbdrvrlnk1: TFDPhysFBDriverLink
    VendorLib = 'C:\'#1080#1089#1093#1086#1076#1085#1080#1082#1080'\ishodniki\Debug\Win32\fbclient\fbclient.dll'
    Embedded = True
    Left = 317
    Top = 227
  end
  object fdtrnsctn1: TFDTransaction
    Options.Isolation = xiSnapshot
    Options.ReadOnly = True
    Connection = con1
    Left = 436
    Top = 229
  end
  object fdqryRead: TFDQuery
    Connection = con1
    Transaction = fdtrnsctn1
    Left = 499
    Top = 232
    ParamData = <
      item
        Name = 'ser'
      end
      item
        Name = 'num'
      end>
  end
end
