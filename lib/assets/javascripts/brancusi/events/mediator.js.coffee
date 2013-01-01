namespace "brancusi"

# An implementation of the mediator pattern.  This class should not be referred to directly, as the AER pattern is preferred.
#
class brancusi.Mediator

  constructor: ->
    @subscribers = {}

  # Subscribes the given handler to the content for the specified event.
  #
  subscribe: (event, handler, context) ->
    @subscribers[event] ?= []
    @subscribers[event].push(-> handler.apply( context, arguments ) )

  # Invokes all handlers for the specified event.
  #
  publish: (event, args...) ->
    subscribers = (@subscribers?[event] || {})
    for handler in subscribers
      handler(args...)
          