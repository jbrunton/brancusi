#= require brancusi/object_model
#= require ./dependent_module

namespace "Brancusi"

# Base class for dependent classes.
#
class Brancusi.DependentObject extends Brancusi.BaseObject
    @include Brancusi.DependentModule