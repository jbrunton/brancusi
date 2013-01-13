#= require brancusi/events
#= require ./bootstrapper

namespace "brancusi"

class brancusi.Application extends brancusi.EventObject
  
  @dependency mediator: "Mediator"
    
  # Default configuration options, which may be overridden by instances
  @config:
    bootstrapper: brancusi.Bootstrapper

  # Module classes for the application
  @modules: {}
  
  # Module instances
  modules: {}
  
  # Controller classes for the application
  @controllers: {}
  
  # Controller instances
  controllers: {}

  # Model classes for the application
  @models: {}

  # Instantiates the application and bootstrapper, then configures the instance.
  #
  # @return [Application] an instance of the application.
  #
  @configure: ->
    @instance = new @
    bootstrapper = new @config.bootstrapper
    @instance.configure(bootstrapper)    

  # Configures, initializes, and runs the application.
  #
  # @return [Application] an instance of the application.
  #
  @configure_and_run: ->
    @configure().initialize().run()

  # Configures and assigns the application container with the bootstrapper, then resolves dependencies, modules and controllers.
  #
  # @return [Application] the application instance.
  #
  configure: (bootstrapper) ->
    @container = bootstrapper.configure_container(@)
    @container.resolve(@)
    @_configure_modules()
    @_configure_controllers()
    @

  # Publishes the application.initialize event.
  #
  # @return [Application] the application instance.
  #
  initialize: ->
    @mediator.publish "application.initialize"
    @

  # Publishes the application.ready event.
  #
  # @return [Application] the application instance.
  #
  run: (bootstrapper) ->
    @mediator.publish "application.ready"
    @

  # @private
  # Instantiates and resolves the application modules.
  #
  _configure_modules: ->
    module_regex = /(.*)Module/ # e.g. AuthModule
    for klass_name, klass of @constructor.modules when matches = module_regex.exec(klass_name)
      module_name = _.string.underscored(matches[1]) # e.g. "auth"
      module = @container.resolve(new klass(module_name))
      module.sandbox.bind_subscriptions(module)
      @modules[module_name] = module
      
  # @private
  # Instantiates and resolves the application controllers.
  #
  _configure_controllers: ->
    controller_regex = /(.*)Controller/ # e.g. HomeController
    for klass_name, klass of @constructor.controllers when matches = controller_regex.exec(klass_name)
      controller_name = _.string.underscored(matches[0]) # e.g. home_controller
      controller = @container.resolve(new klass(controller_name))
      controller.sandbox.bind_subscriptions(controller)
      @controllers[controller_name] = controller
