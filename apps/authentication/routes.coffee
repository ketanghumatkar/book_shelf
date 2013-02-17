routes = (app) ->

  app.all '/*', (req, res, next) ->
    res.locals.currentUser = req.session.currentUser
    next()

  app.get '/login', (req, res) ->
    res.render "#{__dirname}/views/login",
      title: 'Login'
      stylesheet: 'login'

  app.post '/sessions', (req, res) ->
    console.log "in /sessions: %j", req.body
    if ("vishal" is req.body.username) and ("12345" is req.body.password)
      req.session.currentUser = req.body.username
      req.flash "success", "Hi #{req.session.currentUser}, you're logged in"
      res.redirect '/admin/books'
      return
    req.flash "error", 'Wrong credentials! Try again'
    res.redirect '/login'

  #app.del '/sessions', (req, res) ->
  app.get '/logout', (req, res) ->
    req.session.regenerate (err) ->
      req.flash "info", "You're logged out successfully"
      res.redirect "/login"

module.exports = routes # this makes routes accessible when requiring the file