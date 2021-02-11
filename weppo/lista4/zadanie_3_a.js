var b = require('./zadanie_3_b');


function a(x) {
    var res = 'a' + b(x-1)
    return res;
}

module.exports = a;
