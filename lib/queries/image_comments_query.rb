module Queries
  class ImageCommentsQuery
    ImageCommentsData = Struct.new(:image, :comments)

    def call(image_uuid:)
      image    = find_image_by(image_uuid)
      comments = find_comments_for(image)
      ImageCommentsData.new(image, comments)
    end

    private

    def find_comments_for(image)
      repository = CommentsRepository.new
      comments_uuids = image.sets[:comments_uuids].members

      repository.find_by_uuids(comments_uuids)
    end

    def find_image_by(uuid)
      repository = ImagesRepository.new

      repository.find_by_uuid(uuid)
    end
  end
end
