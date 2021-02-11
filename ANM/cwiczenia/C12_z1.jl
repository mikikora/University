using Printf

k = 10

x(a, h, i) = a + h*i

function c(x)
    if x > sqrt(3)/2
        return 1/2
    else
        return sqrt(1-(x^2))
    end
end

function romberg(f,a,b,n)
    h = (b - a) ./ (2 .^ (0:n-1));
    r = zeros(n,n)
    r[1,1] = (b - a) * (f(a) + f(b)) / 2;#pierwszy trapez
    for j = 2:n
        s = 0;
        for i = 1:2^(j-2)#wykladniczo zwiekszamy ilosc wezlow
            s += f(a + (2 * i - 1) * h[j]);
        end
        r[j,1] = r[j-1,1] / 2 + h[j] * s;
        for k = 2:j#wzor reku na pozostale w wierszu
            r[j,k] = (4^(k-1) * r[j,k-1] - r[j-1,k-1]) / (4^(k-1) - 1);
        end
    end
    return r
end

function Romberg(f, a, b)
    h = (b-a)/(2^k)
    sum = 0
    for i in 0:2^k-1
        sum += (f(x(a, h, i)) + f(x(a, h, i+1)))/2
    end
    sum *= h
    sum
end

psi(x,y) = sin(y)^2 * (1 + x^2 + y^2)^(-1/2)
fi(x) = Romberg(y -> psi(x, y), -c(x), c(x))
I = Romberg(x -> sin(x)^2 * fi(x), -1, 3)
println(I)

# fi(x) = romberg(y -> psi(x, y), -c(x), c(x), k)[k,k]
# I = romberg(x -> sin(x)^2 * fi(x), -1, 3, k)[k,k]
# println(I)
