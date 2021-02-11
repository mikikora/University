#Mikołaj Korobczak
#Pracownia z analizy numerycznej P2 zadanie 8
using Printf
using PyPlot
using Remez
using Random

function get_t(n, k)
    pom = (2k-1)/(2n)
    return cos(pom*pi)
end

function get_u(n ,k)
    return cos((k*pi)/(n+1))
end

#działamy na zbiorze [-1,1]
function get_T(k, x)
    return cos(k * acos(x))
end
;

function Chebval(n, a, x) #algorytm Clenshowa
    b2 = b1 = .0
    x2 = 2.0*x
    for i in n:-1:1
        b = a[i+1] - b2 + b1 * x2
        b2 = b1
        b1 = b
    end
    return 0.5 * a[1] - b2 + b1 * x
end

function I(n, f, x)
    #nie udało mi się znaleźć sposobu obliczenia tyko metodą Clenshowa
    a = [sum([f(get_t(n+1, j))*get_T(i, get_t(n+1, j)) for j in 1:n+1]) for i in 0:n] 
    2*Chebval(n, a, x)/(n+1)
end

function J(n, f, x)
    ak = [f(get_u(n-1, k)) for k in 0:n]
    ak[n+1] /= 2
    a = [Chebval(n, ak, get_u(n-1, j)) for j in 0:n]
    a[n+1] /= 2
    2 * Chebval(n, a, x) / n
end

function K(n, f, x)
    ak = [f(get_u(n,k)) for k in 0:n+1]
    ak[n+2] /= 2
    a = [Chebval(n+1, ak, get_u(n, j)) for j in 0:n]
    2*Chebval(n,a,x)/(n+1)
end
;

#kilka pomocniczych funkcji
xs = [i for i in -1:0.001:1]

function error(l1, l2)
    res = []
    for i in 1:length(l1)
        push!(res, l1[i] - l2[i])
    end
    return res
end

function fun_err(f, n)
    xss_f = [f(e) for e in xs]
    xss_I = [I(n, f, e) for e in xs]
    xss_J = [J(n, f, e) for e in xs]
    xss_K = [K(n, f, e) for e in xs]
    err_I = maximum(error(xss_f, xss_I))
    err_J = maximum(error(xss_f, xss_J))
    err_K = maximum(error(xss_f, xss_K))
    return err_I, err_J, err_K
end

function w_opt(polynomian, x) #liczy wartość wielomianu na podstawie współczynników
    res = 0
    for i in 1:length(polynomian)
        res += x^(i-1)*polynomian[i]
    end
    return res
end
;

f(x) = log(x+2)*cos(5x)
xss_f = [f(e) for e in xs]
xss_I = [I(5, f, e) for e in xs]
xss_J = [J(5, f, e) for e in xs]
xss_K = [K(5, f, e) for e in xs]

h(x::BigFloat) = BigFloat(f(Float64(x)))
polynomian, _D, max_error, alternans = ratfn_minimax(h, (-1,1), 5, 0)

alterx = [Float64(e[1]) for e in alternans]
altery = [Float64(e[2] + h(e[1])) for e in alternans]
yss = [w_opt(polynomian, x) for x in xs]

@printf("Błąd wielomianu optymalnego:\t%.16f\tBład wielomianu I:\t%.16f\n", max_error, maximum(map(abs, error(xss_I, xss_f))))
@printf("Błąd wielomianu optymalnego:\t%.16f\tBład wielomianu J:\t%.16f\n", max_error, maximum(map(abs, error(xss_J, xss_f))))
@printf("Błąd wielomianu optymalnego:\t%.16f\tBład wielomianu K:\t%.16f\n", max_error, maximum(map(abs, error(xss_K, xss_f))))

figure1=figure("Position", [10, 10])

subplot(221)
plot(xs, yss, "k-", xs, xss_f)
scatter(alterx, altery, color="red")
title("Aproksymacja wielomianem optymalnym W")

subplot(222)
plot(xs, xss_f, xs, xss_I, "r-")
title("Aproksymacja wielomianem I")

subplot(223)
plot(xs, xss_f, xs, xss_J, "y-")
title("Aproksymacja wielomianem J")

subplot(224)
plot(xs, xss_f, xs, xss_K, "g-")
title("Aproksymacja wielomianem K")
show()

en_I = error(xss_f, xss_I)
en_J = error(xss_f, xss_J)
en_K = error(xss_f, xss_K)
u_n = [get_u(5, k) for k in 0:5]
fu = [- K(5, f, x) + f(x) for x in u_n]

figure1=figure("Position", [10, 10])

subplot(221)
plot(xs, en_I)
grid(true)
title("Błąd aproksymacji I")

subplot(222)
plot(xs, en_J)
grid(true)
title("Błąd aproksymacji J")

subplot(223)
plot(xs, en_K)
scatter(u_n, fu, color="red")
grid(true)
title("Błąd aproksymacji K")

show()

# generowanie funkcji do testów
rng = MersenneTwister(1234)

function random_poly()
    length = abs(rand(rng, Int)) % 20 + 1
    randn(rng, length)
end

function random_trig()
    length = abs(rand(rng, Int)) % 2 + 1
    res = []
    fs = ['c', 's']
    for i in 1:length
        push!(res, (randn(rng), fs[bitrand(rng, 1).+1]))
    end
    res
end

function random_log()
    [randn(rng), abs(rand(rng, Int))%100 + 3]
end

function random_pow()
    abs(randn(rng)) * (abs(rand(rng, Int)) % 10)
end

function eval_pow(p, x)
    p^x
end

function eval_log(l, x)
    l[1] * log(x + l[2])
end

