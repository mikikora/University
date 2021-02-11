def ppn (s):
    s = list(s)
    litery = set(s)
    poukladane = list()
    for e in s:
        if e in litery:
            poukladane.append(e)
            litery = litery - set([e])
    przypisanie = dict()
    #print(poukladane)
    for i in range(1, len(poukladane) + 1):
        przypisanie[poukladane[i-1]] = i
    wynik = ''
    for e in s:
        dolacz = str(przypisanie[e]) + '-'
        wynik = wynik + dolacz
    #print(wynik)
    wynik = wynik[:len(wynik) - 1]
    #print(wynik)
    return wynik

if __name__ == '__main__':
    print(ppn('kajak'))
    print(ppn('indianin'))
