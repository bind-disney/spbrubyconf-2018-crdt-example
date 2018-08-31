module Web
  module Controllers
    module Images
      class Index
        include Web::Action
        include Import[
          list: 'operations.list_images'
        ]

        def call(_params)
          result = list.call

          respond_with(result, serializer: Web::Representers::ImageRepresenter.for_collection)
        end
      end
    end
  end
end
