#= require ./application_module

namespace "Brancusi"

class Brancusi.ApplicationController extends Brancusi.ApplicationModule
  @dependency renderer: 'Renderer'
  
  # @private
  # Called by Brancusi.Dispatcher at the start of the request cycle.
  #
  # param action_name [String] the name of the action on the controller.
  #
  begin_request: (action_name) ->
    @request =
      action: action_name
    @response = {}
      
  end_request: ->
    @render() unless @response.template?
    
  respond_to: (action_name, args) ->
    @begin_request(action_name)
    @[action_name].apply(@, args)
    @end_request()
    
  # Invokes the application renderer.
  #
  # @overload render()
  #   Renders the default template for the controller and action (e.g. 'home/index' for the home controller's index action).
  # @overload render(template)
  # @overload render(context, opts)
  #   Renders the named template using the given rendering context. 
  #
  render: (args...) ->
    if args.length == 1
      if _.isString(args[0])
        template = args[0]
      else
        context = args[0]
    else if args.length == 2
      [context, { template }] = args
    
    template ?= "#{@name}/#{@request.action}"
    
    @response.template = template
    @renderer.render_page(template, context)
      