#= require brancusi/object_model/extend

describe "Brancusi.extend", ->

    class FooModule
        bar: 'bar'

    class FooClass
        Brancusi.extend(@, FooModule)

    it "extends the target with fields from the module", ->
        expect(FooClass.bar).toBe 'bar'
        