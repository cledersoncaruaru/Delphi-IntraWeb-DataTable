object IWServerController: TIWServerController
  AppName = 'ErpCurso'
  Description = 'Curso ERP IntraWeb'
  DisplayName = 'Curso ERP IntraWeb'
  Port = 80
  Version = '15.6.1'
  SessionOptions.RestartExpiredSession = True
  OnConfig = IWServerControllerBaseConfig
  OnNewSession = IWServerControllerBaseNewSession
  OnBind = IWServerControllerBaseBind
  Height = 310
  Width = 342
end
