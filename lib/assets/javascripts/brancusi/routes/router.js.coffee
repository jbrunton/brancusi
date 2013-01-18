class brancusi.Router extends brancusi.ApplicationModule
  
  constructor: ->
    super('router')
  
  initialize: (app) ->
    console.log('initializing router')
    @configure(app.constructor.config)
    app.constructor.routes.apply(app, @)
    
  route: (url, action) ->
    throw new Error("Missing implementation for Router.route")
    
  configure: (config) ->
    throw new Error("Missing implementation for Router.configure")