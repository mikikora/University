from collections import defaultdict as dd
import time

slowa = [e.strip().lower() for e in open('slowa.txt')]

def alfa (slowo):
    l = sorted(slowo)
    wynik = ''
    for e in l:
        wynik += e
    return wynik
'''
def scal (a,b):
    wynik = ' '
    ai = 0
    bi = 0
    while ai < len(a) and bi < len(b):
        if a[ai] <= b[bi]:
            wynik += a[ai]
            ai += 1
        else:
            wynik += b[bi]
            bi += 1
    if ai < len(a):
        wynik += a[ai:]
    if bi < len(b):
        wynik += b[bi:]
    return wynik'''
    
def roznica (oryg, nowe):
    wynik = ''
    oi = 0
    ni = 0
    while oi < len(oryg):
        if oryg[oi] in nowe[ni:]:
            oi += 1
            ni += 1
        else:
            wynik += oryg[oi]
            oi += 1
    return wynik

def zawiera_sie (oryg, nowe):
    literyo = dd(int)
    for e in oryg:
        literyo[e] += 1
    literyn = dd(int)
    for e in nowe:
        literyn[e] += 1
    if all(literyo[e] >= literyn[e] for e in literyn): return 1
    else: return 0
    

def zagadka (imie):
    imie = imie.lower()
    litery = dd(list)
    for e in slowa:
        litery[alfa(e)].append(e)
    alfim = alfa(imie)
    print(alfim)
    poten = list()
    #tablica potencjalnych
    for k in litery:
        if len(k) + 1 < len(imie):
            if zawiera_sie(alfim, k) == 1:
                poten.append(k)
                #print(k)
    dobre = list()
    print(len(poten))
    print()
    #tablica dobrych
    for e in poten:
        alfimtemp = alfim
        alfimtemp = roznica(alfimtemp, e)
        #print(alfim, e, alfimtemp)
        for f in poten:
            if f + ' ' == alfimtemp:
                dobre.append(e,f)
    print(dobre)
    #print(poten)
    wypisane = list()
    for e, f in dobre:
        for i in litery[e]:
            for j in litery[f]:
                do_wypisania = i + ' ' + j
                if do_wypisania not in wypisane:
                    print(i + ' ' + j)
                    wypisane.append(j + ' ' + i)
    

t0 = time.time()
#print(scal('abccde', 'aabcd'))
zagadka('Maja Orłowska')
t1 = time.time() - t0
print(t1)
