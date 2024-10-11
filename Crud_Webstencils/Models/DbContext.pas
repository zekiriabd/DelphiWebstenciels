unit DbContext;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef,UserModel, FireDAC.Phys.ODBCDef, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.ODBC;

type
  TData = class(TDataModule)
    Conn: TFDConnection;
    UserModel: TFDQuery;
    UserQuery: TFDQuery;
    UserModelUserId: TFDAutoIncField;
    UserModelFirstName: TStringField;
    UserModelLastName: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure UserDelete(const UserId: Integer);
    procedure UserUpdate(const User: TUser);
  end;

var
  Data: TData;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}



procedure TData.UserUpdate(const User: TUser);
begin
UserQuery.SQL.Text := 'UPDATE [User] ' +
                      'SET FirstName = :FirstName, ' +
                      '    LastName  = :LastName ' +
                      'WHERE UserId  = :UserId';

UserQuery.ParamByName('FirstName').AsString := User.FirstName;
UserQuery.ParamByName('LastName').AsString := User.LastName;
UserQuery.ParamByName('UserId').AsInteger := User.Id;

UserQuery.ExecSQL;
end;

procedure TData.UserDelete(const UserId: Integer);
begin
  UserQuery.SQL.Text := 'Delete FROM [User] where [UserId] = :UserId';
  UserQuery.ParamByName('UserId').AsInteger := UserId;
  UserQuery.ExecSQL;
end;
procedure TData.DataModuleCreate(Sender: TObject);
begin
  // Clear any existing connection parameters
  Conn.Params.Clear;

  // Set connection parameters for FireDAC's MSSQL driver
  Conn.Params.Add('DriverID=MSSQL');  // Specify to use FireDAC's MSSQL driver
  Conn.Params.Add('Server=softwebsqlserver.database.windows.net');  // SQL Server address
  Conn.Params.Add('Database=azuresqldatabase');  // Database name
  Conn.Params.Add('User_Name=softwebAdmin');     // Your username
  Conn.Params.Add('Password=Talage2002.');       // Your password
  Conn.Params.Add('Encrypt=True');                 // Use encryption
  Conn.Params.Add('TrustServerCertificate=False'); // Don't trust unverified certificates
  Conn.Params.Add('ApplicationName=Enterprise/Architect/Ultimate'); // Application name
  Conn.Params.Add('OSAuthent=No');                 // Disable OS authentication
  Conn.Params.Add('MARS=True');                    // Enable Multiple Active Result Sets (MARS)

  // Disable login prompt
  Conn.LoginPrompt := False;

  // Attempt to connect to the database
  try
    Conn.Connected := True; // Attempt to connect to Azure SQL Database
  except
    on E: Exception do
      // Display connection error message if connection fails
      //ShowMessage('Connection failed: ' + E.Message);
  end;
end;





procedure TData.DataModuleDestroy(Sender: TObject);
begin
Conn.Connected := False;
end;

end.
