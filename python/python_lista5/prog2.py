from turtle import *
import random
speed('fastest')
a = random.randint(100,200)
r = random.randint(5,10)

skrzydla = random.randint(7,13)
ile = random.randint(20,30)
for i in range(skrzydla):
    for j in range(ile):
        fd(a + j * r)
        bk(a + j * r)
        rt(360 / (ile * skrzydla))
        
input()
