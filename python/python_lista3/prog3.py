def usun(napis):
    a=0
    b=0
    while '(' in napis:
        for i in range(len(napis)):
            if napis[i] == '(':
                a = i
            if napis[i] == ')':
                b = i + 1
        napis = napis[:a] + napis[b:]
        
    return napis
    
print(usun('Ala ma (kota) (i) dwa kanarki'))
print(usun('nie wiem co napisac (ale tego ma nie byc)'))
print(usun('(tu niczego nie ma) tu jest cos fajnego (tu tez niczego nie ma)'))
