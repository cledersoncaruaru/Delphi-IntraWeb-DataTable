unit UFrmListaCliente;

interface

uses
  Buttons.Icons,
  System.StrUtils,
  Altert.SweetAlert2,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBase, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmListaCliente = class(TFrmBase)
    BTNDELETE: TIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure BTNDELETEAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTN_CANCELAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    { Private declarations }
    procedure Prc_Crud(EventParams: TStringList);
    Procedure Listar(aParams: TStrings; out aResult: String);

   Function ReturnCountSQL(Query: TFDQuery): Longint;
   Function Delete_Pessoa(ID:Integer; VAR vResult:String):Boolean;

  public
    { Public declarations }

     Procedure Get_Lista_Pessoa(FiltrarPor:Longint; aParams: TStrings; out aResult: String);


  end;

implementation

{$R *.dfm}

uses ServerController;

procedure TFrmListaCliente.BTNDELETEAsyncClick(Sender: TObject;
  EventParams: TStringList);
  var
  vResult : String;
  MinhaChavePrimaria:Integer;
 begin
  inherited;

  UserSession.Clipboard.Get('MinhaPK',MinhaChavePrimaria,True);

  if Delete_Pessoa (MinhaChavePrimaria, vResult)then begin

    WebApplication.CallBackResponse.AddJavaScriptToExecute(swalSuccess('CONFIRMA��O',vResult));
    WebApplication.CallBackResponse.AddJavaScriptToExecuteAsCDATA('$(''#Lista'').dataTable().api().ajax.reload();');

  end else
    WebApplication.CallBackResponse.AddJavaScriptToExecute(swalError('ATEN��O',vResult))

end;

procedure TFrmListaCliente.BTN_CANCELAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
var cancelado := 'Foi Cancelado';
end;

function TFrmListaCliente.Delete_Pessoa(ID: Integer; VAR vResult:String): Boolean;
var
  Qry          : TFDQuery;
begin

  Result  :=False;
  vResult := 'Prezado usu�rio ocorreu algo problema na exclus�o de seu registro.';

  Qry            := TFDQuery.Create(nil);
  Qry.Connection := UserSession.Conexao;

  try

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE PESSOA SET COD_STATUS=:COD_STATUS where (COD_PESSOA = :COD_PESSOA)');
    Qry.ParamByName('COD_PESSOA').AsInteger   := ID;
    Qry.ParamByName('COD_STATUS').AsInteger   := 2;
    Qry.ExecSQL;

    Result:=True;

    vResult := 'Registro Com o Status de Excluido.';

  finally
    Qry.Free;
  end;


end;

procedure TFrmListaCliente.Get_Lista_Pessoa(FiltrarPor: Longint;
  aParams: TStrings; out aResult: String);
var
  Qry          : TFDQuery;
  wresult      : string;
  wtotal       : Integer;
