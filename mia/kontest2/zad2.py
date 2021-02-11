n = int(input())
seen = set()
sum = 0
a = input()
for i in range(n):
    b = a[2*i]
    # print(b)
    if b not in seen:
        seen.add(b)
    else:
        sum += 1

print(sum)
