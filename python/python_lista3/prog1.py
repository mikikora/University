stala=100001
P=stala*[1]

def sito (P):
    P[0]=P[1]=0
    for i in range(stala):
        if P[i] != 0:
            j=i+i
            while j < stala:
                P[j] = 0
                j += i
                
                


sito(P)

k='777'
licznik = 0    
for i in range(stala):
    a=str(i)
    if k in a:
        if P[i] == 1:
            print(i)
            licznik += 1

print(licznik)         
