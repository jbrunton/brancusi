#= require ../renderer

namespace "Brancusi.Knockout"

class Brancusi.Knockout.Renderer extends Brancusi.Renderer
  
  render_template: (template, context, target) ->
    target.html $("<div></div>").attr 'data-bind',
      "template: 'template:#{template}'"

    ko.applyBindings(context || {}, target[0])


  