from turtle import fd, bk, goto, tracer, update, lt, rt, pu, pd, fillcolor, begin_fill, end_fill
from duze_cyfry import daj_cyfre
import random

jaki_kolor = {
    'g' : 'green',
    'b' : 'blue',
    'y' : 'yellow',
    'r' : 'red',
    'p' : 'purple',
    'o' : 'orange',
    'P' : 'pink',
    'B' : 'brown'
}

N = 35
tracer (0,1)

wiersz = ['.' for i in range(N)]
plansza = [[] + wiersz for i in range(N)]

kolory = ['g', 'b', 'y', 'r', 'p', 'o', 'P', 'B'] 

def sasiedzi (a, b, kolor):
    if plansza[a+1][b+1] == kolor or plansza[a-1][b+1] == kolor or plansza[a+1][b-1] == kolor or plansza[a-1][b-1] == kolor:
        return 0
    else:
        return 1 

def wstaw_cyfre (a):
    znalezione = 0
    liczba = daj_cyfre(a)
    
    while znalezione == 0:
        kolor = random.choice(kolory)
        a = random.randint(0,29)
        b = random.randint(0,29)
        good = 1
        for i in range(5):
            for j in range(5):
                if liczba[i][j] == '#':
                    if plansza[a+i][b+j] == '.':
                        if sasiedzi(a+i, b+j, kolor) == 1:
                            pass
                        else:
                            good = 0
                    else:
                        good = 0
        if good == 1:
            znalezione = 1
        if znalezione == 1:    
            for i in range(5):
                for j in range(5):
                    if liczba[i][j] == '#':
                        plansza[a+i][b+j] = kolor
    #print('wstawione')
                

def kwadrat (a, b, kolor) :
    pu()
    goto(b*20-300,-a*20+300)
    pd()
    fillcolor(kolor)
    begin_fill()
    for i in range(4):
        fd(20)
        rt(90)
    end_fill()

def rysuj () :
    for i in range(N):
        for j in range(N):
            if plansza[i][j] != '.':
                kwadrat(i, j, jaki_kolor[plansza[i][j]])



for i in range(30):
    wstaw_cyfre(random.randint(0,9))

#wstaw_cyfre()

rysuj()
#print(plansza)
update()
input()

#print(jaki_kolor['r'])

















