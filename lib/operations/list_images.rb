module Operations
  class ListImages
    include Operation
    include Import[
      list_query: 'queries.images_query'
    ]

    def call
      data = list_query.call

      Success(data)
    end
  end
end
