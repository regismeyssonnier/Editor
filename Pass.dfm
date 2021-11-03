object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Password'
  ClientHeight = 422
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    624
    422)
  PixelsPerInch = 96
  TextHeight = 13
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 624
    Height = 425
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'RichEdit1')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    Zoom = 100
  end
  object MainMenu1: TMainMenu
    Left = 288
    Top = 32
    object Fichier1: TMenuItem
      Caption = 'Fi&chier'
      object Ouvrir1: TMenuItem
        Caption = '&Ouvrir'
        OnClick = Ouvrir1Click
      end
      object OuvrirFichier1: TMenuItem
        Caption = 'Ou&vrir Fichier'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Fermer1: TMenuItem
        Caption = '&Fermer'
        OnClick = Fermer1Click
      end
    end
    object Edition1: TMenuItem
      Caption = '&Edition'
      object trouver1: TMenuItem
        Caption = '&Trouver'
        OnClick = trouver1Click
      end
    end
    object N2: TMenuItem
      Caption = '?'
      object Apropos1: TMenuItem
        Caption = '&A propos'
        OnClick = Apropos1Click
      end
    end
  end
  object FindDialog1: TFindDialog
    OnFind = FindDialog1Find
    Left = 504
    Top = 248
  end
end
