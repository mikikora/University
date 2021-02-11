'''
Skrypt do wygenerowania plików SQLowych, które stworzą bazę na dwa możliwe sposoby w zadaniu (dwa osobne pliki).
W tym skrypcie używam biblioteki Faker
pip install faker
'''
from random import randint
from random import choice
from faker import Faker
fake = Faker(['pl_PL'])
file = open('create_table.dump', 'w')
print('DROP TABLE IF EXISTS "osoba" CASCADE;', file=file)
print('CREATE TABLE osoba (id_osoba SERIAL PRIMARY KEY, imie text, nazwisko text, plec char, pesel varchar(11));', file=file)
#print('COPY osoba (imie, nazwisko, plec, pesel) FROM stdin;', file=file)
for _ in range(100):
    name = fake.name().split()
    while len(name) != 2:
        name = fake.name().split()
    pesel = []
    for _ in range(11):
        pesel.append(choice('0123456789'))
    print('INSERT INTO osoba (imie, nazwisko, plec, pesel) VALUES (', end='', file=file)
    print("'" + name[0] + "'", "'" + name[1] + "'", choice(["'f'", "'m'"]), "'" + ''.join(pesel) + "'", file=file, sep=',', end='')
    print(');', file=file)

#print('\.', file=file)
print("SELECT * FROM osoba", file=file)
file.close()
file = open('create_table_with_sequence.dump', 'w')
print('DROP TABLE IF EXISTS "osoba" CASCADE;', file=file)
print('CREATE SEQUENCE osoba_id START 1 INCREMENT 1;', file=file)
print("CREATE TABLE osoba (id_osoba INTEGER PRIMARY KEY, imie text, nazwisko text, plec char, pesel varchar(11));", file=file)
#print('COPY osoba (imie, nazwisko, plec, pesel) FROM stdin;', file=file)
for _ in range(100):
    name = fake.name().split()
    while len(name) != 2:
        name = fake.name().split()
    pesel = []
    for _ in range(11):
        pesel.append(choice('0123456789'))
    print('INSERT INTO osoba (id_osoba, imie, nazwisko, plec, pesel) VALUES (', end='', file=file)
    print("nextval('osoba_id')", "'" + name[0] + "'", "'" + name[1] + "'" , choice(["'f'", "'m'"]), "'" + ''.join(pesel) + "'", file=file, sep=',', end='')
    print(');', file=file)

#print('\.', file=file),
print("SELECT * FROM osoba", file=file)
file.close()
