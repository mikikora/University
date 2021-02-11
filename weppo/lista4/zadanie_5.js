var fs = require('fs');
fs.readFile('zadanie_5_text.txt', 'utf8', function(err, data) {
    console.log(data);
})
