module Controllers
  module ParamsValidation
    def validate_params(params)
      result = params.result

      return result.output if result.success?

      halt_with_failure(result.errors)
    end
  end
end
