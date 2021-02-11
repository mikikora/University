from turtle import fd, rt, goto, pu, tracer, update, fillcolor, begin_fill, end_fill, speed
from random import shuffle
#tracer(0,1)
speed('fastest')
pu()
kolejnosc = []

def kwadrat (kolor):
    fillcolor(kolor)
    begin_fill()
    for i in range(4):
        fd(10)
        rt(90)
    end_fill()

obrazek = []
def wczytaj ():
    for e in open("obrazek.txt"):
        e = e.strip()
        linia_tekst = e.split()
        linia_eval = []
        for f in linia_tekst:
            #linia_eval.append(eval(f))
            a, b, c = eval(f)
            a /= 255
            c /= 255
            b /= 255
            linia_eval.append((a,b,c))
        obrazek.append(linia_eval)

wczytaj()
N = len(obrazek)
M = len(obrazek[0])

def generuj_kolejnosc ():
    for i in range(N):
        for j in range(M):
            kolejnosc.append([i,j])
    shuffle(kolejnosc)

generuj_kolejnosc()
for e in kolejnosc:
    i, j = e
    goto(-(i-N//2)*10, -(j-M//2)*10)
    kwadrat(obrazek[i][j])

update()
input()
