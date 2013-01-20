namespace "Brancusi.Knockout"

class Brancusi.Knockout.Renderer extends Brancusi.Renderer
  
  render_template: (template, data, target) ->
    target.html $("<div></div>").attr 'data-bind',
      "template: 'template:#{template}'"

    ko.applyBindings(data || {}, target[0])


  