#= require brancusi/object_model/base_object

describe 'Brancusi.BaseObject', ->
  
  class FooModule
    
  describe '.include', ->
    it "invokes Brancusi.include on the calling class, passing the given module", ->
      spyOn(Brancusi, 'include')

      class Foo extends Brancusi.BaseObject
        @include FooModule
    
      expect(Brancusi.include).toHaveBeenCalledWith(Foo, FooModule)
          
  describe '.extend', ->
    it "invokes Brancusi.extend on the calling class, passing the given module", ->
      spyOn(Brancusi, 'extend')
      
      class Foo extends Brancusi.BaseObject
        @extend FooModule
      
      expect(Brancusi.extend).toHaveBeenCalledWith(Foo, FooModule)
    
  describe '#decorate', ->
    it "invokes Brancusi.decorate on the calling instance, passing the given decorator and arguments", ->
      spyOn(Brancusi, 'decorate')
      
      foo = new (class extends Brancusi.BaseObject)
      foo.decorate(FooModule, 'arg1')
      
      expect(Brancusi.decorate).toHaveBeenCalledWith(foo, FooModule, 'arg1')
      
