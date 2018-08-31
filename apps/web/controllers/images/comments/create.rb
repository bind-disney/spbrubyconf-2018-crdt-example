module Web
  module Controllers
    module Images
      module Comments
        class Create
          include Web::Action
          include Import[
            create_comment: 'operations.create_comment'
          ]

          class Params < ::Controllers::Params
            params do
              required(:image_id).filled(:str?)
              required(:comment).filled(:hash?)
            end
          end

          params Params

          def call(params)
            input = validate_params(params)
            result = create_comment.call(image_uuid: input[:image_id], comment_params: input[:comment])

            respond_with(result, serializer: Web::Representers::CommentRepresenter, status: 201)
          end
        end
      end
    end
  end
end
