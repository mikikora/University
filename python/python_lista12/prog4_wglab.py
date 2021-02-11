brzegi = [set(['wilk','koza','kapusta']), set()]
niedozwolone = [set(['wilk','koza']), set(['koza','kapusta'])]
wybor = ['', 'wilk', 'koza', 'kapusta']

def dozwolone (wybrane, teraz, brzeg):
    pakutalny = brzeg[teraz] - set([wybrane])
    if pakutalny in niedozwolone:
        return -1
    else:
        return 0

def wybierz (element, brzeg, teraz):
    brzeg_t = set() | brzeg[teraz]
    brzeg_nt = set() | brzeg[(teraz + 1) % 2]
    brzeg_nt = brzeg_nt - set([element])
    brzeg_t = brzeg_t | set([element])
    if teraz == 0:
        return [brzeg_t, brzeg_nt]
    else:
        return [brzeg_nt, brzeg_t]

def drzewo (element, teraz, stan, zycie = 9):
    if element == '':
        stan[(teraz + 1) % 2] |= set([''])
    if stan[0] == set(['']) and teraz == 1:
        return True
    if zycie == 0 or element not in stan[(teraz + 1) % 2] or dozwolone(element, (teraz + 1) % 2, stan) == -1:
        return False
    nowy_stan = wybierz(element, stan, teraz) 
    nowy_stan[0] -= set([''])
    nowy_stan[1] -= set([''])
    stan[(teraz + 1) % 2] -= set([''])
    t = list()
    for e in wybor:
        t.append(drzewo(e, (teraz + 1) % 2, nowy_stan, zycie - 1))
    return [nowy_stan] + t
    
def znajdz (drzewo, lista = list()):
    if drzewo == True:
        return True
    if drzewo == False:
        return False
    for i in range(1,5):
        a = znajdz(drzewo[i], lista)
        if a != False:
            lista.append(drzewo[0])
            return lista
    return False

#print(drzewo('', 0, brzegi))
tree = drzewo('', 0, brzegi)
l = znajdz(tree)
for i in range(len(l)-1):
    print(l[-i-1])
