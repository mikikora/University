from collections import defaultdict as dd

def jakie_litery (s):
    litery = dd(int)
    for e in s:
        litery[e] += 1
    return litery

def czy_ukladalne (dluzsze, krotsze):
    litery_d = jakie_litery(dluzsze)
    litery_k = jakie_litery(krotsze)
    #if litery_k in litery_d: return 'tak'
    #else: return 'nie'
    if all(litery_k[e] <= litery_d[e] for e in litery_k): return 1
    else: return 0

# print(jakie_litery('slowo'))
#print (czy_ukladalne('lokomotywa', 'motyl'), czy_ukladalne('lokomotywa', 'kotka'))
