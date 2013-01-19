#= require ./application_module

namespace "brancusi"

class brancusi.ApplicationController extends brancusi.ApplicationModule
  @dependency renderer: 'Renderer'
  
  begin_request: (action_name) ->
    @request =
      action: action_name
  
  render: (args...) ->
    if args.length > 0
      @renderer.render_page(args...)
    else
      @renderer.render_page("#{@name}/#{@request.action}")
      