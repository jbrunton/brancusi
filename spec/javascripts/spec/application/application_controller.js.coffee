#= require brancusi/application/application_controller

describe "Brancusi.ApplicationController", ->
  
  it "extends Brancusi.ApplicationModule", ->
    controller = new Brancusi.ApplicationController
    expect(controller).toBeInstanceOf Brancusi.ApplicationModule
    
  it "has a renderer", ->
    expect(Brancusi.ApplicationController).toHaveDependency('renderer', type: 'Renderer')
    
    