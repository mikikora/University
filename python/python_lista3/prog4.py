from turtle import fd, bk, rt, lt, speed, pu, pd
import random

speed('fastest')

def slupek(a):
    lt(90)
    fd(a)
    rt(90)
    fd(5)
    rt(90)
    fd(a)
    rt(90)
    fd(5)
    rt(180)
    
for i in range(50):
    slupek(random.randint(30,160))
    pu()
    fd(7)
    pd()
    


a = input()
