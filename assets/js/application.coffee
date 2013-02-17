#= require jquery.min.js
#= require bootstrap.min.js
#= require underscore-min.js

jQuery ->
  # Home page
  if window.location.pathname is '/'
    refresh = ->
      window.location = '/'

    socket = io.connect("/")
    socket.on "book:changed", (book) ->
      refresh()

    setTimeout refresh, 1000*60

    # DEBUG
    window.socket = socket

  # Admin
  $('td.status div').click ->
    dataId      = $(@).closest('tr').attr('data-id')
    classNames  = $(@).attr('class').split(' ')
    statesArray = _.reject classNames, (className) -> className is 'on'
    state       = statesArray[0]
    $.ajax "/admin/pies/#{dataId}",
      type:'PUT'
      data: {state}
    $(@).closest('tr').find('td.status div').removeClass 'on'
    $(@).addClass 'on'
