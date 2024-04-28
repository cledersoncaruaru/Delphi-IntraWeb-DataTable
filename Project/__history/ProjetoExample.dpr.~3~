program ProjetoExample;

uses
  FastMM4,
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  IWStartHSys,
  uBase in '..\Source\base\uBase.pas' {FrmBase: TIWAppForm},
  ServerController in 'ServerController.pas' {IWServerController: TIWServerControllerBase},
  UserSessionUnit in 'UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase},
  uFrmLogin in '..\Source\uFrmLogin.pas' {FrmLogin: TIWAppForm},
  uFrmDashBoard in '..\Source\uFrmDashBoard.pas' {FrmDashBoard: TIWAppForm},
  DataBase.BD.Funcoes in '..\Source\DataBase\DataBase.BD.Funcoes.pas',
  Buttons.Icons in '..\Source\BootsTrap\Componentes\Buttons\Buttons.Icons.pas',
  uCriptografia in '..\Source\Funcoes\uCriptografia.pas';

{$R *.res}

begin
  TIWStartHSys.Execute(True);

  {$IFDEF DEBUG}
  TIWStartHSys.Execute(True);
  {$ELSE}
  TIWStartHSys.Execute(false);
  {$ENDIF}


end.
