namespace "brancusi.routes"

class brancusi.routes.Dispatcher extends brancusi.DependentObject

  constructor: (@app, @controller_name, @action_name) ->
  
  dispatch: =>
    @controller = @app.controllers["#{@controller_name}_controller"] unless @controller?
    # @app.request =
    #     active_controller: @controller
    @controller[@action_name].apply(@controller, arguments)
    