module Web
  module Controllers
    module Likes
      class Update
        include Web::Action
        include Import[
          like_image: 'operations.like_image'
        ]

        class Params < ::Controllers::Params
          params do
            required(:image_id).filled(:str?)
          end
        end

        params Params

        def call(params)
          input = validate_params(params)
          result = like_image.call(image_uuid: input[:image_id])

          respond_with(result)
        end
      end
    end
  end
end
