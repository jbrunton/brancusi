#= require brancusi/application/sandbox

describe "brancusi.Sandbox", ->

  sandbox = container = null

  beforeEach ->
    container = (new brancusi.Container)
      .register_instance('Mediator', jasmine.createSpyObj('Mediator', ['publish', 'subscribe']))
      .register_class('Sandbox', brancusi.Sandbox)
        
    sandbox = container.resolve('Sandbox', [{ name: 'some' }])

  it "has a mediator", ->
    expect(sandbox.mediator).toBeDefined()
    
  describe "#publish", ->
      
    it "publishes events via the application Mediator", ->
      sandbox.publish('some.event')
      expect(sandbox.mediator.publish).toHaveBeenCalledWith('some.event')
              
    it "publishes events with arguments", ->
      sandbox.publish('some.event', 1, 2, 3)
      expect(sandbox.mediator.publish).toHaveBeenCalledWith('some.event', 1, 2, 3)
  
    it "implicitly scopes published events according to the name of the sandbox module", ->
      sandbox.publish('event')        
      expect(sandbox.mediator.publish).toHaveBeenCalledWith('some.event')

    it "errors if asked to publish an invalid event name", ->
      expect(-> sandbox.publish('not.an.event')).toThrow()
      
  describe "#bind_subscriptions", ->
      
    it "binds event handlers on a target object", ->
      target = { '@some.event': -> }
      sandbox.bind_subscriptions(target)        
      expect(sandbox.mediator.subscribe).toHaveBeenCalledWith('some.event', jasmine.any(Function), target)
      