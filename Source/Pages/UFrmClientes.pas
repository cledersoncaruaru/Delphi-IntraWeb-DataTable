unit UFrmClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBase, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, IWCompEdit;

type
  TFrmClientes = class(TFrmBase)
    LABEL_TITLE: TIWLabel;
    COD_CLIENTE: TIWEdit;
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
    MinhaChavePK:Integer;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ServerController;

procedure TFrmClientes.IWAppFormCreate(Sender: TObject);
begin
  inherited;

   if ( TPS.Templates.Default ='') or (TPS.Templates.Default<> 'FrmClientes.html') then
        TPS.Templates.Default := 'FrmClientes.html';


      LABEL_TITLE.Text    := 'CADASTRO DE CLIENTES';

      //Pegando a variavel que Passei da Minha Lista de Clientes no Form Lista De Cliente
      UserSession.Clipboard.Get('MinhaPK',MinhaChavePK,True);
      COD_CLIENTE.Text   := MinhaChavePK.ToString;





end;

end.
