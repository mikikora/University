#Mikołaj Korobczak
#Pracownia p1 z Analizy Numeryczenj (M)
#Zadanie 12
using Printf
using PyPlot

function kepler(x, M, e)
    return x - e*sin(x) - M
end

function kepler_derivative(x, M, e)
    return 1 - e * cos(x)
end

function coordinates(a, e, alpha) #not used
    x = a * (cos(alpha) - e)
    y = a * sqrt(1 - e^2) * sin(alpha)
    return x, y
end

function deg2rad(d)
    return d * pi / 180
end

function bisec(M, e, iter)
    a, b = M - abs(e), M + abs(e)
    m = (a + b) / 2
    for i in 1:iter
        if kepler(a, M, e) * kepler(m, M, e) < 0
            b = m
        else
            a = m
        end
        m = (a + b) / 2
    end
    return m
end

function iteration(M, e, iter)
    x = 0.0
    for i in 1:iter
        x = e * sin(x) + M
    end
    return x
end

function newton(M, e, iter)
    x = M + (e / 2)
    for i in 1:iter
        x -= kepler(x, M, e) / kepler_derivative(x, M, e)
    end
    return x
end

function bisec_search(M, e, show=false)
    i = 1
    E_bisec_prev = bisec(M, e, 0)
    E_bisec_next = bisec(M, e, 1)
    rel_error_table = [E_bisec_next]
    while abs(E_bisec_prev - E_bisec_next) > 10^-15
        i += 1
        E_bisec_prev = E_bisec_next
        E_bisec_next = bisec(M, e, i)
        push!(rel_error_table, E_bisec_next)
    end
    for j in 1:length(rel_error_table)
        rel_error = abs(rel_error_table[j] - E_bisec_next) / abs(E_bisec_next)
        if show
            @printf("iter: %d \tE: %.16f\trelative error: %.16f\n", j, rel_error_table[j], rel_error)
        end
        rel_error_table[j] = -log(rel_error)
    end
    return E_bisec_next, rel_error_table
end

function iteration_search(M, e, show=false)
    i = 1
    E_iter_prev = iteration(M, e, 0)
    E_iter_next = iteration(M, e, 1)
    rel_error_table = [E_iter_next]
    while abs(E_iter_prev - E_iter_next) > 10^-15 && i < 200
        i += 1
        E_iter_prev = E_iter_next
        E_iter_next = iteration(M, e, i)
        push!(rel_error_table, E_iter_next)
    end
    for j in 1:length(rel_error_table)
        rel_error = abs(rel_error_table[j] - E_iter_next) / abs(E_iter_next)
        if show
            @printf("iter: %d \tE: %.16f\trelative error: %.16f\n", j, rel_error_table[j], rel_error)
        end
        rel_error_table[j] = -log(rel_error)
    end
    return E_iter_next, rel_error_table
end

function newton_search(M, e, show=false)
    i = 1
    E_newton_prev = newton(M, e, 0)
    E_newton_next = newton(M, e, 1)
    rel_error_table = [E_newton_next]
    while abs(E_newton_prev - E_newton_next) > 10^(-15)
        i += 1
        E_newton_prev = E_newton_next
        E_newton_next = newton(M, e, i)
        push!(rel_error_table, E_newton_next)
    end
    for j in 1:length(rel_error_table)
        rel_error = abs(rel_error_table[j] - E_newton_next) / abs(E_newton_next)
        if show
            @printf("iter: %d \tE: %.16f\trelative error: %.16f\n", j, rel_error_table[j], rel_error)
        end
        rel_error_table[j] = -log(rel_error)
    end
    return E_newton_next, rel_error_table
end

#for mars 2019-01-01
mars_a = 1.523735308990487
mars_e = 9.337659277899077*10^-2
mars_M = deg2rad(5.576887337043543*10^1)

E_bisec = bisec(mars_M, mars_e, 10^2)
E_iter = iteration(mars_M, mars_e, 10^2)
E_newton = newton(mars_M, mars_e, 10^2)

@printf("%.64f\n%.64f\n%.64f", E_bisec, E_iter, E_newton)

E, rel_error_bisec_mars = bisec_search(mars_M, mars_e, true)

plot(rel_error_bisec_mars, marker="o", linestyle="", color="green")
xlabel("Iteracje")
ylabel("Cyfry znaczące błędu względnego")
title("Zbieżność bisekcji")
show()

E, rel_error_iter_mars = iteration_search(mars_M, mars_e, true)

plot(rel_error_iter_mars, marker="o", linestyle="")
xlabel("Iteracje")
ylabel("Cyfry znaczące błędu względnego")
title("Zbieżność metody iteracyjej")
show()

E, rel_error_newton_mars = newton_search(mars_M, mars_e, true)

plot(rel_error_newton_mars, color="red", linestyle="", marker="o")
xlabel("Iteracje")
ylabel("Cyfry znaczące błędu względnego")
title("Zbieżność metody Newtona")
show()

