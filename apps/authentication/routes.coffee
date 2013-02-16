routes = (app) ->

  app.get '/login', (req, res) ->
    res.render "#{__dirname}/views/login",
      title: 'Login'
      stylesheet: 'login'

  app.post '/sessions', (req, res) ->
    if ("vishal" is req.body.username) and ("12345" is req.body.password)
      console.log("User: %j", req.body.username);
      req.session.currentUser = req.body.username
      req.flash("success", "Hi #{req.session.currentUser}, you're logged in.")
      res.redirect '/login'
      return
    req.flash("error", 'Wrong credentials! Please try again.')
    console.log("User: %j", req.body.username);
    res.redirect '/login'

module.exports = routes