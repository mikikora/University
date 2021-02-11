using Printf

wynik = -14.636489

function error(x)
    return abs(x - wynik) / abs(wynik)
end

println("Dla pierwszej wersji funkcji:")
function w1_16()
    x::Float16 = 4.71
    res::Float16 = x^3 - 6x^2 + 3x - 0.149
    return Float16(res)
end

function w1_32()
    x::Float32 = 4.71
    res::Float32 = x^3 - 6x^2 + 3x - 0.149
    return res
end

function w1_64()
    x::Float64 = 4.71
    res::Float64 = x^3 - 6x^2 + 3x - 0.149
    return res
end

res1 = w1_16()
res2 = w1_32()
res3 = w1_64()
@printf("Float 16: %f\t%f\t%.32f\n", res1, wynik, error(res1))
@printf("Float 32: %f\t%f\t%.32f\n", res2, wynik, error(res2))
@printf("Float 64: %f\t%f\t%.32f\n", res3, wynik, error(res3))

println("\nDla drugiej wersji funkcji:")
function w2_16()
    x::Float16 = 4.71
    res::Float16 = ((x - 6)x + 3)x - 0.149
    return res
end

function w2_32()
    x::Float32 = 4.71
    res::Float32 = ((x - 6)x + 3)x - 0.149
    return res
end

function w2_64()
    x::Float64 = 4.71
    res::Float64 = ((x - 6)x + 3)x - 0.149
    return res
end

res1 = w2_16()
res2 = w2_32()
res3 = w2_64()
@printf("Float 16: %f\t%f\t%.32f\n", res1, wynik, error(res1))
@printf("Float 32: %f\t%f\t%.32f\n", res2, wynik, error(res2))
@printf("Float 64: %f\t%f\t%.32f\n", res3, wynik, error(res3))
