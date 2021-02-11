from time import time
import heapq
plansza = []
for e in open('zad_input.txt'):
    plansza.append(list(e.strip()))


sciany = list()
cele = list()

moves = [(1,0), (-1,0), (0,1), (0,-1)]
    

class queue():
    def __init__(self):
        self.q = list()
    def push(self, x):
        self.q.append(x)
    def pop(self):
        x = self.q[0]
        self.q = self.q[1:]
        return x
    def __str__(self):
        return self.q.__str__()

def add (a,b):
    return (a[0] + b[0], a[1] + b[1])

def sub (a,b):
    return (a[0] - b[0], a[1] - b[1])

for i in range(len(plansza)):
    for j in range(len(plansza[i])):
        if plansza[i][j] == 'W':
            sciany.append((i,j))
        if plansza[i][j] == 'G' or plansza[i][j] == '*' or plansza[i][j] == '+':
            cele.append((i,j))


def end (stan):
    return all(stan[i] in cele for i in range(1,len(stan)))


def build_state():
    wynik = []
    for i in range(len(plansza)):
        for j in range(len(plansza[i])):
            if plansza[i][j] == 'K' or plansza == '+':
                wynik.insert(0, (i,j))
            if plansza[i][j] == 'B' or plansza[i][j] == '*':
                wynik.append((i,j))
    return wynik

def corner (beczka):
    sasiedzi = [add(beczka, e) for e in moves]
    return beczka not in cele and any(sasiedzi[:2][i] in sciany and sasiedzi[2:][j] in sciany for i in range(2) for j in range(2))

def count_state (stan, ruch):
    #print(stan, ruch)
    nowy_stan = [] + stan
    #print(nowy_stan)
    nowy_stan[0] = add(nowy_stan[0], ruch)
    if nowy_stan[0] in sciany:
        return False
    if nowy_stan[0] in stan:
        poz = int()
        for i in range(1,len(stan)):
            if nowy_stan[0] == stan[i]:
                poz = i
        nowy_stan[poz] = add(stan[poz], ruch)
        if nowy_stan[poz] in sciany:
            return False
        if nowy_stan[poz] in stan:
            #print(nowy_stan, stan, poz, 'hej')
            return False
    if any(corner(nowy_stan[i]) for i in range(1,len(stan))):
        return False
    return nowy_stan

def what_move (nast, pop):
    a = nast[0]
    b = pop[0]
    ruch = sub(a, b)
    if ruch == (1,0):
        return 'D'
    elif ruch == (-1,0):
        return 'U'
    elif ruch == (0,1):
        return 'R'
    elif ruch == (0,-1):
        return 'L'
    else:
        return 'Q'
    

def search_bfs (stan):
    droga = int()
    leanght = 0
    wynik = ''
    seen = set()
    tree = [stan]
    ref = [-1]
    kolejka = queue()
    kolejka.push((stan, len(tree)-1))
    win = end(stan)
    while not win:
        #print(kolejka)
        akt, poz = kolejka.pop()
        win = end(akt)
        if win or tuple(akt) in seen:
            droga = poz
        else:
            for e in moves:
                nowy_stan = count_state(akt, e)
                if nowy_stan != False:
                    tree.append(nowy_stan)
                    ref.append(poz)
                    kolejka.push((nowy_stan, len(tree)-1))
        seen.add(tuple(akt))
    while droga > 0:
        wynik = what_move(tree[droga], tree[ref[droga]]) + wynik
        leanght += 1
        droga = ref[droga]
    return (wynik, leanght)

def h (stan):
    wynik = 0
    for i in range(1,len(stan)):
        if stan[i] in cele:
            wynik += 1
    return wynik

def distance (a,b):
    return abs(a[0] - b[0]) + abs(a[1] - b[1])
'''
def h (stan):
    wynik = 0
    for i in range(1,len(stan)):
        odl = []
        for e in cele:
            odl.append(distance(stan[i], e))
        wynik += min(odl)
    return - wynik'''

def search_A (stan):
    droga = int()
    wynik = ''
    seen = set()
    tree = [stan]
    ref = [-1]
    kolejka = []
    heapq.heappush(kolejka, (0, stan, len(tree)-1, 0))
    win = end(stan)
    while not win:
        #print(kolejka)
        p, akt, poz, odl = heapq.heappop(kolejka)
        win = end(akt)
        if win or tuple(akt) in seen:
            droga = poz
            leanght = odl
        else:
            for e in moves:
                nowy_stan = count_state(akt, e)
                if nowy_stan != False:
                    tree.append(nowy_stan)
                    ref.append(poz)
                    heapq.heappush(kolejka, ( odl + 1 - h(nowy_stan), nowy_stan, len(tree)-1, odl + 1))
        seen.add(tuple(akt))
    while droga > 0:
        wynik = what_move(tree[droga], tree[ref[droga]]) + wynik
        droga = ref[droga]
    return (wynik, leanght)

#print()
#print(search_A(build_state()))
#print()    

t0 = time()
out = open('zad_output.txt', 'w')
print(search_bfs(build_state())[0], file = out)
out.close()
print(time() - t0)






























    
    
