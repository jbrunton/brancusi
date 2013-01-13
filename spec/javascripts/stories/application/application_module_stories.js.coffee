#= require brancusi/application

feature "Application Modules", ->

  summary(
      'As a client of the framework',
      'I want a loosely-coupled module system with communication using AER'
  )
  
  window.support ?= {}
  
  support.GreeterModule = ->
    class extends brancusi.ApplicationModule
      @on 'greet', -> @greet()
      greet: -> "Hello, World!"

      @on 'application.initialize', -> @initialize()
      initialize: ->

      @on 'application.ready', -> @ready()
      ready: ->
  
  support.ListenerModule = ->
    class extends brancusi.ApplicationModule
      @on 'greeter.greet', -> @greeted()
      greeted: -> "Hey there, yo"
      
  scenario "Instantiate the application modules", ->
    
    Application = app = null

    Given "I have an application with a module", ->
      Application = class extends brancusi.Application
      Application.modules.GreeterModule = support.GreeterModule()
        
    When "I configure it", ->
      app = Application.configure()
            
    Then "the module is instantiated by the application", ->
      expect(app.modules.greeter instanceof Application.modules.GreeterModule)
  
  scenario "Initialize the application modules", ->
    
    Application = app = null
    
    Given "I have an application with a module", ->
      Application = class extends brancusi.Application
      Application.modules.GreeterModule = support.GreeterModule()
      app = Application.configure()
        
    When "I initialize it", ->
      spyOn(app.modules.greeter, 'initialize')
      app.initialize()
            
    Then "the module receives the application.initialize event", ->
      expect(app.modules.greeter.initialize).toHaveBeenCalled()
      
  scenario "Start the application modules", ->

    Application = app = null
    
    Given "I have an application with a module", ->
      Application = class extends brancusi.Application
      Application.modules.GreeterModule = support.GreeterModule()
      app = Application.configure()
        
    When "I run it", ->
      spyOn(app.modules.greeter, 'ready')
      app.initialize().run()
      
    Then "the module receives the application.ready event", ->
      expect(app.modules.greeter.ready).toHaveBeenCalled()
      
  scenario "Subscribe the module event listeners to the application mediator", ->
    
    Application = app = null

    Given "I have an application with a module", ->
      Application = class extends brancusi.Application
      Application.modules.GreeterModule = support.GreeterModule()
        
    When "I run it", ->
      app = Application.configure_and_run()
            
    Then "the module should be subscribed to the application mediator", ->
      spyOn(app.modules.greeter, 'greet')
      app.mediator.publish('greeter.greet')
      expect(app.modules.greeter.greet).toHaveBeenCalled()

  scenario "Communication between modules", ->
    
    Application = app = null
    
    Given "I have an application with two modules", ->
      Application = class extends brancusi.Application
      
      Application.modules.GreeterModule = support.GreeterModule()
      Application.modules.ListenerModule = support.ListenerModule()
      
      app = Application.configure_and_run()
      
    When "I publish an event with the first module which the second subscribes to", ->
      spyOn(app.modules.listener, 'greeted')
      app.modules.greeter.publish('greet')
    
    Then "The listening module should receive the event", ->
      expect(app.modules.listener.greeted).toHaveBeenCalled()
      