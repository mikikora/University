#niedokończone i niedeklarowane
N = 1000
g = 9.81
h = 0.01

k1(f, y) = f.(y)
k2(f, y) = f.(y + h/2 * k1(f, y))
k3(f, y) = f.(y + h/2 * k2(f, y))
k4(f, y) = f.(y + h* k3(f, y))

function RK4(f, y)
    for i in 1:N
        y = y + h/6*(k1(f, y) + 2k2(f, y) + 2k3(f, y)+k4(f, y))
    end
    y
end

function RK2(f, y)
    for i in 1:N
        y = y + h/2 * (k1(f, y) + k2(f, y))
    end
    y
end

function get_data(kappa)
    z(u, v) = kappa * (u^2 + v^2)^(1/2)

    x = [0.0]
    y = [0.0]
    u = [float(100 * cosd(60))]
    v = [float(100 * sind(60))]

    t = [e*h for e in 0:N]
    u = RK4(t)
