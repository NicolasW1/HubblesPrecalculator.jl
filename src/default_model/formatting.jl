function parameterString(params::AbstractParameter)
    join([string(p) * "_" * cfmt("%.3f", getfield(par, p)) for p in fieldnames(typeof(params))], "__")
end

saveDict(p::AbstractParameter{T}) = throw(MissingException("Please provide an implementation by overwriting this function."))