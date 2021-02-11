using Printf


function bit2float(string)
    s = string[1] == '1' ? -1 : 1
    cs = reverse(string[2:12]) #żeby potęgi rosły z indeksami
    ms = string[13:end]
    @assert length(ms) + length(cs) == 63
    m = 1.0
    for i in 1:1:length(ms)
        m += '1' == ms[i] ? 2.0^(-i) : 0
    end
    println(m)
    c = 0
    for i in 1:1:length(cs)
        c += '1' == cs[i] ? 2^(i-1) : 0
    end
    c -= 1023
    println(c)
    return s * m * 2.0^c
end

a = -0.706
println(bitstring(a))
res = bit2float(bitstring(a))
@printf("%f\n", res)
