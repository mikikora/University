from random import randint as losuj
from turtle import fd, rt, pu, tracer, update, fillcolor, begin_fill, end_fill, goto

kolory = ['green', (0.5, 1, 0) , 'yellow', 'orange', 'red', (0.5, 0,0) ]

wiersz = [0 for i in range(100)]
mapa = [[] + wiersz for i in range(100)]

def kwadrat (kolor):
    fillcolor(kolor)
    begin_fill()
    for i in range(4):
        fd(5)
        rt(90)
    end_fill()

def srednia (x,y):
    srednia = mapa[x][y]
    mianownik = 1
    gora = 0
    dol = 0
    lewo = 0
    prawo = 0
    if x < 99:
        prawo = 1
    if x > 0:
        lewo = 1
    if y < 99:
        gora = 1
    if y > 0:
        dol = 1
    if prawo == 1:
        srednia += mapa[x+1][y] *2
        mianownik += 2
    if lewo == 1:
        srednia += mapa[x-1][y] *2
        mianownik += 2
    if gora == 1:
        srednia += mapa[x][y+1] *2
        mianownik += 2
    if dol == 1:
        srednia += mapa[x][y-1] *2
        mianownik += 2
    if gora == 1 and prawo == 1:
        srednia += mapa[x+1][y+1]
        mianownik += 1
    if gora == 1 and lewo == 1:
        srednia += mapa[x-1][y+1]
        mianownik += 1
    if dol == 1 and prawo == 1:
        srednia += mapa[x+1][y-1]
        mianownik += 1
    if dol == 1 and lewo == 1:
        srednia += mapa[x-1][y-1]
        mianownik += 1
    #srednia += mapa[x-1][y] + mapa[x-1][y-1] + mapa[x][y-1] + mapa[x+1][y-1] + mapa[x-1][y+1] + mapa[x+1][y] + mapa[x][y+1] + mapa[x+1][y+1]
    return srednia / mianownik

mapa[losuj(10,89)][losuj(10,89)] = 100000
mapa[losuj(10,89)][losuj(10,89)] = 100000
mapa[losuj(10,89)][losuj(10,89)] = 100000
mapa[losuj(10,89)][losuj(10,89)] = 100000
mapa[losuj(10,89)][losuj(10,89)] = 100000
mapa[losuj(10,89)][losuj(10,89)] = 100000
mapa[losuj(10,89)][losuj(10,89)] = 100000
mapa[losuj(10,89)][losuj(10,89)] = 100000
mapa[losuj(10,89)][losuj(10,89)] = 100000
mapa[losuj(10,89)][losuj(10,89)] = 100000

#generowanie mapy

for i in range(1000000):
    x = losuj(0,99)
    y = losuj(0,99)
    mapa[x][y] = srednia(x,y)
    
#print (mapa)

#generowanie sredniej

srednia = 0
for i in range(100):
    for j in range(100):
        srednia += mapa[i][j]

srednia /= 100*100
print(srednia)

#odchylenie standardowe
'''
ro = 0
suma_ro = 0

for i in range(100):
    for j in range(100):
        suma_ro += (mapa[i][j] - srednia)**2

ro = (suma_ro / 100*100) ** (1/2)
print(ro)

#print(max(max(mapa)),min(min(mapa)))
'''
#prepisywanie mapy na kolory

for i in range(100):
    for j in range(100):
        if mapa[i][j] <= srednia/100:
            mapa[i][j] = 1
        elif mapa[i][j] <= srednia/9:
            mapa[i][j] = 2
        elif mapa[i][j] <= srednia:
            mapa[i][j] = 3
        elif mapa[i][j] <= 3*srednia:
            mapa[i][j] = 4
        elif mapa[i][j] <= 6*srednia:
            mapa[i][j] = 5
        else:
            mapa[i][j] = 6

#print(mapa)

#rysowanie
tracer(0,1)
pu()
#goto(-10000,-10000)

for i in range(100):
    for j in range(100):
        goto((i-25)*5,(j-25)*5)
        kwadrat(kolory[mapa[i][j]-1])

update()
input()
















