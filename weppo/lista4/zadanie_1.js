function Tree(val, left, right) {
    this.left = left;
    this.right = right;
    this.val = val;
}
/*
Tree.prototype[Symbol.iterator] = function*() {
    yield this.val;
    if ( this.left ) yield* this.left;
    if ( this.right ) yield* this.right;
}*/

var queue = {
    _array : [],
    get pop() {
        return this._array.splice(0,1)[0];
    },
    set push(x) {
        this._array.push(x);
    },
    get isEmpty() {
        return this._array.length == 0;
    }
}

Tree.prototype[Symbol.iterator] = function*() {
    queue.push = this;
    while (! queue.isEmpty) {
        let t = queue.pop;
        if (t.left) queue.push = t.left;
        if (t.right) queue.push = t.right;
        yield t.val;
    }
}

var root = new Tree( 1,
    new Tree( 2, new Tree( 3 ) ), new Tree( 4 ));
    

for ( var e of root ) {
    console.log( e );
}
