from itertools import product

formula = "x + (y*-z)"


def zmienne(F):
    z = set('abcdefgijklomnopqrstuvwzyzx')
    wynik = list()
    i = 0
    while i < len(F):
        if F[i] in z:
            zmienna = ''
            while i < len(F) and F[i] in z:
                zmienna += F[i]
                i += 1
            wynik.append(zmienna)
        else:
            i += 1
    
    return wynik
    
def ciagi_binarne(n):
    lista = n * [ [False, True] ]
    return list(product(*lista))
    
def wartosciowania(zmienne):
    n = len(zmienne)
    cb = ciagi_binarne(n)
    
    wynik = []
    for c in cb:
        #wynik.append( dict(zip(zmienne, c)))
        dobrane = {e : c for e in zmienne}
        wynik.append(dobrane)
    return wynik
            
def wartosc_logiczna(F, wart):
    F = F.replace('*', ' and ')
    F = F.replace('+', ' or ')
    F = F.replace('-', ' not ')
    
    return eval(F, wart)

def spelnialna(F):
    z = zmienne(F)
    wart = wartosciowania(z)
    return any(wartosc_logiczna(F, w) == True for w in wart)
    
def tautologia(F):
    z = zmienne(F)
    wart = wartosciowania(z)
    return all(wartosc_logiczna(F, w) for w in wart)
         
'''
cb = ciagi_binarne(3)

print(cb)
print(len(cb))    

print(wartosciowania('abc'))     
'''
taut = '-qba + (p+qba)'
print(taut, tautologia(taut))

formuly = [ 'a', 'a * b', 'a * -a', '(p + q + r) * (-p * -q * -r)']    

for f in formuly:
    print(f, spelnialna(f))
        
