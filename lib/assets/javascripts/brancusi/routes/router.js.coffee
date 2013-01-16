class brancusi.Router extends brancusi.ApplicationModule
  
  initialize: (app) ->
    @configure(app.constructor.config)
    app.constructor.routes.apply(app, @)
    
  route: (url, action) ->
    console.log("route: #{url}")
    