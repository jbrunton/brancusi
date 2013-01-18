#= require brancusi/container

namespace "brancusi"

class brancusi.Bootstrapper

    configure_container: ( application ) ->
        container = new brancusi.Container()
        
        # TODO: do we need these?
        container.register_instance "Application", application
        container.register_instance "Container", container
        
        container.register_class "Sandbox", brancusi.Sandbox
        container.register_class "Mediator", brancusi.Mediator, singleton: true
        container.register_class "RegionManager", brancusi.renderer.RegionManager, singleton: true
        
        container
