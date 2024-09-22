object WebModule1: TWebModule1
  OnCreate = WebModuleCreate
  Actions = <
    item
      Default = True
      Name = 'IndexPage'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      Name = 'UserPage'
    end>
  Height = 230
  Width = 415
  object IndexView: TWebStencilsProcessor
    Engine = WebStencilsEngine1
    InputFileName = 'Views/index.html'
    Left = 40
    Top = 16
  end
  object WebStencilsEngine1: TWebStencilsEngine
    PathTemplates = <>
    Left = 240
    Top = 64
  end
end
