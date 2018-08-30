module Queries
  class ImageCommentsQuery
    include Import[
      comment_repo: 'repositories.comments',
      image_repo: 'repositories.images'
    ]

    def call(image_uuid:)
      image    = find_image_by(image_uuid)
      comments = find_comments_for(image)

      ImageWithComments.new(image: image, comments: comments)
    end

    private

    def find_comments_for(image)
      comments_uuids = image.sets[:comments_uuids].members

      comment_repo.find_by_uuids(comments_uuids)
    end

    def find_image_by(uuid)
      image_repo.find_by_uuid(uuid)
    end
  end
end
