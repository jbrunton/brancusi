namespace "brancusi"

# An implementation of the mediator pattern.  This class should not be referred to directly, as the AER pattern is preferred.
#
class brancusi.Mediator

  constructor: ->
    @subscribers = {}

  # Subscribes the given handler to the content for the specified event.
  #
  # @param event [String] the (fully qualified) name of the event.
  # @param handler [Function] the event handler.
  # @param context [Object] optional the context to invoke the handler against
  #
  subscribe: (event, handler, context) ->
    @subscribers[event] ?= []
    @subscribers[event].push(-> handler.apply(context, arguments))

  # Invokes all handlers for the given event.
  #
  # @param event [String] the (fully qualified) name of the event.
  # @param args... the arguments to forward to the handler.
  #
  publish: (event, args...) ->
    @publish_scoped(event, null, args...)

  # Invokes all handlers for the given event.
  #
  # @param event [String] the name of the event (either qualified or unqualified)
  # @param scope [String] the name of the scope for unqualified event names.
  # @param args... the arguments to forward to the handler.
  #
  publish_scoped: (event, scope, args...) ->
    event = @_scoped_name(event, scope, true) if scope?
    subscribers = (@subscribers?[event] || {})
    for handler in subscribers
      handler(args...)
  
  # Binds all subscriptions on the target object (optionally using the given scope).
  #
  # @param target [Object] the target object.
  # @param scope [String] optional the name of the scope of the object.
  #
  bind_subscriptions: (target, scope) ->
    for name, handler of target when matches = /@(.*)/.exec(name)
      event = matches[1]
      event = @_scoped_name(event, scope) if scope?
      @subscribe(event, handler, target)

  # @private
  # Returns the fully qualified name of the event, and optionally validates the inpute.
  #
  # @param input [String] the input to qualify (and maybe validate).
  # @param scope [String] optional the name of the scope for unqualified event names.
  # @param validate [Boolean] optional whether or not to error on invalid event names.
  #
  _scoped_name: (input, scope, validate) =>
    regex = /^((\w+)\.)?(\w+)$/

    if input.match(regex)
      [_, _, event_scope, event] = regex.exec(input)
      if scope?
        event_scope ?= scope
        "#{event_scope}.#{event}"
      else
        event
    else if validate?
      throw new Error("Invalid event name: #{input}")

