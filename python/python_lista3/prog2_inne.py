import random
L=[]
wyjscie = 0
while len(L) < 108000 or wyjscie == 1:
    liczba='0000000000'
    ile = 3
    while ile > 0:
        k = random.randint(0,9)
        if k == 0 and liczba[0] == '0':
            liczba = str(random.randint(1,9)) + liczba[1:]
            ile -= 1
        else:
            liczba = liczba[:k] + str(random.randint(0,9)) + liczba[k+1:]
            ile -= 1        
    wyjscie = 1
    print(liczba)

    
