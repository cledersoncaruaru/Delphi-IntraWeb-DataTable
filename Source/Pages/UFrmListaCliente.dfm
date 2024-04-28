inherited FrmListaCliente: TFrmListaCliente
  DesignLeft = 2
  DesignTop = 2
  inherited BTN_CANCEL: TIWButton
    OnAsyncClick = BTN_CANCELAsyncClick
  end
  object BTNDELETE: TIWButton [3]
    AlignWithMargins = False
    Left = 544
    Top = 192
    Width = 120
    Height = 30
    Caption = 'DELETAR'
    Color = clBtnFace
    FriendlyName = 'BTNDELETE'
    OnAsyncClick = BTNDELETEAsyncClick
  end
end
