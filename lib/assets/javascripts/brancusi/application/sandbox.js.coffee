#= require brancusi/container

namespace "brancusi"

class brancusi.Sandbox extends brancusi.DependentObject
  @dependency mediator: "Mediator"

  constructor: (@scope) ->
  
  scoped_name: (input, opts) =>
    if opts?.match_subscriptions?
      regex = /^@((\w+)\.)?(\w+)$/
    else
      regex = /^((\w+)\.)?(\w+)$/
        
    if input.match( regex )
      [_, _, scope, event] = regex.exec(input)            
      scope ?= @scope
      "#{scope}.#{event}"
    else if opts?.validate?
      throw new Error("Invalid event name: #{input}")
  
  publish: (event, args...) =>
    scoped_name = @scoped_name(event, validate: true)
    @mediator.publish(scoped_name, args...)
      
  bind_subscriptions: (target) =>
    for event, handler of target
      scoped_name = @scoped_name(event, match_subscriptions: true)                
      if scoped_name?
        @mediator.subscribe(scoped_name, handler, target)
      