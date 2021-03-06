const express = require('express');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var methodOverride = require('method-override');
const path = require('path');

var app = express();
var server = require('http').Server(app);
var mongoose = require('mongoose');
var passport = require('passport');
var flash    = require('connect-flash');
var morgan = require('morgan');
var session = require('express-session');

var port = 8080;

app.use(bodyParser.urlencoded({extended: true}));
app.use(methodOverride('X-HTTP-Method-Override'));
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requestet-With, Content-Type, Accept");
    next();
})

var configDB = require('./config/database.js');

mongoose.connect(configDB.url);

// require('dotenv').config();

require('./config/passport')(passport);

app.use(cookieParser());
app.use(bodyParser.json());
app.use(session({ secret: 'ilovescotchscotchyscotchscotch' }));
app.use(passport.initialize());
app.use(passport.session());
app.use(flash());


require('./api/routes.js')(app, passport);

server.listen(port, function() {
    var port = server.address().port;
    console.log("App running on port " + port);
})
