Book = require('../../models/book.coffee')

routes = (app) ->

  app.namespace '/admin', ->

    app.namespace '/books', ->

      app.all '/*', (req, res, next) ->
        if not (req.session.currentUser)
          req.flash "error", "Please login first !"
          res.redirect '/login'
          return
        next()

      app.get '/', (req, res) ->
        book = new Book {}
        res.render "#{__dirname}/views/books/all",
          title: 'All Books'
          stylesheet: 'admin'
          book: book

      app.post '/', (req, res) ->
        attributes =
          name: req.body.name
          author: req.body.author
          language: req.body.language
        book = new Book(attributes)
        book.save (err, book) ->
          req.flash "success", "Book - #{book.name} added successfully"
          res.redirect '/admin/books'

module.exports = routes