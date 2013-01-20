#= require brancusi/container

namespace "Brancusi"

class Brancusi.Sandbox extends Brancusi.DependentObject
  @dependency mediator: "Mediator"

  constructor: (@scope) ->
  
  publish: (event, args...) =>
    @mediator.publish_scoped(event, @scope, args...)
      
  bind_subscriptions: (target) =>
    @mediator.bind_subscriptions(target, @scope)