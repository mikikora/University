from math import factorial

# exp(1) value from Wikipedia
# 2.71828182845904523536028747135266249775724709369995
# 2.71828182845904523536028747135266249775724709369870

# Potrzebne: add, mul, truediv

def NWD(a,b):
    while b != 0:
        c = a % b
        a = b
        b = c
    return a

class R:
    def __init__(self, n, d=1):
        self.n = n
        self.d = d
    
    def skroc (self):
        nwd = NWD(self.n, self.d)
        self.n //= nwd
        self.d //= nwd
        
    def __mul__(self, y):
        x = self        
        return R(x.n * y.n, x.d * y.d)
    
    def __add__(self, y):
        x = self
        return R(x.n * y.d + y.n * x.d , x.d * y.d)
        
    def __repr__(self):
        self.skroc()
        return '%d/%d' % (self.n, self.d)
        
    def inv(self):
        return R(self.d, self.n)
        
    def __truediv__(self, y):
        return self * y.inv()
        
    def digits(self, N):
        value = int(10 ** N * self.n // self.d)
        res = str(value)
        return res[0] + '.' + res[1:]  # niepoprawne, jeżel liczba >= 10
    
    def __sub__(self, y):
        y.n = -y.n
        return self + y
    
    def __eq__(self, y):
        a = 1 * self.n
        b = 1 * y.n
        a *= y.d
        b *= x.d
        if a == b: return True
        else: return False
    
    def __le__(self, y):
        a = 1 * self.n
        b = 1 * y.n
        a *= y.d
        b *= x.d
        if a <= b: return True
        else: return False
    
    def __ge__(self, y):
        a = 1 * self.n
        b = 1 * y.n
        a *= y.d
        b *= x.d
        if a >= b: return True
        else: return False
    
    def __lt__(self, y):
        return self <= y and not self == y
    
    def __gt__(self, y):
        return self >= y and not self == y
             
        
x = R(2,4)
y = R(1,3)
L = [x,y]
print(L, x==y, x>y, x<y)      

e = R(0)

for i in range(400):
    e = e + R(1, factorial(i))

szukane = e.digits(100)[2:]

def sito(N):
    tab = [1 for i in range(N)]
    tab[0] = tab[1] = 0
    for i in range(2,N):
        if tab[i] == 1:
            for j in range(i+i,N,i):
                tab[j] = 0
    return tab

tab = sito(10**6)
for i in range(len(szukane)-5):
    if tab[int(szukane[i:i+5])] == 1 and szukane[i] != '0':
        print(szukane[i:i+5])
        break
        
            
 
                
