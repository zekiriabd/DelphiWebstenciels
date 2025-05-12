unit PrincipalControllers;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp,
  Web.Stencils, System.IOUtils,System.Generics.Collections ;
type
  TWebModule1 = class(TWebModule)
    Index: TWebStencilsProcessor;
    WebFileDispatcher1: TWebFileDispatcher;
    WebStencilsEngine1: TWebStencilsEngine;
    manifest: TWebStencilsProcessor;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  FilePath, FileName, Extension: string;
  MimeTypes: TDictionary<string, string>;
begin
  FilePath := ExtractFilePath(ParamStr(0));
  FileName := FilePath + Request.PathInfo.Substring(1);
  Extension := ExtractFileExt(FileName).ToLower;

  MimeTypes := TDictionary<string, string>.Create;
  try
    MimeTypes.Add('.webmanifest', 'application/manifest+json; charset=utf-8');
    MimeTypes.Add('.js', 'application/javascript; charset=utf-8');
    MimeTypes.Add('.css', 'text/css; charset=utf-8');
    MimeTypes.Add('.png', 'image/png');
    MimeTypes.Add('.jpg', 'image/jpeg');
    MimeTypes.Add('.svg', 'image/svg+xml');


    if MimeTypes.ContainsKey(Extension) then
    begin
      Response.ContentType := MimeTypes[Extension];
      Response.Content := TFile.ReadAllText(FileName, TEncoding.UTF8);
    end
    else
    begin
      MimeTypes.Add('.html', 'text/html; charset=utf-8');
      Response.Content := Index.Content;
    end;

    Handled := True;
  finally
    MimeTypes.Free;
  end;
end;

end.
