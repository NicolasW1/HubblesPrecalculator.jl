struct ExternalInput{T,X,P}
    qₑₓₜ::SVector{2,T}
    ffs::X
    params::P
end

struct PrecalculationParameter{T, I, N}
    logΛₘᵢₙ::T
    logΛₘₐₓ::T
    ΔlogΛ::T

    order::I

    rtol::T
    atol::T
    maxeval::I

    init_refinement::N

    saveDiscr::Bool
    calcInterp::Bool
    saveOutput::Bool
end
function PrecalculationParameter(logΛₘᵢₙ, logΛₘₐₓ, ΔlogΛ, order, rtol, atol)
    PrecalculationParameter(logΛₘᵢₙ, logΛₘₐₓ, ΔlogΛ, order, rtol, atol, 0, Val{7}(), false, true, true)
end