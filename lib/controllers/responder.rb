module Controllers
  module Responder
    SUCCESS_STATUS = 200
    FAILURE_STATUS = 400

    def respond_with(result, serializer: nil, status: SUCCESS_STATUS)
      if result.success?
        respond_with_success(result.value!, serializer: serializer, status: status)
      else
        respond_with_failure(result.failure)
      end
    end

    def respond_with_success(entity, serializer: nil, status: SUCCESS_STATUS)
      self.status = status
      self.body =
        if status == 204
          nil
        else
          serializer.nil? ? entity : serializer.new(entity).to_json
        end
    end

    def respond_with_failure(error)
      status, body = extract_status_with_body_from_error(error)

      self.body = body
      self.status = status
    end

    def halt_with_failure(error)
      status, body = extract_status_with_body_from_error(error)

      halt(status, body)
    end

    private

    def extract_status_with_body_from_error(error)
      body = error.respond_to?(:to_json) ? error.to_json : error.to_s
      status = FAILURE_STATUS # TODO: Determine status from error

      [status, body]
    end
  end
end
