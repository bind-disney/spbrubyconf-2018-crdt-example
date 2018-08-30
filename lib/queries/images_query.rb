module Queries
  class ImagesQuery
    include Import[
      image_repo: 'repositories.images'
    ]

    def call
      image_repo.all
    end
  end
end
