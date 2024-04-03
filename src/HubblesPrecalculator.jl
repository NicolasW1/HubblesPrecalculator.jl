module HubblesPrecalculator

using StaticArrays
using Dates

using HubblesPrerequisites
export AbstractModel, AbstractParameter, Bubble
export TnFp, ∂¹aTnFp, ∂³aTnFp
export ExternalInput
# export everything for now (move into this module...)

include("brillouin_zones/general.jl")
include("brillouin_zones/hexagonal.jl")
include("parameter.jl")
include("solver.jl")

export BrillouinZone
export hexagonal_brillouin, hexagonal_wedge_momenta
export PrecalculationParameter
export evaluateBubble!, update_discretization!, getResult!, generateLambdaGrid, run_precalculation

export testF

end
