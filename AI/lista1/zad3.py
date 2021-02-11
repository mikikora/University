from random import choice
from collections import defaultdict as dd
from time import time
#♦♥♣♠

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
        kolory[e[2]] += 1
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
    if not dwie_pary(reka) and not trojka(reka) and any(figury[k] == 2 for k in figury):
        return True
    return False

'''def wygrywa_blot (blot, fig):
    wart_blot = 0
    wart_fig = 0
    if poker(blot):
        wart_blot = 8
    elif kareta(blot):
        wart_blot = 7
    elif full(blot):
        wart_blot = 6
    elif kolor(blot):
        wart_blot = 5
    elif strit(blot):
        wart_blot = 4
    elif trojka(blot):
        wart_blot = 3
    elif dwie_pary(blot):
        wart_blot = 2
    elif para(blot):
        wart_blot = 1
    
    if poker(fig):
        wart_fig = 8
    elif kareta(fig):
        wart_fig = 7
    elif full(fig):
        wart_fig = 6
    elif kolor(fig):
        wart_fig = 5
    elif strit(fig):
        wart_fig = 4
    elif trojka(fig):
        wart_fig = 3
    elif dwie_pary(fig):
        wart_fig = 2
    elif para(fig):
        wart_fig = 1
    
    if wart_blot > wart_fig:
        return True
    else:
        return False'''


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


def oblicz (talia_blotkarza, talia_figuranta):
    N = 20000
    wygrane = 0
    for i in range(N):
        dost_blot = set() | talia_blotkarza
        dost_fig = set() | talia_figuranta

        reka_blot = set()
        reka_fig = set()
        for i in range(5):
            reka_blot.add(choice(list(dost_blot)))
            dost_blot = dost_blot - reka_blot
            reka_fig.add(choice(list(dost_fig)))
            dost_fig = dost_fig - reka_fig
        if wygrywa_blot(reka_blot, reka_fig):
            wygrane += 1
    print(wygrane*100/N, '%', sep = '')

#print(reka_blot, reka_fig, sep = '\n')

def odpowiedz_bez (*karty):
    talia_blotkarza = set([str(f) + ' ' + e for e in "CDHS" for f in range(1,10)])
    talia_figuranta = set([str(f) + ' ' + e for e in "CDHS" for f in 'JDKA'])
    for e in karty:
        talia_blotkarza -= set([e])
    oblicz(talia_blotkarza, talia_figuranta)

def odpowiedz_z (talia):
    talia_figuranta = set([str(f) + ' ' + e for e in "CDHS" for f in 'JDKA'])
    oblicz(talia, talia_figuranta)

t0 = time()
odpowiedz_bez()
odpowiedz_bez('1 H', '1 C', '1 D', '1 S')
odpowiedz_bez('1 H', '1 C', '1 D', '1 S', '2 H', '2 C', '2 D', '2 S')
odpowiedz_z(set(['1 H', '2 H', '3 H', '4 H', '5 H']))
print(time() - t0)





