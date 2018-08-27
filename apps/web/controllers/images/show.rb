module Web::Controllers::Images
  class Show
    include Web::Action

    def call(params)
			data = Queries::ImageCommentsQuery.new.call(image_uuid: params[:id])

      self.body = Web::Representers::ImageCommentsRepresenter.new(data).to_json
    end
  end
end
