#= require ./extend

namespace "Brancusi"
    
# Decorates the target object with methods from the given decorator, and invokes the constructor.
#
# @param target [Object] the object to decorate.
# @param decorator [Class] the decorator to use.
# @param args... [Array] the arguments to pass to the decorator's constructor.
#
Brancusi.decorate = (target, decorator, args...) ->
  Brancusi.extend(target, decorator)
  decorator.apply(target, args)
  