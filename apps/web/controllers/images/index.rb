module Web::Controllers::Images
  class Index
    include Web::Action

    def call(params)
      data = Queries::ImagesQuery.new.call

      self.body = Web::Representers::ImageRepresenter.for_collection.new(data).to_json
    end
  end
end
