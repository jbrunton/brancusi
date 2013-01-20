namespace "Brancusi"

# Extends the target with methods from the given mixin.
#
# @param target [Class] the class to mix in the module.
# @param module [Class] the module to mixin.
#
Brancusi.include = (target, module) ->
  for key, value of module
    target[key] = value
      
  for key, value of module::
    target::[key] = value
