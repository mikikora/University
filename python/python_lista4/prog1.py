from turtle import speed, fd, bk, rt, lt, fillcolor, begin_fill, end_fill, update, tracer, pu, pd, goto
import random

tracer(0,1)

def mieszanka(a, kolor1, kolor2):
    r1, g1, b1 = kolor1
    r2, g2, b2 = kolor2
    r3 = a * r1 + (1-a) * r2
    g3 = a * g1 + (1-a) * g2
    b3 = a * b1 + (1-a) * b2
    return r3, g3, b3

def kwadrat(n, kolor):
    fillcolor(kolor)
    begin_fill()
    for i in range(4):
        fd(n)
        rt(90)
    end_fill()

K1 = 1, 0, 1
K2 = 1, 1, 0
N = 0
K=18
k=K

for i in range(1, k+1):
    N += i

pu()
lt(90)
goto(300,-300)
pd()
for i in range(N):
    if i == k:
        K -= 1
        k += K
        bk(30)
        lt(90)
        
    a = i / N
    kwadrat(30, mieszanka(a, K2, K1))
    fd(30)
    
    
    




update()
input()

