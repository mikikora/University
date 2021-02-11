#!/usr/bin/env python
# coding: utf-8

# In[1]:


from collections import defaultdict as dd
from itertools import permutations as perm


# In[2]:


s1 = 'Judyta dała wczoraj Stefanowi czekoladki'.lower().split(' ')
s2 = 'Babuleńka miała dwa rogate koziołki'.lower().split(' ')
s3 = 'Wczoraj wieczorem spotkałem pewną piękną kobietę'.lower().split(' ')


# In[3]:


def get_2grams(s):
    file = open('poleval_2grams.txt', 'r')
    pol_dict2 = dd(list)
    words = set(s)
    for e in file:
        if e[-1] == '\n':
            e = e[:-1]
        l, first, second = e.split(' ')
        if first in words or second in words:
            pol_dict2[first].append((int(l), second))
    file.close()
    return pol_dict2


# In[4]:


def get_3grams(s):
    file = open('poleval_3grams.txt', 'r')
    pol_dict3 = dd(list)
    words = set(s)
    for e in file:
        if e[-1] == '\n':
            e = e[:-1]
        pom = e.split(' ')
        if len(pom) < 4:
            continue
        l, first, second, third = pom
        if first in words or second in words or third in words:
            pol_dict3[(first, second)].append((int(l), third))
    file.close()
    return pol_dict3


# In[5]:


def natural_count(s, pol_dict2, pol_dict3):
    suma = 0
    for i in range(len(s)-1):
#         print(s[i], s[i+1])
#         print(pol_dict2[s[i]])
        if len(pol_dict2[s[i]]) != 0 and any(x[1] == s[i+1] for x in pol_dict2[s[i]]):
            for x in pol_dict2[s[i]]:
                if x[1] == s[i+1]:
                    suma += x[0]
                    break
    for i in range(len(s)-2):
        if len(pol_dict3[(s[i], s[i+1])]) != 0 and any(x[1] == s[i+2] for x in pol_dict3[(s[i], s[i+1])]):
            for x in pol_dict3[(s[i], s[i+1])]:
                if x[1] == s[i+2]:
                    suma += x[0]
                    break
    return suma


# In[6]:


def create_res(s):
    pol_dict2 = get_2grams(s)
    pol_dict3 = get_3grams(s)
    res = list()
    for e in perm(s, len(s)):
        res.append((natural_count(e, pol_dict2, pol_dict3), e))

    res.sort(reverse=True, key=lambda x: x[0])
    i = 0
    for e in res:
        print(e)
        i += 1
        if i >= 10:
            break


# In[7]:


create_res(s1)
create_res(s2)
create_res(s3)


# In[ ]:




