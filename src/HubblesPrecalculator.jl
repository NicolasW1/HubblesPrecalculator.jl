module HubblesPrecalculator

using StaticArrays
using Dates, Format

include("abstract_types.jl")
export AbstractModel, AbstractParameter, Bubble
include("occupation_numbers.jl")
export TnFp, ∂¹aTnFp, ∂³aTnFp

include("default_model/formatting.jl")
export parameterString, saveDict

include("brillouin_zones/general.jl")
include("brillouin_zones/hexagonal.jl")
include("parameter.jl")
include("solver.jl")

export BrillouinZone
export hexagonal_brillouin, hexagonal_wedge_momenta
export PrecalculationParameter, ExternalInput
export evaluateBubble!, update_discretization!, getResult!, generateLambdaGrid, run_precalculation

end
