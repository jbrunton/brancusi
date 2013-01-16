# #= require brancusi/events
# 
# feature "Events", ->
# 
#   summary(
#   )
#   
#   window.support ?= {}
#   
#   window.support.listener = ->
#     new class extends brancusi.EventObject
#       @on "some.event", @handler()
#       handler: ->
#         
#   scenario "Subscribe to events", ->
#     
#     mediator = listener = null
#     
#     Given "A mediator and a listener", ->
#       mediator = new brancusi.Mediator
#       listener = support.listener()
#   
#     When "I publish an event the listener is subscribed to", ->
#       mediator.subscribe()
#     
#     