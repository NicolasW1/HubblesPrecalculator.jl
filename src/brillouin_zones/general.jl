struct BrillouinZone{T, X<:NamedTuple}
    special_points::X
    corners::Vector{SVector{2,T}}
    area::T
end