from duze_cyfry import daj_cyfre

def odwroc (n):
    a=0
    while n>0:
        a = a*10 + n%10
        n = n//10
    return a

def liczby (n):
    for i in range(5):
        a=odwroc(n)
        while a>0:
            b=a%10
            a = a//10
            print (daj_cyfre(b)[i],end=' ')
        print ()
        
liczby(15473)
    

