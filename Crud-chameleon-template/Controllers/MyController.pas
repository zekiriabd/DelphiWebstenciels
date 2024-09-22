unit MyController;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Web.HTTPProd, Web.Stencils;
type
  TWebModule1 = class(TWebModule)
    IndexView: TWebStencilsProcessor;
    WebStencilsEngine1: TWebStencilsEngine;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
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

  TMyMessage = class
    private
    FHello: string;
  public

        property Hello: string read FHello write FHello;
  end;
var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  MyList: TMyMessage;
begin
  // Create the list
  MyList := TMyMessage.Create;
  try
    // Add strings to the list
    MyList.FHello := 'Bonjour';

    // Add the string to the WebStencils engine
    if not WebStencilsEngine1.HasVar('MyVar') then
      WebStencilsEngine1.AddVar('MyVar', MyList, False);

    try
      // Render the content using the template
      Response.Content := IndexView.Content;
    except
      on E: EWebStencilsLoginRequired do
        // Handle the exception or load a default view if needed
        Response.Content := 'Login required';
    end;
  finally
    // Free the list
    MyList.Free;
  end;

  Handled := True;
end;


procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  FTitle := WebTitle;
  FVersion := WebVersion;
  WebStencilsEngine1.AddVar('App', Self, False);
end;

end.
