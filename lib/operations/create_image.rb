module Operations
  class CreateImage
    include Operation
    include Import[
      image_repo: 'repositories.images'
    ]

    def call(image_params:)
      entity = Image.new(image_params)

      image_repo.create(entity)
    end
  end
end
