module Operations
  class CreateImage
    def call(image_params:)
      client = Riak::Client.new
      repository = ImagesRepository.new(client)
      template = Image.new(image_params)

      repository.create(template)
    end
  end
end
