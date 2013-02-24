#= require brancusi/application
#= require brancusi/renderer

feature "Application Controllers", ->

  summary(
      'As a client of the framework',
      'I want a Rails-like controller class'
  )
  
  scenario "Instantiate the application controllers", ->
    # TODO: this.
  
  scenario "Render the default template", ->

    Application = app = null

    Given "I have an application with a controller", ->
      Application = create('Application')

      Application.Controllers.HomeController = class extends Brancusi.ApplicationController
        index: ->
          @render()
      
      app = Application.run()

    When "the controller responds to a request", ->
      spyOn(app.renderer, 'render_page')
      app.controllers.home.respond_to('index')

    Then "the application renderer should be invoked with the default template for that action", ->
      expect(app.renderer.render_page).toHaveBeenCalledWith('home/index', undefined)


  scenario "Render a page with a given template and context", ->

    Application = app = context = null

    Given "I have an application with a controller", ->
      Application = create('Application')

      Application.Controllers.HomeController = class extends Brancusi.ApplicationController
        index: ->
          @render(context = {}, template: 'users/welcome')

      app = Application.run()

    When "I invoke the controller's action", ->
      spyOn(app.renderer, 'render_page')
      app.controllers.home.respond_to('index')

    Then "the application renderer should be invoked with the default template for that action", ->
      expect(app.renderer.render_page).toHaveBeenCalledWith('users/welcome', context)

