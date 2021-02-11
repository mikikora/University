using Printf
using PyPlot

g = 9.81
h = 0.01
N = 1000000
function get_data(kappa)
    # kappa = 0.015

    z(u, v) = kappa * (u^2 + v^2)^(1/2)

    x = [0.0]
    y = [0.0]
    u = [float(100 * cosd(60))]
    v = [float(100 * sind(60))]

    for i in 1:N
        push!(u, u[i] - h * z(u[i], v[i]) * u[i])
        push!(v, v[i] - h * (g + z(u[i], v[i]) * v[i]))
        push!(x, x[i] + h * u[i])
        push!(y, y[i] + h * v[i])
        if y[i+1] <= 0
            break
        end
    end
    return x, y
end

x0, y0 = get_data(0)
x1, y1 = get_data(0.0002)
x2, y2 = get_data(0.0004)
x3, y3 = get_data(0.0006)
x4, y4 = get_data(0.0008)
x5, y5 = get_data(0.001)

plot(x0, y0, x1, y1, x2, y2, x3, y3, x4, y4, x5, y5)
show()

# plot(x, y)
# show()
# plot(u,v)
# show()
