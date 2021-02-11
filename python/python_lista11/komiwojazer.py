from turtle import *
import math

def perm(L):
    "perm generuje listę wszystkich permutacji listy L"
    if len(L) == 0:
        return [ [] ]
    ps = perm(L[1:])
    return [ p[:i] + [L[0]] + p[i:] for p in ps for i in range(len(p)+1)]
  
speed('fastest')

points = []
for e in open('punkty.txt'):
    e = e.strip().split()
    a,b = e
    a = int(a)
    b = int(b)
    points.append((a,b))
print(points)
  
def draw_points(ps):
    pu()
    fillcolor('yellow')
    for p in ps:
        begin_fill()
        goto(*p)
        circle(10)
        end_fill()
    pd()
    
def draw_line(ps, c):
    pu()
    goto(*ps[0])
    pd()
    pencolor(c)
    for p in ps[1:]:
        goto(*p)  # == goto(p[0], p[1])
  
def dist(p1,p2):
    return ((p1[0] - p2[0]) ** 2 + (p1[1] - p2[1]) ** 2) ** 0.5 

def length(path):
    d = 0.0
    for i in range(1, len(path)):
        d += dist(path[i-1], path[i])
    return d

def zachlanny (L):
    wynik = list()
    wynik.append(L[0])
    for i in range(1,len(L)):
        odleglosc = list()
        for j in range(len(wynik)):
            tab = wynik[:j] + [L[i]] + wynik[j:]
            odleglosc.append([tab, length(tab)])
        najlepsze = min(odleglosc, key = lambda odleglosc: odleglosc[1])
        wynik = najlepsze[0]
        print(najlepsze)
    return wynik

  
draw_points(points)

#best_perm = min(perm(points), key=length)
best_perm = zachlanny(points)

draw_line(best_perm, 'black')

input()
