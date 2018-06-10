module Web::Controllers::Images
  class Index
    include Web::Action

    def call(params)
      client = Riak::Client.new
      images = ImagesRepository.new(client).all

      self.body = Web::Representers::ImagesRepresenter.new(images).to_json
    end
  end
end
