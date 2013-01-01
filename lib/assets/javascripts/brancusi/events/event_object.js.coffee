#= require ./events_module

namespace "brancusi"

# Base class for AER classes.
#
class brancusi.EventObject extends brancusi.DependentObject
    @include brancusi.EventsModule
    