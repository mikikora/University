#!/usr/bin/env python
# coding: utf-8

# In[1]:


# import tqdm import tqdm


# In[2]:


def Bleu(oryg, sample):
    res = 0
    all_bigrams = 0
    l = sample.split(' ')
    for i in range(len(l)-1):
        bigram = ' ' + l[i] + ' ' + l[i+1] + ' '
        all_bigrams += 1
        if bigram in oryg:
            res +=1
    return res/all_bigrams


# In[3]:


file = open('odm.txt', 'r')
korp = set()


# In[4]:


# i = 0

for e in file:
    if e[-1] == '\n':
        e = e[:-1]
    for f in e.split(', '):
        korp.add(f.lower())
#     i += 1
#     if i > 10000000:
#         break

file.close()


# In[5]:


alfabet = 'filmujrzeźżądańpośćgnębchłystków'
alfabets = 'filmujrzeźżądańpośćgnębchłystków '
inwokacja = '''
Litwo! Ojczyzno moja Ty! jesteś jak zdrowie,
Ile cię trzeba cenić, ten tylko się dowie,
Kto cię stracił. Dziś piękność twą w całej ozdobie
Widzę i opisuję, bo tęsknię po tobie
Panno święta, co Jasnej bronisz Częstochowy
I w Ostrej świecisz Bramie Ty, co gród zamkowy
Nowogródzki ochraniasz z jego wiernym ludem!
Jak mnie dziecko do zdrowia powróciłaś cudem,
Gdy od płaczącej matki pod Twoją opiekę
Ofiarowany martwą podniosłem powiekę
I zaraz mogłem pieszo do Twych świątyń progu
Iść za wrócone życie podziękować Bogu,
Tak nas powrócisz cudem na Ojczyzny łono.
Tymczasem przenoś moją duszę utęsknioną
Do tych pagórków leśnych, do tych łąk zielonych,
Szeroko nad błękitnym Niemnem rozciągnionych;
Do tych pól malowanych zbożem rozmaitem,
Wyzłacanych pszenicą, posrebrzanych żytem;
Gdzie bursztynowy świerzop, gryka jak śnieg biała,
Gdzie panieńskim rumieńcem dzięcielina pała,
A wszystko przepasane jakby wstęgą, miedzą
Zieloną, na niej z rzadka ciche grusze siedzą.'''
def erase_spaces(x, alph):
    if x == '\n':
        x = ' '
    if x in alph:
        return x
    else:
        return ''
oryginal = ''.join(list(map(lambda x: erase_spaces(x, alfabets), inwokacja.lower())))
inwokacja = ''.join(list(map(lambda x: erase_spaces(x, alfabet), inwokacja.lower())))
print(inwokacja)


# In[6]:


def MaxMatch(text, corpra):
    lenght = max(len(x) for x in corpra)
    i = 0
    res = []
    while i < len(text):
        good = False
        for j in range(lenght, 1 ,-1):
            if text[i:j+i] in corpra:
                res.append(text[i:i+j])
                i = i + j
                good = True
                break
        if  not good:
            res.append(text[i])
            i+=1
    return ' '.join(res)


# In[7]:


res = MaxMatch(inwokacja, korp)
print(res)


# In[8]:


print(Bleu(oryginal, res))


# In[9]:


def rMaxMatch(text, corpra):
    lenght = max(len(x) for x in corpra)
    i = len(text)
    res = []
    while i > 0:
        good = False
        for j in range(min(lenght, i), 0, -1):
#             print(text[i-j:i])
            if text[i-j:i] in corpra:
                res = [text[i-j:i]] + res
                i = i - j
                good = True
                break
        if not i > 0:
            break
        if not good:
            res = [text[i-1]] + res
            i -= 1
    return ' '.join(res)


# In[10]:


rres = rMaxMatch(inwokacja,korp)
print(rres)


# In[11]:


print(Bleu(oryginal, rres))


# In[12]:


print('litwo' in korp)


# In[ ]:




