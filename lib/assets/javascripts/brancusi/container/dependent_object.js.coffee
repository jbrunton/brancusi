#= require brancusi/object_model
#= require ./dependent_module

namespace "brancusi"

# Base class for dependent classes.
#
class brancusi.DependentObject extends brancusi.BaseObject
    @include brancusi.DependentModule