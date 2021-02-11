from random import randint as losuj
from itertools import permutations as permutuj

def litery (a):
    wynik = list()
    for e in a:
        wynik.append(e)
    return wynik
'''
def generuj (slownik, spis):
    for e in spis:
        slownik[e] = losuj(0,9)
'''

def sprawdz (pierw, drug, koniec, klucz):
    if klucz[pierw[0]] == 0 or klucz[drug[0]] == 0 or klucz[koniec[0]] == 0:
        return 0
    i = 1
    wynik = list()
    pamiec = 0
    while i <= len(pierw):
        dodanie = klucz[pierw[-i]] + klucz[drug[-i]] + pamiec
        #print(dodanie)
        pamiec = 0
        while dodanie > 9:
            pamiec += 1
            dodanie -= 10
        wynik = [dodanie] + wynik
        #print([dodanie], wynik)
        i += 1
    while i <= len(drug):
        dodanie = klucz[drug[-i]] + pamiec
        pamiec = 0
        while dodanie > 9:
            pamiec += 1
            dodanie -= 10
        wynik = [dodanie] + wynik
    if pamiec != 0:
        wynik = [pamiec] + wynik
    koniecc = [klucz[e] for e in koniec]
    if koniecc == wynik:
        return 1
    return 0
    
def polacz (tab, slownik, spis):
    for i in range(len(spis)):
        slownik[spis[i]] = int(tab[i])

def solved (zagadka):
    zagadka = zagadka.split()
    #print(zagadka)
    pierwsze = litery(zagadka[0])
    drugie = litery(zagadka[2])
    wynik = litery(zagadka[-1])
    if len(pierwsze) > len(drugie):
        pierwsze, drugie = drugie, pierwsze
    przypisz = dict()
    spis = list()
    for e in pierwsze + drugie + wynik:
        spis.append(e)
    spis = list(set(spis))
    #print(spis)
    if len(spis) > 10:
        return {}
    good = 0
    for p in permutuj('0123456789',len(spis)):
        polacz(p, przypisz, spis)
        if sprawdz(pierwsze, drugie, wynik, przypisz) == 1:
            good = 1
            break
    if good == 1:
        return przypisz
    else:
        return {}
   
def wypisz (s):
    wynik = solved(s)
    s = s.split()
    pierwsze = litery(s[0])
    drugie = litery(s[2])
    ostatnie = litery(s[-1])
    for e in pierwsze:
        print(wynik[e], sep = '', end = '')
    print()
    for e in drugie:
        print(wynik[e], sep = '', end = '')
    print()
    for e in ostatnie:
        print(wynik[e], sep = '', end = '')
    print() 
    
wypisz('send + more = money')
print()
wypisz('ciacho + ciacho = nadwaga')
'''
slownik = {}
generuj(slownik, set(['a','b','c']))
print(slownik)
'''
