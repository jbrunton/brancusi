#= require ./events_module
#= require ../container/dependent_object

namespace "brancusi"

# Base class for AER classes.
#
class brancusi.EventObject extends brancusi.DependentObject
    @include brancusi.EventsModule
    