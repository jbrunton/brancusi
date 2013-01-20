#= require ./application_module

namespace "Brancusi"

class Brancusi.ApplicationController extends Brancusi.ApplicationModule
  @dependency renderer: 'Renderer'
  
  # Called by Brancusi.Dispatcher at the start of the request cycle.
  #
  # param action_name [String] the name of the action on the controller.
  #
  begin_request: (action_name) ->
    @request =
      action: action_name
  
  # Invokes the application renderer.
  #
  # @overload render()
  #   Renders the default template for the controller and action (e.g. 'home/index' for the home controller's index action).
  #
  # @overload render(template, context)
  #   Renders the named template using the given rendering context. 
  #
  render: (args...) ->
    if args.length > 0
      @renderer.render_page(args...)
    else
      @renderer.render_page("#{@name}/#{@request.action}")
      