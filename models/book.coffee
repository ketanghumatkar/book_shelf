class Book
  constructor: (arguments) ->
    @[key] = value for key, value of arguments
    @setDefaults()
    @
  setDefaults: ->
    unless @state
      @state = 'unread'
    @generateId()
  generateId: ->
    if not @id and @name
      @id = @name.replace /\s/g, '-'

module.exports = Book
