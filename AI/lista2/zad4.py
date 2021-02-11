from time import time
from random import choice

plansza = []
for e in open('zad_input.txt'):
    plansza.append(e.strip())

moves = [(1, 0), (-1, 0), (0, 1), (0, -1)]
sciany = set()
cele = set()

def add(a,b):
    return (a[0] + b[0], a[1] + b[1])

def sub(a,b):
    return (a[0] - b[0], a[1] - b[1])

def end (stan):
    return all(e in cele for e in stan)

class queue():
    def __init__(self):
        self.q = list()
    def push(self, x):
        self.q.append(x)
    def pop(self):
        x = self.q[0]
        self.q = self.q[1:] # del self.q[0]
        return x
    def __str__(self):
        return self.q.__str__()

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
                wynik.add((i, j))
    return wynik

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

def hashable_state(stan):
    # print(stan)
    return tuple(sorted(list(stan)))

def zmniejsz_niepewnosc(stan):
    t0 = time()
    wyniki = list()
    # start = True
    # while start or wyniki[-1][0] < 2:
    #     if start:
    #         start = False
    while time() - t0 <= 4:
        tab = [stan]
        krok = 0
        while krok < 100 and len(tab[-1]) > 1:
            move = choice(moves)
            for i in range(4):
                tab.append(count_state(tab[-1], move))
            krok += 4
        wyniki.append((len(tab[-1]), len(tab), tab))
    #print(len(wyniki))
    return min(wyniki, key = lambda x: (x[0], x[1]))[2]


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


def bfs (stan):
    print(len(stan))
    wynik = ''
    tree = [stan]
    # print(hashable_state(stan))
    seen = set([hashable_state(stan)])
    q = queue()
    q.push((0, stan))
    ref = [-1]
    win = end(stan)
    while not win:
        ojciec, akt = q.pop()
        # print(akt)
        for e in moves:
            nowy = count_state(akt, e)
            hs = hashable_state(nowy)
            if hs not in seen and end(nowy):
                win = True
                tree.append(nowy)
                ref.append(ojciec)
            elif hs not in seen and not win:
                seen.add(hashable_state(nowy))
                tree.append(nowy)
                ref.append(ojciec)
                q.push((len(tree) - 1, nowy))
    # print(tree[-1])
    droga = ref[-1]
    pop = tree[-1]
    while droga >= 0:
        nast = tree[droga]
        wynik = what_move(nast, pop) + wynik
        pop = set() | nast
        droga = ref[droga]
    return wynik


def find_answer (stan):
    dobry = zmniejsz_niepewnosc(stan)
    wynik = ''
    pop = dobry[-1]
    i = len(dobry) - 2
    while i >= 0:
        nast = dobry[i]
        wynik = what_move(nast, pop) + wynik
        pop = set() | nast
        i -= 1
    wynik += bfs(dobry[-1])
    return wynik



# w = zmniejsz_niepewnosc(build_state())[1][-1]
# print(w)
# print(bfs(w))
t0 = time()
w = find_answer(build_state())
out = open("zad_output.txt", 'w')
print(w)
print(w, file = out)
out.close()

print(time() - t0)















