sign = ['A', 'T', 'G', 'C']

from random import choice

N = 50

res = ''
for i in range(50):
	res += choice(sign)
print(res)
