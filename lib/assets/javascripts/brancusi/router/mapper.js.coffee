namespace "Brancusi"

# given a url, maps to a controller + action
# given a resource, maps to a url

class Brancusi.RoutesMapper

    constructor: ->
      @mappings = {}

    draw: (block) ->
        block.apply(@)        
        
    match: (url, opts) ->
      @mappings[url] = @parse(opts)
      
    parse: (opts) ->
      if _.isString(opts)
        [controller, action] = /(.*)#(.*)/.exec(opts)[1..2]
        { controller: controller, action: action }
      else
        opts
      
    apply: (app, router) ->
      for url, { controller, action } of @mappings
        dispatcher = new Brancusi.Dispatcher(app, controller, action)
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