from turtle import fd, rt, lt, tracer, update, pu, pd, goto, speed, bk

def drzewo (N):
    if N < 1:
        pass
    else:
        nowe = (N/2)*(2**(1/2))
        fd(N)
        lt(45)
        drzewo((N/2)*(2**(1/2)))
        rt(135)
        fd(N)
        lt(135)
        if nowe >= 1: fd(nowe)
        rt(90)
        drzewo(nowe)
        lt(90)
        if nowe >= 1: bk(nowe)
        rt(135+90)
        fd(N)
        rt(90)
        fd(N)
        rt(90)
        


tracer(0,1)
#speed('fastest')
lt(90)
pu()
goto(0,-450)
pd()
drzewo(200)
update()
input()
