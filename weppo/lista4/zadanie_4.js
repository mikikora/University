//u mnie domyślny encoding jest ustawiony na utf8

process.stdin.setEncoding('utf8');
console.log('Wprowadź swoje imie: ');
process.stdin.on('data', function(data) {
    console.log(`Witaj: ${data}`);
    process.stdin.pause();
});

