#= require brancusi/application

feature "Application", ->

  summary(
      'As a client of the framework',
      'I want a loosely-coupled module system with communication using AER'
  )
  
  scenario "Initialize the application modules", ->
    
    Application = app = null
    
    Given "I have an application", ->
      Application = class extends brancusi.Application
        
    When "I configure it with a module", ->
      Application.modules.GreeterModule = class extends brancusi.ApplicationModule
        @on 'greet', -> @greet()
        greet: -> "Hello, World!"

        @on 'Application.initialize', -> @initialize()
        initialize: ->

        @on 'Application.ready', -> @ready()
        ready: ->
      
      app = Application.configure()
            
    Then "the module is instantiated by the application", ->
      expect(app.modules.greeter instanceof Application.modules.GreeterModule)
      
    And "the module receives the Application.initialize event during initialization", ->
      spyOn(app.modules.greeter, 'initialize')
      app.initialize()
      expect(app.modules.greeter.initialize).toHaveBeenCalled()
      
    And "the module receives the Application.ready event when the application starts", ->
      spyOn(app.modules.greeter, 'ready')
      app.run()
      expect(app.modules.greeter.ready).toHaveBeenCalled()
            
    And "the module should be subscribed to the application mediator", ->
      spyOn(app.modules.greeter, 'greet')
      app.mediator.publish('greeter.greet')
      expect(app.modules.greeter.greet).toHaveBeenCalled()
