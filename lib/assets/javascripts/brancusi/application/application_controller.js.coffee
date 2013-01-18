#= require ./application_module

namespace "brancusi"

class brancusi.ApplicationController extends brancusi.ApplicationModule
  @dependency renderer: 'Renderer'
  
  render: (args...) ->
    @renderer.render_page(args...)
    