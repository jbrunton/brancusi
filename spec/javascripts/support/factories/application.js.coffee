factory 'Application', ->
  Application = class extends Brancusi.Application(Support.Bootstrapper)
    @dependency router: 'Router'
    @dependency renderer: 'Renderer'
    
  Application

factory 'application', (run) ->
  Application = window.create('Application')
  app = Application.create()
  app.initialize().run() if run
  app
  