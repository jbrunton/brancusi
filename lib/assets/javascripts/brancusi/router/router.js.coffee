#= require brancusi/application/application_module

namespace "Brancusi"

class Brancusi.Router extends Brancusi.ApplicationModule
  
  constructor: ->
    super('router')
  
  initialize: (app) ->
    @configure(app.constructor.config)
    app.constructor.routes.apply(app, @)
    
  route: (url, action) ->
    throw new Error("Missing implementation for Router.route")
    
  configure: (config) ->
    throw new Error("Missing implementation for Router.configure")