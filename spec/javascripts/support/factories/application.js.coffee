factory 'Application', ->
  Application = class extends Brancusi.Application.reset()
    @dependency router: 'Router'
    @dependency renderer: 'Renderer'
    
  Application.Bootstrapper = Support.Bootstrapper
  Application

factory 'application', (run) ->
  Application = window.create('Application')
  app = Application.create()
  app.initialize().run() if run
  app
  