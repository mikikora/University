
out = open('zad_output.txt', 'w')
inpu = open('zad_input.txt')
a = inpu.readline()
a = a.strip().split()
n = int(a[0]) #wiersze
m = int(a[1])

x = [] #kolumny
y = [] #wiersze
for i in range(n + m):
    a = inpu.readline()
    a = a.strip().split()
    if i >= n:
        y.append([e for e in map(int, a)])
    else:
        x.append([e for e in map(int, a)])

inpu.close()

plansza = [list() + ['?' for i in range(n)] for j in range(m)]

def end ():
    return not any('?' in e for e in plansza)

def sprawdz_ustawienie (row, block):
    if '?' in row:
        return False
    i = 0
    while i < len(row) and row[i] == '0':
        i += 1
    if i >= len(row) and block != []:
        return False
    if i >= len(row) and block == []:
        return True
    if i < len(row) and block == []:
        return False
    dlugosc = 0
    while i < len(row) and row[i] == '1':
        dlugosc += 1
        i += 1
    if dlugosc == block[0]:
        return True and sprawdz_ustawienie(row[i:], block[1:])
    return False


def stworz_mozliwe(row, block):
    if block == []:
        return [['0' for i in range(row)]]
    i = block[0]
    wynik = []
    while len(block) != 1 and row - i > sum(block[1:]) + len(block[1:]) - 1:
        pom = [['0'for j in range(0,i-block[0])] + ['1' for j in range(i-block[0],i)] + ['0'] + e for e in stworz_mozliwe(row - i - 1, block[1:])]
        wynik += pom
        i += 1
    while len(block) == 1 and i <= row:
        pom = [['0' for j in range(0, i - block[0])] + ['1' for j in range(i - block[0], i)] + e for e in stworz_mozliwe(row - i, block[1:])]
        wynik += pom
        i += 1
    return wynik


mozliwe_wiersze = [set([tuple(e) for e in stworz_mozliwe(n, y[i])]) for i in range(len(y))]
mozliwe_kolumny = [set([tuple(e) for e in stworz_mozliwe(m, x[i])]) for i in range(len(x))]


def ogranicz_wiersz (ktory):
    wiersz = plansza[ktory]
    pewne1 = [i for i in range(n) if wiersz[i] == '1']
    pewne0 = [i for i in range(n) if wiersz[i] == '0']
    mozliwe = mozliwe_wiersze[ktory]
    ostateczne = mozliwe.copy()
    for i in pewne1:
        for e in mozliwe:
            if e[i] != '1':
                ostateczne -= set([e])
    for i in pewne0:
        for e in mozliwe:
            if e[i] != '0':
                ostateczne -= set([e])
    mozliwe_wiersze[ktory] = ostateczne
    nowy_wiersz = ['?' for i in range(n)]
    for i in range(len(wiersz)):
        if all(e[i] == '1' for e in ostateczne):
            nowy_wiersz[i] = '1'
        elif all(e[i] == '0' for e in ostateczne):
            nowy_wiersz[i] = '0'
    plansza[ktory] = nowy_wiersz


def ogranicz_kolumne(ktora):
    kolumna = []
    for i in range(m):
        kolumna.append(plansza[i][ktora])
    pewne1 = [i for i in range(m) if kolumna[i] == '1']
    pewne0 = [i for i in range(m) if kolumna[i] == '0']
    mozliwe = mozliwe_kolumny[ktora]
    ostateczne = mozliwe.copy()
    for i in pewne1:
        for e in mozliwe:
            if e[i] != '1':
                ostateczne -= set([e])
    for i in pewne0:
        for e in mozliwe:
            if e[i] != '0':
                ostateczne -= set([e])
    mozliwe_kolumny[ktora] = ostateczne
    nowa_kolumna = ['?' for i in range(m)]
    for i in range(len(kolumna)):
        # print(i)
        if all(e[i] == '1' for e in ostateczne):
            nowa_kolumna[i] = '1'
        elif all(e[i] == '0' for e in ostateczne):
            nowa_kolumna[i] = '0'
    for i in range(m):
        plansza[i][ktora] = nowa_kolumna[i]


def obroc_plansze ():
    nowa_plansza = [list() + ['' for i in range(m)] for i in range(n)]
    for i in range(m):
        for j in range(n):
            nowa_plansza[j][i] = plansza[i][j]
    return nowa_plansza

def wypisz ():
    plansza = obroc_plansze()
    for i in range(n):
        for j in range(m):
            if plansza[i][j] == '1':
                print('#', sep='', end='')
            elif plansza[i][j] == '?':
                print('?', sep='', end='')
            else:
                print('.', sep='', end='')
        print()
    print('\n')


def szukaj ():
    zle_wiersze = set()
    zle_kolumny = set()
    for i in range(m):
        if not sprawdz_ustawienie(plansza[i], y[i]):
            zle_wiersze.add(i)
    for i in range(n):
        kolumna = []
        for j in range(m):
            kolumna.append(plansza[j][i])
        if not sprawdz_ustawienie(kolumna, x[i]):
            zle_kolumny.add(i)
    while not end():
        for i in range(m):
            if i in zle_wiersze:
                ogranicz_wiersz(i)
            if sprawdz_ustawienie(plansza[i], y[i]):
                zle_wiersze -= set([i])
        for i in range(n):
            if i in zle_kolumny:
                ogranicz_kolumne(i)
            kolumna = []
            for j in range(m):
                kolumna.append(plansza[j][i])
            if sprawdz_ustawienie(kolumna, x[i]):
                zle_kolumny -= set([i])
        wypisz()


def wypisz_do_pliku ():
    plansza = obroc_plansze()
    for i in range(n):
        for j in range(m):
            if plansza[i][j] == '1':
                print('#', sep='', end='', file=out)
            else:
                print('.', sep='', end='', file=out)
        print('', file=out)

szukaj()
wypisz()
wypisz_do_pliku()
out.close()
