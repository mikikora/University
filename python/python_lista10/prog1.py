def daj_litery () :
    litery = 'aąbcćdeęfghijklłmnńoóprsśtuwyzźż'
    litery = [e for e in litery]
    return litery

litery = daj_litery()
#print(litery)

def cezar (s, k):
    if k < 0:
        k = len(litery) + k
    k = k % len(litery)
    szyfrowane = list()
    for i in range(len(litery)):
        a = i + k
        if a >= len(litery):
            a -= len(litery)
        szyfrowane.append(litery[a])
    #print(szyfrowane)
    klucze = zip(litery, szyfrowane)
    slownik = dict()
    for e in klucze:
        slownik[e[0]] = e[1]
    #print(slownik)
    #rozwiazanie
    wynik = ''
    for e in s:
        wynik += slownik[e]
    return wynik

slowo = 'konstantynopolitańczykiewiczówna'
print(slowo, cezar(slowo,206))

