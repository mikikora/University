using LinearAlgebra
function f(x)
    map(x->cos(500x), x)
    # map(x->exp(exp(exp(x))), x)
end

function AdaptSimpson(f,a,b,abstol=1.0e-6)
    nf=3
    ff = f([a,(a+b)/2,b])
    I1 = (b-a)*dot([1,4,1],ff)/6
    function adaptRec(f,a,b,ff,I1,tol,nf)
        h = (b-a)/2
        fm = f([a+h/2,b-h/2])
        nf+=2
        fR = [ff[2], fm[2], ff[3]]
        fL = [ff[1], fm[1], ff[2]]
        IL = h*dot([1,4,1], fL)/6
        IR = h*dot([1,4,1], fR)/6
        I2 = IL + IR
        I = I2 + (I2-I1)/15
        if (abs(I-I2)>tol)
            IL, nf = adaptRec(f,a,a+h,fL,IL,tol/2,nf)
            IR, nf = adaptRec(f,b-h,b,fR,IR,tol/2,nf)
            I = IL+IR
        end
        return I,nf
    end
    return adaptRec(f,a,b,ff,I1,abstol,nf)
end

println(AdaptSimpson(f, -1, 1))
