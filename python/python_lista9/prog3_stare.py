from collections import defaultdict as dd
from time import time

slowa = [e.strip().lower() for e in open('slowa.txt')]

def alfa (slowo):
    l = sorted(slowo)
    wynik = ''
    for e in l:
        wynik += e
    return wynik

def roznica (oryg, klucz):
    if any(a not in oryg for a in klucz):
        return 1
    o = 0
    k = 0
    wynik = ''
    while o < len(oryg) and k < len(klucz):
        if oryg[o] in klucz[k:]:
            while oryg[o] != klucz[k]:
                if klucz[k] not in oryg[o:]:
                    return 1
                k += 1
            o += 1
            k += 1
        else:
            wynik = wynik + oryg[o]
            o += 1
    if k < len(klucz):
        return 1
    wynik += oryg[o:]
    return wynik
    

def zagadka (imie):
    imie = imie.lower()
    alfim = alfa(imie)
    print(alfim)
    litery = dd(list)
    for e in slowa:
        litery[alfa(e)].append(e)
    poten = list()
    for k in litery:
        roz = roznica (alfim,k)
        if roz == 1:
            pass
        else:
            poten.append((k,roz))
    print(len(poten))
    #print(poten)
    #przeglad pozostalych kluczy
    dobre = list()
    for e in poten:
        for k in poten:
            if e[1] == ' ' + k[0]:
                dobre.append((e[0], k[0]))
    #print(dobre)
    wypisane = list()
    for e, f in dobre:
        for i in litery[e]:
            for j in litery[f]:
                do_wypisania = i + ' ' + j
                if do_wypisania not in wypisane:
                    print(i + ' ' + j)
                    wypisane.append(j + ' ' + i)
    

t0 = time()
zagadka('Tomasz Wierzbicki')
print(time() - t0)












