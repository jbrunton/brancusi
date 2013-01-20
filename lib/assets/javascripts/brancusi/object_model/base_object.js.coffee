#= require ./include
#= require ./decorate

namespace "Brancusi"

# Implements convenience methods to include mixins and decorate instances.
#
class Brancusi.BaseObject

  # Static method to include a module into the class.
  #
  # @param module [Object] the module to include.
  #
  @include: (module) ->
    Brancusi.include(@, module)
      
  # Static method to extend the class with a module.
  #
  # @param module [Object] the module to include.
  #
  @extend: (module) ->
    Brancusi.extend(@, module)

  # Decorates the instance with the given decorator.
  #
  decorate: (decorator, args...)->
    Brancusi.decorate(@, decorator, args...)