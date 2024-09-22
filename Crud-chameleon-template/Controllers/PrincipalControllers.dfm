object PrincipalController: TPrincipalController
  Actions = <
    item
      Default = True
      Name = 'Home'
      PathInfo = '/'
      OnAction = PrincipalControllerIndexPageAction
    end
    item
      MethodType = mtGet
      Name = 'Users'
      PathInfo = '/user'
      OnAction = PrincipalControllerUsersAction
    end
    item
      MethodType = mtDelete
      Name = 'UserDelelet'
      PathInfo = '/user'
      OnAction = PrincipalControllerUserDeleletAction
    end
    item
      MethodType = mtPost
      Name = 'UserPost'
      PathInfo = '/user'
      OnAction = PrincipalControllerUserPostAction
    end
    item
      MethodType = mtPut
      Name = 'UserEdit'
      PathInfo = '/user'
      OnAction = PrincipalControllerUserEditAction
    end>
  Height = 452
  Width = 725
  object Index: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = 'Views/Home/index.html'
    Left = 24
    Top = 16
  end
  object WebStencilsEngine1: TWebStencilsEngine
    PathTemplates = <>
    RootDirectory = '.'
    Left = 656
    Top = 16
  end
  object UsersView: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = 'Views/Home/users.html'
    Left = 72
    Top = 80
  end
  object WebFileDispatcher1: TWebFileDispatcher
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
        MimeType = 'application/octet-stream'
        Extensions = 'svg;svgz'
      end
      item
        MimeType = 'text/h323'
        Extensions = 'eot'
      end
      item
        MimeType = 'image/svg+xml'
        Extensions = 'svg;svgz'
      end
      item
        MimeType = 'font/woff'
        Extensions = 'woff'
      end
      item
        MimeType = 'font/woff2'
        Extensions = 'woff2'
      end
      item
        MimeType = 'application/x-font-ttf'
        Extensions = 'ttf'
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
    RootDirectory = '.'
    VirtualPath = '/'
    Left = 656
    Top = 72
  end
  object UsersGridComp: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = 'Views/Home/usersGridComp.html'
    Left = 160
    Top = 80
  end
  object UserEdit: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = 'Views/Home/userEdit.html'
    Left = 240
    Top = 80
  end
end
