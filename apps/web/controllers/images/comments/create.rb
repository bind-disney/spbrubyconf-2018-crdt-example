module Web::Controllers::Comments
  class Create
    include Web::Action

    def call(params)
			result = Operations::CreateComment.new.call(image_uuid: params[:image_id],
                                                  comment_params: params[:comment])
      if result.success?
        self.status = 200
        self.body = Web::Representers::CommentRepresenter.new(result.value!)
      else
        self.status = 400
        self.body = result.failure
      end
    end
  end
end
