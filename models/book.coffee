redis = require('redis').createClient()

class Book
  @key: ->
    #"book_shelf_#{process.env.NODE_ENV}"
    "book_shelf_development"
  @states: ['unread', 'reading', 'read']
  @all: (callback) ->
    redis.hgetall Book.key(), (err, objects) ->
      books = []
      for id, json of objects
        book = new Book JSON.parse(json)
        books.push book
      callback null, books
  @active: (callback) ->
      Book.all (err, books) ->
        activeBooks = (book for book in books when book.state isnt 'unread')
        callback null, activeBooks
  @getById: (id, callback) ->
    redis.hget Book.key(), id, (err, json) ->
      if json is null
        callback new Error("Book '#{id}' could not be found.")
        return
      book = new Book JSON.parse(json)
      callback null, book
  constructor: (attributes) ->
    @[key] = value for key, value of attributes
    @setDefaults()
    @
  setDefaults: ->
    unless @state
      @state = 'unread'
    @generateId()
    @defineStateMachine()
  generateId: ->
    if not @id and @name
      @id = @name.replace /\s/g, '-'
  defineStateMachine: ->
    for state in Book.states
      do (state) =>
        @[state] = (callback) ->
          @state = state
          @stateUpdatedAt = (new Date).getTime()
          @save ->
            callback()
  save: (callback) ->
    @generateId()
    redis.hset Book.key(), @id, JSON.stringify(@), (err, code) =>
      callback null, @

module.exports = Book