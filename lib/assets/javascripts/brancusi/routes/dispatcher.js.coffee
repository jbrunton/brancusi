namespace "brancusi.routes"

class brancusi.routes.Dispatcher extends brancusi.DependentObject

  constructor: (@app, @controller_name, @action_name) ->
  
  dispatch: =>
    @controller = @app.controllers["#{@controller_name}"] unless @controller?
    @controller.begin_request(@action_name)
    @controller[@action_name].apply(@controller, arguments)