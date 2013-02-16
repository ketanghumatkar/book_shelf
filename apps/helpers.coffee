helpers = (app) ->

  app.locals
    urlFor: (object) ->
      if object.id
        "/admin/books/#{object.id}"
      else
        "/admin/books/"

  #app.dynamicHelper
  #  urlFor: (req, res) ->


module.exports = helpers