#= require brancusi/object_model/extend

describe "brancusi.extend", ->

    class FooModule
        bar: 'bar'

    class FooClass
        brancusi.extend(@, FooModule)

    it "extends the target with fields from the module", ->
        expect(FooClass.bar).toBe 'bar'
        