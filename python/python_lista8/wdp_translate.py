from collections import defaultdict as dd
from random import choice

czestosc = dd(int)
pol_ang = dd(list)

for e in open('brown.txt'):
    e = e.strip()
    for k in e.split():
        czestosc[k] += 1

for x in open('pol_ang.txt'):
    x = x[:-1]
    wiersz = x.split('=')
    if len(wiersz) != 2:
        continue
    pol, ang = wiersz
    pol_ang[pol].append(ang)
    
def tlumacz(L):
    wynik = []
    for w in L:
        if w in pol_ang:
            maxi = 0
            najw = pol_ang[w][0]
            for k in pol_ang[w]:
                if czestosc[k] > maxi:
                    maxi = czestosc[k]
                    najw = k
            wynik.append(najw)
        else:
            wynik.append('?' + w)
    return wynik
    
'''        
for wiersz in open('tekst.txt'):
    wiersz = wiersz.split()
    print (' '.join(tlumacz(wiersz)))
'''
print(tlumacz('dziewczyna z chłopiec iść do kino'.split()))    
#print(pol_ang['z'])    
