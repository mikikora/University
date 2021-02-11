var Pool = require("pg").Pool;
var pool = new Pool({
    user: "mikolaj",
    host: "localhost",
    database: "weppo",
    port: 5432
});

//wszystkie zdania są rozwiązywane na tabeli osoba (id_osoba SERIAL PRIMARY KEY, imie text, nazwisko text, plec char, pesel varchar(11))
(async function () {
    //zadanie 2
    try {
        var result = await pool.query('SELECT * FROM osoba');

        result.rows.forEach( r => {
            console.log( `${r.imie} ${r.nazwisko} `);
        });
    }
    catch (err) {
        console.log(err);
    }
    try {
        var id = await pool.query("INSERT INTO osoba (imie, nazwisko, plec, pesel) VALUES ('Mikolaj', 'Korobczak', 'm', '99999999999') RETURNING id_osoba;");

        id.rows.forEach( r => {
            console.log( `${r.id_osoba}` );
        });
    }
    catch (err) {
        console.log(err);
    }
    //zadanie 3

    try {
        await pool.query("UPDATE osoba SET pesel='88888888888' WHERE imie='Mikolaj' AND nazwisko='Korobczak'");
        var result = await pool.query("SELECT * FROM osoba WHERE imie='Mikolaj' and nazwisko='Korobczak'");
        result.rows.forEach( r => {
            console.log( `${r.pesel}` );
        });
    }
    catch (err) {
        console.log(err);
    }
    try {
        await pool.query("DELETE FROM osoba WHERE id_osoba=1");
        var result = await pool.query("SELECT * FROM osoba WHERE id_osoba=1");
        console.log('Wypisywanie usuniętej osoby:');
        result.rows.forEach( r => {
            console.log( `${r.imie} ${r.nazwisko}` );
        });
        console.log('Koniec wypisywania');
    }
    catch (err) {
        console.log(err);
    }
    //zadanie 4
    try {
        await pool.query("CREATE TABLE miejsce_pracy (id_miejsca_pracy SERIAL PRIMARY KEY, nazwa text)");
        await pool.query("ALTER TABLE osoba ADD COLUMN id_miejsca_pracy INTEGER;");
        await pool.query("ALTER TABLE osoba ADD FOREIGN KEY (id_miejsca_pracy) REFERENCES miejsce_pracy(id_miejsca_pracy);");
        var id_miejsca_pracy = await pool.query("INSERT INTO miejsce_pracy (nazwa) VALUES ('bezrobotny') RETURNING id_miejsca_pracy;");
        await pool.query(`INSERT INTO osoba (imie, nazwisko, plec, pesel, id_miejsca_pracy) VALUES ('Jan', 'Kowalski', 'm', '11111111111', ${id_miejsca_pracy.rows[0].id_miejsca_pracy});`);
        var result = await pool.query("SELECT * FROM osoba JOIN miejsce_pracy ON osoba.id_miejsca_pracy=miejsce_pracy.id_miejsca_pracy WHERE pesel='11111111111';");
        result.rows.forEach( r => {
            console.log( `${r.imie} ${r.nazwisko} ${r.id_miejsca_pracy} ${r.nazwa}` );
        });
    }
    catch (err) {
        console.log(err);
    }
})();



















