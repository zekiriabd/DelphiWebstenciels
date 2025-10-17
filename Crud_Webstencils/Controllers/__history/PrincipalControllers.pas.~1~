unit PrincipalControllers;

interface

uses
  System.SysUtils,DbContext, System.Classes, Web.HTTPApp, Web.HTTPProd,
  Web.Stencils,FireDAC.DApt,UserModel,System.Generics.Collections;
type
  TPrincipalController = class(TWebModule)
    Index: TWebStencilsProcessor;
    WebStencilsEngine1: TWebStencilsEngine;
    UsersView: TWebStencilsProcessor;
    WebFileDispatcher1: TWebFileDispatcher;
    UsersGridComp: TWebStencilsProcessor;
    UserEdit: TWebStencilsProcessor;
    LoginView: TWebStencilsProcessor;
    procedure PrincipalControllerIndexPageAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure PrincipalControllerUsersAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure PrincipalControllerUserDeleletAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure PrincipalControllerUserPostAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure PrincipalControllerUserEditAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure PrincipalControllerLoginAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure PrincipalControllerLoginPostAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleDestroy(Sender: TObject);
    procedure WebModuleCreate(Sender: TObject);
  private
    FVersion: string;
    FTitle: string;
    procedure UserLoggedIn(isLogreg : Boolean; roles : string);
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
  Db: TData;
implementation
  uses Web.StencilsConst,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  System.NetEncoding,
  System.JSON,
  System.Net.URLClient;


{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}


function GetRolesFromToken(const JWT: string): string;
var
  Parts: TArray<string>;
  Payload: string;
  JSONPayload: TJSONObject;
  RolesArray: TJSONArray;
begin
  Result := ''; // Initialize result

  // Split the JWT into its three parts
  Parts := JWT.Split(['.']);
  if Length(Parts) < 2 then
    Exit; // Not a valid JWT

  // The payload is the second part (index 1)
  Payload := Parts[1];

  // Add padding if necessary
  case Length(Payload) mod 4 of
    2: Payload := Payload + '==';
    3: Payload := Payload + '=';
  end;

  // Decode the Base64Url encoded payload
  Payload := Payload.Replace('-', '+').Replace('_', '/'); // Convert to standard Base64
  Payload := TNetEncoding.Base64.Decode(Payload); // Decode Base64

  // Parse the JSON payload
  JSONPayload := TJSONObject.ParseJSONValue(Payload) as TJSONObject;
  try
    if Assigned(JSONPayload) then // Check if "roles" is present in the payload
      if JSONPayload.TryGetValue<TJSONArray>('https://softweb/api/roles', RolesArray) then
        Result := RolesArray.Items[0].Value; // Concatenate roles
  finally
    JSONPayload.Free; // Free the JSON object
  end;
end;


function GetAuth0Token(login : string ; password : string) : string;
var
  Response: IHTTPResponse;
  JSONBody: TStringStream;
  URL: string;
begin
  var HttpClient := THTTPClient.Create;
  try
    URL := 'https://softweb.eu.auth0.com/oauth/token';
    JSONBody := TStringStream.Create(
      '{' +
      '"client_id":"aSrQkmYTNo2x7Hjfn4lTigpKZNMw80Hb",' +
      '"client_secret":"EXOHRIgF15NjVz6X7PjIBIkj4mMeazT9mkwl2-xqmq8OvyxSgZ8LY-84mCfo4pH1",' +
      '"audience":"https://softweb/api",' +
      '"grant_type": "password",' +
      '"username": "'+ login +'",' +
      '"password": "'+ password +'",' +
      '"scope": "openid profile email",' +
      '"connection": "Username-Password-Authentication"' +
      '}',
      TEncoding.UTF8);

    // Set the content type
    JSONBody.Position := 0; // Reset the stream position

    // Send the request and get the response
    Response := HttpClient.Post(URL, JSONBody, nil, [TNetHeader.Create('Content-Type', 'application/json'),
      TNetHeader.Create('__cf_bm', 'QLZ16o60dVU3gU4hPeMMJmuCv54D6b4KCqI56rps6LY-1727530348-1.0.1.1-AsrkgnKCagNVnUw8Q1JxQGPnHL9IAf8.3mFGjmWHo7RIZUGpDpbQIrcU5.dCpvSa'),
      TNetHeader.Create('did', 's%3Av0%3Ab330793d-b4a9-4b98-b995-f25dafbc70e4.81eP6ZcZw3P0NhIrZejqh3iWixzyU82kcvxVqXapiwY'),
      TNetHeader.Create('did_compat', 's%3Av0%3Ab330793d-b4a9-4b98-b995-f25dafbc70e4.81eP6ZcZw3P0NhIrZejqh3iWixzyU82kcvxVqXapiwY')
    ]);

    // Check the response status
    if Response.StatusCode = 200 then
      Result := Response.ContentAsString
    else
      Result := '';

  finally
    HttpClient.Free;
    JSONBody.Free;
  end;




end;

procedure TPrincipalController.UserLoggedIn(isLogreg : Boolean; roles : string);
begin
   for var i := 0 to ComponentCount - 1 do
    if Components[i] is TWebStencilsProcessor then
    begin
      TWebStencilsProcessor(Components[i]).UserLoggedIn := True;
      TWebStencilsProcessor(Components[i]).UserRoles := roles;
    end;
