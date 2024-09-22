unit UserModel;

interface

type
  TUser = class
  private
    fId: Integer;
    fFirstName: String;
    fLastName: String;
  public
    property Id: Integer read fId write fId;
    property FirstName: String read fFirstName write fFirstName;
    property LastName: String read fLastName write fLastName;
    constructor Create(Id: Integer; FirstName, LastName: String); reintroduce;
  end;

implementation

constructor TUser.Create(Id:Integer;FirstName, LastName: String);
begin
  inherited Create;
  fId := Id;
  fFirstName := FirstName;
  fLastName := LastName;
end;

end.
