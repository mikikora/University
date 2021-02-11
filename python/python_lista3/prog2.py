cyfry = 10
siodemki = 7

licz = 0 
siedem = siodemki * '7'
#trzy liczby na początku
for i in range(10 ** (cyfry - siodemki)):
    if '7' in str(i):
        nicnierob=1
    else:
        a = str(i)
        a = a + siedem
        print(int(a))
        licz += 1
        
#siódemki w środku
for i in range(90):
    for j in range(9):
        if '7' in str(i + 10) or '7' in str(j + 1):
            nicnierob=1
        else:
            a = str(i + 10) + siedem + str(j + 1)
            print(int(a))
            licz += 1
            b = str(j + 1) + siedem + str(i + 10)
            print(int(b))
            licz += 1
            
            

#siódemki na początku            
for i in range(1000):
    a = str(i)
    if i < 10:
        a = '0' + a
    if i < 100:
        a = '0' + a
    if '7' in a:
        nicnierob = 1
    else:
        a = siedem + a
        print(int(a))
        licz += 1
        
for i in range (10):
    for j in range(10):
        if '7' in str(i) or '7' in str(j):
            nicnierob=1
        else:
            a = '7' + str(i) + siedem + str(j)
            b = str(i) + '7' + siedem + str(j)
            c = str(i) + str(j) + siedem + '7'
            print(int(a), int(b), int(c), sep='\n')
            licz += 3
            
for i in range(10):
    if '7' in str(i):
            nicnierob=1
    else:
        d = str(i) + 2 * '7' + siedem
        e = 2 * '7' + str(i) + siedem
        f = '7' + str(i) + '7' + siedem
        print(int(d), int(e), int(f), sep='\n')
        licz +=3

print(int(3*'7' + siedem))
licz += 1

        
print(licz)