end;

procedure TPrincipalController.WebModuleCreate(Sender: TObject);
begin
   Db:= TData.Create(self);
end;

procedure TPrincipalController.WebModuleDestroy(Sender: TObject);
begin
 Db.Free;
end;

procedure SetCookie(Response: TWebResponse; const Token: string);
var
  MyCookies: TStringList;
begin
  MyCookies := TStringList.Create;
  MyCookies.Add('Token=' + Token);
  Response.SetCookieField(MyCookies, '/', '/', (Now + 1), true, true);
end;

function GetCookie(ARequest: TWebRequest; const Key: string): string;
begin
  Result := ARequest.CookieFields.Values[Key];
end;

procedure TPrincipalController.PrincipalControllerLoginPostAction(
  Sender: TObject; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
var
  login, password: string;
begin
  login := Request.ContentFields.Values['user-name'];
  password := Request.ContentFields.Values['user-password'];

   var token := GetAuth0Token(login,password);
   SetCookie(Response, token);

  if token <> '' then
  begin
    var roles := GetRolesFromToken(token);
    UserLoggedIn(True, roles);
    Response.SendRedirect('/');
  end
  else
    Response.Content := 'erreur';

  Handled := True;
end;

procedure TPrincipalController.PrincipalControllerIndexPageAction(
  Sender: TObject; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
begin

  try
       if (Index.UserLoggedIn <> true)  then
       begin
          var token := GetCookie(Request,'Token');
          if token <> '' then
          begin
            var roles := GetRolesFromToken(token);
            UserLoggedIn(True, roles);
          end;
       end;

       Response.Content := Index.Content;
  except
        on E:EWebStencilsLoginRequired do
  Response.SendRedirect('/login');
  end;

  Handled := True;
end;

procedure TPrincipalController.PrincipalControllerLoginAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
      try
           Response.Content := LoginView.Content;
      except
        on E:EWebStencilsLoginRequired do
           Response.Content := 'error';
      end;
end;






procedure TPrincipalController.PrincipalControllerUserDeleletAction(
  Sender: TObject; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
begin
    var UserId := Request.QueryFields.Values['id'];
      Db.UserDelete(UserId.ToInteger());
       try
           Response.Content := UsersGridComp.Content;
      except
        on E:EWebStencilsLoginRequired do
          Response.Content := 'wspAccessDenied 405';
      end;
end;

procedure TPrincipalController.PrincipalControllerUserEditAction(
  Sender: TObject; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
begin
 var UserId := Request.QueryFields.Values['id'];
 Db.UserModel.Open();
 try
   if (UserId <> '0') then
   begin
      if not (Db.UserModel.FindKey([UserId])) then
         Response.Content := 'not found 501';
   end
   else
        Db.UserModel.Insert;
       //WebStencilsEngine1.AddVar('User', nil, False);

          try
          if not WebStencilsEngine1.HasVar('User') then
             WebStencilsEngine1.AddVar('User', Db.UserModel, True);

          Response.Content := '<div id="user-content">' + UserEdit.Content + '</div>';
          except
          on E:EWebStencilsLoginRequired do
            Response.Content := 'wspAccessDenied 405';
          end;
  finally
       Db.UserModel.close();
       Handled := True;
  end;
end;


procedure TPrincipalController.PrincipalControllerUserPostAction(
  Sender: TObject; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);

begin
  {var user := UserModel.TUser.Create;
  user.FirstName := Request.ContentFields.Values['firstName'];
  user.LastName := Request.ContentFields.Values['lastName'];
  user.Id := Request.QueryFields.Values['id'].ToInteger();

  DB.UserUpdate(user);
 }
 try
    try
    var UserId := Request.QueryFields.Values['id'];
     Db.UserModel.Open();

   if (UserId <> '-1') then
   begin

    Db.UserModel.FindKey([UserId]);
    Db.UserModel.Edit;
    Db.UserModelFirstName.Value :=  Request.ContentFields.Values['firstName'];
    Db.UserModelLastName.Value  :=  Request.ContentFields.Values['lastName'];
    Db.UserModel.Post;

   end
   else
   begin

      Db.UserModel.Insert;
      Db.UserModelFirstName.Value :=  Request.ContentFields.Values['firstName'];
      Db.UserModelLastName.Value  :=  Request.ContentFields.Values['lastName'];
      Db.UserModel.Post;
   end;

    Response.Content := '<div class="table-responsive" id="user-list">'+UsersGridComp.Content +'</div>';
      except
        on E:EWebStencilsLoginRequired do
          Response.Content := 'wspAccessDenied 405';
      end;
  finally
       Db.UserModel.close();
       Handled := True;
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
      on E: EWebStencilsLoginRequired do
      begin
         if (E.Message = SWebStencilsLoginIsRequired) then
            Response.SendRedirect('/login') // إعادة توجيه إلى صفحة تسجيل الدخول
        else
          Response.Content := '403 Forbidden';
      end;
    end;
  finally
       Db.UserModel.close();
       Handled := True;
  end;
end;


end.

