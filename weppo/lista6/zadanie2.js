var http = require('http');
var express = require('express');
var app = express();
var url = require('url');

app.set('view engine', 'ejs');
app.set('views', './views');

app.use( express.urlencoded({extended: true}) );

app.get( '/', (req, res) => {
    res.render('index');
});



http.createServer(app).listen(3000);
console.log('started');
