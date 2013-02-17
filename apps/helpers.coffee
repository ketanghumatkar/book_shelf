helpers = (app) ->

  app.locals
    urlFor: (object) ->
      if object.id
        "/admin/books/#{object.id}"
      else
        "/admin/books/"
    #currentUser: (req, res) ->
    #  if req.session
    #    req.session.currentUser
    #  else
    #  undefined

  #app.dynamicHelper
  #  urlFor: (req, res) ->


module.exports = helpers