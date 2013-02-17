Book = require '../../models/book'

routes = (app) ->

  app.get '/', (req, res) ->
    Book.active (err, books) ->
      res.render "#{__dirname}/views/index",
        title: 'Activity'
        stylesheet: 'showcase'
        books: books

module.exports = routes