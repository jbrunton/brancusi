#= require brancusi/object_model
#= require brancusi/events/events_module

describe "Brancusi.EventsModule", ->

    foo = new \
      class Foo extends Brancusi.BaseObject
        @include Brancusi.EventsModule        
        @on "Bar", ->

    describe ".on", ->  
      it "should define a handler on the instance", ->
        expect(foo["@Bar"]).toBeDefined()
        