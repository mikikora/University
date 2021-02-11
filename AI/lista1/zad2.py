from random import choice as losuj

slowa = set([e.strip() for e in open('words_for_ai1.txt')])

moje_slowow = 'tamatematykapustkinieznosi'

def podziel (litery):
    wynik = list()
    for i in range(len(litery) + 1):
        for j in range(i,len(litery) + 1):
            if litery[i:j] in slowa:
                wynik.append(litery[i:j])
    return set(wynik) - set([''])


def polacz (lista):
    wynik = str()
    for e in lista:
        wynik += e
    return wynik

def moge_dolozyc (slowo, litery):
    return len(litery) >= len(slowo) and all(litery[i] == slowo[i] for i in range(len(slowo)))  

def wszystkie_mozliwosci (litery, zbior):
    wynik = dict()
    for e in zbior:
        if moge_dolozyc(e, litery):
            wynik[e] = wszystkie_mozliwosci(litery[len(e):], zbior)
        else:
            pass
    return wynik
    
def dfs (slownik, lista = ['']):
    #dodanie = []
    if slownik == dict():
        return lista
    wynik = []
    for e in slownik:
        #print(e)
        #dodanie.append(lista + [e])
        try:
            wynik.extend(dfs(slownik[e], lista + [e]))
        except:
            print(lista, e)
            input()
        #print(lista + [e], wynik, dfs(slownik[e], lista + [e]))
    return wynik
        
    
def przeksztalc_dfs (lista):
    lista_slow = []
    i = 1
    while i < len(lista):
        chwilowy = []
        while i < len(lista) and lista[i] != '':
            chwilowy.append(lista[i])
            i += 1
        lista_slow.append(chwilowy)
        i += 1
    return lista_slow

def znajdz_pelne (lista_slow, litery):
    wynik = []
    for e in lista_slow:
        if polacz(e) == litery:
            wynik.append(e)
    return wynik

def suma_kwadratow(lista):
    suma = 0
    for e in lista:
        suma += len(e) ** 2
    return suma

def max_kwadratow_dlugosci(lista):
    spis = dict()
    for e in lista:
        spis[suma_kwadratow(e)] = e
    maxymalny = max(spis)
    return spis[maxymalny]

def wstaw_spacje (slowo):
    print(slowo)
    slowo_w_liscie = max_kwadratow_dlugosci(znajdz_pelne(przeksztalc_dfs(dfs(wszystkie_mozliwosci(slowo, podziel(slowo)))), slowo))
    wynik = str()
    for e in slowo_w_liscie:
        wynik += e + ' '
    return wynik[:-1]
    
'''
def skroc_czas(slowo):
    wyniki = list()
    i = 70
    wyniki.append(wstaw_spacje(slowo[:70]))
    while i < len(slowo):
        wyniki.append(wstaw_spacje(slowo[i-50:i]))
        i += 50
    i -= 50
    wyniki.append(wstaw_spacje(slowo[i:]))
    print(wyniki)
    return 'narazie cos'''

#print(wstaw_spacje(moje_slowow))
out = open('zad2_output.txt', 'w')
for e in open('zad2_input.txt'):
    e = e.strip()
    print(e, len(e))
    '''if len(e) > 70:
        w = skroc_czas(e)
    else:
        w = wstaw_spacje(e)'''
    w = wstaw_spacje(e)
    print(w, '\n')
    print(w, file = out)


