namespace "Brancusi.Davis"

class Brancusi.Davis.Router extends Brancusi.Router
  
  constructor: ->
    @davis = new Davis
    
  route: (url, action) ->
    @davis.get(url, action)
    
  configure: (config) ->
    @davis.configure(-> @generateRequestOnPageLoad = true) if config.route_on_load
    
  @on "application.initialize", (app) ->
    @initialize(app)
    
  @on "application.ready", ->
    @davis.start()
    