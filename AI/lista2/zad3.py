import heapq

plansza = []
for e in open('zad_input.txt'):
    plansza.append(list(e.strip()))

sciany = set()
cele = set()

for i in range(len(plansza)):
    for j in range(len(plansza[i])):
        if plansza[i][j] == 'W':
            sciany.add((i, j))
        if plansza[i][j] == 'G' or plansza[i][j] == '*' or plansza[i][j] == '+':
            cele.add((i, j))
        if plansza[i][j] == 'K' or plansza == '+':
            player_start = [{'gdzie': (i, j)}]

moves = {'D': (1, 0), 'U': (-1, 0), 'R': (0, 1), 'L': (0, -1)}


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


def add(a, b):
    return (a[0] + b[0], a[1] + b[1])


def sub(a, b):
    return (a[0] - b[0], a[1] - b[1])


def build_state():  # x, y góra dół prawo lewo
    wynik = []
    for i in range(len(plansza)):
        for j in range(len(plansza[i])):
            if plansza[i][j] == 'B' or plansza[i][j] == '*':
                wynik.append({'gdzie': (i, j), 'U': False, 'D': False, 'R': False, 'L': False})
    return wynik


def paint_sides(stan, stan_pop):  # jeżeli pierwszy, to stan_pop to pozycja gracza
    poz_gracza = tuple()
    beczki = []
    for e in stan:
        beczki.append(e['gdzie'])
    for e in stan_pop:
        if e not in stan:
            poz_gracza = e['gdzie']
    for e in stan:
        for f in moves:
            e[f] = False
    q = queue()
    q.push(poz_gracza)
    seen = set([poz_gracza])
    while q.__str__() != '[]':
        obecny = q.pop()
        for e in moves:
            # print(obecny, moves[e])
            nowy = add(obecny, moves[e])
            if nowy in beczki and nowy not in sciany:
                for i in range(len(beczki)):
                    if beczki[i] == nowy:
                        ktora_to = i
                if add(beczki[ktora_to], moves[e]) not in sciany and add(beczki[ktora_to], moves[e]) not in beczki:
                    stan[ktora_to][e] = True
            elif nowy not in seen and nowy not in sciany:
                q.push(nowy)
                seen.add(nowy)
    return stan


def end(stan):
    return all(stan[i]['gdzie'] in cele for i in range(len(stan)))


def move_box(stan, ruch, skrzynka):
    skrzynki = set()
    for e in stan:
        skrzynki.add(e['gdzie'])
    to_move = add(ruch, stan[skrzynka]['gdzie'])
    if to_move in sciany or to_move in skrzynki:
        return False
    nowy_stan = [e.copy() for e in stan]
    nowy_stan[skrzynka]['gdzie'] = to_move
    return paint_sides(nowy_stan, stan)


def heuristic(stan):
    return len(stan) - len([e for e in stan if e['gdzie'] in cele])



def hasheable_state(stan):
    pozycje = []
    for e in stan:
        pozycje.append(str(e['gdzie']))
    return ' '.join(pozycje)

def distance (a,b):
    return abs(a[0] - b[0]) + abs(a[1] - b[1])


def dif_heuristic(stan):
    wynik = 0
    tab = []
    for e in stan:
        for f in cele:
            tab.append(distance(e['gdzie'], f))
        wynik += min(tab)
        tab = []
    return wynik

def find_sequence(stan):
    jakis_licznik = 0
    h = []
    tree = [stan]
    ref = [-1]
    seen = set(hasheable_state(stan))
    heapq.heappush(h, (0, jakis_licznik, stan, 0))
    win = end(stan)
    zakoncz = False
    while not win:
        #print(seen)
        # print(len(h))
        try:
            p, smiec, akt, ojciec = heapq.heappop(h)
            for i in range(len(akt)):
                for f in akt[i]:
                    if akt[i][f] == True:
                        nowy = move_box(akt, moves[f], i)
                        if nowy != False and hasheable_state(nowy) not in seen:
                            jakis_licznik += 1
                            win = end(nowy)
                            if win and not zakoncz:
                                tree.append(nowy)
                                ref.append(ojciec)
                                zakoncz = True
                            elif zakoncz:
                                pass
                            else:
                                tree.append(nowy)
                                # if heuristic(nowy) <= 1:
                                    # print(len(akt), heuristic(nowy))
                                    # print([e['gdzie'] for e in akt])
                                    # print([e['gdzie'] for e in akt if e['gdzie'] not in cele])
                                    # print([e['gdzie'] for e in akt if e['gdzie'] in cele])
                                ref.append(ojciec)
                                seen.add(hasheable_state(nowy))
                                heapq.heappush(h, (heuristic(nowy), jakis_licznik, nowy, len(tree) - 1))
        except:
            for e in tree:
                    if dif_heuristic(e) <=5:
                            print('\n', cele)
                            print([f['gdzie'] for f in e])
            input()
    wynik = [tree[-1]]
    droga = ref[-1]
    while droga > 0:
        droga = ref[droga]
        print(droga)
        wynik = [tree[droga]] + wynik
    return wynik


def dotrzyj(dokad, skad, stan):
    beczki = []
    for e in stan:
        beczki.append(e['gdzie'])
    print(skad, dokad, beczki, '\n')
    q = queue()
    seen = set([skad])
    ref = [-1]
    tree = [skad]
    q.push((skad, 0))
    if skad == dokad:
        koniec = True
    else:
        koniec = False
    while koniec == False:
        jestem, ojciec = q.pop()
        for e in moves:
            nowy = add(jestem, moves[e])
            if nowy not in sciany and nowy not in seen and nowy not in beczki:
                if nowy == dokad:
                    koniec = True
                    tree.append(nowy)
                    ref.append(ojciec)
                else:
                    seen.add(nowy)
                    tree.append(nowy)
                    ref.append(ojciec)
                    q.push((nowy, len(tree) - 1))
    wynik = ''
    droga = ref[-1]
    a = tree[-1]
    b = tree[droga]
    while droga > -1:

        ruch = sub(a, b)
        print(a, b)
        a = b
        b = tree[ref[droga]]
        for e in moves:
            if moves[e] == ruch:
                wynik = e + wynik
        droga = ref[droga]
    print(wynik)
    return wynik


def move_sequence():
    sequence = find_sequence(paint_sides(build_state(), player_start))
    print(sequence)
    wynik = ''
    gracz = player_start[0]['gdzie']
    while len(sequence) > 1:
        pop = sequence[0].copy()
        nast = sequence[1].copy()
        sequence = sequence[1:]
        skrzynki = [e['gdzie'] for e in nast]
        print(skrzynki)
        print(cele)
        for i in range(len(pop)):
            if pop[i]['gdzie'] not in skrzynki:
                print(pop[i]['gdzie'], '\n\n\n')
                ruszona = i
        zmiana = sub(nast[ruszona]['gdzie'], pop[ruszona]['gdzie'])
        for e in moves:
            if moves[e] == zmiana:
                przesuniecie = e
        print(sequence)
        print(pop[ruszona]['gdzie'])
        wynik += dotrzyj(sub(pop[ruszona]['gdzie'], zmiana), gracz, pop)
        # print(dotrzyj(sub(pop[ruszona]['gdzie'], moves[przesuniecie]),gracz))
        wynik += przesuniecie
        print(wynik)
        gracz = pop[ruszona]['gdzie']

    return wynik


odpowiedz = move_sequence()
print(odpowiedz)
out = open('zad_output.txt', 'w')
print(odpowiedz, file=out)
