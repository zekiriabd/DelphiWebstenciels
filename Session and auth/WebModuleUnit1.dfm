object WebModule1: TWebModule1
  Actions = <
    item
      Name = 'Home'
      PathInfo = '/'
      OnAction = WebModule1HomeAction
    end
    item
      Name = 'Login'
      PathInfo = '/login'
      OnAction = WebModule1LoginAction
    end
    item
      Name = 'Forbidden'
      PathInfo = '/forbidden'
      OnAction = WebModule1ForbiddenAction
    end
    item
      Name = 'UserPage'
      PathInfo = '/admin/users'
      OnAction = WebModule1UserPageAction
    end
    item
      Name = 'Counter'
      PathInfo = '/counter'
      OnAction = WebModule1CounterAction
    end
    item
      Name = 'Weather'
      PathInfo = '/weather'
      OnAction = WebModule1WeatherAction
    end>
  Height = 382
  Width = 348
  object WebSessionManager: TWebSessionManager
    OnCreated = WebSessionManagerCreated
    Left = 256
    Top = 8
  end
  object HomePage: TWebStencilsProcessor
    InputFileName = 'Components/Pages/home/home.html'
    Left = 64
    Top = 16
  end
  object WebFormsAuthenticator: TWebFormsAuthenticator
    LoginURL = '/login'
    HomeURL = '/'
    LogoutURL = '/logout'
    OnAuthenticate = WebFormsAuthenticatorAuthenticate
    Left = 256
    Top = 64
  end
  object LoginPage: TWebStencilsProcessor
    InputFileName = 'login.html'
    Left = 64
    Top = 72
  end
  object WebAuthorizer: TWebAuthorizer
    UnauthorizedURL = '/forbidden'
    Zones = <
      item
        PathInfo = '/'
      end
      item
        PathInfo = '/admin/*'
        Roles = 'admin'
      end
      item
        PathInfo = '/wwwroot/*'
        Kind = zkFree
      end>
    Left = 256
    Top = 208
  end
  object WebFileDispatcher: TWebFileDispatcher
    WebFileExtensions = <
      item
        MimeType = 'text/css'
        Extensions = 'css'
      end
      item
        MimeType = 'text/html'
        Extensions = 'html;htm'
      end
      item
        MimeType = 'application/javascript'
        Extensions = 'js'
      end
      item
        MimeType = 'image/jpeg'
        Extensions = 'jpeg;jpg'
      end
      item
        MimeType = 'image/png'
        Extensions = 'png'
      end
      item
        MimeType = 'image/svg+xml'
        Extensions = 'svg;svgz'
      end
      item
        MimeType = 'image/x-icon'
        Extensions = 'ico'
      end
      item
        MimeType = 'text/css'
        Extensions = 'map'
      end
      item
        MimeType = 'text/x-scss'
        Extensions = 'scss'
      end
      item
        MimeType = 'text/x-sass'
        Extensions = 'sass'
      end
      item
        MimeType = 'text/css'
        Extensions = 'min.css'
      end
      item
        MimeType = 'image/svg+xml'
        Extensions = 'svg;svgz'
      end>
    WebDirectories = <
      item
        DirectoryAction = dirInclude
        DirectoryMask = '*'
      end
      item
        DirectoryAction = dirExclude
        DirectoryMask = '\templates\*'
      end>
    RootDirectory = '/'
    VirtualPath = '/'
    Left = 256
    Top = 144
  end
  object ForbiddenPage: TWebStencilsProcessor
    InputFileName = 'forbidden.html'
    Left = 64
    Top = 128
  end
  object UserPage: TWebStencilsProcessor
    InputFileName = 'admin/user.html'
    Left = 64
    Top = 184
  end
  object CounterPage: TWebStencilsProcessor
    InputFileName = 'Components/Pages/counter/counter.html'
    Left = 64
    Top = 240
  end
  object WeatherPage: TWebStencilsProcessor
    InputFileName = 'Components/Pages/weather/weather.html'
    Left = 64
    Top = 304
  end
end
