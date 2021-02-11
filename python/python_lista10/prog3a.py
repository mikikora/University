from random import randint as losuj

def litery (a):
    wynik = list()
    for e in a:
        wynik.append(e)
    return wynik

'''def generuj (slownik, spis):
    for e in spis:
        slownik[e] = losuj(0,9)'''

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
    
def permutacja (slownik, spis):
    if slownik == dict():
        for e in spis:
            slownik[e] = 0
        return slownik
    for i in range(1,len(spis)+1):
        if slownik[spis[-i]] != 9:
            slownik[spis[-i]] += 1
            return slownik
        else:
            slownik[spis[-i]] = 0

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
    spis = set(spis)
    spis = list(spis)
    #print(spis)
    gen = 9 ** len(spis) #tyle jest możliwych permutacji
    print(gen)
    good = 0
    i = 0
    while i < gen and good == 0:
        #print(przypisz)
        permutacja(przypisz, spis)
        if sprawdz(pierwsze, drugie, wynik, przypisz) == 1:
            good = 1
        i += 1
    if good == 1:
        return przypisz
    else:
        return {}
    
def odpowiedz(zagadka):
    odpowiedz = solved(zagadka)
    if odpowiedz == {}:
        print({})
    zagadka = zagadka.split()
    pierwsze = litery(zagadka[0])
    drugie = litery(zagadka[2])
    wynik = litery(zagadka[-1])
    for e in pierwsze:
        print(odpowiedz[e],end='',sep='')
    print()
    for e in drugie:
        print(odpowiedz[e],end='',sep='')
    print()
    for e in wynik:
        print(odpowiedz[e],end='',sep='')
    print()
    

odpowiedz('send + more = money')
print()
odpowiedz('ciacho + ciacho = nadwaga')
'''print(solved('send + more = money'))
print(solved('ciacho + ciacho = nadwaga'))'''
'''
slownik = {}
generuj(slownik, set(['a','b','c']))
print(slownik)
'''
