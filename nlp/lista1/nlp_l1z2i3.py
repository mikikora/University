#!/usr/bin/env python
# coding: utf-8

# In[1]:


from collections import defaultdict as dd
from random import choice
from random import randint


# In[2]:


file = open('2grams.txt', 'r')
pol_dict2 = dd(list)


# In[3]:


# i = 0
for e in file:
    if e[-1] == '\n':
        e = e[:-1]
    l, first, second = e.split(' ')
    pol_dict2[first].append((int(l), second))
#     i += 1
    if int(l) <= 1:
#         print(l)
        break

file.close()


# # Zadanie 2

# In[4]:


print(len(pol_dict2))


# In[5]:


def gen_sen2(pol_dict):
    sentense = [choice(pol_dict['<BOS>'])[1]]
    while True:
        if len(pol_dict[sentense[-1]]) == 0:
            w = choice(list(pol_dict.keys()))
        else:
            w = sentense[-1]
        word = choice(pol_dict[w])[1]
        if word == '<EOS>':
            break
        sentense.append(word)
    return sentense


# In[6]:


print(' '.join(gen_sen2(pol_dict2)))


# In[7]:


file = open('3grams.txt', 'r')
pol_dict3 = dd(list)


# In[8]:


# i = 0
for e in file:
    if e[-1] == '\n':
        e = e[:-1]
    pom = e.split(' ')
    if len(pom) < 4:
        continue
    l, first, second, third = pom
    pol_dict3[(first, second)].append((int(l), third))
#     i += 1
    if int(l) <= 1:
        print(l)
        break
        
        
file.close()


# In[9]:


print(len(pol_dict3))


# In[10]:


def gen_sen3(pol_dict):
    first = choice([(x, y) for (x, y) in pol_dict.keys() if x == '<BOS>'])
    sentense = [first[1], choice(pol_dict[first])[1]]
    while True:
        if len(pol_dict[(sentense[-2], sentense[-1])]) == 0:
            w = choice(list(pol_dict.keys()))
        else:
            w = (sentense[-2], sentense[-1])
        word = choice(pol_dict[w])[1]
        if word == '<EOS>':
            break
        sentense.append(word)
    return sentense


# In[11]:


print(' '.join(gen_sen3(pol_dict3)))


# # Zadanie 3

# In[12]:


def draw(l):
#     print(l[0])
    results = [l[0][0]]
    for i in range(1,len(l)):
        results.append(l[i][0] + results[-1])
    rand = randint(1,results[-1])
    i = 0
    while results[i] < rand:
        i += 1
    return l[i][1]


# In[13]:


def gen_sen2_s(pol_dict):
    sentense = [draw(pol_dict['<BOS>'])]
    while True:
        if len(pol_dict[sentense[-1]]) == 0:
            w = choice(list(pol_dict.keys()))
        else:
            w = sentense[-1]
        word = draw(pol_dict[w])
#         print(word)
        if word == '<EOS>':
            break
        sentense.append(word)
    return sentense


# In[14]:


print(' '.join(gen_sen2_s(pol_dict2)))


# In[15]:


def gen_sen3_s(pol_dict):
    first = choice([(x, y) for (x, y) in pol_dict.keys() if x == '<BOS>'])
    sentense = [first[1], draw(pol_dict[first])]
    while True:
        if len(pol_dict[(sentense[-2], sentense[-1])]) == 0:
            w = choice(list(pol_dict.keys()))
        else:
            w = (sentense[-2], sentense[-1])
        word = draw(pol_dict[w])
        if word == '<EOS>':
            break
        sentense.append(word)
    return sentense


# In[16]:


print(' '.join(gen_sen3_s(pol_dict3)))


# In[ ]:




