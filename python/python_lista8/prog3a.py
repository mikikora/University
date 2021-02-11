from collections import defaultdict as dd

slowa = [e.strip().lower() for e in open('slowa.txt')]

def alfa (slowo):
    l = sorted(slowo)
    wynik = ''
    for e in l:
        wynik += e
    return wynik

#tu powinno być zwykłe scalanie a nie scalanie bez powtórek !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11    
'''def scal (a, b):
    wynik = ''
    ai = 0
    bi = 0
    while ai < len(a) and bi < len(b):
        if a[ai] == b[bi]: 
            wynik += a[ai]
            ai += 1
            bi += 1
        elif a[ai] in b[bi:]:
            while a[ai] != b[bi]:
                wynik += b[bi]
                bi += 1
        elif b[bi] in a[ai:]:
            while a[ai] != b[bi]:
                wynik += a[ai]
                ai += 1
        elif b[bi] not in a[ai:] and b[bi] < a[ai]:
            wynik += b[bi]
            bi += 1
        elif a[ai] not in b[bi:] and a[ai] < b[bi]:
            wynik += a[ai]
            ai += 1
    if bi < len(b):
        wynik += b[bi:]
    if ai < len(a):
        wynik += a[ai:]
    return wynik'''

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
    return wynik

def zagadka (imie):
    imie = imie.lower()
    litery = dd(list)
    for e in slowa:
        litery[alfa(e)].append(e)
    alfim = alfa(imie)
    #print(alfim)
    '''dobre = list()
    for k in litery:
        if '''
    poten = list()
    for k in litery:
        if all(a in alfim for a in k):
            poten.append(k)
            #print(k)
    dobre = list()
    #print(len(poten))
    #print()
    for e in poten:
        for f in poten:
            #print(e,f)
            ef = scal(e,f)
            #print(ef)
            #print()
            if ef == alfim:
                dobre.append((e,f))
    #print(dobre)
    #print(poten)
    wypisane = list()
    for e, f in dobre:
        for i in litery[e]:
            for j in litery[f]:
                do_wypisania = i + ' ' + j
                if do_wypisania not in wypisane:
                    print(i + ' ' + j)
                    wypisane.append(j + ' ' + i)
    

#print(scal('abccde', 'aabcd'))
zagadka('Paweł Korobczak')
