from itertools import product
import sys
from time import time
sys.setrecursionlimit(100000)
#plansza A-H, 1-8

ruchy_krola = [a for a in product('012', repeat=2)]
#ruchy_krola = ruchy_krola[1:]
for i in range(len(ruchy_krola)):
    ruchy_krola[i] = (int(ruchy_krola[i][0]) - 1, int(ruchy_krola[i][1]) - 1)
#ruchy_krola = ruchy_krola[:3] + ruchy_krola[4:]

ruchy_wiezy = set([(0,a) for a in range(-8,9)] + [(a,0) for a in range(-8,8)])
ruchy_wiezy = ruchy_wiezy - set([(0,0)])
ruchy_wiezy = list(ruchy_wiezy)

#print(ruchy_krola)

def zamien_litery (miejsce):
    slownik = dict()
    i = 1
    for e in 'abcdefgh':
        slownik[e] = i
        i += 1
    a = slownik[miejsce[0]]
    b = int(miejsce[1])
    return (a, b)

def zamien_na_litery (miejsce):
    slownik = dict()
    i = 1
    for e in 'abcdefgh':
        slownik[i] = e
        i += 1
    a = slownik[miejsce[0]]
    return a + str(miejsce[1])

def przeskok (krol, wieza, ruch):
    if wieza[1] == krol[1] and krol[1] == ruch[1]:
        if wieza[0] < krol[0]:
            jeden_start = 'lewo'
        else:
            jeden_start = 'prawo'
        if ruch[0] < krol[0]:
            jeden_meta = 'lewo'
        else:
            jeden_meta = 'prawo'
        if jeden_start != jeden_meta:
            return True
    if wieza[0] == krol[0] and krol[0] == ruch[0]:
        if wieza[1] < krol[1]:
            jeden_start = 'lewo'
        else:
            jeden_start = 'prawo'
        if ruch[1] < krol[1]:
            jeden_meta = 'lewo'
        else:
            jeden_meta = 'prawo'
        if jeden_start != jeden_meta:
            return True
    return False

def odleglosc_1 (jeden, drugi):
    x1, y1 = jeden
    x2, y2 = drugi
    if (abs(x1-x2) == 1 and abs(y1-y2) == 1) or (abs(x1-x2) == 0 and abs(y1-y2) == 1) or (abs(x1-x2) == 1 and abs(y1-y2) == 0):
        return True
    else:
        return False

def czy_wykonalny (stan, pozycja, pole, czy_krol = False):
    x, y = pole
    if not 0 < x < 9 or not 0 < y < 9:
        return False
    if zamien_litery(stan[1]) == pole or zamien_litery(stan[2]) == pole or zamien_litery(stan[3]) == pole:
        return False
    if czy_krol == True:
        for i in range(len(stan)):
            if stan[i] == pozycja:
                miejsce = i
        if miejsce > 2:
            kolor = 'czarny'
        else:
            kolor = 'bialy'
        if kolor == 'czarny':
            pole_lit = zamien_na_litery(pole)
            #print(pole, pole_lit)
            #print(stan[3][0], stan[3][1])
            if pole_lit[0] == stan[2][0] or pole_lit[1] == stan[2][1]:
                return False
            pole_bialy_krol = zamien_litery(stan[1])
            if odleglosc_1(pole_bialy_krol, pole):
                #print('tutaj')
                return False
        else:
            pole_czarny_krol = zamien_litery(stan[-1])
            if odleglosc_1(pole_czarny_krol, pole):
                return False
    else:
        krol1 = zamien_litery(stan[1])
        krol2 = zamien_litery(stan[3])
        wieza = zamien_litery(pozycja)
        if przeskok(krol1, wieza, pole) or przeskok(krol2, wieza, pole):
            return False
    return True

def add(first, second):
    a, b = first
    c, d = second
    return (a+c, b+d)

def ustaw (stan, pozycja, ruch):
    for i in range(len(stan)):
        if stan[i] == pozycja:
            miejsce = i
    nowy_stan = list()
    for i in range(len(stan)):
        if i == 0:
            if stan[0] == 'black':
                nowy_stan.append('white')
            else:
                nowy_stan.append('black')
        elif i == miejsce:
            nowy_stan.append(zamien_na_litery(ruch))
        else:
            nowy_stan.append(stan[i])
    return tuple(nowy_stan)
#print(czy_wykonalny(('white', 'b5', 'f3', 'c8'), 'b5', (2,6), True))

def czy_szach (stan):
    ruch, bk, bw, ck = stan
    if bw[0] == ck[0] or bw[1] == ck[1]:
        krol_bialy = zamien_litery(bk)
        krol_czarny = zamien_litery(ck)
        wieza = zamien_litery(bw)
        if odleglosc_1(krol_czarny, wieza):
            if odleglosc_1(krol_bialy, wieza):
                return True
        else:
            return True
    else:
        return False

def ruch_krol (poz_krol, stan):
    wynik = list()
    krol = zamien_litery(poz_krol)
    #print(krol)
    ruchy = list()
    for e in ruchy_krola:
        ruch = add(krol, e)
        #print(ruch)
        if czy_wykonalny(stan, poz_krol, ruch, True):
            ruchy.append(ruch)
    #print(ruchy)
    if ruchy == [] and czy_szach(stan):
        wynik = ['mat']
        #print('cos jest')
        #input()
    else: 
        for e in ruchy:
            wynik.append(ustaw(stan, poz_krol, e))
    #print(wynik)
    return wynik

