unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Web.Stencils,
  System.Generics.Collections,System.Threading, DateUtils,
  System.IOUtils;

type

  TController = class(TWebModule)
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
    procedure LoginAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebFormsAuthenticatorAuthenticate(
      Sender: TCustomWebAuthenticator; Request: TWebRequest; const UserName,
      Password: string; var Roles: string; var Success: Boolean);
    procedure ForbiddenAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure UserPageAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure HomeAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WeatherAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure CounterPostAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure CounterAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TCurrentModel = class
  public
    CurrentCount : integer;
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
  WebModuleClass: TComponentClass = TController;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TWeatherForecast.GetTemperatureF: Integer;
begin
  Result := 32 + Round(FTemperatureC / 0.5556);
end;


procedure TController.WebFormsAuthenticatorAuthenticate(
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



procedure TController.CounterAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  var Model : TCurrentModel;
begin
   Model := TCurrentModel.Create;
   Model.CurrentCount := 0;
   CounterPage.AddVar('Model', Model, False);
   Response.Content :=  CounterPage.Content;
   Handled := True;
end;

procedure TController.CounterPostAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  var  Count : integer;
begin
  var val := Request.ContentFields.Values['count'];
  Response.Content := Format('<input class="inputlabel" name="count" type="text" id="counter-content" value="%d">',
  [StrToIntDef(val, 0) +1]);
end;

procedure TController.ForbiddenAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := ForbiddenPage.Content;
end;

procedure TController.HomeAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
    Response.Content := HomePage.Content;
end;

procedure TController.LoginAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
 Response.Content := LoginPage.Content;

end;

procedure TController.UserPageAction(Sender: TObject;
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

procedure TController.WeatherAction(Sender: TObject;
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
