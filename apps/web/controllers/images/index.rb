module Web::Controllers::Images
  class Index
    include Web::Action
    include Import[
      list_query: 'queries.images_query'
    ]

    def call(params)
      data = list_query.call

      self.body = Web::Representers::ImageRepresenter.for_collection.new(data).to_json
    end
  end
end
