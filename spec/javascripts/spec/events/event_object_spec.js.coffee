#= require brancusi/events

describe 'Brancusi.EventObject', ->
  
  describe '.on', ->
    it "invokes EventsModule.on on the calling class", ->
      class Foo extends Brancusi.EventObject
        @on 'Bar', ->
          
      instance = new Foo
    
      expect(instance["@Bar"]).toBeDefined()
