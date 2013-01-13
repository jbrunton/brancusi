#= require brancusi/container

namespace "brancusi"

class brancusi.Sandbox extends brancusi.DependentObject
  @dependency mediator: "Mediator"

  constructor: (@scope) ->
  
  publish: (event, args...) =>
    @mediator.publish_scoped(event, @scope, args...)
      
  bind_subscriptions: (target) =>
    @mediator.bind_subscriptions(target, @scope)