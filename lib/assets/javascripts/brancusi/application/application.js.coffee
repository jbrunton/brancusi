#= require ./bootstrapper
#= require brancusi/events
#= require brancusi/router/mapper

namespace "Brancusi"

Brancusi.Application = (Bootstrapper) ->

  class Brancusi.ApplicationBase extends Brancusi.EventObject
  
    @dependency mediator: "Mediator"
    
    @config: {}
    
    # Module instances
    modules: {}
  
    # Module classes
    @Modules: {}
    
    # Controller instances
    controllers: {}

    # Controller classes
    @Controllers: {}

    @Bootstrapper: Bootstrapper
    
    @Models: {}
    
    @routes: new Brancusi.RoutesMapper

    # Instantiates the application and bootstrapper, and resolves any dependencies, modules and controllers.
    #
    # @return [Application] an instance of the application.
    #
    @create: ->
      @instance = new @
      bootstrapper = new @Bootstrapper
      @instance.resolve(bootstrapper)    

    # Resolves, initializes, and runs the application.
    #
    # @return [Application] an instance of the application.
    #
    @run: ->
      @create().initialize().run()

    # Creates and assigns the application container with the bootstrapper, then resolves dependencies, modules and controllers.
    #
    # @return [Application] the application instance.
    #
    resolve: (bootstrapper) ->
      @container = bootstrapper.configure_container(@)
      @container.resolve(@)
      @_resolve_modules()
      @_resolve_controllers()
      @
    
    # Binds event handlers on the modules and controllers, then publishes the application.initialize event.
    #
    # @return [Application] the application instance.
    #
    initialize: ->
      @_bind_events()
      @mediator.publish "application.initialize", @
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
    _resolve_modules: ->
      # @modules.router = @router if @router?
      # @modules.renderer = @renderer if @renderer?
      module_regex = /(.*)Module/ # e.g. AuthModule
      for klass_name, klass of @constructor.Modules when matches = module_regex.exec(klass_name)
        module_name = _.string.underscored(matches[1]) # e.g. "auth"
        module = @container.resolve(new klass(module_name))
        # module.sandbox.bind_subscriptions(module)
        @modules[module_name] = module
      
    # @private
    # Instantiates and resolves the application controllers.
    #
    _resolve_controllers: ->
      controller_regex = /(.*)Controller/ # e.g. HomeController
      for klass_name, klass of @constructor.Controllers when matches = controller_regex.exec(klass_name)
        controller_name = _.string.underscored(matches[1]) # e.g. home
        controller = @container.resolve(new klass(controller_name))
        # controller.sandbox.bind_subscriptions(controller)
        @controllers[controller_name] = controller

    # @private
    # Binds event handlers on the modules and controllers.
    #
    _bind_events: ->
      @router.sandbox.bind_subscriptions(@router) if @router?
      @renderer.sandbox.bind_subscriptions(@renderer) if @renderer?
    
      for module_name, module of @modules
        module.sandbox.bind_subscriptions(module)
    
      for controller_name, controller of @controllers
        controller.sandbox.bind_subscriptions(controller)
      
      # route_mapper = new @container.resolve 'RouteMapper'
      # route_mapper.draw(@constructor.routes.( config?.routes || -> )
      # @router?.initialize?()