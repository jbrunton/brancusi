#= require brancusi/container

namespace "Bbrancusi"

class Brancusi.Bootstrapper

    configure_container: ( application ) ->
        container = new Brancusi.Container()
        
        # TODO: do we need these?
        container.register_instance "Application", application
        container.register_instance "Container", container
        
        container.register_class "Sandbox", Brancusi.Sandbox
        container.register_class "Mediator", Brancusi.Mediator, singleton: true
        container.register_class "RegionManager", Brancusi.RegionManager, singleton: true
        
        container
