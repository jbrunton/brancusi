#= require brancusi/events

describe "Brancusi.Mediator", ->

  mediator = test_handler = null

  beforeEach ->
    test_handler = jasmine.createSpy('test_handler')
    
  describe "#subscribe", ->
    it "registers the given subscriber for the named event", ->
      mediator = new Brancusi.Mediator
      mediator.subscribe 'foo', test_handler
      expect(mediator.subscribers['foo']).toContain(jasmine.any(Function))
      
  describe "#publish", ->
    
    beforeEach ->
      mediator = new Brancusi.Mediator
      mediator.subscribe 'foo', test_handler
    
    it "invokes subscribed handlers for the event", ->
      mediator.publish 'foo'
      expect(test_handler).toHaveBeenCalled()

    it "passes the given arguments to the subscriber", ->
      mediator.publish 'foo', 'arg1', 'arg2'
      expect(test_handler).toHaveBeenCalledWith('arg1', 'arg2')
  
  describe "#publish_scoped", ->
    
    beforeEach ->
      mediator = new Brancusi.Mediator
      mediator.subscribe 'foo.bar', test_handler
      
    it "implicitly scopes events", ->
      mediator.publish_scoped('bar', 'foo')
      expect(test_handler).toHaveBeenCalled()
    
    it "publishes qualified events without modification", ->
      mediator.publish_scoped('foo.bar', 'baz')
      expect(test_handler).toHaveBeenCalled()

    it "errors if asked to publish an invalid event name when given a scope", ->
      expect(-> mediator.publish_scoped('not.an.event', 'foo')).toThrow()
    
  describe "#bind_subscriptions", ->
    
    target = null
    
    beforeEach ->
      mediator = new Brancusi.Mediator
      target = jasmine.createSpyObj('Target', ['@event', '@some.event'])
    
    it "subscribes the target's event handlers", ->
      spyOn(mediator, 'subscribe')
      mediator.bind_subscriptions(target)
      expect(mediator.subscribe).toHaveBeenCalledWith('event', jasmine.any(Function), target)
      expect(mediator.subscribe).toHaveBeenCalledWith('some.event', jasmine.any(Function), target)
    
    it "subscribes the target's event handlers using the given scope, if one is provided", ->
      spyOn(mediator, 'subscribe')
      mediator.bind_subscriptions(target, 'target')
      expect(mediator.subscribe).toHaveBeenCalledWith('target.event', jasmine.any(Function), target)
      expect(mediator.subscribe).toHaveBeenCalledWith('some.event', jasmine.any(Function), target)
  
    