module Web
  module Controllers
    module Tags
      class Create
        include Web::Action
        include Import[
          tag_image: 'operations.tag_image'
        ]

        class Params < ::Controllers::Params
          params do
            required(:image_id).filled(:int?)
            required(:tag).filled(:str?)
          end
        end

        params Params

        def call(params)
          input = validate_params(params)
          result = tag_image.call(image_uuid: input[:image_id], tag: input[:tag])

          respond_with(result, status: 201)
        end
      end
    end
  end
end
