#= require brancusi/object_model/decorate

describe "Brancusi.decorate", ->

  class TestDecorator
    foo: "foo"
    constructor: (@bar) ->
      @bar ?= 'bar'

  target = null

  beforeEach ->
    target = new Object
  
  it "should extend an object with instance fields", ->
    Brancusi.decorate(target, TestDecorator)
    expect(target.foo).toBe 'foo'
      
  it "should invoke the constructor", ->
    Brancusi.decorate(target, TestDecorator)
    expect(target.bar).toBe 'bar'
  
  it "should pass the given arguments to the constructor", ->
    Brancusi.decorate(target, TestDecorator, 'baz')
    expect(target.bar).toBe 'baz'
