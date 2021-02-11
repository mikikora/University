import heapq
debug = open('debug.txt', 'w')
plansza = []
for e in open('zad_input.txt'):
    plansza.append(list(e.strip()))

walls = set()
goals = set()

for i in range(len(plansza)):
    for j in range(len(plansza[i])):
        if plansza[i][j] == 'W':
            walls.add((i, j))
        if plansza[i][j] == 'G' or plansza[i][j] == '*' or plansza[i][j] == '+':
            goals.add((i, j))
        if plansza[i][j] == 'K' or plansza == '+':
            player_start = [{'position': (i, j)}]

moves = {'D': (1, 0), 'U': (-1, 0), 'R': (0, 1), 'L': (0, -1)}

def add(a, b):
    return a[0] + b[0], a[1] + b[1]


def sub(a, b):
    return a[0] - b[0], a[1] - b[1]

# def distance (a,b):
#     return abs(a[0] - b[0]) + abs(a[1] - b[1])

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

    def is_empty(self):
        return self.q == list()


def build_state():  # x, y góra dół prawo lewo
    wynik = []
    for i in range(len(plansza)):
        for j in range(len(plansza[i])):
            if plansza[i][j] == 'B' or plansza[i][j] == '*':
                wynik.append({'position': (i, j), 'U': False, 'D': False, 'R': False, 'L': False})
    return wynik

def paint_sides(state, prev_state):
    # player_pos = tuple()
    barrels = []
    for e in state:
        barrels.append(e['position'])
    for e in prev_state:
        if e not in state:
            player_pos = e['position']
    for e in state:
        for f in moves:
            e[f] = False
    q = queue()
    q.push(player_pos)
    seen = set([player_pos])
    while not q.is_empty():
        current = q.pop()
        for e in moves:
            newone = add(current, moves[e])
            if newone in barrels and newone not in walls:
                for i in range(len(barrels)):
                    if barrels[i] == newone:
                        whichone = i
                her_new_pos = add(barrels[whichone], moves[e])
                if her_new_pos not in walls and her_new_pos not in barrels:
                    state[whichone][e] = True
            elif newone not in seen and newone not in walls:
                q.push(newone)
                seen.add(newone)
    return state

def end(state):
    return all(state[i]['position'] in goals for i in range(len(state)))

def heuristic(state):
    return len(state) - len([e for e in state if e['position'] in goals])

def move_box(state, move, box):
    barrels = set()
    for e in state:
        barrels.add(e['position'])
    new_pos = add(move, state[box]['position'])
    if new_pos in walls or new_pos in barrels:
        return None
    new_state = [e.copy() for e in state]
    new_state[box]['position'] = new_pos
    return paint_sides(new_state, state)

def hasheable_state(stan):
    pozycje = []
    for e in stan:
        pozycje.append(str(e['position']))
    return ' '.join(pozycje)

def find_sequence(state):
    not_important_counter = 0
    h = []
    tree = [state]
    ref = [-1]
    seen = set([hasheable_state(state)])
    heapq.heappush(h, (heuristic(state), not_important_counter, state, 0))
    win = end(state)
    while not win:
        smiec, trash, act_state, parent = heapq.heappop(h)
        del trash
        for i in range(len(act_state)):
            if win:
                continue
            for f in moves:
                if win:
                    continue
                if act_state[i][f]:
                    new_state = move_box(act_state, moves[f], i)
                    if new_state is not None and hasheable_state(new_state) not in seen:
                        not_important_counter += 1
                        win = end(new_state)
                        tree.append(new_state)
                        ref.append(parent)
                        seen.add(hasheable_state(new_state))
                        heapq.heappush(h, (heuristic(new_state), not_important_counter, new_state, len(tree) - 1))
    result = [tree[-1]]
    way = ref[-1]
    while way >= 0:
        result = [tree[way]] + result
        way = ref[way]
    return result

def reach(begining, finish, state):
    barrels = set()
    for e in state:
        barrels.add(e['position'])
    q = queue()
    seen = set([begining])
    ref = [-1]
    tree = [begining]
    q.push((begining, 0))
    ending = begining == finish
    while not ending:
        place, parent = q.pop()
        for e in moves:
            if ending:
                continue
            new_place = add(place, moves[e])
            if new_place not in seen and new_place not in walls and new_place not in barrels:
                tree.append(new_place)
                ref.append(parent)
                seen.add(new_place)
                ending = new_place == finish
                if ending:
                    # print('doszedlem tutaj')
                    continue
                q.push((new_place, len(ref) - 1))
    result = ''
    way = ref[-1]
    succ = tree[-1]
    prev = tree[way]
    # print(tree)
    # print(ref)
    while way > -1:
        move = sub(succ, prev)
        # print(move)
        succ = prev
        prev = tree[ref[way]]
        for e in moves:
            if moves[e] == move:
                result = e + result
        way = ref[way]
    return result

def build_result():
    sequence = find_sequence(paint_sides(build_state(), player_start))
    # print(sequence, file=open('debug.txt', 'w'))
    for e in sequence:
        print(e, file=debug)
    # input()
    # print(sequence[-1], sequence[-2], sep='\n\n')
    result = ''
    player = player_start[0]['position']
    for j in range(1, len(sequence)):
        my_move = tuple()
        prev = sequence[j-1]
        succ = sequence[j]
        for i in range(len(prev)):
            # print(prev)
            # print(succ)
            # print('\n\n')
            # print(prev[i], succ[i], sep='\n\n', end='\n\n\n')
            if prev[i]['position'] != succ[i]['position']:
                for e in moves:
                    # print(move_box(prev, moves[e], i), end='\n\n')
                    # print(succ, end='\n\n\n\n')
                    if prev[i][e] and move_box(prev, moves[e], i) == succ:
                        my_move = (i, e)
        # print(prev, succ, sep='\n\n')
        # print(my_move)
        # print(player, sub(prev[my_move[0]]['position'], moves[my_move[1]]), prev)
        result += reach(player, sub(prev[my_move[0]]['position'], moves[my_move[1]]), prev)
        result += my_move[1]
        player = prev[my_move[0]]['position']
    return result


# print(player_start)
# print(reach(player_start[0]['position'], (1,1), build_state()))
# print(find_sequence(paint_sides(build_state(), player_start)))
# print(reach((3,2), (4,4), [{'position': (3, 3), 'U': False, 'D': False, 'R': False, 'L': False}, {'position': (4, 2), 'U': False, 'D': False, 'R': False, 'L': False}, {'position': (3, 4), 'U': True, 'D': True, 'R': False, 'L': False}, {'position': (4, 3), 'U': False, 'D': False, 'R': False, 'L': False}, {'position': (5, 2), 'U': False, 'D': False, 'R': True, 'L': True}, {'position': (5, 4), 'U': True, 'D': True, 'R': True, 'L': True}]))
answer = build_result()
print(answer)
out = open('zad_output.txt', 'w')
print(answer, file=out)
out.close()
debug.close()
# print(build_state())












