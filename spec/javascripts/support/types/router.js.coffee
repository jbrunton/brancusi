namespace "Support"

class Support.Router extends Brancusi.Router
  route: (url, action) ->

  configure: (config) ->

  @on "application.initialize", (app) ->
    @initialize(app)
