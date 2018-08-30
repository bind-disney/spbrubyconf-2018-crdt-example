module Helpers
  module ActionHelpers
    SUCCESS_STATUS = 200
    FAILURE_STATUS = 400

    def respond_with(result, serializer:, status: SUCCESS_STATUS)
      if result.success?
        respond_with_success(result.value!, serializer: serializer, status: status)
      else
        respond_with_failure(result.failure, status: status)
      end
    end

    def respond_with_success(entity, serializer:, status: SUCCESS_STATUS)
      self.body = status == 204 ? nil : serializer.new(entity).to_json
      self.status = status
    end

    def respond_with_failure(entity, status: FAILURE_STATUS)
      self.body = entity
      self.status = status
    end

    def halt_with_failure(error, status: FAILURE_STATUS)
      body = error.respond_to?(:to_json) ? error.to_json : error.to_s
      halt(status, body)
    end

    def validate_params(params)
      result = params.result

      return result.output if result.success?

      halt_with_failure(result.errors)
    end
  end
end
