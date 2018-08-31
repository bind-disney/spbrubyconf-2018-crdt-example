module Web
  module Controllers
    module Images
      class Show
        include Web::Action
        include Import[
          list_query: 'queries.image_comments_query'
        ]

        class Params < ::Controllers::Params
          params do
            required(:id).filled(:str?)
          end
        end

        params Params

        def call(params)
          input = validate_params(params)
          data = list_query.call(image_uuid: input[:id])

          respond_with(data, serializer: Web::Representers::ImageCommentsRepresenter)
        end
      end
    end
  end
end
