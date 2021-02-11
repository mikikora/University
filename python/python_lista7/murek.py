from turtle import *
from random import choice

#speed('fastest')
tracer(0,1)

def kwadrat(bok, kolor):
    fillcolor(kolor)
    begin_fill()
    for i in range(4):
        fd(bok)
        rt(90)
    end_fill()
    
def murek(s,bok):
    kolor = 'black'    
    for a in s:
        if a == 'f':
            kwadrat(bok, kolor)
            fd(bok)
        elif a == 'b':
            kwadrat(bok, kolor)
            bk(bok)         
        elif a == 'l':
            lt(90)
        elif a == 'r':
            rt(90)
        elif a == 'y':
            kolor = 'yellow'
        elif a == 'g':
            kolor = 'green'
        elif a == 'o':
            kolor = 'orange'
        

        
#color('black', 'yellow')

   
murek(('gfyfofr'*4+'gfyfrfofbyblgbbr')*4,10)    
pu()
fd(500)
pd()
colory=['y','g','o']
for i in range(10):
    print(2*i*(choice(colory)+'f')+'l',15)
    murek(2*i*(choice(colory)+'f')+'l',15)
#murek(4 * 'fffffr', 14)    
update() # uaktualnienie rysunku

input()
