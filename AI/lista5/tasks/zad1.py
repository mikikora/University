
actions = set([(i,j) for i in [-1,0,1] for j in [-1,0,1]])
n = 0
m = 0

def count_next_state(s, a):
    x, y, vx, vy = s
    dvx, dvy = a
    vx += dvx
    vy += dvy
    vx = (3 if vx > 3 else vx)
    vy = (3 if vy > 3 else vy)
    vx = (-3 if vx < -3 else vx)
    vy = (-3 if vy < -3 else vy)
    res = (x + vx, y + vy, vx, vy)
    if 0 <= res[0] < n and 0 <= res[1] < m:
        return res
    return (-1,-1,0,0)


def add(a,b):
    return (a[0 ]+ b[0], a[1] + b[1])

board = {}
policy = {}
reward = {}
gamma = 0.99
all_states = []
V = {}

def generate_states(n,m):
    return [(i,j,k,l) for i in range(n) for j in range(m) for k in [-3, -2, -1, 0, 1, 2, 3] for l in [-3, -2, -1, 0, 1, 2, 3]]

def T(s0, a, s1):
    if board[(s0[0], s0[1])] == '#' or board[(s0[0], s0[1])] == 'e' or board[(s0[0], s0[1])] == 's':
        if count_next_state(s0, a) == s1:
            return 1.0
    elif board[(s0[0], s0[1])] == 'o':
        return 1.0/9
    return 0.0

def generate_new_states(s, a):
    place = board[s[0], s[1]]
    if place == '.' or place == 'e':
        return list()
    if place == '#' or place == 's':
        pom = count_next_state(s,a)
        return [pom]
    res = []
    for o in actions:
        pom = count_next_state(s,a)
        if pom == (-1,-1,0,0):
            res.append(pom)
        else:
            pom = count_next_state((s[0], s[1], pom[2], pom[3]), o)
            res.append(pom)
    return res

def V_generate_pom(V):
    new_V = {(-1,-1,0,0):-100}
    diff = []
    for s in all_states:
        new_V[s] = max(sum(T(s,a,s1) * (gamma * reward[(s1[0], s1[1])] + gamma * V[s1]) for s1 in generate_new_states(s, a) if T(s,a,s1) != 0) for a in actions)
        dif = abs(V[s] - new_V[s])
        diff.append(dif)
    return new_V, max(diff)

def V_generate(V = {}, first_time = True):
    if first_time:
        V = {s:0 for s in all_states}
        V[(-1,-1,0,0)] = -100
    new_V, max_diff = V_generate_pom(V)
    print(max_diff)
    if max_diff < 0.1:
        return new_V
    else:
        return V_generate(new_V, False)

def Q(s,a):
    return sum([T(s,a,s1) * (reward[(s1[0], s1[1])] + gamma*V[s1]) for s1 in generate_new_states(s,a)])

def pi(s):
    res = {a : Q(s,a) for a in actions}
    return max(res, key=lambda x: res[x])

which_file = 1
while which_file < 12:
    if which_file == 4:
        which_file += 2
    if which_file == 7:
        which_file += 1
    plansza = []
    for e in open('task' + str(which_file) + '.txt'):
        plansza.append(list(e.strip()))
    n = len(plansza)
    m = len(plansza[0])
    for i in range(len(plansza)):
        for j in range(len(plansza[i])):
            board[(i,j)] = plansza[i][j]
            if plansza[i][j] == 's':
                start = (i, j)
            if plansza[i][j] == 's' or plansza[i][j] == '#' or plansza[i][j] == 'o':
                reward[(i,j)] = 0
            if plansza[i][j] == 'e':
                reward[(i,j)] = 100
            if plansza[i][j] == '.':
                reward[(i,j)] = -100
    reward[(-1,-1)] = -100
    all_states = generate_states(len(plansza), len(plansza[0]))
    for e in all_states:
        if board[(e[0], e[1])] != '.':
            policy[e] = (0, 0)
    V = V_generate()
    i = 0
    pom = len(policy)
    for s in policy:
        print(i, pom)
        policy[s] = pi(s)
        i += 1
    out = open('policy_for_task' + str(which_file) + '.txt', 'w')
    for e in policy:
        out.write(str(e[1]) + ' ' + str(e[0]) + ' ' + str(e[3]) + ' ' + str(e[2]) + ' ' + '  ' + str(policy[e][1]) + ' ' + str(policy[e][0]) + '\n')
    out.close()
    which_file += 1


