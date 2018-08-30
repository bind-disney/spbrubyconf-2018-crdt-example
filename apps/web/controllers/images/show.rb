module Web::Controllers::Images
  class Show
    include Web::Action
    include Import[
      list_query: 'queries.image_comments_query'
    ]

    params do
      required(:id).filled(:int?)
    end

    def call(params)
			data = list_query.call(image_uuid: params[:id])

      self.body = Web::Representers::ImageCommentsRepresenter.new(data).to_json
    end
  end
end
