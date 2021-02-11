from prog1 import cezar, daj_litery
from collections import defaultdict as dd

slowa = set([a.lower().strip() for a in open("slowa.txt")])
#print(slowa)
litery = daj_litery()
pozycja = dict()
for i in range(len(litery)):
    pozycja[litery[i]] = i
'''
def czy_cesarskie (a, b):
    #print(a,b)
    k1 = pozycja[a[0]] - pozycja[b[0]]
    k2 = pozycja[b[0]] - pozycja[a[0]]
    if cezar(a,k2) == b and a == cezar(b,k1):
        return 1
    return 0
'''
def znajdz ():
    dlugosc = dd(list)
    for e in slowa:
        if all(a in litery for a in e):
            dlugosc[len(e)].append(e)
    #print(dlugosc)
    klucze = [a for a in dlugosc]
    klucze.sort(reverse=True)
    print(klucze)
    wynik = list()
    good = 0
    for k in klucze:
        print(k, len(dlugosc[k]))
        if good == 0:
            for e in dlugosc[k]:
                for i in range(1,len(litery)):
                    if cezar(e,i) in slowa:
                        good = 1
                        wynik.append(e)
    return wynik
            

#print(czy_cesarskie('konstantynopolitańczykiewiczówna', 'wążdęlżęhżącąytęlanihwtógtnibgżl'))
print(znajdz())
