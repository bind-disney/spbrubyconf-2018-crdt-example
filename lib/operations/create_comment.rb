module Operations
  class CreateComment
    def initialize(client)
      @client = client
    end

    def call(image_uuid:, comment_params:)
      comment_template = Comment.new(comment_params)
      comment = CommentsRepository.new(@client).create(comment_template)
      image = ImagesRepository.new(@client).find_by_uuid(image_uuid)

      image.sets[:comments_uuids].add(comment.key)
    end
  end
end
