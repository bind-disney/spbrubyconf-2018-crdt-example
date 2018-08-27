require 'dry/monads/result'
require 'dry/monads/do/all'

module Operations
  class TagImage
    include Dry::Monads::Result::Mixin
    include Dry::Monads::Do::All

    def call(image_uuid:, tag:)
      image = yield find_image(image_uuid)
      tag = yield convert_input(tag)

      image.sets[:tags].add(tag)
      TagsRepository.new.add(tag)

      Success(tag)
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

    def convert_input(tag)
      tag = tag.split.map { |i| i.capitalize }.join('')

      Success(tag)
    end
  end
end
