var fs = require('fs');
var http2 = require('http2');

(async function () {
    var pfx = await fs.promises.readFile('certificate.pfx');
    var server = http2.createSecureServer({
        pfx: pfx,
        passphrase: 'test'
 });
    server.on('stream',
        (stream, headers) => {
            stream.respond({
                'content-type': 'text/html',
                ':status': 200
            });
        stream.end(`hello world ${new Date()}`);
    });

    server.listen(3000);
    console.log('started');
})(); 
