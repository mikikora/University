from duze_cyfry import daj_cyfre
from turtle import speed, fd, bk, rt, lt, pencolor, pu, pd, goto, tracer, fillcolor, begin_fill, end_fill, update
import random

#tracer(0,1)
speed('fastest')
kolory = ['red', 'green', 'blue', 'magenta', 'orange', 'brown', 'yellow']

pu()
goto(-300,100)
pd()

def kwadrat(n, kolor):
    fillcolor(kolor)
    begin_fill()
    for i in range(4):
        fd(n)
        rt(90)
    end_fill()


def rysuj_cyfre(n):
    kolor = random.choice(kolory)
    for r in daj_cyfre(n):
        print()
        for i in range(len(r)):
            print(r[i],end='')
            if r[i] == '#':
                kwadrat(50, kolor)
                fd(50)
            else:
                pu()
                fd(50)
                pd()
        pu()
        bk(50 * len(r))
        rt(90)
        fd(50)
        lt(90)
        pd()
    pu()
    fd(300)
    lt(90)
    fd(250)
    rt(90)
    pd()

def rysuj_liczbe(n):
    licz = str(n)
    for i in range(len(licz)):
        rysuj_cyfre(int(licz[i]))

rysuj_liczbe(987)

update()
input()
