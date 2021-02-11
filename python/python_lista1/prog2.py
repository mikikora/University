def silnia(a,w):
    if a == 1:
        return w
    else:
        w *= a
        a -= 1
        return silnia(a,w)

for i in range(100):
    a=silnia(i+1, 1)
    a=str(a)
    if i < 3:
        print(i+1,'! ma 1 cyfre', sep='')
    elif i<5:
        print(i+1,'! ma ',len(a),' cyfry',sep='')
    else:
        print(i+1,'! ma ',len(a),' cyfr',sep='')
