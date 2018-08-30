module Operations
  class LikeImage
    include Operation
    include Import[
      image_repo: 'repositories.images'
    ]

    def call(image_uuid:)
      image = yield find_image(image_uuid)

      Success(image.counters[:likes].increment)
    end

    private

    def find_image(uuid)
      image = image_repo.find_by_uuid(uuid)

      image ? Success(image) : Failure(:image_not_found)
    end
  end
end