def ruch_wieza (poz_wieza, stan):
    wynik = list()
    wieza = zamien_litery(poz_wieza)
    ruchy = list()
    for e in ruchy_wiezy:
        ruch = add(wieza, e)
        if czy_wykonalny(stan, poz_wieza, ruch):
            ruchy.append(ruch)
    for e in ruchy:
        wynik.append(ustaw(stan, poz_wieza, e))
    return wynik

def zbuduj_drzewo (stan, mozliwe_zaglebienie, odwiedzone, zaglebienie = 0): #stan to krotka (kolor, poz_wk, ...)
    if stan == 'mat' or stan == 'pat':
        return []
    if zaglebienie >= mozliwe_zaglebienie:
        #print(zaglebienie, mozliwe_zaglebienie)
        return []
    #print(stan)
    try:
        ruch, wk, wt, bk = stan
    except:
        print(stan)
        input()
    lista = list()
    if ruch == 'black':
        lista = ruch_krol(bk, stan)
        #print(lista)
    else:
        lista.extend(ruch_wieza(wt, stan))
        lista.extend(ruch_krol(wk, stan))
        #print(lista)
    drzewo = [stan, []]
    #print(lista)
    for e in lista:
        #print(e)
        if e == 'mat' or e == 'pat':
            drzewo[1].append([e])
        elif e not in odwiedzone or (e in odwiedzone and odwiedzone[e] > zaglebienie):
            drzewo[1].extend([zbuduj_drzewo(e, mozliwe_zaglebienie, odwiedzone, zaglebienie + 1)])
            odwiedzone[e] = zaglebienie
    return drzewo

def przegladaj_drzewo (drzewo):
    #print('\n\n', drzewo)
    dzieci = drzewo[1]
    ojciec = drzewo[0]
    wynik = list()
    for e in dzieci:
        if e == []:
            wynik.append([ojciec] + [[]])
        else:
            #print('\n\t', e)
            ojciec_e = ojciec + [e[0]]
            try:
                wynik.append([ojciec_e] + [e[1]])
            except:
                print(drzewo)
                print(ojciec_e, e)
                input()
    #print('\n', wynik)
    return wynik
    
#drzewa = list()
def bfs (drzewo):
    drzewa = list()
    drzewa.append(drzewo)
    drzewa[0][0] = [drzewa[0][0]]
    znalezione = 0
    while znalezione < 1:
        #sprawdzone = 0
        i = 0
        for e in drzewa:
            #print(e)
            try:
                if e != [] and 'mat' in e[1][0]:
                    znalezione = 1
                    return (e[0], len(e[0]) - 1)
            except:
                pass
        rozmiar_drzewa_narazie = len(drzewa)
        while i < rozmiar_drzewa_narazie:
            if drzewa[i] == [] or drzewa[i] == [['pat']]:
                pass
            else:
                drzewa.extend(przegladaj_drzewo(drzewa[i]))
                i += 1
        #gedit print(i)
        
def szach_mat (drzewo):
    if drzewo == []:
        return 0
    elif drzewo[0] == 'mat':
        return 1
    elif drzewo[0] == 'pat':
        return 0
    else:
        wynik = 0
        for e in drzewo[1]:
            wynik += szach_mat(e)
        return wynik

def szukaj(stan):
    ile_matow = 0
    i = 5
    while ile_matow == 0:
        #print(ile_matow, i)
        odwiedzone = dict()
        drzewo = zbuduj_drzewo(stan, i, odwiedzone)
        #print(drzewo)
        ile_matow = szach_mat(drzewo)
        i += 2
    return bfs(drzewo)

def znajdz_roznice (a, b):
    for i in range(1,4):
        if a[i] != b[i]:
            return i

def wypisz (stan):
    #wynik_bfs = szukaj(stan)
    drzewo = zbuduj_drzewo(stan, 13, dict())
    wynik_bfs = bfs(drzewo)
    print(wynik_bfs[1])
    for i in range(1, len(wynik_bfs[0])):
        poz_roznicy = znajdz_roznice(wynik_bfs[0][i-1], wynik_bfs[0][i])
        print(wynik_bfs[0][i-1][poz_roznicy], '->', wynik_bfs[0][i][poz_roznicy])
                       
#drzewo = zbuduj_drzewo(('black', 'h1', 'c3', 'a5'), 13)
#print(szach_mat(drzewo))
#print('zbudowane')
#print(bfs(drzewo))
#print(szukaj(('black','c4','c8','h3')))
#print(zbuduj_drzewo(('black', 'c4', 'c8', 'h3'), 12))

wypisz(('white', 'h6', 'a4', 'd4'))
'''
out = open('zad1_output.txt', 'w')
for e in open('zad1_input.txt'):
    e = e.split()
    e = tuple(e)
    print(e)
    t0 = time()
    print(szukaj(e)[1], file = out)
    print(time() - t0)'''
   




