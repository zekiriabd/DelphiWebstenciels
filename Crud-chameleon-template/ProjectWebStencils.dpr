program ProjectWebStencils;
{$APPTYPE GUI}

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  WebPrograme in 'WebPrograme.pas' {Form1},
  PrincipalControllers in 'Controllers\PrincipalControllers.pas' {PrincipalController: TWebModule},
  UserModel in 'Models\UserModel.pas',
  DbContext in 'Models\DbContext.pas' {Db: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDb, Db);
  Application.Run;
end.
