def F(n):
    if n % 2 == 0:
        return n / 2
    else:
        return 3 * n + 1
        
def energia(n):
    poz = 0
    while n != 1:
        n = F(n)
        poz += 1
    return poz

def srednia(L):
    a = 0
    for i in L:
        a += i
    a /= len(L)
    return a

def mediana(L):
    if len(L) % 2 == 0:
        a = (L[len(L) // 2] + L[(len(L) // 2) - 1]) / 2
    else:
        a = L[(len(L) // 2)]
    return a

def analiza_collatza(a, b):
    L=[]
    for i in range(a,b+1):
        L.extend([energia(i)])
    print(srednia(L))
    print(mediana(L))
    print(max(L))
    print(min(L))
    return L

print(analiza_collatza(1,20))
