import sys

def domains(Qs, N):
    return [ q + ' in 0..' + str(N-1) for q in Qs ]
    
def all_different(Qs):
    return ['all_distinct([' + ', '.join(Qs) + '])']
    
def diagonal(Qs):   
    N = len(Qs)
    return [ "abs(%s - %s) #\\= abs(%d-%d)" % (Qs[i],Qs[j],i,j) 
            for i in range(N) for j in range(N) if i != j ]

def commas(x):
    return ', '.join(x)
                
def print_constraints(Cs, indent, d):
    position = indent
    print (indent - 1) * ' ',
    for c in Cs:
        print c + ',',
        position += len(c)
        if position > d:
            position = indent
            print
            print (indent - 1) * ' ',
    
def queens(N):
    vs = ['Q' + str(i) for i in range(N)]
    print ':- use_module(library(clpfd)).'
    print 'solve([' + ', '.join(vs) + ']) :- '
    
    cs = domains(vs, N) + all_different(vs) + diagonal(vs)
    
    print_constraints(cs, 4, 70),
    print
    print '    labeling([ff], [' +  commas(vs) + ']).' 
    print 
    print ':- solve(X), write(X), nl.'       

if __name__ == "__main__":
    queens(int(sys.argv[1]))            

    
        
    
