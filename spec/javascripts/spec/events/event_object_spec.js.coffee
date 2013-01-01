#= require brancusi/events

describe 'brancusi.EventObject', ->
  
  describe '.on', ->
    it "invokes EventsModule.on on the calling class", ->
      class Foo extends brancusi.EventObject
        @on 'Bar', ->
          
      instance = new Foo
    
      expect(instance["@Bar"]).toBeDefined()
