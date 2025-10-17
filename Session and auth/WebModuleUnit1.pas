unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Web.Stencils,
  System.Generics.Collections,System.Threading, DateUtils;

type

  TWebModule1 = class(TWebModule)
    WebSessionManager: TWebSessionManager;
    HomePage: TWebStencilsProcessor;
    WebFormsAuthenticator: TWebFormsAuthenticator;
    LoginPage: TWebStencilsProcessor;
    WebAuthorizer: TWebAuthorizer;
    WebFileDispatcher: TWebFileDispatcher;
    ForbiddenPage: TWebStencilsProcessor;
    UserPage: TWebStencilsProcessor;
    CounterPage: TWebStencilsProcessor;
    WeatherPage: TWebStencilsProcessor;
    procedure WebSessionManagerCreated(Sender: TCustomWebSessionManager;
      Request: TWebRequest; Session: TWebSession);
    procedure WebModule1LoginAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebFormsAuthenticatorAuthenticate(
      Sender: TCustomWebAuthenticator; Request: TWebRequest; const UserName,
      Password: string; var Roles: string; var Success: Boolean);
    procedure WebModule1ForbiddenAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1UserPageAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1HomeAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1CounterAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WeatherAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TMessage = class
  private
    Fval : string;
  public
    property val:string read Fval write Fval;
  end;

  TWeatherForecast = class
  private
    FDate: TDateTime;
    FTemperatureC: Integer;
    FSummary: string;
    function GetTemperatureF: Integer;
  public
    property Date: TDateTime read FDate write FDate;
    property TemperatureC: Integer read FTemperatureC write FTemperatureC;
    property Summary: string read FSummary write FSummary;
    property TemperatureF: Integer read GetTemperatureF;
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TWeatherForecast.GetTemperatureF: Integer;
begin
  Result := 32 + Round(FTemperatureC / 0.5556);
end;


procedure TWebModule1.WebSessionManagerCreated(
  Sender: TCustomWebSessionManager; Request: TWebRequest; Session: TWebSession);
begin
  Session.DataVars.Values['UserName'] := 'Zekiri Abdelali';
end;

procedure TWebModule1.WebFormsAuthenticatorAuthenticate(
  Sender: TCustomWebAuthenticator; Request: TWebRequest; const UserName,
  Password: string; var Roles: string; var Success: Boolean);
begin
  Success := False;
  Roles := '';

  if SameText(UserName, 'test') and SameText(Password, '123') then
  begin
    Success := True;
    Roles := 'user';
  end

  else if SameText(UserName, 'admin') and SameText(Password, '123') then
  begin
    Success := True;
    Roles := 'admin';
  end
end;



procedure TWebModule1.WebModule1CounterAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  App: TMessage;
  NewVal: Integer;
begin
  App := TMessage.Create;
  try
    App.val := Request.QueryFields.Values['val'];
    if(App.val = '') then
      NewVal := 0
    else
      NewVal := StrToIntDef(App.val, 0) + 1;

    App.val := IntToStr(NewVal);
    CounterPage.AddVar('App', App, False);
    Response.Content := CounterPage.Content;
    Handled := true;
  finally
   App.Free;
  end;
end;




procedure TWebModule1.WebModule1ForbiddenAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := ForbiddenPage.Content;
end;

procedure TWebModule1.WebModule1HomeAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
    Response.Content := HomePage.Content;
end;

procedure TWebModule1.WebModule1LoginAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
 Response.Content := LoginPage.Content;

end;

procedure TWebModule1.WebModule1UserPageAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
   Response.Content := UserPage.Content;
end;



function LoadForecasts(): TObjectList<TWeatherForecast>;
var
  i: Integer;
  Summaries: TArray<string>;
  TempC, SummaryIndex: Integer;
  StartDate: TDateTime;
  Forecast: TWeatherForecast;
begin
      Result := TObjectList<TWeatherForecast>.Create();
      StartDate := Date;
      Summaries := ['Freezing', 'Bracing', 'Chilly', 'Cool', 'Mild', 'Warm', 'Balmy', 'Hot', 'Sweltering', 'Scorching'];

      For i := 1 to 5 do
      begin
        Forecast := TWeatherForecast.Create;
        Forecast.Date := IncDay(StartDate, i);
        TempC := Random(76) - 20;
        Forecast.TemperatureC := TempC;

        SummaryIndex := Random(Length(Summaries));
        Forecast.Summary := Summaries[SummaryIndex];

        Result.Add(Forecast);
      end;
end;

procedure TWebModule1.WebModule1WeatherAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  var
  Forecasts : TObjectList<TWeatherForecast>;
begin
    Forecasts := LoadForecasts();
    WeatherPage.AddVar('Forecasts', Forecasts, False);
    Response.Content := WeatherPage.Content;
    Handled := true;

end;

end.
