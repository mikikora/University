def koperta(n):
    a=2*n+1
    for i in range(a):
        for j in range(a):
            if i == 0 or j == 0 or i == a-1 or j == a-1 or i == j or j + i == a-1:
                print ('*',sep='',end='')
            else:
                print(' ',end='')
        print()

koperta(6)
