var http = require('http');
var express = require('express');
var app = express();
var url = require('url');

app.set('view engine', 'ejs');
app.set('views', './views');

app.use( express.urlencoded({extended: true}) );

app.get( '/', (req, res) => {
    obj = {surrname: '', name:'', subj:''};
    res.render('index', obj);
});

app.post( '/', (req, res) => {
    if (! req.body.name) {
        res.render('index', {name:'', surrname:req.body.surrname, subj:req.body.subj, message: 'należy podać imie'});
    } else if (! req.body.surrname) {
        res.render('index', {surrname:'', name:req.body.name, subj:req.body.subj, message: 'należy podać nazwisko'});
    } else if (! req.body.subj) {
        res.render('index', {surrname:req.body.surrname, name:req.body.name, subj:req.body.subj, message: 'należy podać przedmiot'});
    } else {
        
        res.redirect(url.format({
            pathname: '/print',
            query: req.body
        }));
    }
});

app.get('/print', (req, res) => {
    res.write('Imie i nazwisko: ' + req.query.name + ' ' + req.query.surrname + '\n');
    res.write('Przedmiot: ' + req.query.subj + '\n');
    for (var i = 1; i <= 10; i++) {
        if ( ! req.query[`s${i}`]) {
            res.write('S1: ' + '0' + '\n');
        } else {
            res.write('S1: ' + req.query[`s${i}`] + '\n');
        }
    }
    res.end('');
});


http.createServer(app).listen(3000);
console.log('started');
