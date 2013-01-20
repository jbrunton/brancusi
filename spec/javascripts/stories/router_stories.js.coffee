#= require brancusi/application
#= require brancusi/router

feature "Routing", ->

  summary(
      'As a client of the framework',
      'I want to configure the application routes with a DSL'
  )

  scenario "Route with 'match'", ->
  
    Application = app = null

    Given "I have an application with some routes", ->
      Application = window.create('Application')

      Application.routes.draw ->
        @match '/', 'home#index'
        
      app = Application.create()
      
    When "I initialize it", ->
      spyOn(app.router, 'route')
      app.initialize()
          
    Then "the router should receive the specified routes", ->
      expect(app.router.route).toHaveBeenCalledWith('/', jasmine.any(Function))
      
    And "the route should map to the index action on the home controller", ->
      # TODO: how to test this?

    