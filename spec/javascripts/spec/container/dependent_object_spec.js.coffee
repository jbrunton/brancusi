#= require brancusi/container

describe 'brancusi.DependentObject', ->
  
  describe '.dependency', ->
    it "invokes DependentModule.dependencies on the calling class", ->
      class Foo extends brancusi.DependentObject
        @dependency foo: 'foo', 'arg1', 'arg2'
    
      expect(Foo::dependencies).toEqual {foo: ['foo', ['arg1', 'arg2']]}
      
