window.namespace = (scope) ->

  add_namespace = (scope, ctx) ->
    [outer, rest...] = scope
    
    if not ctx[outer]?
      ctx[outer] = {}
    
    if rest.length
      add_namespace rest, ctx[outer]

  add_namespace scope.split("."), window
    