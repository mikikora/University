from turtle import fd, rt, goto, pu, tracer, update, fillcolor, begin_fill, end_fill, speed

tracer(0,1)
#speed('fastest')

def kwadrat (kolor):
    fillcolor(kolor)
    begin_fill()
    for i in range(4):
        fd(10)
        rt(90)
    end_fill()

obrazek = []
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
    
N = len(obrazek)
M = len(obrazek[0])

pu()

for i in range(N):
    for j in range(M):
        goto(-(i*10-10*(N//2)), -(j*10-10*(M//2)))
        kwadrat(obrazek[i][j])
        
update()
input()
