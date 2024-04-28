unit uBase;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML,System.StrUtils, Vcl.Controls, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton, IWCompLabel;

type
  TFrmBase = class(TIWAppForm)
    TPS: TIWTemplateProcessorHTML;
    BTN_POST: TIWButton;
    BTN_CANCEL: TIWButton;
    PARAMETRO_PASSADO: TIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
  public

  Procedure Menu(EventParams: TStringList);


  end;

implementation

{$R *.dfm}

uses uFrmDashBoard, uFrmLogin, UFrmClientes, UFrmListaCliente;


procedure TFrmBase.IWAppFormCreate(Sender: TObject);
begin

   RegisterCallBack('Menu',Menu);



  if self.Name = 'FrmLogin' then begin

     TPS.Templates.Default := '/FrmLogin.html';

  end else begin

    TPS.MasterTemplate          := '/master.html';
     TPS.Templates.Default       := '/'+self.Name+'.html';

  end;




end;


procedure TFrmBase.Menu(EventParams: TStringList);
var
 vFormname, Page : string;
begin

  Page  := EventParams.Values['page'];

    case AnsiIndexStr(Page,['login','dashboard','clientes','lista-clientes']) of

     0 : WebApplication.ShowForm(TFrmLogin,True,True);
     1 : WebApplication.ShowForm(TFrmDashBoard,True,True);
     2 : WebApplication.ShowForm(TFrmClientes,True,True);
     3 : WebApplication.ShowForm(TFrmListaCliente,True,True);
    end;

end;

end.
