module Operations
  class CreateComment
    include Operation
    include Import[
      comment_repo: 'repositories.comments',
      image_repo: 'repositories.images'
    ]

    def call(image_uuid:, comment_params:)
      image = yield find_image(image_uuid)
      comment = yield create_comment(comment_params)
      comment = image.sets[:comments_uuids].add(comment.key)

      Success(comment)
    end

    private

    def find_image(uuid)
      image = image_repo.find_by_uuid(uuid)

      image ? Success(image) : Failure(:image_not_found)
    end

    def create_comment(params)
      entity = Comment.new(params)
      comment = comment_repo.create(entity)

      Success(comment)
    end
  end
end
