#= require brancusi/application/application_module

describe "brancusi.ApplicationModule", ->
  
  module = null

  beforeEach ->
    container = (new brancusi.Container)
      .register_instance('Mediator', {})
      .register_instance('Sandbox', jasmine.createSpyObj('Sandbox', ['publish']))
        
    module = container.resolve(new brancusi.ApplicationModule('example'))

  it "has a name", ->
    expect(module.name).toBe 'example'

  it "has a sandbox", ->
    expect(module.sandbox).toBeDefined()
    
  describe "#publish", ->
    
    it "delegates to its sandbox's publish method", ->
      module.publish('some.event')
      expect(module.sandbox.publish).toHaveBeenCalledWith('some.event')
      
