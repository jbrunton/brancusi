#= require brancusi/object_model/base_object

describe 'brancusi.BaseObject', ->
  
  class FooModule
    @bar: 'bar'
    baz: 'baz'
    
  describe '.include', ->
    it "invokes brancusi.include on the calling class, passing the given module", ->
      spyOn(brancusi, 'include')

      class Foo extends brancusi.BaseObject
        @include FooModule
    
      expect(brancusi.include).toHaveBeenCalledWith(Foo, FooModule)
          
  describe '.extend', ->
    it "invokes brancusi.extend on the calling class, passing the given module", ->
      spyOn(brancusi, 'extend')
      
      class Foo extends brancusi.BaseObject
        @extend FooModule
      
      expect(brancusi.extend).toHaveBeenCalledWith(Foo, FooModule)
    
  describe '#decorate', ->
    it "invokes brancusi.decorate on the calling instance, passing the given decorator and arguments", ->
      spyOn(brancusi, 'decorate')
      
      foo = new (class extends brancusi.BaseObject)
      foo.decorate(FooModule, 'arg1')
      
      expect(brancusi.decorate).toHaveBeenCalledWith(foo, FooModule, 'arg1')
      
