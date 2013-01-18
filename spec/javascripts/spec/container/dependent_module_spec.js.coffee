#= require brancusi/object_model
#= require brancusi/container

describe "brancusi.DependentModule", ->
  
  Foo = null
  
  beforeEach ->
    Foo = class extends brancusi.BaseObject
      @include brancusi.DependentModule

  describe ".dependency", ->
    it "adds the parameter as a dependency to the target class", ->
      Foo.dependency foo: 'foo'
      expect(Foo.dependencies).toEqual {foo: ['foo', []]}              

    it "appends multiple dependencies, if specified", ->
      Foo.dependency foo: 'foo', bar: 'bar'
      expect(Foo.dependencies).toEqual {foo: ['foo', []], bar: ['bar', []]}
      
    it "stores the passed arguments, if specified", ->
      Foo.dependency foo: 'foo', 'arg1', 'arg2'
      expect(Foo.dependencies).toEqual {foo: ['foo', ['arg1', 'arg2']]}
      
