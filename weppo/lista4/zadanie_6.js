var rd = require('readline');
var fs = require('fs');

var my_interface = rd.createInterface({
    input : fs.createReadStream('test_6.txt')
});



var ipAddr = {
    _array : [],
    push : function(x) {
        function isGood(y) {
            return x == y[0]
        }
        var idx = this._array.findIndex(isGood);
        if (idx != -1) {
            this._array[idx][1] += 1;
        } else {
            this._array.push([x, 0]);
        }
    },
    best3 : function() {
        this._array.sort(function(x, y) {if ( x[1] < y[1]) {
            return 1;
        } else {
                return -1}});
        return [this._array[0], this._array[1], this._array[2]];
    }
}

my_interface.on('line', function(data) {
    var line = data.split(' ');
    ipAddr.push(line[1]);
});
my_interface.on('close', function() {
    console.log(ipAddr.best3());
});
