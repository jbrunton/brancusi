#= require brancusi/application/sandbox

describe "Brancusi.Sandbox", ->

  sandbox = container = null

  beforeEach ->
    container = (new Brancusi.Container)
      .register_instance('Mediator', jasmine.createSpyObj('Mediator', ['publish_scoped', 'subscribe']))
      .register_class('Sandbox', Brancusi.Sandbox)
        
    sandbox = container.resolve('Sandbox', ['some'])

  it "has a mediator", ->
    expect(sandbox.mediator).toBeDefined()
    
  describe "#publish", ->
      
    it "publishes events via the application Mediator", ->
      sandbox.publish('some.event')
      expect(sandbox.mediator.publish_scoped).toHaveBeenCalledWith('some.event', 'some')
              
    it "publishes events with arguments", ->
      sandbox.publish('some.event', 1, 2, 3)
      expect(sandbox.mediator.publish_scoped).toHaveBeenCalledWith('some.event', 'some', 1, 2, 3)
      
  describe "#bind_subscriptions", ->
      
    it "binds event handlers on a target object", ->
      # target = { '@some.event': -> }
      #       sandbox.bind_subscriptions(target)        
      #       expect(sandbox.mediator.subscribe).toHaveBeenCalledWith('some.event', jasmine.any(Function), target)
      #       