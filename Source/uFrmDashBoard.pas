unit uFrmDashBoard;
interface
uses

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBase, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompButton, IWCompLabel, IWCanvas, IWChartJS, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWSweetAlert, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,PngImage,IWColor, IWTypes;
type
  TFrmDashBoard = class(TFrmBase)
    BOTAOFORM: TIWButton;
    IWSweetAlert1: TIWSweetAlert;

  private
    { Private declarations }




  public
    { Public declarations }
  end;

implementation
{$R *.dfm}

uses UFrmClientes, ServerController,IW.Common.AppInfo;



end.