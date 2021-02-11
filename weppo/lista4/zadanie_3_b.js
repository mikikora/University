//var a = require('./zadanie_3_a'); //Tutaj a jest jeszcze pustym obiektem więc nie będę mógł wywołać a

function b(x) {
    if (x <= 0) return 'b'
    var a = require('./zadanie_3_a'); //tutaj w głównej przestrzeni nazw require będzie już posiadał definicję a
    var res = 'b' + a(x-1);
    return res;
}

module.exports = b;
