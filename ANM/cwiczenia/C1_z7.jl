
x = 1.0
e = eps(Float64)
# e=2^(-52)

while x < 2.0
    global x += e
    if x * (1.0/x) != 1.0
        break
    end

end

println(x)

#1.000000057228997
