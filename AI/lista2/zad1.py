from random import choice
from random import randint

out = open('zad_output.txt', 'w')
inpu = open('zad_input.txt')
a = inpu.readline()
a = a.strip().split()
# print(a)
n = int(a[0]) #wiersze
m = int(a[1])

x = [] #kolumny
y = [] #wiersze
for i in range(n + m):
    a = inpu.readline()
    a = a.strip().split()
    # print(a)
    if i >= n:
        y.append([e for e in map(int, a)])
    else:
        x.append([e for e in map(int,a)])

# print(x, y)

def opt_dist(line, blocks):
    line.extend([0, 0])
    linesums = [0]
    for i in range(1,len(line)):
        linesums.append(linesums[-1] + line[i-1])
    blocksums = [0]
    for i in range(1,len(blocks)):
        blocksums.append(blocksums[-1] + blocks[i])
    dp = [list() + [0 for j in range(len(line))] for i in range(len(blocks) + 1)]
    n = len(line)
    b_len = len(blocks)
    loopend = (n - (blocksums[b_len - 1] - blocksums[0] + b_len - 0 - 1))
    for i in range(blocksums[0], loopend):
        dp[0][i] = (linesums[i - blocks[0]] - linesums[0] + blocks[0] - linesums[i] + linesums[i - blocks[0]] + line[i])
    for j in range(1, b_len):
        loopend = (n - (blocksums[b_len - 1] - blocksums[j] + b_len - j - 1))
        for i in range(blocksums[j] + j,loopend):
            dp[j][i] = n
            previoused = i - blocks[j]
            for k in range(blocksums[j-1] + j - 1, previoused):
                newdp = dp[j-1][k] + linesums[i-blocksums[j]] - linesums[k+1]
                if newdp < dp[j][i] :
                    dp[j][i] = newdp
            dp[j][i] += blocks[j] - linesums[i] + linesums[i - blocks[j]] + line[i]
    return dp[b_len - 1][n-1]
        
print(opt_dist([1,0,1,1,1,0,1,0,0,1,1,0,1], [3,2,2,1]))
print(opt_dist([0,0,0,0,0,0,0,0,0,0,1,1,1,1,0], [3,2,2]))

def neg(a):
    if a == '0':
        return '1'
    return '0'

def wypisz(tab, czy_do_pliku = False):
    if czy_do_pliku == False:
        for e in tab:
            for f in e:
                if f == 0:
                    print('.', end = '')
                else:
                    print('#', end = '')
            print()
    else:
        for e in tab:
            for f in e:
                if f == 0:
                    print('.', end = '', file = out)
                else:
                    print('#', end = '', file = out)
            print(file = out)


def zamien_wiersz (tab, a):
    wynik = ''
    for i in range(n):
        wynik = wynik + str(tab[a][i])
    return wynik

def zamien_kolumne (tab, a):
    wynik = ''
    for i in range(m):
        wynik = wynik + str(tab[i][a])
    return wynik

def wybierz_najlepszy (kolumna, wart_kol, wiersze, nr_kol, koszty_wierszy): #przekazuję napisy nie listy
    koszty = []
    for i in range(n):
        koszty.append(0)
        pom = list() + list(kolumna)
        pom[i] = neg(pom[i])
        # print(pom)
        # print('tu jestem')
        koszty[i] += 2 * opt_dist([int(a) for a in ''.join(map(str, pom))], wart_kol)
        pom = list() + list(wiersze[i])
        pom[nr_kol] = neg(pom[nr_kol])
        koszty[i] += opt_dist([int(a) for a in ''.join(map(str, pom))], koszty_wierszy[nr_kol])
    w = min(koszty)
    #print(koszty, koszty_wierszy)
    a = randint(0,n - 1)
    while koszty[a] != w:
        a = randint(0,n - 1)
    return a
        
def sprawdz_ktore_ok (tab):
    ok_kolumny = set([a for a in range(m)])
    ok_wiersze = set([a for a in range(n)])
    for i in range(n):
        if opt_dist([int(a) for a in zamien_kolumne(tab, i)], x[i]) == 0:
            ok_kolumny -= set([i])
    for i in range(m):
        if opt_dist([int(a) for a in zamien_wiersz(tab, i)], y[i]) == 0:
            ok_wiersze -= set([i])
    return (ok_kolumny, ok_wiersze)

def rozwiaz():
    tab = [list() + [randint(0,1) for e in range(n)] for f in range(m)]
    ok_kolumny, ok_wiersze = sprawdz_ktore_ok(tab)
    #print(ok_wiersze, ok_kolumny)
    ile_wywolan = 0
    while ok_kolumny != set() or ok_wiersze != set():
        if ile_wywolan > 10 ** 3:
            tab = [list() + [randint(0,1) for e in range(n)] for f in range(m)]
            ok_kolumny, ok_wiersze = sprawdz_ktore_ok(tab)
            ile_wywolan = 0
        w_czy_k = randint(0,1)
        if w_czy_k == 0 and ok_wiersze != set():
            wybrany = choice(tuple(ok_wiersze))
            wyliczone = wybierz_najlepszy(zamien_wiersz(tab, wybrany), y[wybrany], [zamien_kolumne(tab, i) for i in range(n)], wybrany, x)
            #print('a', wybrany, wyliczone)
            tab[wybrany][wyliczone] = int(neg(str(tab[wybrany][wyliczone])))
        if w_czy_k == 1 and ok_kolumny != set():
            wybrany = choice(tuple(ok_kolumny))
            wyliczone = wybierz_najlepszy(zamien_kolumne(tab, wybrany), x[wybrany], [zamien_wiersz(tab, i) for i in range(m)], wybrany, y)
            #print('b', wyliczone, wybrany)
            tab[wyliczone][wybrany] = int(neg(str(tab[wyliczone][wybrany])))
        ok_kolumny, ok_wiersze = sprawdz_ktore_ok(tab)
        wypisz(tab)
        print()
        ile_wywolan += 1
    wypisz(tab)
    return tab
    
    
    





wynik = rozwiaz()
wypisz(wynik, True)








