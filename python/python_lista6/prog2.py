'''slowa = []

for x in open('slowa.txt'):
    slowa.append(x.strip())
'''
wystapil = {}

def odwroc (slowo):
    wynik = ''
    i = len(slowo) - 1
    while i >= 0:
        wynik += slowo[i]
        i -= 1
    return wynik
        

def wspak ():
    do_wypisania = set([])
    for e in open('slowa.txt'):
        #print(wystapil)
        e = e.strip()
        if e in wystapil:
            #print (e, wystapil[e])
            wynik = e + ' ' + wystapil[e]
            #print(wynik)
            do_wypisania.add(wynik)
        else:
            f = odwroc(e)
            wystapil[f] = e
    return do_wypisania


print(wspak())

