#= require brancusi/application/application_controller

describe "Brancusi.ApplicationController", ->
  
  it "extends Brancusi.ApplicationModule", ->
    controller = new Brancusi.ApplicationController
    expect(controller).toBeInstanceOf Brancusi.ApplicationModule
    
  it "has a renderer", ->
    expect(Brancusi.ApplicationController).toHaveDependency('renderer', type: 'Renderer')
    
  describe "#begin_request", ->
    it "sets the controller's request object with the given action name", ->
      controller = new Brancusi.ApplicationController('home')
      controller.begin_request('index')
      expect(controller.request).toEqual { action: 'index' }   
      
  describe "#end_request", ->
    controller = null
    
    beforeEach ->
      controller = new Brancusi.ApplicationController('home')
      controller.renderer = jasmine.createSpyObj('renderer', ['render_page'])
      controller.begin_request('index')
      
    it "does nothing, if @render was called during the request cycle", ->
      controller.render()
      spyOn(controller, 'render')
      controller.end_request()
      expect(controller.render).not.toHaveBeenCalled()
      
    it "invokes the controller's render method if it was not already called during the request cycle", ->
      spyOn(controller, 'render')
      controller.end_request()
      expect(controller.render).toHaveBeenCalled()
    
  describe "#render", ->
    controller = null
    
    beforeEach ->
      controller = new Brancusi.ApplicationController('home')
      controller.renderer = jasmine.createSpyObj('renderer', ['render_page'])
      controller.begin_request('index')
      
    describe "overload: render()", ->
      it "invokes the default template for the controller", ->
        controller.render()
        expect(controller.renderer.render_page).toHaveBeenCalledWith('home/index', undefined)
    
    describe "overload: render(template)", ->
      it "invokes the template named by the given parameter", ->
        controller.render('users/welcome')
        expect(controller.renderer.render_page).toHaveBeenCalledWith('users/welcome', undefined)
        
    describe "overload: render(context)", ->
      it "invokes the default template with the given object as the rendering context", ->
        context = {}
        controller.render(context)
        expect(controller.renderer.render_page).toHaveBeenCalledWith('home/index', context)
        
    describe "overload: render(context, opts)", ->
      it "invokes the template named in the opts param against the given context", ->
        context = {}
        controller.render(context, template: 'users/welcome')
        expect(controller.renderer.render_page).toHaveBeenCalledWith('users/welcome', context)
        