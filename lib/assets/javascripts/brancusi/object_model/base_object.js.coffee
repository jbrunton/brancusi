#= require ./include
#= require ./decorate

namespace "brancusi"

# Implements convenience methods to include mixins and decorate instances.
#
class brancusi.BaseObject

    # Static method to include a module into a class.
    #
    # @param module [Object] the module to include.
    #
    @include: ( module ) ->
        brancusi.include( @, module )

    # Decorates an instance with the given decorator.
    #
    decorate: ->
        brancusi.decorate( @, arguments... )