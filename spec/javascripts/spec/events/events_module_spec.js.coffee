#= require brancusi/object_model
#= require brancusi/events/events_module

describe "brancusi.EventsModule", ->

    foo = new \
      class Foo extends brancusi.BaseObject
        @include brancusi.EventsModule        
        @on "Bar", ->

    describe ".on", ->  
      it "should define a handler on the instance", ->
        expect(foo["@Bar"]).toBeDefined()
        