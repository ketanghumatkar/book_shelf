
/**
 * Module dependencies.
 */

require('coffee-script');

var express = require('express')
  , RedisStore = require('connect-redis')(express)
  , flashify = require('flashify')
  , fs = require('fs')
  //, routes = require('./routes')
  //, user = require('./routes/user')
  , http = require('http')
  , path = require('path');

var app = express();

var logFile = fs.createWriteStream('./devlog.log', {flags: 'a'});

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.logger({stream: logFile}));
  //app.use(require('less-middleware')({ src: __dirname + '/public' }));
  //app.use(express.static(__dirname + '/public'));
  //app.use(express.bodyParser());
  //app.use(express.methodOverride());
  //app.use(app.router);
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser(
    "dglkkhlkdglkdlkghmlfgmflgfjhkjhjkdjrwoporzc"
  ));
  app.use(express.session({
    secret: "dgkglkerpozcplcbmqsfalkwjlghfghgvdmglejjgjdlg",
    store: new RedisStore
  }));
  app.use(flashify);
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
  app.use(function(req, res, next) {
    res.locals.messages = req.session.messages
    next();
  });
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

// Routes
//app.get('/', routes.index);
require('./apps/authentication/routes')(app);

http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
