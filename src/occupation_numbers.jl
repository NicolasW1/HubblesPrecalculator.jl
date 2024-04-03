# T times the temperature derivative of nF
# κ = exp(-z) ⟸⟹ lnκ = -z ⟸⟹ z = -lnκ
function TnFp(z::T, κ::T) where {T}
    res = κ * z / evalpoly(κ, (1, 2, 1))
    isnan(res) ? zero(T) : res
end

function ∂¹aTnFp(z::T, κ::T) where {T}
    res = evalpoly(κ, (0, 1 - z, 1 + z)) / evalpoly(κ, (1, 3, 3, 1))
    isnan(res) ? zero(T) : res
end

function ∂³aTnFp(z::T, κ::T) where {T}
    res = evalpoly(κ, (0, 3 - z, muladd(-z, -11, -9), muladd(-z, 11, -9), 3 + z)) / evalpoly(κ, (1, 5, 10, 10, 5, 1))
    isnan(res) ? zero(T) : res
end