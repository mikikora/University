from collections import defaultdict as dd
ile_liter = dd(list)
dlugosci = set()
litery = 'abcdefghijklmnopqrstuwvxyzABCDEFGHIJKLMNOPQRSTUWVXYZĄĘÓŹŻĆŚŃŁąęóżźćśńł'
def program (tekst):
    for e in open(tekst):
        e = e.strip()
        wiersz = e.split()
        for f in wiersz:
            #f = f.lower()
            wynik=''
            for g in f:
                if g in litery:
                    wynik = wynik + g
            f = wynik
            dlugosci.add(len(f))
            ile_liter[len(f)].append(f)

    print(sorted(ile_liter[max(dlugosci)]))

program('nad_niemnem.txt')
#program('przyklad.txt')
