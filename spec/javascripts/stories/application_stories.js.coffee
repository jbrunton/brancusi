#= require brancusi/application

feature "Application", ->

  summary(
      'As a client of the framework',
      'I want to bootstrap and run my application'
  )
  
  scenario "Initialize the application models", ->
    
    Application = bootstrapper = null
    
    Given "I have an application", ->
      Application = class extends brancusi.Application
      
    When "I configure it with a model and run it", ->
      Application.config.models.User = class extends brancusi.Model
        @attr "screen_name"
        
      app = new Application
      app.run(new Bootstrapper)
    
    Then "the module is configured and ...", ->
      user = app.models.User.create(screen_name: 'user123')
      expect( user instanceof Application.config.models.User ).toBe true

  scenario "Initalize the application modules", ->
    
    Application = bootstrapper = null
    
    Given "I have an application", ->
      Application = class extends brancusi.Application
        
    When "I configure it with a module and run it", ->
      Application.config.modules.ExampleModule = class extends brancusi.ApplicationModule
        @on "event", -> @event_handler()                    
        event_handler: ->          
    
    Then "the module is instantiated during initialization", ->
      expect(app.modules.example instanceof Application.config.modules.ExampleModule)
    
    And "the module event handlers are bound", ->
      spyOn(app.modules.example, 'event_handler')
      app.publish('event')
      expect(app.modules.example.event_handler).toHaveBeenCalled()
      
