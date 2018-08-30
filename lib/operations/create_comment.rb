require 'dry/monads/result'
require 'dry/monads/do/all'

module Operations
  class CreateComment
    include Dry::Monads::Result::Mixin
    include Dry::Monads::Do::All

    def call(image_uuid:, comment_params:)
      image = yield find_image(image_uuid)
      comment = yield create_comment(comment_params)

      Success(image.sets[:comments_uuids].add(comment.key))
    end

    private

    def find_image(uuid)
      image = ImagesRepository.new.find_by_uuid(uuid)

      if image
        Success(image)
      else
        Failure(:image_not_found)
      end
    end

    def create_comment(params)
      comment_template = Comment.new(params)
      comment = CommentsRepository.new.create(comment_template)

      Success(comment)
    end
  end
end
