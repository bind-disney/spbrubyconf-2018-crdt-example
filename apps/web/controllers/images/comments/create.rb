module Web::Controllers::Comments
  class Create
    include Web::Action
    include Import[
      create_comment: 'operations.create_comment'
    ]

    def call(params)
			result = create_comment.call(image_uuid: params[:image_id], comment_params: params[:comment])
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
