#from random import randint as losuj
from collections import defaultdict as dd
from zagadka import alfa, roznica
from random import choice as wybierz

slowa = [e.lower().strip() for e in open("slowa.txt")]
slownik = dd(list)
for e in slowa:
    slownik[alfa(e)].append(e)
litery = 'aąbcćdeęfghijklłmnńoóprsśtuwyzźż'
litery = sorted(litery)
tmp = ''
for e in litery:
    tmp += e
litery = tmp
pojedyncze = [k for k in slownik if roznica(litery,k) != 1]

def polalfabeton (wynik = ''):
    dostepne = litery
    mozliwe = pojedyncze
    if wynik != '':
        dostepne = roznica(dostepne, wynik)
        mozliwe = [e for e in slownik if roznica(dostepne,e) != 1]
        wynik += ' '
    #print(mozliwe)
    while (mozliwe != []):
        k = wybierz(mozliwe)
        wynik += wybierz(slownik[k]) + ' '
        dostepne = roznica(dostepne,k)
        mozliwe = [e for e in slownik if roznica(dostepne,e) != 1]
    return (wynik,dostepne)

def trudnosc_liter(ile):
    trudnosc = dd(int)
    for i in range(ile):
        print(i)
        pozostalo = polalfabeton()[1]
        for e in pozostalo:
            trudnosc[e] += 1
    return trudnosc

def posortuj_pojedyncze():
    trudnosc = trudnosc_liter(10)
    pary = list()
    for e in pojedyncze:
        suma = 0
        for f in e:
            suma += trudnosc[f]
        pary.append((e,suma))
    pary = sorted(pary, reverse = True, key = lambda para: para[1])
    #print(pary)
    nowe_pojedyncze = list()
    for e in pary:
        nowe_pojedyncze.append(e[0])
    return nowe_pojedyncze
        
#print(trudnosc_liter(10))
#print(polalfabeton()[0])
#for i in range(10):
#    print(polalfabeton())
pojedyncze = posortuj_pojedyncze()
wybrane_slowo = wybierz(slownik[pojedyncze[0]])
print(polalfabeton(wybrane_slowo))
