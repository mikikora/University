pi = 3.14

#zakładam, że n jest nieparzyste

def kolko (n,roznica):
    r=4*n//7
    s=n//2
    for i in range(n):
        print(roznica*' ',end='')
        for j in range(n):
            if (i==s and j==s) or (((i-s)**2 + (j-s)**2)**(1/2)) <= r:
                print('#',end='')
            else:
                print(' ',end='')
        print()
        
def balwanek (n):
    kolko(n,5)
    kolko(n+6,2)
    kolko(n+10,0)
    
balwanek(11)
