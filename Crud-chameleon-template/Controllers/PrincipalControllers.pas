unit PrincipalControllers;

interface

uses
  System.SysUtils,DbContext, System.Classes, Web.HTTPApp, Web.HTTPProd, Web.Stencils,FireDAC.DApt,UserModel,System.Generics.Collections;
type
  TPrincipalController = class(TWebModule)
    Index: TWebStencilsProcessor;
    WebStencilsEngine1: TWebStencilsEngine;
    UsersView: TWebStencilsProcessor;
    WebFileDispatcher1: TWebFileDispatcher;
    UsersGridComp: TWebStencilsProcessor;
    procedure PrincipalControllerIndexPageAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure PrincipalControllerUsersAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure PrincipalControllerUserDeleletAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    FVersion: string;
    FTitle: string;
  public
    // this will not work in the WebStencilsEngine
    const
      WebTitle = 'WebStencils test';
      WebVersion = '0.3';
    // these will be available by the WebStencilsEngine parser
    property Title: string read FTitle write FTitle;
    property Version: string read FVersion write FVersion;
  end;


var
  WebModuleClass: TComponentClass = TPrincipalController;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TPrincipalController.PrincipalControllerIndexPageAction(
  Sender: TObject; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
begin
  Response.Content := Index.Content;
  Handled := True;
end;

procedure TPrincipalController.PrincipalControllerUserDeleletAction(
  Sender: TObject; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
begin
    var UserId := Request.QueryFields.Values['id'];
      DB.Delete(UserId.ToInteger());
       try
           Response.Content := UsersGridComp.Content;
      except
        on E:EWebStencilsLoginRequired do
          Response.Content := 'wspAccessDenied 405';
      end;
end;

procedure TPrincipalController.PrincipalControllerUsersAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Db.UserModel.Open();
  try
    if not WebStencilsEngine1.HasVar('Users') then
       WebStencilsEngine1.AddVar('Users', Db.UserModel, False);
    try
      Response.Content := UsersView.Content;
    except
      on E:EWebStencilsLoginRequired do
        Response.Content := 'wspAccessDenied 405';
    end;
  finally
       Db.UserModel.close();
       Handled := True;
  end;
end;

end.
