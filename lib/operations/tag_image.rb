module Operations
  class TagImage
    def call(image_uuid:, tag:)
      client = Riak::Client.new
      repository = ImagesRepository.new(client)
      image = repository.find_by_uuid(image_uuid)

      image.sets[:tags].add(tag)
      TagsRepository.new.add(tag)
    end
  end
end
