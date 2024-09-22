unit DbContext;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Wait,System.Generics.Collections,
  UserModel, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, Data.FMTBcd,
  Data.SqlExpr, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDb = class(TDataModule)
    Conn: TFDConnection;
    UserModel: TFDQuery;
    UserModelUserId: TFDAutoIncField;
    UserModelFirstName: TStringField;
    UserModelLastName: TStringField;
    UserQuery: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure Delete(const UserId: Integer);
  end;

var
  Db: TDb;

implementation

uses
System.IniFiles;


{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDb.Delete(const UserId: Integer);
begin
  UserQuery.SQL.Text := 'Delete FROM [test].[dbo].[User]  where  [UserId] = :UserId';
  UserQuery.ParamByName('UserId').AsInteger := UserId;
  UserQuery.ExecSQL;
end;

procedure TDb.DataModuleCreate(Sender: TObject);
var
  IniFile: TIniFile;
  DBPath: string;
begin
try
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'dbconfig.ini');
  try
   { Conn.DriverName := IniFile.ReadString('Database', 'DriverName', '');
    Conn.Params.Values['Server'] := IniFile.ReadString('Database', 'Server', '');
    Conn.Params.Values['Database'] := IniFile.ReadString('Database', 'Database', '');
    Conn.Params.Values['OSAuthent'] := 'Yes';
    Conn.Params.Values['Encrypt'] := 'Optional'; }
    Conn.Connected := True;

  except

  end;
finally
   IniFile.Free;
end;

end;

procedure TDb.DataModuleDestroy(Sender: TObject);
begin
Conn.Connected := False;
end;



end.
