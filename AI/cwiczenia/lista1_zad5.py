from itertools import product
from itertools import combinations
from collections import defaultdict as dd

#♦♥♣♠

#talia_blotkarza = set([str(f) + ' ' + e for e in "CDHS" for f in range(1,10)])
#talia_figuranta = set([str(f) + ' ' + e for e in "CDHS" for f in 'JDKA'])

def poker (reka): #8
    if strit(reka) and kolor(reka):
        return True
    return False

def kareta (reka): #7
    figury = dd(int)
    for e in reka:
        figury[e[0]] += 1
    if any(figury[k] == 4 for k in figury):
        return True
    return False

def full (reka): #6
    if trojka(reka) and para(reka):
        return True
    return False

def kolor (reka): #5
    kolory = dd(int)
    for e in reka:
        kolory[e[1]] += 1
    if any(kolory[k] == 5 for k in kolory):
        return True
    return False

def strit (reka): #4
    try:
        mozliwe = set()
        for i in range(1,10-4):
            s = str()
            for j in range(i,i+5):
                s = s + str(j)
            mozliwe.add(s)
        l = list()
        for e in reka:
            l.append(int(e[0]))
        s = str()
        for e in sorted(l):
            s = s + str(e)
        if s in mozliwe:
            return True
        return False
    except:
        return False

def trojka (reka): #3
    figury = dd(int)
    for e in reka:
        figury[e[0]] += 1
    if not kareta(reka) and any(figury[k] == 3 for k in figury):
        return True
    return False

def dwie_pary (reka): #2
    figury = dd(int)
    for e in reka:
        figury[e[0]] += 1
    if any(figury[k] == 2 and figury[j] == 2 for k in figury for j in figury if j != k):
        return True
    return False

def para (reka): #1
    figury = dd(int)
    for e in reka:
        figury[e[0]] += 1
    if any(figury[k] == 2 for k in figury):
        return True
    return False

def wygrywa_blot (blot, fig):
    wart_blot = 0
    wart_fig = 0
    figu = [poker, kareta, full, kolor, strit, trojka, dwie_pary, para]
    figury = dict()
    i = 8
    for e in figu:
        figury[e] = i
        i -= 1
    for e in figury:
        if e(blot) and wart_blot < figury[e]:
            wart_blot = figury[e]
        if e(fig) and wart_fig < figury[e]:
            wart_fig = figury[e]
    if wart_blot > wart_fig:
        return True
    else:
        return False

figu = [poker, kareta, full, kolor, strit, trojka, dwie_pary, para]
figury = dict()
i = 8
for e in figu:
    figury[e] = i
    i -= 1

uklady_fig = dd(int)
uklady_blot = dd(int)

for e in combinations(product('JQKA', 'HDCS'), 5):
    end = False
    for f in figury:
        if f(e) and not end:
            uklady_fig[figury[f]] += 1
            end = True
    if not end:
        uklady_fig[0] += 1

for e in combinations(product('123456789', 'HDCS'), 5):
    end = False
    for f in figury:
        if f(e) and not end:
            uklady_blot[figury[f]] += 1
            end = True
    if not end:
        uklady_blot[0] += 1

#1/(sum(Bn) * sum(Fn)) * (sum(Bi * sum(Fj)))

#liczenie prawdopodobieństwa

suma1 = 0
for e in uklady_fig:
    suma1 += uklady_fig[e]
suma2 = 0
for e in uklady_blot:
    suma2 += uklady_blot[e]

pierwszy_skladnik = suma1 * suma2
drugi_skladnik = 0


for i in range(0,9):
    suma1 = 0
    for j in range(0,i):
        suma1 += uklady_fig[j]
    drugi_skladnik += uklady_blot[i] * suma1


print(drugi_skladnik * 100 / pierwszy_skladnik, '%', sep = '')










