module Operations
  class UpvoteImage
    def call(uuid:)
      client = Riak::Client.new
      repository = ImagesRepository.new(client)

      image = repository.find_by_uuid(uuid)

      image.counters[:votes].increment
    end
  end
end
