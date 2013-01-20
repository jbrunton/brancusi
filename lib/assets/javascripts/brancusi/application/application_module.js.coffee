#= require brancusi/events

namespace "Brancusi"

class Brancusi.ApplicationModule extends Brancusi.EventObject    
    constructor: (@name) ->
    
    @dependency sandbox: (container) ->
        container.resolve "Sandbox", [@name]

    @dependency container: (container) ->
        container.child().register_instance "Sandbox", @sandbox

    publish: (args...) ->
        @sandbox.publish(args...)

    # TODO: maybe bind subscriptions automatically after resolving any EventObject (or anything with subscriptions)
    # e.g.
    # resolve: (ref, opts) ->
    #     resolution = @container.resolve(ref, opts)
    #     @sandbox.bind_scriptions(resolution)
    #     resolution.publish = @sandbox.publish
    #     resolution
    # bind_subscriptions: (target) ->
    #     @sandbox.bind_subscriptions.apply( @sandbox, [target] )
    #     target.publish = @sandbox.publish
        
    # create_model: ( class_name, opts ) ->
    #     @env.create( class_name, opts )
