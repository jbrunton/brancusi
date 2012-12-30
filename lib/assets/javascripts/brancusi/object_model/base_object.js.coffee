namespace "brancusi"

#= require ./include
#= require ./decorate

# Implements convenience methods to include mixins and decorate instances.
#
class brancusi.BaseObject

  # Static method to include a module into the class.
  #
  # @param module [Object] the module to include.
  #
  @include: (module) ->
    brancusi.include(@, module)
      
  # Static method to extend the class with a module.
  #
  # @param module [Object] the module to include.
  #
  @extend: (module) ->
    brancusi.extend(@, module)

  # Decorates the instance with the given decorator.
  #
  decorate: (decorator, args...)->
    brancusi.decorate(@, decorator, args...)