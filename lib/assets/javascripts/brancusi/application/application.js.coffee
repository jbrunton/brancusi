#= require brancusi/events
#= require ./bootstrapper

namespace "brancusi"

class brancusi.Application extends brancusi.EventObject
  
  @dependency mediator: "Mediator"
    
  # default configuration options, which may be overridden by instances
  @config:
    bootstrapper: brancusi.Bootstrapper

  # module classes for the application
  @modules: {}
  
  # module instances
  modules: {}
  
  # model classes for the application
  @models: {}
  
  # controller classes for the application
  @controllers: {}

  # instantiates, initializes, starts and returns the application instance  
  @configure_and_run: ->
    @configure().initialize().run()
    
  @configure: ->
    @instance = new @
    bootstrapper = new @config.bootstrapper
    @instance.configure(bootstrapper)
    

  configure: (bootstrapper) ->
    @container = bootstrapper.configure_container()
    @container.resolve(@)
    @configure_modules()
    @
    
  initialize: ->
    @mediator.publish "application.initialize"
    @

  run: (bootstrapper) ->
    @mediator.publish "application.ready"
    @

  configure_modules: ->
    module_regex = /(.*)Module/ # e.g. AuthModule
    for klass_name, klass of @constructor.modules when matches = module_regex.exec(klass_name)
      module_name = _.string.underscored(matches[1]) # e.g. "auth"
      module = @container.resolve(new klass(module_name))
      module.sandbox.bind_subscriptions(module)
      @modules[module_name] = module
