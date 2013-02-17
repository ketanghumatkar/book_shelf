
/**
 * Module dependencies.
 */

require('coffee-script');
require('less');
require('express-namespace');

var express = require('express')//.createServer()
  //, Handlebars = require('handlebars')
  , http = require('http')
  , app = express()
  , server = http.createServer(app)
  , RedisStore = require('connect-redis')(express)
  , flashify = require('flashify')
  , fs = require('fs')
  //, routes = require('./routes')
  //, user = require('./routes/user')
  , http = require('http')
  , path = require('path');


//require('express-handlebars')(app, Handlebars);



var logFile = fs.createWriteStream('./devlog.log', {flags: 'a'});


// Configuration
require('./apps/socket-io')(server, app)

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.logger({stream: logFile}));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser("dglkkhlkdglkdlkghmlfgmf"));
  app.use(express.session({
    secret: "dgkglkerpozcplcblg",
    store: new RedisStore
  }));
  app.use(flashify);
  app.use(app.router);
  app.use(require('connect-assets')());
  app.use(express.static(path.join(__dirname, 'public')));
  app.use(function(req, res, next) {
    //res.locals.session = req.session;
    next();
  });
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

// Helpers
require('./apps/helpers')(app);

// Routes
require('./apps/authentication/routes')(app);
require('./apps/admin/routes')(app);
require('./apps/showcase/routes')(app);

server.listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'))
});