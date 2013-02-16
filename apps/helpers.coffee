helpers = (app) ->

  app.locals
    urlFor: (object) ->
      if object.id
        "/admin/books/#{object.id}"
      else
        "/admin/books/"
    currentUser: (req, res) ->
      req.session.currentUser
      ()

  #app.dynamicHelper
  #  urlFor: (req, res) ->


module.exports = helpers