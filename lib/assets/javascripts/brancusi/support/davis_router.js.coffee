namespace "brancusi.routes"

class brancusi.routes.DavisRouter extends brancusi.Router
  
  constructor: ->
    @davis = new Davis
    
  route: (url, action) ->
    super(url, action)
    @davis.get(url, action)
    
  configure: (config) ->
    @davis.configure(-> @generateRequestOnPageLoad = true) if config.route_on_load
    
  @on "application.initialize", (app) ->
    @initialize(app)
    
  @on "application.ready", ->
    @davis.start()
    