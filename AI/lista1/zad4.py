przyklad = '0000000001'

def calculate (zagadka, dlugosc):
    jedynki = 0
    for e in zagadka:
        if e == '1':
            jedynki += 1
    mini = dlugosc + jedynki
    for i in range(dlugosc):
        if zagadka[i] == '1':
            mini -= 2
    aktualny = mini
    for i in range(dlugosc, len(zagadka)):
        if aktualny < mini:
            mini = aktualny
        if zagadka[i - dlugosc]  == '1':
            aktualny += 2
        if zagadka[i] == '1':
            aktualny -= 2
    if aktualny < mini:
        mini = aktualny
    return mini


#print(calculate(przyklad, 1))

out = open('zad4_output.txt', 'w')
for e in open('zad4_input.txt'):
    e = e.split()
    print(calculate(e[0], int(e[1])), file = out)
