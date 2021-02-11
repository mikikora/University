L = [1,2,3,1,2,3,8,2,2,2,9,9,4]
tab=[]

for i in range(len(L)):
    tab.extend([[L[i], i]])

tab.sort()
wynik=[]
wynik.extend([tab[0]])
for e in tab:
    if wynik[-1][0] == e[0]:
        pass
    else:
        wynik.append(e)

wynik.sort(key = lambda wynik: wynik[1])

wynik_ostateczny=[]
for e in wynik:
    wynik_ostateczny.append(e[0])
    

print(wynik_ostateczny)
