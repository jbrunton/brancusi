#= require brancusi/object_model/include

describe "brancusi.include", ->
        
    class FooModule
        @bar: 'bar'
        baz: 'baz'

    class FooClass
        brancusi.include(@, FooModule)

    it "mixes in static fields to the target", ->
        expect(FooClass.bar).toBe 'bar'
        
    it "mixes in instance fields to the target's prototype", ->
        foo = new FooClass
        expect(foo.baz).toBe 'baz'
        