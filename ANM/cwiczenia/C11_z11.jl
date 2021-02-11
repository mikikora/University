using FastGaussQuadrature
using LinearAlgebra
using Printf


# println(res)
function foo()
    nodes, weights = gausslaguerre(1)
    res = dot(weights, cos.(nodes).^2)
    i = 1
    while abs(res - 0.6) > 0.001
        i += 1
        nodes, weights = gausslaguerre(i)
        res = dot(weights, cos.(nodes).^2)
    end
    @printf("%f\n%f\n%d\n", res, abs(res - 0.6), i)
end
foo()
