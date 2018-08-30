module Operations
  class TagImage
    include Operation
    include Import[
      tag_repo: 'repositories.tags',
      image_repo: 'repositories.images'
    ]

    def call(image_uuid:, tag:)
      image = yield find_image(image_uuid)
      tag = yield convert_input(tag)

      image.sets[:tags].add(tag)
      tag_repo.add(tag)

      Success(tag)
    end

    private

    def find_image(uuid)
      image = image_repo.find_by_uuid(uuid)

      image ? Success(image) : Failure(:image_not_found)
    end

    def convert_input(tag)
      tag = tag.split.map(&:capitalize).join('')

      Success(tag)
    end
  end
end
