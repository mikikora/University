def pkta (L):
    if len(L) == 1:
        return set(L + [0])
    else:
        podzbior = list(pkta(L[0:-1]))
        return set(podzbior + [L[-1]] + [L[-1] + e for e in podzbior])

print(pkta([1,2,3,100]))
print()

def pktb (N, A, B):
    if N == 1:
        return [[i] for i in range(A,B+1)]
    mniej = pktb(N-1, A, B)
    #print(mniej)
    return [(e + [i]) for e in mniej for i in range(A, B+1) if i >= e[-1] ]

print(pktb(3, 1, 7)) 
