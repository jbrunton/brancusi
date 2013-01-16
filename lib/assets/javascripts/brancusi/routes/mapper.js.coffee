namespace "brancusi.routes"

# given a url, maps to a controller + action
# given a resource, maps to a url

class brancusi.routes.Mapper

    constructor: ->
      @mappings = {}

    draw: (block) ->
        block.apply(@)        
        
    match: (url, opts) ->
      @mappings[url] = opts
      
    apply: (app, router) ->
      for url, { controller, action } of @mappings
        dispatcher = new brancusi.routes.Dispatcher(app, controller, action)
        router.route(url, dispatcher.dispatch)
        
    # resource: ( resource ) ->
    #     for action in ['view', 'edit']
    #         path_name = opt?.paths_names?[action]?
    #         path_name ?= action
    #         @router.route "#{resource}/:id/#{action}", resource, action
    #     for action in ['create']
    #         path_name = opt?.paths_names?[action]?
    #         path_name ?= action
    #         @router.route "#{resource}/#{action}", resource, action
        
    #namespace: ( path, block ) ->
    #    @scope.push path
    #    @draw( block )