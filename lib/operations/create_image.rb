module Operations
  class CreateImage
    def call(image_params:)
      repository = ImagesRepository.new
      template = Image.new(image_params)

      repository.create(template)
    end
  end
end
