object WebModule1: TWebModule1
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end>
  Height = 683
  Width = 1118
  object Index: TWebStencilsProcessor
    InputFileName = 'Views/Pages/index.html'
    Left = 104
    Top = 56
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
    Left = 543
    Top = 16
  end
  object WebStencilsEngine1: TWebStencilsEngine
    PathTemplates = <>
    RootDirectory = '.'
    Left = 544
    Top = 88
  end
  object manifest: TWebStencilsProcessor
    InputFileName = 'manifest.webmanifest'
    DefaultFileExt = '.webmanifest'
    Left = 80
    Top = 160
  end
end
