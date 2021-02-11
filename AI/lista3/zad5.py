
out = open('zad_output.txt', 'w')
txt = list()
for e in open('zad_input.txt'):
    txt.append(e)
# print(txt[0].strip().split())
raws = [int(e) for e in txt[0].strip().split()]
cols = [int(e) for e in txt[1].strip().split()]
triples = []
for i in range(2, len(txt)):
    if txt[i].strip():
        triples.append([int(e) for e in txt[i].strip().split()])


def B(i, j):
    return 'B_%d_%d' % (i,j)

def write(s):
    print(s, file=out)

def domains(bs):
    return [q + ' in 0..1' for q in bs]

def sums_col(R, cols):
    wynik = []
    for i in range(len(cols)):
        w = []
        w += [B(j, i) for j in range(R)]
        # wynik += [str(e) + ' #= ' + ' + '.join(w)]
        wynik += [' + '.join(w) + ' #= ' + str(cols[i])]
    return wynik

def sums_raw(C, raws):
    wynik = []
    for i in range(len(raws)):
        w = []
        w += [B(i, j) for j in range(C)]
        # wynik += [str(e) + ' #= ' + ' + '.join(w)]
        wynik += [' + '.join(w) + ' #= ' + str(raws[i])]
    return wynik

def warunki(R, C):
    trojki = [[0,0,0], [1,1,0], [1,0,0], [0,1,1], [0,0,1], [1,1,1], [1,0,1]]
    czworki = [[0,0,0,0], [1,0,0,0], [0,1,0,0], [0,0,1,0], [0,0,0,1],  [1,1,0,0], [1,0,1,0], [0,1,0,1], [0,0,1,1], [1,1,1,1]]
    L = []
    for i in range(R-1):
        for j in range(C-1):
            L.append([B(l,k) for k in range(i, i+2) for l in range(j, j+2)])
    # print(L)
    wynik1 = ['tuples_in([[' + ', '.join(L[i]) + ']], ' + str(czworki) + ')' for i in range(len(L))]
    # print(wynik1)
    L = []
    for i in range(R):
        for j in range(C-3):
            L.append([B(i, l) for l in range(j, j+3)])
    # print(L)
    for i in range(R-3):
        for j in range(C):
            L.append([B(l, j) for l in range(i, i+3)])
    # print(L)
    wynik2 = ['tuples_in([[' + ', '.join(L[i]) + ']], ' + str(trojki) + ')' for i in range(len(L))]
    # print(wynik2)
    return wynik1 + wynik2

def trojki(triples):
    wynik = []
    for e in triples:
        wynik.append(B(e[0],e[1]) + ' #= ' + str(e[2]))
        # wynik.append(str(e[2]) + ' #= ' + B(e[0], e[1]))
    return wynik

def print_constraints(Cs, indent, d):
    position = indent
    print((indent - 1) * ' ', end=' ', file=out)
    for c in Cs:
        print(c + ',', end=' ', file=out)
        position += len(c)
        if position > d:
            position = indent
            # print()
            print('\n' + (indent - 1) * ' ', end=' ', file=out)

def storms(raws, cols, triples):
    write(':- use_module(library(clpfd)).')

    R = len(raws)
    C = len(cols)

    bs = [B(i,j) for i in range(R) for j in range(C)]
    write('solve([' + ', '.join(bs) + ']) :- ')

    cs = domains(bs) + warunki(R, C) + sums_col(R, cols) + sums_raw(C, raws) + trojki(triples)
    # print(cs)

    print_constraints(cs, 4, 70)
    write('')

    write('    labeling([ff], [' + ', '.join(bs) + ']).\n')
    write(":- tell('prolog_result.txt'), solve(X), write(X), nl, told.")


storms(raws, cols, triples)
out.close()
