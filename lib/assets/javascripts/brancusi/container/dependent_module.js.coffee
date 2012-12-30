namespace "brancusi"

# A module to facilitate the specification of dependencies.
#
# @mixin
#
class brancusi.DependentModule

    @dependency: (dependencies, args...) ->
        @::dependencies ?= {}
        
        for dependency_name, dependency_type of dependencies
            @::dependencies[dependency_name] = [dependency_type, args]