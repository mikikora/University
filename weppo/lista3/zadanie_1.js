var person = {
    name: 'Andrzej',
    say: function () {
        console.log(preson.name);
    },
    _surrname: '',
    get surrname() {
        return person._surrname;   
    },
    set surrname(s) {
        person._surrname = s;
    }
};

person.surrname = 'kowalski';
console.log(person.surrname);

person.age = 14;
person.greeting = function() {
    console.log(`Hello! I\'m ${person.name}`);
};
person.greeting();
person._sex = 'f';
Object.defineProperty(person, 'sex', { 
    get: function() {return person._sex;}, 
    set: function(s) {person._sex=s;} });

person.sex = 'm';
console.log(person.sex);

