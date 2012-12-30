namespace "brancusi"

# A module to facilitate the specification of dependencies.  Dependencies are defined on the
# 'dependencies' property of the target's prototype, in the format:
#
#     {attr1: ['dep1', [<args1>]], attr2: ['dep2', [<args2>]]}
#
# @mixin
#
class brancusi.DependentModule

  # Adds the named dependencies to the object's ::dependencies property
  #
  # @overload dependency(dependency, args...)
  #   Defines the given dependency on the subject class
  #   @param dependency [Object] an object with a single field in the format {<attribute>: '<dependency name>'}
  #   @param args [Array] optional an array of arguments to store with the dependency, to be passed as arguments on resolution
  #
  # @overload dependency(dependencies)
  #   Defines the given dependencies on the subject class
  #   @param dependencies [Object] an object naming a number of dependencies
  # 
  @dependency: (dependencies, args...) ->
    @::dependencies ?= {}
    
    for dependency_name, dependency_type of dependencies
      @::dependencies[dependency_name] = [dependency_type, args]