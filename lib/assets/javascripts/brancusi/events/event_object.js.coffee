#= require ./events_module
#= require ../container/dependent_object

namespace "Brancusi"

# Base class for AER classes.
#
class Brancusi.EventObject extends Brancusi.DependentObject
    @include Brancusi.EventsModule
    