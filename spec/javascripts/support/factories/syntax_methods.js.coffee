factories = {}

window.factory = (name, fn) ->
  factories[name] = fn

window.create = (name, args...) ->
  factories[name].apply(null, args)
  
