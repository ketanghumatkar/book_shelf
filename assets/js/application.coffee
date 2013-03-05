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
      console.log('A book state is modified');
      refresh()
    socket.on "book:deleted", (book) ->
      console.log('A book is deleted');
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
    console.log("....."+statesArray)
    $.ajax "/admin/books/#{dataId}",
      type:'PUT'
      data: {state}
    $(@).closest('tr').find('td.status div').removeClass 'on'
    $(@).addClass 'on'
