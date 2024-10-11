object Db: TDb
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 288
  Width = 701
  object Conn: TFDConnection
    Params.Strings = (
      'SERVER=LAPTOP-61VJQ0J4'
      'OSAuthent=Yes'
      'ApplicationName=Enterprise/Architect/Ultimate'
      'Workstation=LAPTOP-61VJQ0J4'
      'Encrypt=Optional'
      'MARS=yes'
      'DATABASE=test'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 8
    Top = 8
  end
  object UserModel: TFDQuery
    IndexFieldNames = 'UserId'
    Connection = Conn
    SQL.Strings = (
      ' SELECT [UserId]'
      '      ,[FirstName]'
      '      ,[LastName]'
      '  FROM [test].[dbo].[User]')
    Left = 224
    Top = 40
    object UserModelUserId: TFDAutoIncField
      FieldName = 'UserId'
    end
    object UserModelFirstName: TStringField
      FieldName = 'FirstName'
      Size = 50
    end
    object UserModelLastName: TStringField
      FieldName = 'LastName'
      Size = 50
    end
  end
  object UserQuery: TFDQuery
    Connection = Conn
    Left = 296
    Top = 40
    ParamData = <
      item
        Name = 'UserId'
        DataType = ftInteger
      end
      item
        Name = 'FirstName'
        DataType = ftString
      end
      item
        Name = 'LastName'
        DataType = ftString
      end>
  end
end
