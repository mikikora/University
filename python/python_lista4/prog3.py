import random

def randperm(n):
    L = []
    for i in range(n):
        L.extend([i])
    for i in range(n):
        a = random.randint(0,n-1)
        L[i], L[a] = L[a], L[i]
    return L
        
print(randperm(10))
print(randperm(10))
print(randperm(10))

print(randperm(10))
print(randperm(10))
print(randperm(10))
print(randperm(10))
print(randperm(10))
print(randperm(10 ** 6))
