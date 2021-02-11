from turtle import fd, rt, lt, tracer, update, pu, pd, goto

def koch (N):
    if N < 5:
        fd(N)
    else:
        koch(N/3)
        lt(60)
        koch(N/3)
        rt(120)
        koch(N/3)
        lt(60)
        koch(N/3)
        
tracer(0,1)
pu()
goto(-250,250)
pd()
for i in range(3):
    koch(1000)
    rt(120)

update()
input()
