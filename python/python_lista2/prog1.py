def szachownica (n, k):
    for i in range(2*n*k):
        for j in range(n):
            #for l in range(k):
            if (i//k)%2 == 0:
                print (k*" ",k*'#',sep='',end='')
            else:
                print (k*'#',k*' ',sep='',end='')
        print()


szachownica(4,3)
# PEP 8
