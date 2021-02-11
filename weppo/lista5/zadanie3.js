var http = require('http');

var server =
    http.createServer(
    (req, res) => {
        res.setHeader('Content-Disposition', 'attachment');
        res.end(`hello world ${new Date()}`);
    });


server.listen(3000);
console.log('started');
