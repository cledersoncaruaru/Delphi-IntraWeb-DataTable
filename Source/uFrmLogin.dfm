inherited FrmLogin: TFrmLogin
  Width = 541
  Height = 296
  ExplicitWidth = 541
  ExplicitHeight = 296
  DesignLeft = 2
  DesignTop = 2
  object USUARIO: TIWEdit [3]
    AlignWithMargins = False
    Left = 80
    Top = 104
    Width = 200
    Height = 32
    Css = 'form-control'
    StyleRenderOptions.RenderBorder = False
    FriendlyName = 'USUARIO'
    SubmitOnAsyncEvent = True
    Text = 'Usuario'
  end
  object SENHA: TIWEdit [4]
    AlignWithMargins = False
    Left = 80
    Top = 152
    Width = 200
    Height = 32
    Css = 'form-control'
    StyleRenderOptions.RenderBorder = False
    FriendlyName = 'SENHA'
    SubmitOnAsyncEvent = True
    DataType = stPassword
  end
  object BTN_LOGIN: TIWButton [5]
    AlignWithMargins = False
    Left = 112
    Top = 208
    Width = 120
    Height = 30
    Caption = 'BTN_LOGIN'
    Color = clBtnFace
    FriendlyName = 'BTN_LOGIN'
    OnAsyncClick = BTN_LOGINAsyncClick
  end
end
