from losowanie_fragmentow import losuj_fragment

def losuj_haslo(n):
    a=''
    while len(a) != n:
        b=losuj_fragment()
        if n - (len(a) + len(b)) != 1 and len(a)+len(b) <= n:
            a += b
    print(a)

for i in range(10):
    losuj_haslo(8)
for i in range(10):
    losuj_haslo(12)
