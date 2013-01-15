namespace "brancusi.routes"

class brancusi.routes.DavisRouter extends Davis
  route: (url, action) ->
    @get(url, action)
    
  initialize: ->
    @start()
    