x1 = [e for e in 1:length(rel_error_bisec_mars)]
x2 = [e for e in 1:length(rel_error_iter_mars)]
x3 = [e for e in 1:length(rel_error_newton_mars)]
plot(x1,rel_error_bisec_mars, linestyle="", marker="o", color="green")
scatter(x2, rel_error_iter_mars)
scatter(x3, rel_error_newton_mars, color="red")
xlabel("Iteracje")
ylabel("Cyfry znaczące błędu względnego")
title("Zestawienie wszystkich metod")
show()

#all data for 2019-01-01
#for earth
earth_e = 1.714784243883271E-02
earth_M = deg2rad(3.582577144695844E+02)

#for venus
venus_e = 1.440912442492587E-02
venus_M = deg2rad(3.364009332350369E+02)

#for mercury
mercury_e = 2.064529232369614E-01
mercury_M = deg2rad(1.388051146573238E+02)

E, rel_error_bisec_earth = bisec_search(earth_M, earth_e)
E, rel_error_iter_earth = iteration_search(earth_M, earth_e)
E, rel_error_newton_earth = newton_search(earth_M, earth_e)

E, rel_error_bisec_venus = bisec_search(venus_M, venus_e)
E, rel_error_iter_venus = iteration_search(venus_M, venus_e)
E, rel_error_newton_venus = newton_search(venus_M, venus_e, true)

E, rel_error_bisec_mercury = bisec_search(mercury_M, mercury_e)
E, rel_error_iter_mercury = iteration_search(mercury_M, mercury_e)
E, rel_error_newton_mercury = newton_search(mercury_M, mercury_e)

b1 = [e for e in 1:length(rel_error_bisec_earth)]
b2 = [e for e in 1:length(rel_error_bisec_venus)]
b3 = [e for e in 1:length(rel_error_bisec_mercury)]

i1 = [e for e in 1:length(rel_error_iter_earth)]
i2 = [e for e in 1:length(rel_error_iter_venus)]
i3 = [e for e in 1:length(rel_error_iter_mercury)]

n1 = [e for e in 1:length(rel_error_newton_earth)]
n2 = [e for e in 1:length(rel_error_newton_venus)]
n3 = [e for e in 1:length(rel_error_newton_mercury)]

figure1=figure("Position", [10, 10])

subplot(2,2,1)
plot(x1, rel_error_bisec_mars, linestyle="", marker="o", color=(0,1.0,0))
scatter(x2, rel_error_iter_mars, color=(0,0,1))
scatter(x3, rel_error_newton_mars, color=(1,0,0))
xlabel("Iteracje")
ylabel("Cyfry znaczące błędu względnego")
title("Mars")

subplot(2,2,2)
plot(b1, rel_error_bisec_earth, color=(0.5,0.7,0.2), linestyle="", marker="o")
scatter(i1, rel_error_iter_earth, color=(0.5,0.2,0.7))
scatter(n1, rel_error_newton_earth, color=(0.7,0.2,0.5))
xlabel("Iteracje")
ylabel("Cyfry znaczące błędu względnego")
title("Ziemia")

subplot(2,2,3)
plot(b2, rel_error_bisec_venus, color=(0.2,0.7,0.5), linestyle="", marker="o")
scatter(i2, rel_error_iter_venus, color=(0.2,0.5,0.7))
scatter(n2, rel_error_newton_venus, color=(0.7,0.5,0.2))
xlabel("Iteracje")
ylabel("Cyfry znaczące błędu względnego")
title("Wenus")

subplot(2,2,4)
plot(b3, rel_error_bisec_mercury, color=(0,0.5,0), linestyle="", marker = "o")
scatter(i3, rel_error_iter_mercury, color=(0,0,0.5))
scatter(n3, rel_error_newton_mercury, color=(0.5,0,0))
xlabel("Iteracje")
ylabel("Cyfry znaczące błędu względnego")
title("Merkury")

show()

plot(x1, rel_error_bisec_mars, linestyle="", marker="o", color=(0,1.0,0))
scatter(b1, rel_error_bisec_earth, color=(0.5,0.7,0.2))
scatter(b2, rel_error_bisec_venus, color=(0.2,0.7,0.5))
scatter(b3, rel_error_bisec_mercury, color=(0,0.5,0))

scatter(i1, rel_error_iter_earth, color=(0.5,0.2,0.7))
scatter(i2, rel_error_iter_venus, color=(0.2,0.5,0.7))
scatter(i3, rel_error_iter_mercury, color=(0,0,0.5))
scatter(x2, rel_error_iter_mars, color=(0,0,1))

scatter(n1, rel_error_newton_earth, color=(0.7,0.2,0.5))
scatter(n2, rel_error_newton_venus, color=(0.7,0.5,0.2))
scatter(n3, rel_error_newton_mercury, color=(0.5,0,0))
scatter(x3, rel_error_newton_mars, color=(1,0,0))
xlabel("iteracje")
ylabel("cyfry znaczące błędu względnego")
title("Zestawienie wszystkich przykładów")
show()

E, table = iteration_search(mars_M, 10.0)
plot(table, linestyle="", marker="o", color=(0.3,0.6,1))
xlabel("Iteracje")
ylabel("Cyfry znaczące błędu względnego")
title("Wykres metody iteracyjnej dla dużych e")
show()

for i in 0.001:0.001:3
    E, table = iteration_search(mars_M, i)
    if length(table) == 200
        println(i)
        break
    end
end
