namespace "brancusi.renderer"

class brancusi.renderer.KnockoutRenderer extends brancusi.renderer.Renderer
  
  render_template: (template, data, target) ->
    target.html $("<div></div>").attr 'data-bind',
      "template: 'template:#{template}'"

    ko.applyBindings(data || {}, target[0])


  