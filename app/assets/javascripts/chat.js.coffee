# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class ChatController
  constructor: ->
    @vent = new EventSource("/chat/connect")
    @vent.onerror = (event)=>
      console.log "onError", event
      @_addSystemMessage(text: 'Verbindung unterbrochen')
    @vent.onopen = (event)=>
      @_addSystemMessage(text: 'Verbindung hergestellt')

#    @vent.onmessage = (event)-> console.log "onMessage", event

    @vent.addEventListener 'append_message', (event)=>
      console.log 'append_message', event
      @_addChatMessage(JSON.parse(event.data))

    console.log "init EventSource", @vent

  _addChatMessage: (data)->
    $('<div class="message"></div>').text(data.text).prependTo('#chat')

  _addSystemMessage: (data)->
    $('<div class="system-message"></div>').text(data.text).prependTo('#chat')

$ ->
  new ChatController()