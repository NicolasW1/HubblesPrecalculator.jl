function evaluateBubble!(result, bubbleType::Type{Q}, discretization, externalParams) where {Q}
    # TODO:
    # write the function
    return 1.0
end

function update_discretization!(integrator, genParams, bubble::Type, extParams)
    println("--------------------------------------------------")
    println("Precalculating refinement for logΛ = $(log10(extParams.Λ))")

    start_time = now()

    integrator(x->onsite_bubble(bubble, x, extParams), genParams.rtol, genParams.atol, genParams.maxeval)
    save_current_refinement(integrator)

    if genParams.saveDiscr
        save_refinement(integrator, "run_" * string(log10(extParams.Λ)))
    end

    println("    Took : " * Dates.format(convert(DateTime, now() - start_time), "HH:MM:SS.sss"))
    println("    Number of elements : $(length(integrator.init_geo_refinement))")
    println("--------------------------------------------------")
    
    nothing
end

function getResult!(result, bubbleType::Type, discretization, extParams)
    starttime = now()

    println(" Calculating result for logΛ = $(log10(extParams.Λ))")

    err = evaluateBubble!(result, bubbleType, discretization, extParams)

    println("     Took : " * Dates.format(convert(DateTime, now() - starttime), "HH:MM:SS.sss"))

    err
end

##################################################

function generateLambdaGrid(logΛₘᵢₙ, logΛₘₐₓ, order)
    # This matches the definition in FastOPInterpolation.jl, which is nothing else then Cheb points.
    # Currently the generation of Elements in the package is not type stable, this circumvents related issues
    transpose(logΛₘᵢₙ .+ (logΛₘₐₓ - logΛₘᵢₙ) / 2 .* (1 .- cos.(one(logΛₘᵢₙ) * pi/(order) .* range(0, order))))
end

###################################################################

function testF(x)
    return x
end

function run_precalculation(model, genParams::PrecalculationParameter{T,I}, bubble::Type, extParams) where {T,I}
    start_time = now()

    return testF(1)

    # # file output
    # if genParams.saveOutput
    #     outputDict = generateSaveDict(bubble, genParams, extParams)
    #     outputFilePath = joinpath(outputFolder(extParams), filePath(bubble, extParams))
    # end

    # # Λ grids
    # precalcLogLambdas = reverse(collect(genParams.logΛₘᵢₙ : genParams.ΔlogΛ : genParams.logΛₘₐₓ))
    # interpLogLambdas = reverse(generateLambdaGrid(genParams.logΛₘᵢₙ, genParams.logΛₘₐₓ, genParams.order))
    # num_evals=similar(precalcLogLambdas, Int)

    # # result collection
    # results = zeros(Complex{T}, length(extParams.ffs), length(interpLogLambdas))
    # errors = zeros(T, length(interpLogLambdas))

    # # integration
    # integration_domain = full_refine(generate_domain(), genParams.init_refinement)
    # integrator = SCubatureFactory(Float64, integration_domain)
    # interp_index = 1

    # for (precalc_index, pre_logΛ) in enumerate(precalcLogLambdas)
    #     update_discretization!(integrator, genParams, bubble, ExternalInput(extParams, 10^pre_logΛ))
    #     num_evals

    #     if genParams.calcInterp
    #         while interp_index <= length(interpLogLambdas) && interpLogLambdas[interp_index] >= pre_logΛ
    #             interp_logΛ = interpLogLambdas[interp_index]
    #             local_res = @view results[:, interp_index]

    #             errors[interp_index] = getResult!(local_res, bubble, integrator.init_geo_refinement, ExternalInput(extParams, 10^interp_logΛ))

    #             if genParams.saveOutput
    #                 appendData!(outputDict, interp_logΛ, local_res, errors[interp_index])
    #             end

    #             interp_index += 1
    #         end
    #     end
    # end

    # # save output
    # if genParams.saveOutput
    #     open(outputFilePath * ".json", "w") do io
    #         JSON3.pretty(io, outputDict)
    #     end
    # end

    # println("Total evaluation time : " * Dates.format(convert(DateTime, now() - start_time), "HH:MM:SS"))

    # results, errors
end