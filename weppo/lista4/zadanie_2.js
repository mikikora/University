function Foo() {
    this.val = 0;
    function Qux() {
        return 1;
    };
    Foo.prototype.Bar = function() {
        return Qux();
    }
    
}


var f1 = new Foo();
console.log( f1.Bar() );
try {
    console.log( f1.Qux() );
}
catch(e) {
    console.log('nie ma takiego pola');
}
