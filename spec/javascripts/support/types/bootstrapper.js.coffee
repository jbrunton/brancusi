#= require ./router

namespace "Support"

class Support.Bootstrapper extends Brancusi.Bootstrapper
  configure_container: (app) ->
    container = super(app)
    container.register_class 'Router', Support.Router, singleton: true
    container.register_class 'Renderer', Brancusi.Renderer, singleton: true
    container
  