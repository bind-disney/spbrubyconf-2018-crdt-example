require 'dry/monads/result'
require 'dry/monads/do/all'

module Operations
  class LikeImage
    include Dry::Monads::Result::Mixin
    include Dry::Monads::Do::All

    def call(image_uuid:)
      image = yield find_image(image_uuid)

      Success(image.counters[:likes].increment)
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
  end
end