function eval_poly(poly, x)
    px = 1
    res = 0
    for e in poly
        res += e * px
        px *= x
    end
    res
end

function eval_trig(trig, x)
    res = 0
    for e in trig
        if e[2] == 's'
            res += e[1] * sin(x)
        else
            res += e[1] * cos(x)
        end
    end
    res
end
;

# wielomiany
polynomians = []
for i in 1:200
    push!(polynomians, random_poly())
end
maximum_N = 0
error_I = []
error_J = []
error_K = []
@time begin
    for N in 2:100
        error_IN = []
        error_JN = []
        error_KN = []
        for e in polynomians
            errors = fun_err(x->eval_poly(e, x), N)
            push!(error_IN, errors[1])
            push!(error_JN, errors[2])
            push!(error_KN, errors[3])
        end
        push!(error_I, maximum(error_IN))
        push!(error_J, maximum(error_JN))
        push!(error_K, maximum(error_KN))
        if length(error_I) < 2
            continue
        end
        if abs(error_I[length(error_I)] - error_I[length(error_I) - 1]) < 0.001 && abs(error_J[length(error_J)] - error_J[length(error_J) - 1]) < 0.001 && abs(error_K[length(error_K)] - error_K[length(error_K) - 1]) < 0.001
            println(N)
            maximum_N = N
            break
        end
        maximum_N = 100
    end
end

figure1=figure("Position", [10, 10])
xs_err = [e for e in 2:length(error_I)+1]
subplot(221)
plot(xs_err, error_I, "r-")
title("Aproksymacja wielomianem I")
xlabel("stopień wielomianu")
ylabel("maksymalny błąd")
grid(true)

subplot(222)
plot(xs_err, error_J, "y-")
title("Aproksymacja wielomianem J")
xlabel("stopień wielomianu")
ylabel("maksymalny błąd")
grid(true)

subplot(223)
plot(xs_err, error_K, "g-")
title("Aproksymacja wielomianem K")
xlabel("stopień wielomianu")
ylabel("maksymalny błąd")
grid(true)

show()

println(error_I, '\n')
println(error_J, '\n')
println(error_K, '\n')

# funkcje trygonometryczne +/* wielomiany
functions = []
for i in 1:50
    push!(functions, [random_trig(), random_poly(), +])
    push!(functions, [random_trig(), random_poly(), *])
end

error_I = []
error_J = []
error_K = []
@time begin
    for N in 2:10
        error_IN = []
        error_JN = []
        error_KN = []
        for e in functions
            errors = fun_err(x->e[3](eval_poly(e[2], x), eval_trig(e[1], x)), N)
            push!(error_IN, errors[1])
            push!(error_JN, errors[2])
            push!(error_KN, errors[3])
        end
        push!(error_I, maximum(error_IN))
        push!(error_J, maximum(error_JN))
        push!(error_K, maximum(error_KN))
        maximum_N = 10
    end
end

figure1=figure("Position", [10, 10])
xs_err = [e for e in 2:length(error_I)+1]
subplot(221)
plot(xs_err, error_I, "r-")
title("Aproksymacja wielomianem I")
xlabel("stopień wielomianu")
ylabel("maksymalny błąd")
grid(true)

subplot(222)
plot(xs_err, error_J, "y-")
title("Aproksymacja wielomianem J")
xlabel("stopień wielomianu")
ylabel("maksymalny błąd")
grid(true)

subplot(223)
plot(xs_err, error_K, "g-")
title("Aproksymacja wielomianem K")
xlabel("stopień wielomianu")
ylabel("maksymalny błąd")
grid(true)

show()

println(error_I, '\n')
println(error_J, '\n')
println(error_K, '\n')

# kilka mieszanych funkcji
functions = []
for i in 1:50
    push!(functions, ['a', random_poly(), random_log(), random_trig()])
    push!(functions, ['b', random_poly(), random_trig(), random_log()])
    push!(functions, ['c', random_trig(), random_log(), random_poly()])
end

function eval_function(e)
    if e[1] == 'a'
        return x-> eval_poly(e[2], x) * eval_log(e[3], x) + eval_trig(e[4], x)
    elseif e[1] == 'b'
        return x-> eval_poly(e[2], x) * eval_trig(e[3], x) + eval_log(e[4], x)
    else
        return x-> eval_trig(e[2], x) * eval_log(e[3], x) + eval_poly(e[4], x)
    end
end

maximum_N = 0
error_I = []
error_J = []
error_K = []
@time begin
    for N in 2:10
        error_IN = []
        error_JN = []
        error_KN = []
        for e in functions
            errors = fun_err(eval_function(e), N)
            push!(error_IN, errors[1])
            push!(error_JN, errors[2])
            push!(error_KN, errors[3])
        end
        push!(error_I, maximum(error_IN))
        push!(error_J, maximum(error_JN))
        push!(error_K, maximum(error_KN))
        maximum_N = 10
    end
end

figure1=figure("Position", [10, 10])
xs_err = [e for e in 2:length(error_I)+1]
subplot(221)
plot(xs_err, error_I, "r-")
title("Aproksymacja wielomianem I")
xlabel("stopień wielomianu")
ylabel("maksymalny błąd")
grid(true)

subplot(222)
plot(xs_err, error_J, "y-")
title("Aproksymacja wielomianem J")
xlabel("stopień wielomianu")
ylabel("maksymalny błąd")
grid(true)

subplot(223)
plot(xs_err, error_K, "g-")
title("Aproksymacja wielomianem K")
xlabel("stopień wielomianu")
ylabel("maksymalny błąd")
grid(true)

show()

println(error_I, '\n')
println(error_J, '\n')
println(error_K, '\n')
