def zadanie (plik):
    slowa = [e.strip() for e in open(plik)]
    tekst = ''
    for e in slowa:
        tekst = tekst + e

    tablica = list()
    dl = len(tekst)
    for i in range(dl):
        tablica.append(tekst[dl-i:dl - i + 1000])
    tablica.sort()

    ma = 0
    i = 1
    fragment = ''
    while i < len(tablica):
        if tablica[i] == '' or tablica[i-1] == '':
            pass
        elif tablica[i-1][0] == tablica[i][0]:
            pierw = tablica[i-1]
            drug = tablica[i]
            dlugosc = 1
            while dlugosc < len(pierw) and dlugosc < len(drug) and pierw[dlugosc] == drug[dlugosc]:
                dlugosc += 1
            if dlugosc > ma:
                ma = dlugosc
                fragment = pierw[:dlugosc]
        i += 1

    return (ma, fragment)

print(zadanie('faraon.txt'))
print(zadanie('nad-niemnem.txt'))
