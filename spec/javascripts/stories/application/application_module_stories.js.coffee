#= require brancusi/application

feature "Application Modules", ->

  summary(
      'As a client of the framework',
      'I want a loosely-coupled module system with communication using AER'
  )
      
  scenario "Instantiate the application modules", ->
    
    Application = app = null

    Given "I have an application with a module", ->
      Application = create('Application')
      Application.Modules.ExampleModule = class extends Brancusi.ApplicationModule
        
    When "I configure it", ->
      app = Application.create()
            
    Then "the module is instantiated by the application", ->
      expect(app.modules.example instanceof Application.Modules.ExampleModule)
  
  scenario "Initialize the application modules", ->
    
    Application = app = null
    
    Given "I have an application with a module", ->
      Application = create('Application')
      Application.Modules.ExampleModule = class extends Brancusi.ApplicationModule
        @on 'application.initialize', ->

      app = Application.create()
        
    When "I initialize it", ->
      spyOn(app.modules.example, '@application.initialize')
      app.initialize()
            
    Then "the module receives the application.initialize event", ->
      expect(app.modules.example['@application.initialize']).toHaveBeenCalled()
      
  scenario "Start the application modules", ->

    Application = app = null
    
    Given "I have an application with a module", ->
      Application = create('Application')
      Application.Modules.ExampleModule = class extends Brancusi.ApplicationModule
          @on 'application.ready', ->
          
      app = Application.create()
        
    When "I run it", ->
      spyOn(app.modules.example, '@application.ready')
      app.initialize().run()
      
    Then "the module receives the application.ready event", ->
      expect(app.modules.example['@application.ready']).toHaveBeenCalled()
      
  scenario "Subscribe the module event listeners to the application mediator", ->
    
    Application = app = null

    Given "I have an application with a module", ->
      Application = create('Application')
      Application.Modules.ExampleModule = class extends Brancusi.ApplicationModule
        @on 'foo', ->
          
      app = Application.create()
        
    When "I run it", ->
      spyOn(app.modules.example, '@foo')
      app.initialize().run()
            
    Then "the module should be subscribed to the application mediator", ->
      app.mediator.publish('example.foo')
      expect(app.modules.example['@foo']).toHaveBeenCalled()

  scenario "Communication between modules", ->
    
    Application = app = null
    
    Given "I have an application with two modules", ->
      Application = create('Application')
      
      Application.Modules.GreeterModule = class extends Brancusi.ApplicationModule
        greet: -> @publish 'greet'
          
      Application.Modules.ListenerModule = class extends Brancusi.ApplicationModule
        @on 'greeter.greet', ->
      
      app = Application.create()
      
    When "I publish an event with the first module which the second subscribes to", ->
      spyOn(app.modules.listener, '@greeter.greet')
      app.initialize().run()
      app.modules.greeter.publish('greet')
    
    Then "The listening module should receive the event", ->
      expect(app.modules.listener['@greeter.greet']).toHaveBeenCalled()
      