begin

  Qry             := TFDQuery.Create(nil);
  Qry.Connection  := UserSession.Conexao;

  try

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(' select  p.cod_pessoa, p.pes_razao, p.pes_cnpj_cpf, p.pes_email_nfe,      ');
    Qry.SQL.Add(' p.pes_telefone, p.pes_cidade, p.pes_uf, s.sta_descricao  from pessoa p   ');
    Qry.SQL.Add(' inner join status s on s.cod_status = p.cod_status                       ');
    Qry.SQL.Add(' WHERE S.COD_STATUS=1');


    if FiltrarPor < 0 then
       FiltrarPor:= 0;

     if aParams.Values['search[value]'] ='' then
        begin
          Qry.SQL.Add(' AND COD_PESSOA between 1 and 100');

        end
        ELSE
        BEGIN

          case FiltrarPor of
            0 : Qry.SQL.Add(' AND PES_RAZAO like ''%'+StringReplace(UpperCase(aParams.Values['search[value]']), ' ', '%', [rfReplaceAll])+'%'' ');
            1 : Qry.SQL.Add(' AND PES_FANTASIA like ''%'+StringReplace(UpperCase(aParams.Values['search[value]']), ' ', '%', [rfReplaceAll])+'%'' ');
            2 : Qry.SQL.Add(' AND COD_PESSOA ='+aParams.Values['search[value]']);
            3 : Qry.SQL.Add(' AND PES_CNPJ_CPF like ''%'+StringReplace(UpperCase(aParams.Values['search[value]']), ' ', '%', [rfReplaceAll])+'%'' ');
            4 : Qry.SQL.Add(' AND PES_INSC_ESTADUAL like ''%'+StringReplace(UpperCase(aParams.Values['search[value]']), ' ', '%', [rfReplaceAll])+'%'' ');
            5 : Qry.SQL.Add(' AND PES_CIDADE like ''%'+StringReplace(UpperCase(aParams.Values['search[value]']), ' ', '%', [rfReplaceAll])+'%'' ');
            6 : Qry.SQL.Add(' AND PES_UF like ''%'+StringReplace(UpperCase(aParams.Values['search[value]']), ' ', '%', [rfReplaceAll])+'%'' ');
          end;


        END;




    case aParams.Values['order[0][column]'].ToInteger of

      0: Qry.SQL.Add('Order by COD_PESSOA '+aParams.Values['order[0][dir]'] + ' ');
      1: Qry.SQL.Add('Order by PES_RAZAO '+aParams.Values['order[0][dir]'] + ' ');
      2: Qry.SQL.Add('Order by PES_CNPJ_CPF '+aParams.Values['order[0][dir]'] + ' ');
      3: Qry.SQL.Add('Order by PES_EMAIL_NFE '+aParams.Values['order[0][dir]'] + ' ');
      4: Qry.SQL.Add('Order by PES_TELEFONE '+aParams.Values['order[0][dir]'] + ' ');
      5: Qry.SQL.Add('Order by PES_CIDADE '+aParams.Values['order[0][dir]'] + ' ');
      6: Qry.SQL.Add('Order by PES_UF '+aParams.Values['order[0][dir]'] + ' ');
      7: Qry.SQL.Add('Order by sta_descricao '+aParams.Values['order[0][dir]'] + ' ');


    end;

    Qry.FetchOptions.RecsMax:=StrToInt(aParams.Values['length']);
    Qry.FetchOptions.RecsSkip:=StrToInt(aParams.Values['start']);

    Qry.Open;


    // aqui � feito para o Firedac Paginar
    wtotal := ReturnCountSQL(Qry);

    wresult:='{'+
      '"draw": '+StrToIntDef(aParams.Values['draw'],0).ToString + ', ' +
      '"recordsTotal": '+wtotal.ToString + ', ' +
      '"recordsFiltered": '+wtotal.ToString + ', ' +
      '"data": [';

    while not Qry.Eof do
    begin

        wresult := wresult + '['+
                           '"'+StringReplace(Trim(Qry.FieldByName('COD_PESSOA').AsString), '"', '\"', [rfReplaceAll])+'", '+
                           '"'+StringReplace(Trim(Qry.FieldByName('PES_RAZAO').AsString), '"', '\"', [rfReplaceAll])+'", '+
                           '"'+StringReplace(Trim(Qry.FieldByName('PES_CNPJ_CPF').AsString), '"', '\"', [rfReplaceAll])+'", '+
                           '"'+StringReplace(Trim(Qry.FieldByName('PES_EMAIL_NFE').AsString), '"', '\"', [rfReplaceAll])+'", '+
                           '"'+StringReplace(Trim(Qry.FieldByName('PES_TELEFONE').AsString), '"', '\"', [rfReplaceAll])+'", '+
                           '"'+StringReplace(Trim(Qry.FieldByName('PES_CIDADE').AsString), '"', '\"', [rfReplaceAll])+'", '+
                           '"'+StringReplace(Trim(Qry.FieldByName('PES_UF').AsString), '"', '\"', [rfReplaceAll])+'", '+
                           '"'+StringReplace(Trim(Qry.FieldByName('sta_descricao').AsString), '"', '\"', [rfReplaceAll])+'", '+
                           '"<button type=\"button\" class=\"btn btn-warning '+Button_Size+'\"    onclick=\"ajaxCall(''Crud'', ''Edit='+Qry.FieldByName('COD_PESSOA').AsString+''')\"><i class=\"'+Icon_Edit+'\"></i></button> '+
                           ' <button type=\"button\" class=\"btn btn-danger '+Button_Size+'\"   onclick=\"ajaxCall(''Crud'', ''Delete='+Qry.FieldByName('COD_PESSOA').AsString+''')\"><i class=\"'+Icon_Delete+'\"></i></button> "' +

                           '],';
      Qry.Next;
    end;
    Qry.Close;

    if wtotal <= 0 then
      wresult := wresult + ']}'
    else
      wresult := LeftStr(Trim(wresult),Length(Trim(wresult))-1) + ']}';

    aResult := wresult;

  finally
    Qry.Free;
  end;


end;

procedure TFrmListaCliente.IWAppFormCreate(Sender: TObject);
begin
  inherited;


  if ( TPS.Templates.Default ='') or (TPS.Templates.Default<> 'FrmListaCliente.html') then
       TPS.Templates.Default := 'FrmListaCliente.html';


      RegisterCallBack('Pessoa',Listar);
      RegisterCallBack('Crud', Prc_Crud);


end;

procedure TFrmListaCliente.Listar(aParams: TStrings; out aResult: String);
begin

Get_Lista_Pessoa(0,aParams,aResult);

end;

procedure TFrmListaCliente.Prc_Crud(EventParams: TStringList);
begin



   if (StrToIntDef(EventParams.Values['Edit'],0) > 0)then begin

    UserSession.Clipboard.Put('MinhaPK', StrToIntDef(EventParams.Values['Edit'],-1));
    WebApplication.CallBackResponse.AddJavaScriptToExecute('ajaxCall(''Menu'',''page=clientes'')');
    Exit;


  end;

  if (StrToIntDef(EventParams.Values['Delete'],0) > 0)then begin
      UserSession.Clipboard.Put('MinhaPK', StrToIntDef(EventParams.Values['Delete'],-1));

      WebApplication.CallBackResponse.AddJavaScriptToExecute(swalConfirm( 'EXCLUS�O DE REGISTRO',
                                                           'Prezado usu�rio deseja EXCLUIR este REGISTRO agora?',
                                                           'error',
                                                           'SIM',
                                                           'N�O',
                                                           'BTNDELETE',
                                                           'BTN_CANCEL'));


  end;




end;

function TFrmListaCliente.ReturnCountSQL(Query: TFDQuery): Longint;
var
  Qry : TFDQuery;
begin

  Result:= 0;

   Qry            := TFDQuery.Create(nil);
   Qry.Connection := UserSession.Conexao;

  try

    Qry.SQL.Add('SELECT COUNT(*) FROM (' + Query.SQL.Text + ') AS TEMP1');

    try
      Qry.Open;
      Result := Qry.FieldByName('COUNT').AsInteger;
     except

      on E: Exception do begin

        raise Exception.Create(E.Message);
      end;

    end;

  finally
    Qry.Free;
  end;


end;

end.
