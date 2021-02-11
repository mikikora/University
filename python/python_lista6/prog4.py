def podziel(napis):
    i=0
    wynik=[]
    while i < len(napis):
        if napis[i] == ' ':
            pass
        else:
            wycinek=""
            while i < len(napis) and napis[i] != ' ':
                wycinek += napis[i]
                i += 1
            wynik.append(wycinek)
        i += 1
    return wynik

    
print(podziel("   Ala      ma  kota i       4     psy"))
