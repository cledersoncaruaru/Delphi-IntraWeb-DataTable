unit ServerController;
interface
uses
  SysUtils, Classes, IWServerControllerBase, IWBaseForm, HTTPApp,
  // For OnNewSession Event
  UserSessionUnit, IWApplication, IWAppForm, IW.Browser.Browser, 
  IW.HTTP.Request, IW.HTTP.Reply;
type
  TIWServerController = class(TIWServerControllerBase)
    procedure IWServerControllerBaseNewSession(ASession: TIWApplication);
    procedure IWServerControllerBaseBind(const aHttpBindings,
      aHttpsBindings: TStrings);
    procedure IWServerControllerBaseConfig(Sender: TObject);
  private
    { Private declarations }
    
  public
    { Public declarations }
  end;
  function UserSession: TIWUserSession;
  function IWServerController: TIWServerController;
implementation
{$R *.dfm}
uses
  IWInit, IWGlobal, IWTemplateProcessorHTML;
function IWServerController: TIWServerController;
begin
  Result := TIWServerController(GServerController);
end;

function UserSession: TIWUserSession;
begin
  Result := TIWUserSession(WebApplication.Data);
end;
{ TIWServerController }
procedure TIWServerController.IWServerControllerBaseBind(const aHttpBindings,
  aHttpsBindings: TStrings);
begin
  aHttpBindings.Clear;
  aHttpsBindings.Clear;
  {$IFDEF DEBUG}
    aHttpBindings.Add('http://*:80/');
  {$ELSE}
    aHttpBindings.Add('http://SEUDOMINIO.COM.BR:80/');
    aHttpBindings.Add('http://www.SEUDOMINIO.COM.BR:80/');
    aHttpsBindings.Add('https://SEUDOMINIO.COM.BR:443/');
    aHttpsBindings.Add('https://www.SEUDOMINIO.COM.BR:443/');
  {$ENDIF}
end;
procedure TIWServerController.IWServerControllerBaseConfig(Sender: TObject);
begin
//    JavaScriptOptions.RenderjQuery := False;
    SecurityOptions.CheckSameUA    := False;
    SecurityOptions.CorsOrigin     := '*';
    ExceptionLogger.Enabled        := True;


    ExceptionLogger.FilePath :=  ExtractFilePath(ParamStr(0)) + '\files\LogError\';
      if not DirectoryExists(ExceptionLogger.FilePath) then
    forceDirectories(ExceptionLogger.FilePath);

    SSLOptions.EnableACME    := True;
  {$IFDEF DEBUG}
    SSLOptions.NonSSLRequest := nsAccept;
    SSLOptions.Port          := 0;
  {$ELSE}
    SSLOptions.NonSSLRequest := nsRedirect;
    SSLOptions.Port          := 443;
  {$ENDIF}

end;
procedure TIWServerController.IWServerControllerBaseNewSession(
  ASession: TIWApplication);
begin
  ASession.Data := TIWUserSession.Create(nil, ASession);

  {$IFDEF DEBUG}
   TIWTemplateCache.Instance.ClearCache;
{$ENDIF}

end;
initialization
  TIWServerController.SetServerControllerClass;
end.
