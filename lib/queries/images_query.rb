module Queries
  class ImagesQuery
    def call
      ImagesRepository.new.all
    end
  end
end
