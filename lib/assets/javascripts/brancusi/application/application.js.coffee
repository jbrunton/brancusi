namespace "brancusi"

class brancusi.Application extends brancusi.EventObject
  
  # default configuration options, which may be overridden by instances
  @config: {}

  # module classes for the application
  @modules: {}
  
  # model classes for the application
  @models: {}
  
  # controller classes for the application
  @controllers: {}

  # instantiates, initializes, starts and returns the application instance  
  @run: ->
    bootstrapper = new @config.bootstrapper
    @instance = new(@)
    @instance.run(bootstrapper)

  run: (bootstrapper)->
    @container = bootstrapper.configure_container()
    configure_modules()

    @publish "Application.initialize"
    @publish "Application.ready"
    @

  configure_modules: ->
    module_regex = /(.*)Module/ # e.g. AuthModule
    for klass_name, klass of @constructor.modules when matches = module_regex.exec(klass_name)
      module_name = _.string.underscored(matches[0]) # e.g. "auth"
      module = @container.resolve(new klass(module_name))
      @modules[module_name] = module
