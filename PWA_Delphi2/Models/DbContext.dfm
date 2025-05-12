object Data: TData
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 640
  object Conn: TFDConnection
    Params.Strings = (
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 56
    Top = 16
  end
  object UserModel: TFDQuery
    Connection = Conn
    SQL.Strings = (
      ' SELECT [UserId]'
      '      ,[FirstName]'
      '      ,[LastName]'
      '  FROM [dbo].[User]')
    Left = 192
    Top = 56
    object UserModelUserId: TFDAutoIncField
      FieldName = 'UserId'
      Origin = 'UserId'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object UserModelFirstName: TStringField
      FieldName = 'FirstName'
      Origin = 'FirstName'
      Size = 50
    end
    object UserModelLastName: TStringField
      FieldName = 'LastName'
      Origin = 'LastName'
      Size = 50
    end
  end
  object UserQuery: TFDQuery
    Connection = Conn
    Left = 272
    Top = 56
  end
end
