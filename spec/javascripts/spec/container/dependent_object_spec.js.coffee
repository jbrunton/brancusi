#= require brancusi/container

describe 'brancusi.DependentObject', ->
  
  describe '.dependency', ->
    it "invokes DependentModule.dependencies on the calling class", ->
      class Foo extends brancusi.DependentObject
        @dependency foo: 'foo', 'arg1', 'arg2'
    
      expect(Foo.dependencies).toEqual {foo: ['foo', ['arg1', 'arg2']]}
      
    it "respects inheritance", ->
      class window.Foo extends brancusi.DependentObject
        @dependency foo: 'foo'
        
      class window.Bar extends Foo
        @dependency bar: 'bar'
        
      class window.Baz extends Foo
        @dependency baz: 'baz'
        
      expect(Bar.dependencies).toEqual {foo: ['foo', []], bar: ['bar', []]}
      expect(Baz.dependencies).toEqual {foo: ['foo', []], baz: ['baz', []]}