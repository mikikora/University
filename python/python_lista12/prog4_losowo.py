from random import choice

brzeg = [set(['wilk', 'koza', 'kapusta']), set([])]
niedozwolone = [set(['wilk','koza']), set(['koza','kapusta'])]

def dozwolone (wybrane, teraz):
    pakutalny = brzeg[teraz] - set([wybrane])
    if pakutalny in niedozwolone:
        return -1
    else:
        return 0

def wybierz(wybrane, teraz):
    if wybrane == '':
        return (teraz + 1) % 2
    brzeg[teraz] = brzeg[teraz] - set([wybrane])
    teraz = (teraz + 1) % 2
    brzeg[teraz] = brzeg[teraz] | set([wybrane])
    return teraz

def losowo (teraz):
    while brzeg[0] != set() or teraz != 1:
        wybrane = choice(list(brzeg[teraz]) + [''])
        if dozwolone(wybrane, teraz) == 0:
            teraz = wybierz(wybrane, teraz)
            print(brzeg, teraz)




losowo(0)
