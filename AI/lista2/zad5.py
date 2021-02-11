import heapq
from time import time

plansza = []
for e in open("zad_input.txt"):
        plansza.append(e.strip())

sciany = set()
cele = set()

for i in range(len(plansza)):
    for j in range(len(plansza[i])):
        if '#' == plansza[i][j]:
            sciany.add((i, j))
        if 'B' == plansza[i][j] or 'G' == plansza[i][j]:
            cele.add((i, j))

def build_state():
    wynik = set()
    for i in range(len(plansza)):
        for j in range(len(plansza[i])):
            if 'S' == plansza[i][j] or 'B' == plansza[i][j]:
                wynik.add((i,j))
    return wynik


#moves = {'U': (-1, 0), 'D': (1, 0), "R": (0, 1), "L": (0, -1)}
moves = [(-1, 0), (1, 0), (0, 1), (0, -1)]

def add(a,b):
    return (a[0] + b[0], a[1] + b[1])

def sub(a,b):
    return (a[0] - b[0], a[1] - b[1])

def end(stan):
    return all(e in cele for e in stan)

def count_state (stan, move):
    #print(stan)
    wynik = set()
    for e in stan:
        #print(e, move)
        nowy = add(e, move)
        if nowy in sciany:
            wynik.add(e)
        else:
            wynik.add(nowy)
    return wynik

def odl(a, b):
    return abs(a[0] - b[0]) + abs(a[1] - b[1])

def heuristic(stan):
    wynik = []
    for e in stan:
        odleglosci = []
        for f in cele:
            odleglosci.append(odl(e, f))
        wynik.append(min(odleglosci))
    return max(wynik)
    # return 0

def hashable_state(stan):
    return tuple(sorted(list(stan)))

def what_move (nast, pop):
    for e in moves:
        #print(count_state(nast, e), pop)
        if count_state(nast, e) == pop:
            #print("cos")
            ruch = e
    if ruch == (1, 0):
        return 'D'
    elif ruch == (-1, 0):
        return 'U'
    elif ruch == (0, 1):
        return 'R'
    elif ruch == (0, -1):
        return 'L'
    else:
        return 'Q'

def A_search(stan):
    #print(stan)
    queue = []
    wynik = ''
    seen = set()
    seen.add(hashable_state(stan))
    tree = [stan]
    ref = [-1]
    win = end(stan)
    heapq.heappush(queue, (heuristic(stan), stan, 0, 0))
    while not win:
        _, akt, ojciec, odl = heapq.heappop(queue)
        #print(akt)
        for e in moves:
            nowy = count_state(akt, e)
            hs = hashable_state(nowy)
            if hs not in seen:
                seen.add(hs)
                if end(nowy):
                    win = True
                    tree.append(nowy)
                    ref.append(ojciec)
                if not win:
                    tree.append(nowy)
                    ref.append(ojciec)
                    heapq.heappush(queue, (odl + 1 + heuristic(nowy), nowy, len(tree) - 1, odl + 1))
    print("zbudowane")
    print(len(seen))
    # for i in range(len(tree)):
    #     print(i, tree[i], ref[i])
    # print(cele)
    droga = ref[-1]
    pop = tree[-1]
    while droga >= 0:
        nast = tree[droga]
        wynik = what_move(nast, pop) + wynik
        pop = set() | nast
        droga = ref[droga]
    return wynik

t0 = time()
#print(A_search(build_state()))
out = open("zad_output.txt", 'w')
w = A_search(build_state())
print(w)
print(w, file = out)
out.close()
print(time() - t0)














