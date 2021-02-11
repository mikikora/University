from collections import defaultdict as dd
def arctan (x):
    wynik = 0
    for n in range(20):
        wynik += ( ((-1) ** n) / (2 * n + 1) ) * (x ** (2 * n + 1) )
    return wynik

def liczpi () :
    wynik = (10 ** 100) * (4 * arctan(1/5) - arctan(1/239))
    return 4 * wynik

def litery (slowo):
    poprawne = 'abcdefghijklmnopqrstuwvxyzABCDEFGHIJKLMNOPQRSTUWVXYZĄĘÓŹŻĆŚŃŁąęóżźćśńł'
    wynik = ''
    for e in slowo:
        if e in poprawne:
            wynik += e
    return wynik

pi = str(int(liczpi()))
print(pi)

wersy = [e for e in open('tadeusz.txt')]
slowa = [a for e in wersy for a in e.split()]
print(len(slowa))

for i in range(len(slowa)):
    slowa[i] = litery(slowa[i])
#print(slowa)

i = 0
cyfra = 0
maxymalne = dd(list)
dobrze = 0
while i < len(slowa):
    #print(len(slowa[i]), int(pi[cyfra]))
    kolejna = int(pi[cyfra])
    if kolejna == 0:
        kolejna = 10
    if len(slowa[i]) == kolejna:
        dobrze += 1
        cyfra += 1
    elif dobrze > 0:
        wynik = ''
        for j in range(dobrze):
            wynik += ' ' + slowa[i - dobrze + j]
        maxymalne[dobrze].append(wynik)
        cyfra = 0
        i -= 1
        dobrze = 0
    i += 1

klucze = list()
for k in maxymalne:
    klucze.append(k)
#print(maxymalne)
print(maxymalne[max(klucze)])
