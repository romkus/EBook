object Form1: TForm1
  Left = 145
  Top = 137
  Width = 241
  Height = 46
  Hint = #1060#1086#1088#1084#1072
  HorzScrollBar.Size = 25
  HorzScrollBar.Tracking = True
  VertScrollBar.Size = 25
  VertScrollBar.Tracking = True
  Align = alTop
  BiDiMode = bdLeftToRight
  Caption = #1055#1110#1076#1088#1091#1095#1085#1080#1082
  Color = clBtnFace
  TransparentColorValue = clBtnFace
  UseDockManager = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  ParentBiDiMode = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 48
    Top = 8
    object N1: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      object N2: TMenuItem
        Caption = '&'#1042#1110#1076#1082#1088#1080#1090#1080' '#1082#1085#1080#1075#1091'...'
        ShortCut = 16463
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = '&'#1047#1072#1082#1088#1080#1090#1080' '#1082#1085#1080#1075#1091
        ShortCut = 16469
        OnClick = N3Click
      end
      object N4: TMenuItem
        Caption = #1042#1080'&'#1081#1090#1080
        ShortCut = 49240
        OnClick = N4Click
      end
    end
    object NMenuPages: TMenuItem
      Caption = '&'#1057#1090#1086#1088#1110#1085#1082#1080
      object NMenuMainPage: TMenuItem
        Caption = '&'#1043#1086#1083#1086#1074#1085#1072
        ShortCut = 16461
        OnClick = NMenuMainPageClick
      end
    end
    object N5: TMenuItem
      Caption = '&'#1044' '#1110' '#1111
      object N6: TMenuItem
        Caption = '&'#1055#1077#1088#1077#1084#1072#1083#1102#1074#1072#1090#1080' '#1089#1090#1086#1088#1110#1085#1082#1080
        OnClick = N6Click
      end
    end
    object N7: TMenuItem
      Caption = #1044#1086'&'#1074#1110#1076#1082#1072
      object N8: TMenuItem
        Caption = #1055#1088#1086' &'#1087#1088#1086#1075#1088#1072#1084#1091'...'
        OnClick = N8Click
      end
      object N9: TMenuItem
        Caption = #1055#1088#1086' &'#1072#1074#1090#1086#1088#1072'...'
        OnClick = N9Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = #1050#1085#1080#1078#1082#1080' '#1110#1079' '#1089#1090#1086#1088#1110#1085#1086#1082' (*.txt; *.bop)|*.txt;*.bop|'#1042#1089#1110' '#1092#1072#1081#1083#1080'|*.*'
    Options = [ofReadOnly, ofHideReadOnly, ofEnableSizing]
    Title = #1042#1110#1076#1082#1088#1080#1074#1072#1085#1085#1103' '#1082#1085#1080#1075#1080
    Left = 8
    Top = 8
  end
end
