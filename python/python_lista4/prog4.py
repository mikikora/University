pierwsza=[]

def sito(n):
    for i in range(n):
        pierwsza.extend([1])
    pierwsza[0] = pierwsza[1] = 0
    for i in range(2,n):
        if pierwsza[i] == 1:
            j = 2*i
            while j<n:
                pierwsza[j] = 0
                j = j + i

def palindrom(a, b):
    sito(b+1)
    ile = 0
    for i in range(a, b):
        if pierwsza[i] == 1:
            pal = str(i)
            good = 1
            for j in range(len(pal) // 2):
                if pal[j] != pal[len(pal) - j - 1]:
                    good = 0
            if good == 1:
                ile += 1
                print(pal)
    return ile
    
print(palindrom(2,1000))
