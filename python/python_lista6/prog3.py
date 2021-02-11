pierwsza=[]
def sito(N):
    for i in range(N):
        pierwsza.append(1)
    pierwsza[0] = pierwsza[1] = 0
    for i in range(N):
        if pierwsza[i] == 1:
            j=2*i
            while j<N:
                pierwsza[j] = 0
                j += i
                

def dzielniki(a):
    sito(a+1)
    wynik=[]
    for i in range(2, a):
        if a%i == 0 and pierwsza[i] == 1:
            wynik.append(i)
    set(wynik)
    return wynik
    
    
print(dzielniki(730))
