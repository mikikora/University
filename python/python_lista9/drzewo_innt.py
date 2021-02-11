from turtle import fd, rt, lt, tracer, update, pu, goto, pd, speed, bk

def drzewo (N):
    if N < 1:
        pass
    else:
        podzial = (N ** 2) / 25
        krotsze = (9 * podzial) ** (1/2)
        dluzsze = (16 * podzial) ** (1/2)
        fd(N)
        lt(30)
        drzewo (dluzsze)
        rt(120)
        fd(N)
        lt(120)
        pu()
        fd(krotsze)
        pd()
        rt(90)
        drzewo(krotsze)
        pu()
        rt(90)
        fd(krotsze)
        rt(30)
        fd(N)
        rt(90)
        fd(N)
        rt(90)

tracer (0,1)
#speed('fastest')
pu()
goto(0,-450)
pd()
lt(90)
drzewo(200)
update()
input()
        
