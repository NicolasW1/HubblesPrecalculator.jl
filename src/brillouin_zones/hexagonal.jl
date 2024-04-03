function hexagonal_brillouin(T::Type)

    s = 2*T(pi)/3
    corner_length = 1/sqrt(3*one(T))

    # Center
    Γ = SVector(zero(T), zero(T))

    # Corners: R=right, L=left, M=middle, T=top, B=bottom
    c_RT = K₊ = s * SVector(one(T), corner_length)
    c_MT = s * SVector(zero(T), 2 * corner_length)
    c_LT = s * SVector(-one(T), corner_length)
    c_LB = s * SVector(-one(T), -corner_length)
    c_MB = s * SVector(zero(T), -2 * corner_length)
    c_RB = K₋ = s * SVector(one(T), -corner_length)

    M₁ = s * SVector(one(T), zero(T))

    area = 6 * s^2 * corner_length

    BrillouinZone((Γ = Γ, K₊, K₋, M₁), [c_RT, c_MT, c_LT, c_LB, c_MB, c_RB], area)
end

"""
    hexagonal_wedge_momenta(n, T::Type=Float64)

Generates a equally spaced momentum grid in 1/12th of the Brillouin zone.
`n` determines the number of points on each edge of the resulting triangle.
"""
function hexagonal_wedge_momenta(n, T::Type=Float64)
    zone = hexagonal_brillouin(T)
    Γ = zone.special_points[:Γ]
    K₊ = zone.special_points[:K₊]
    M₁ = zone.special_points[:M₁]

    λs = reverse(range(zero(T), one(T), length = n))

    [λ₁ * Γ + λ₂ * M₁ + (1 - λ₁ - λ₂) * K₊ for λ₁ in λs for λ₂ in λs if (1 - λ₁ - λ₂) >= -2*eps(T)]
end

# let
#     n = 6

#     zone = hexagonal_brillouin(Float64)
#     corners_x = [x[1] for x in zone.corners]
#     corners_y = [x[2] for x in zone.corners]
#     scatter(corners_x, corners_y, aspect_ratio = 1, label = "Corners")
#     pts = hexagonal_wedge_momenta(n)
#     @show length(pts)
#     xc = [x[1] for x in pts]
#     yc = [x[2] for x in pts]
#     scatter!(xc, yc, label = "Momentum grid with (n=$n)")
# end