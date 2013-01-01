namespace "brancusi"

# Provides convenience methods @on and publish for subscribing and publishing to application events with AER.
#
class brancusi.EventsModule

  # Generates a named event handler for AER.
  #
  # @param event [String] the name of the event.
  # @param handler [Function] the event handler.
  #
  @on: (event, handler) ->
    @::["@#{event}"] = handler
      