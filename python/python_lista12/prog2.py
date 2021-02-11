from permutacja import ppn
from collections import defaultdict as dd
from random import choice

alfabet = 'pchnąćwtęłódźjeżalubośmskrzyńfig'
slowa = [e for a in open('slowa.txt') for e in a.strip().split()]
szyfrogramy = [e.strip() for e in open('szyfrogramy.txt')]

pierwszy = szyfrogramy[0]
drugi = szyfrogramy[1]

PermutacyjnaPostac = dd(list)
for e in slowa:
    PermutacyjnaPostac[ppn(e)].append(e)


def odkoduj (szyfr):
    szyfr = szyfr.split()
    wynik = list()
    for e in szyfr:
        if any(a not in alfabet for a in e):
            wynik.append(e)
        else:
            postac = ppn(e)
            if PermutacyjnaPostac[postac] == []:
                print(e, postac)
            wynik.append(choice(PermutacyjnaPostac[postac]))
    return wynik

if False:
    wynik1 = odkoduj(pierwszy)
    wynik2 = odkoduj(drugi)           
    print(wynik1, wynik2, sep = '\n')

for e in szyfrogramy:
    print(e, odkoduj(e), sep = '\n')
    print()

