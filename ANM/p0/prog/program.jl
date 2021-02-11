using Plots
using Printf

pyplot()

tab = [i for i in -8:8]

e = MathConstants.e

f(x) = (1 / e) * (x + (3x / 17))^2

res = map(f, tab)

for i in 1:length(tab)
    @printf("%d\t&\t%.32f\\\\\n", tab[i], res[i])
end

x = LinRange(-10.0, 10.0, 1000)

plot(x, f.(x))


