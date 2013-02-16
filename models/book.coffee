redis = require('redis').createClient()

class Book
  @key: ->
    #"book_shelf_#{process.env.NODE_ENV}"
    "book_shelf_development"
  @all: (callback) ->
    redis.hgetall Book.key(), (err, objects) ->
      books = []
      for id, json of objects
        book = new Book JSON.parse(json)
        books.push book
      callback null, books
  constructor: (attributes) ->
    @[key] = value for key, value of attributes
    @setDefaults()
    @
  setDefaults: ->
    unless @state
      @state = 'unread'
    @generateId()
  generateId: ->
    if not @id and @name
      @id = @name.replace /\s/g, '-'
  save: (callback) ->
    @generateId()
    redis.hset Book.key(), @id, JSON.stringify(@), (err, code) =>
      callback null, @

module.exports = Book